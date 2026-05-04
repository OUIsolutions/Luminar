---@type LuminarPublicModuleClass
local Luminar = require("release/Luminar")

local sample = [[
your name is {!name}

eval-lua: if age > 18 then
    <h1>you are an adult</h1>
eval-lua: else
    <h1>you are not an adult</h1>
eval-lua: end

]]

local parsed_document = Luminar.parse({
    content = sample,
    props = Luminar.create_parse_props()
})

local generation = Luminar.generate({
    parsed_document = parsed_document,
    props = Luminar.create_generation_props()
})
-- evaluate the generated code by loading it into a sandboxed environment
-- that exposes the template variables
local env = { name = "Alice", age = 12 }
local result = Luminar.evaluate({
    code=generation,
    env=env,
    deps= {
        setmetatable = setmetatable,
        load = load,
        type = type,
        error = error
    }
})
print(result)

