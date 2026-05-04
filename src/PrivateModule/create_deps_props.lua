
PrivateModule.create_deps_props = function()
    local deps = {}
    deps.setmetatable = setmetatable    
    deps.load = load
    deps.type = type
    deps.error = error
    return deps
end

