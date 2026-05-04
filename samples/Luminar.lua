function PrivateDarwing_parse_to_bytes(seq)
    local buffer = {}
    for i = 1, #seq do
        buffer[#buffer + 1] = string.char(seq[i])
    end
    return buffer
end
PRIVATE_DARWIN_Luminar_SO_INCLUDED = {}
Luminar_AssetsObject = {}

return (function()
local PrivateModule = {}
-- file: src/PrivateModule/get_asset.lua



PrivateModule.get_asset = function (name)
    for i = 1, #Luminar_AssetsObject do
        if Luminar_AssetsObject[i].path == name then
            return Luminar_AssetsObject[i].content
        end
    end
    return nil
end
PrivateModule.lib_start()
return PrivateModule.lib_start()
end)()