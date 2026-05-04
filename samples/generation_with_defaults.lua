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
    content=sample,
    props= Luminar.create_parse_props()
})

local generation = Luminar.generate({
    parsed_document=parsed_document,
    props= Luminar.create_generation_props()

})

--- expected
--- return (function() local internal_Luminar_amalgamation = {}
--- internal_Luminar_amalgamation[#internal_Luminar_amalgamation+1] = " your name is  ";
--- internal_Luminar_amalgamation[#internal_Luminar_amalgamation+1] = "  ";
--- if 18 > 18 then 
---     internal_Luminar_amalgamation[#internal_Luminar_amalgamation+1] = " <h1>you are an adult</h1> ";
--- else 
---     internal_Luminar_amalgamation[#internal_Luminar_amalgamation+1] = " <h1>you are not an adult</h1> ";
--- end;
--- internal_Luminar_amalgamation[#internal_Luminar_amalgamation+1] = [[  ]] 
--- return table.concat(internal_Luminar_amalgamation,'') 
--- end)()