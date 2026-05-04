---@type PROJECT_NAMEPublicModuleClass
local PROJECT_NAME = require("PROJECT_NAME")


local result = PROJECT_NAME.evaluate({
    template=[[
    your name is {!name}

    eval-lua: if age > 18 then
        <h1>you are an adult</h1>
    eval-lua: else
        <h1>you are not an adult</h1>
    eval-lua: end

    ]],
    env={ name = "Alice", age = 12 }
})

print(result)