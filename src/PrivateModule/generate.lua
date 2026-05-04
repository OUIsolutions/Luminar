
PrivateModule.generate = function(config)
    local parsed_document = config.parsed_document
    local props = config.props
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

    return table.concat(parts, "\n")
end
