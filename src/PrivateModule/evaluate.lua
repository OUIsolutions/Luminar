
PrivateModule.evaluate = function(config)
    local code = config.code
    local env = config.env
    local deps = config.deps
    if not env then
        env = {}
    end
    if not deps then
        deps = PrivateModule.create_deps_props()
    end



    local fn, err = deps.load(code, "template", "t", env)
    if not fn then
        error("failed to load generated code: " .. tostring(err))
    end
    local result = fn()
    return result
end