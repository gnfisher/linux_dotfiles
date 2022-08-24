if vim.fn.executable('rdm') == 1 then
  vim.g.clipboard = {
    name = "rdm",
    copy = {
      ["+"] = {"rdm", "copy"},
      ["*"] = {"rdm", "copy"} 
    },
    paste = {
      ["+"] = {"rdm", "paste"},
      ["*"] = {"rdm", "paste"} 
    },
  }
end
