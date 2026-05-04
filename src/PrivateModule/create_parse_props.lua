
PrivateModule.create_parse_props = function()
    return {
        non_tag = "text",
        entries = {
            {type = "variable", start_tag = "{!", end_tag = "}"},
            {type = "code",     start_tag = "eval-lua: ", end_tag = "\n"},
        }
    }
end
