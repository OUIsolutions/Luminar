---@type PROJECT_NAMEPublicModuleClass
local PROJECT_NAME = require("PROJECT_NAME")
local sample = [[

your name is {!name}

eval-lua: if age > 18 then 
    <h1>you are adult</h1>
eval-lua: else 
    <h1>you are not adult</h1>
eval-lua: end

]]

local transform = PROJECT_NAME.transform({
    content=sample,
    non_tag="text",
    entries = { 
        {type="variable",start_tag="{!",end_tag="}"},
        {type="code",start_tag="eval-lua: ",end_tag="\n"},
    }
})
for i=1, #transform do
    local current = transform[i]
    --types can be "code"(eval-lua), "variable"({!var}), "text"
    print("type: " .. current.type)  
    print(current.content)
end


