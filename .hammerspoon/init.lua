local hyper = {"ctrl", "shift", "cmd"}

hs.loadSpoon("MiroWindowsManager")

hs.window.animationDuration = 0.1
spoon.MiroWindowsManager:bindHotkeys({
  up = {hyper, "up"},
  up = {hyper, "k"},
  right = {hyper, "right"},
  right = {hyper, "l"},
  down = {hyper, "down"},
  down = {hyper, "j"},
  left = {hyper, "left"},
  left = {hyper, "h"},
  fullscreen = {hyper, "m"}
})
