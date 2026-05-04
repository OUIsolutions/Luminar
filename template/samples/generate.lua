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

local parsed_document = PROJECT_NAME.parse({
    content=sample,
    non_tag="text",
    entries = { 
        {type="variable",start_tag="{!",end_tag="}"},
        {type="code",start_tag="eval-lua: ",end_tag="\n"},
    }
})
local generation = PROJECT_NAME.generate({
    parsed_document=parsed_document,
    before= "return (function() local internal_PROJECT_NAME_amalgamation = {}",
    after= "return table.concat(internal_PROJECT_NAME_amalgamation,'') end)()",
    modifiers ={
        variable={
            before= "internal_PROJECT_NAME_amalgamation[#internal_PROJECT_NAME_amalgamation+1] = ",
            after = ";"
        },
        text={
            before= "internal_PROJECT_NAME_amalgamation[#internal_PROJECT_NAME_amalgamation+1] = [[ ",
            after = " ]];"  
        }

    }
})  

---expect
