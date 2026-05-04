
PrivateModule.generate = function(config)
    local parsed_document = config.parsed_document
    local props = config.props
    if not props then
        props = PrivateModule.create_generation_props()
    end

    local deps = config.deps
    if not deps then
        deps = PrivateModule.create_deps_props()
    end

    local modifiers = props.modifiers or {}

    local parts = {}

    if props.before then
        parts[#parts + 1] = props.before
    end

    for _, node in ipairs(parsed_document) do
        local modifier = modifiers[node.type]
        if modifier then
            parts[#parts + 1] = modifier.before .. node.content .. modifier.after
        else
            parts[#parts + 1] = node.content
        end
    end

    if props.after then
        parts[#parts + 1] = props.after
    end

    return deps.table.concat(parts, "\n")
    
end
