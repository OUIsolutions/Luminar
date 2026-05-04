
PrivateModule.parse = function(config)
    local content = config.content
    local props = config.props
    local non_tag_type = props.non_tag or "text"
    local entries = props.entries or {}

    local result = {}
    local pos = 1
    local len = #content

    while pos <= len do
        local earliest_pos = nil
        local earliest_entry = nil

        for _, entry in ipairs(entries) do
            local found = content:find(entry.start_tag, pos, true)
            if found and (earliest_pos == nil or found < earliest_pos) then
                earliest_pos = found
                earliest_entry = entry
            end
        end

        if earliest_pos == nil then
            local text = content:sub(pos)
            if #text > 0 then
                result[#result + 1] = {type = non_tag_type, content = text}
            end
            break
        end

        if earliest_pos > pos then
            local text = content:sub(pos, earliest_pos - 1)
            if #text > 0 then
                result[#result + 1] = {type = non_tag_type, content = text}
            end
        end

        local tag_content_start = earliest_pos + #earliest_entry.start_tag
        local end_pos = content:find(earliest_entry.end_tag, tag_content_start, true)

        if end_pos == nil then
            local tag_content = content:sub(tag_content_start)
            result[#result + 1] = {type = earliest_entry.type, content = tag_content}
            break
        end

        local tag_content = content:sub(tag_content_start, end_pos - 1)
        result[#result + 1] = {type = earliest_entry.type, content = tag_content}
        pos = end_pos + #earliest_entry.end_tag
    end

    return result
end
