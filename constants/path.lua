local lfs = require "lfs"

---@type table<string, string>
local export = {}

local file;

file = assert(io.open("gtavpath", "r"))
export.gtav_root = file:read("*l")
export.mount_path = export.gtav_root
export.profile_root = lfs.currentdir() .. "/profiles/"

file:close()

return export
