
PrivateModule.create_generation_props = function()
    return {
        before = "return (function() local internal_PROJECT_NAME_amalgamation = {}",
        after  = "return table.concat(internal_PROJECT_NAME_amalgamation,'') end)()",
        modifiers = {
            variable = {
                before = "internal_PROJECT_NAME_amalgamation[#internal_PROJECT_NAME_amalgamation+1] = ",
                after  = ";"
            },
            text = {
                before = "internal_PROJECT_NAME_amalgamation[#internal_PROJECT_NAME_amalgamation+1] = [[",
                after  = "]];"
            }
        }
    }
end
