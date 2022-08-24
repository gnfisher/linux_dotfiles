local status_ok, config = pcall(require, "lint")
if not status_ok then
  return
end

config.linters_by_ft = {
  ruby = { 'robocop' }
}

