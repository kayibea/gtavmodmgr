local m = {}

---@param path string
---@return boolean
function m.is_mounted(path)
    local f, err = io.popen("mount | grep '^overlay' | grep '" .. path .. "'")

    if not f then
        print("Error checking mount status: " .. (err or "unknown error"))
        return false
    end

    local result = f:read("*a")
    f:close()
    return result ~= ""
end

---@param paths string[]
function m.ensure_dirs(paths)
    local lfs = require "lfs"

    for _, path in ipairs(paths) do
        path = m.trim(path)
        local attr = lfs.attributes(path)
        if not attr then
            local success, err = lfs.mkdir(path)
            if not success then
                error("Failed to create directory: " .. path .. "\n- " .. (err or "unknown error"))
            end
        elseif attr.mode ~= "directory" then
            error("Path exists and is not a directory: " .. path)
        end
    end
end

---@param s string
---@return string
function m.trim(s)
    return s:match("^%s*(.-)%s*$")
end

return m
