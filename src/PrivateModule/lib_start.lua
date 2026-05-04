
PrivateModule.lib_start = function()
    local PublicModule = {}
    PublicModule.parse                 = PrivateModule.parse
    PublicModule.generate              = PrivateModule.generate
    PublicModule.create_parse_props    = PrivateModule.create_parse_props
    PublicModule.create_generation_props = PrivateModule.create_generation_props
    return PublicModule
end
