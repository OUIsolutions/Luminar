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
    content=sample,
    props= {
            non_tag="text", 
            entries = { 
                {type="variable",start_tag="{!",end_tag="}"},
                {type="code",start_tag="eval-lua: ",end_tag="\n"},
            }
    }
})
local generation = PROJECT_NAME.generate({
    parsed_document=parsed_document,
    props={
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
    }

})  

--- expected
--- return (function() local internal_PROJECT_NAME_amalgamation = {}
--- internal_PROJECT_NAME_amalgamation[#internal_PROJECT_NAME_amalgamation+1] = " your name is  ";
--- internal_PROJECT_NAME_amalgamation[#internal_PROJECT_NAME_amalgamation+1] = "  ";
--- if 18 > 18 then 
---     internal_PROJECT_NAME_amalgamation[#internal_PROJECT_NAME_amalgamation+1] = " <h1>you are an adult</h1> ";
--- else 
---     internal_PROJECT_NAME_amalgamation[#internal_PROJECT_NAME_amalgamation+1] = " <h1>you are not an adult</h1> ";
--- end;
--- internal_PROJECT_NAME_amalgamation[#internal_PROJECT_NAME_amalgamation+1] = [[  ]] 
--- return table.concat(internal_PROJECT_NAME_amalgamation,'') 
--- end)()