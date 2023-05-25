local status_ok, tmux = pcall(require, "tmux")
if status_ok then
  return
end


tmux.setup()
