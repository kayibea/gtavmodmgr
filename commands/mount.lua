local lfs = require "lfs"
local path = require "constants.path"
local is_mounted = require "utils.util".is_mounted

---@param profile_name string
return function(profile_name)
    local profile_dir = path.profile_root .. profile_name
    local work_dir = profile_dir .. "/work"
    local upper_dir = profile_dir .. "/upper"
    local gtav_root = path.gtav_root
    local mount_path = path.mount_path

    if not lfs.attributes(profile_dir, "mode") then
        print("Profile directory not found: " .. profile_dir)
        return
    end

    if not lfs.attributes(gtav_root, "mode") then
        print("gtav_root path not found: " .. gtav_root)
        return
    end

    if is_mounted(mount_path) then
        print("Already mounted at " .. mount_path)
        return
    end

    os.execute("mkdir -p '" .. work_dir .. "'")
    os.execute("mkdir -p '" .. upper_dir .. "'")

    local cmd = string.format(
        "sudo mount -t overlay overlay -o lowerdir='%s',upperdir='%s',workdir='%s' '%s'",
        gtav_root, upper_dir, work_dir, mount_path
    )

    local ok, how, code = os.execute(cmd)
    if ok and how == "exit" and code == 0 then
        print("Mounted successfully.")
    else
        print("Mount failed.")
    end
end
