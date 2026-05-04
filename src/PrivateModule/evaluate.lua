
PrivateModule.evaluate = function(config)
    local code = config.code

    if config.template then 
        local props = config.props
        if not props then
            props = {}
        end

        local parsed_document = PrivateModule.parse({
            content = config.template,
            props = props.parse_props
        })
        code = PrivateModule.generate({
            parsed_document = parsed_document,
            props = props.generation_props
        })        
    end 
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
    print('dddd')
    local result = fn()
    return result
end