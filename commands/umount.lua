local path = require "constants.path"
local is_mounted = require "utils.util".is_mounted

return function()
    local mount_path = path.mount_path

    if not is_mounted(mount_path) then
        print("Nothing is mounted at: " .. mount_path)
        return
    end

    local cmd = string.format("sudo umount '%s'", mount_path)
    local ok, how, code = os.execute(cmd)

    if ok and how == "exit" and code == 0 then
        print("Unmounted successfully.")
    else
        print("Failed to unmount.")
    end
end
