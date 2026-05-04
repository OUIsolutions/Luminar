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
    content=sample,
    props= Luminar.create_parse_props()
})

local generation = Luminar.generate({
    parsed_document=parsed_document,
    props= Luminar.create_generation_props()

})
dtw.write_file("x.lua",generation)