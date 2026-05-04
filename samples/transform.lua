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
    props= {
            non_tag="text", 
            entries = { 
                {type="variable",start_tag="{!",end_tag="}"},
                {type="code",start_tag="eval-lua: ",end_tag="\n"},
            }
    }
   
})
for i=1, #parsed_document do
    local current = parsed_document[i]
    print("type: " .. current.type)  
    print(current.content)
end


