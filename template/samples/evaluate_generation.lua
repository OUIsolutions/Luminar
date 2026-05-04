---@type PROJECT_NAMEPublicModuleClass
local PROJECT_NAME = require("PROJECT_NAME")

local sample = [[
your name is {!name}

eval-lua: if age > 18 then
    <h1>you are an adult</h1>
eval-lua: else
    <h1>you are not an adult</h1>
eval-lua: end

]]

local parsed_document = PROJECT_NAME.parse({
    content = sample,
    props = PROJECT_NAME.create_parse_props()
})

local generation = PROJECT_NAME.generate({
    parsed_document = parsed_document,
    props = PROJECT_NAME.create_generation_props()
})

-- evaluate the generated code by loading it into a sandboxed environment
-- that exposes the template variables
local env = { name = "Alice", age = 12 }
local result = PROJECT_NAME.evaluate({
    code=generation,
    env=env,
    props= {
        parse_props = PROJECT_NAME.create_parse_props(),
        generation_props = PROJECT_NAME.create_generation_props(),
    },
    deps= {
        setmetatable = setmetatable,
        load = load,
        type = type,
        error = error,
        table=table
    }
})

print(result)