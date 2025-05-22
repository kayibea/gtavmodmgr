local lfs = require "lfs"

return function()
    print(" Profile: ")
    for entry in lfs.dir(lfs.currentdir() .. "/profiles") do
        if entry ~= "." and entry ~= ".." then
            local profile_dir = lfs.currentdir() .. "/profiles/" .. entry

            if lfs.attributes(profile_dir, "mode") == "directory" then
                print("\t" .. entry)
            end
        end
    end
end
