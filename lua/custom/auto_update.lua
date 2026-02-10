-- Auto-update this config from its git upstream on startup.
-- Set `vim.g.kickstart_auto_update = false` to disable.

local function system_async(cmd, cb)
  if vim.system then
    vim.system(cmd, { text = true }, function(res) cb(res.code, res.stdout or '', res.stderr or '') end)
    return
  end

  local stdout, stderr = {}, {}
  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      for _, line in ipairs(data or {}) do
        if line ~= '' then table.insert(stdout, line) end
      end
    end,
    on_stderr = function(_, data)
      for _, line in ipairs(data or {}) do
        if line ~= '' then table.insert(stderr, line) end
      end
    end,
    on_exit = function(_, code) cb(code, table.concat(stdout, '\n'), table.concat(stderr, '\n')) end,
  })
end

local function trim(s) return (s:gsub('%s+$', '')) end

local function auto_update_self()
  if vim.g.kickstart_auto_update == false then return end
  local uv = vim.uv or vim.loop
  local repo = vim.fn.stdpath 'config'
  if not uv.fs_stat(repo .. '/.git') then return end
  -- Intentionally silent check to avoid startup noise.

  system_async({ 'git', '-C', repo, 'status', '--porcelain' }, function(code, out)
    if code ~= 0 or trim(out) ~= '' then return end
    system_async({ 'git', '-C', repo, 'rev-parse', '--abbrev-ref', '--symbolic-full-name', '@{u}' }, function(code2, upstream)
      if code2 ~= 0 or trim(upstream) == '' then return end
      local upstream_ref = trim(upstream)
      local remote, branch = upstream_ref:match('^([^/]+)/(.+)$')
      if not remote or not branch then return end
      system_async({ 'git', '-C', repo, 'fetch', '--quiet', remote, branch }, function(code3)
        if code3 ~= 0 then return end
        system_async({ 'git', '-C', repo, 'rev-parse', 'HEAD' }, function(code4, local_sha)
          if code4 ~= 0 then return end
          system_async({ 'git', '-C', repo, 'rev-parse', upstream_ref }, function(code5, remote_sha)
            if code5 ~= 0 then return end
            if trim(local_sha) ~= trim(remote_sha) then
              vim.schedule(function()
                local choice = vim.fn.confirm('Auto-update: updates found. Pull now?', '&Yes\n&No', 2)
                if choice ~= 1 then
                  vim.notify('Auto-update: skipped.', vim.log.levels.INFO)
                  return
                end
                vim.notify('Auto-update: pulling updates...', vim.log.levels.INFO)
                system_async({ 'git', '-C', repo, 'pull', '--ff-only', remote, branch }, function(code6)
                  if code6 ~= 0 then return end
                  vim.schedule(function()
                    vim.notify('Updated Neovim config from origin.', vim.log.levels.INFO)
                    local restart = vim.fn.confirm('Auto-update: restart Neovim now?', '&Restart\n&Later', 1)
                    if restart == 1 then
                      vim.cmd 'silent! wa'
                      vim.cmd 'qa'
                    end
                  end)
                end)
              end)
            end
          end)
        end)
      end)
    end)
  end)
end

vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function() vim.defer_fn(auto_update_self, 1000) end,
})
