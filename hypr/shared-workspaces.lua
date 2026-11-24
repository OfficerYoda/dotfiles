-- Use native Hyprland global workspace numbers instead of Omarchy's
-- per-monitor blocks. Load before default.hypr.omarchy so its bindings use
-- these dispatchers and its monitor reconciliation hooks are not installed.
require("default.hypr.helpers")

local workspaces = {}

function workspaces.focus(id)
  return hl.dsp.focus({ workspace = tostring(id) })
end

function workspaces.move_window(id, follow)
  return hl.dsp.window.move({ workspace = tostring(id), follow = follow ~= false })
end

function workspaces.move_to_monitor(direction)
  return hl.dsp.workspace.move({ monitor = direction })
end

function workspaces.move_window_to_monitor(direction)
  return hl.dsp.window.move({ monitor = direction })
end

o.workspaces = workspaces
package.loaded["default.hypr.monitor-workspaces"] = workspaces

return workspaces
