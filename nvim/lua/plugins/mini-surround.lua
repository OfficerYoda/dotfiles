return {
  "nvim-mini/mini.surround",
  custom_surroundings = {
    -- Remove space padding for all opening brackets
    ["("] = { output = { left = "(", right = ")" } },
    ["["] = { output = { left = "[", right = "]" } },
    ["{"] = { output = { left = "{", right = "}" } },
    ["<"] = { output = { left = "<", right = ">" } },
  },
}
