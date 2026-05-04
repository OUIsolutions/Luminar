---@type LuminarPublicModuleClass
local Luminar = require("Luminar")

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
local env = { name = "Alice", age = 25 }
setmetatable(env, { __index = _G })

local fn, err = load(generation, "template", "t", env)
if not fn then
    error("failed to load generated code: " .. tostring(err))
end

local result = fn()
print(result)

-- expected output:
-- your name is Alice
--
--     <h1>you are an adult</h1>
