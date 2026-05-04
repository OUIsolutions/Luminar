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
-- file: src/PublicModule/.gitkeep


-- file: src/PrivateModule/create_deps_props.lua


PrivateModule.create_deps_props = function()
    local deps = {}
    deps.setmetatable = setmetatable    
    deps.load = load
    deps.type = type
    deps.error = error
    return deps
end


-- file: src/PrivateModule/create_generation_props.lua


PrivateModule.create_generation_props = function()
    return {
        before = "return (function() local internal_Luminar_amalgamation = {}",
        after  = "return table.concat(internal_Luminar_amalgamation,'') end)()",
        modifiers = {
            variable = {
                before = "internal_Luminar_amalgamation[#internal_Luminar_amalgamation+1] = ",
                after  = ";"
            },
            text = {
                before = "internal_Luminar_amalgamation[#internal_Luminar_amalgamation+1] = [[ ",
                after  = " ]];"
            }
        }
    }
end

-- file: src/PrivateModule/create_parse_props.lua


PrivateModule.create_parse_props = function()
    return {
        non_tag = "text",
        entries = {
            {type = "variable", start_tag = "{!", end_tag = "}"},
            {type = "code",     start_tag = "eval-lua: ", end_tag = "\n"},
        }
    }
end

-- file: src/PrivateModule/evaluate.lua


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

    env.table = env.table or table

    local fn, err = deps.load(code, "template", "t", env)
    if not fn then
        error("failed to load generated code: " .. tostring(err))
    end
    local result = fn()
    return result
end
-- file: src/PrivateModule/generate.lua


PrivateModule.generate = function(config)
    local parsed_document = config.parsed_document
    local props = config.props
    if not props then
        props = PrivateModule.create_generation_props()
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

    return table.concat(parts, "\n")
end

-- file: src/PrivateModule/get_asset.lua



PrivateModule.get_asset = function (name)
    for i = 1, #Luminar_AssetsObject do
        if Luminar_AssetsObject[i].path == name then
            return Luminar_AssetsObject[i].content
        end
    end
    return nil
end
-- file: src/PrivateModule/lib_start.lua


PrivateModule.lib_start = function()
    local PublicModule = {}
    PublicModule.parse                 = PrivateModule.parse
    PublicModule.generate              = PrivateModule.generate
    PublicModule.evaluate              = PrivateModule.evaluate
    PublicModule.create_parse_props    = PrivateModule.create_parse_props
    PublicModule.create_generation_props = PrivateModule.create_generation_props
    PublicModule.create_deps_props     = PrivateModule.create_deps_props
    return PublicModule
end

-- file: src/PrivateModule/parse.lua


PrivateModule.parse = function(config)
    local content = config.content
    local props = config.props
    if not props then
        props = PrivateModule.create_parse_props()
    end
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

PrivateModule.lib_start()
return PrivateModule.lib_start()
end)()