
---@class PrivateModuleClass
---@field parse fun(config: {content: string, props: PROJECT_NAME_ParseProps}): PROJECT_NAME_ParsedNode[]
---@field generate fun(config: {parsed_document: PROJECT_NAME_ParsedNode[], props: PROJECT_NAME_GenerationProps}): string
---@field create_parse_props fun(): PROJECT_NAME_ParseProps
---@field create_generation_props fun(): PROJECT_NAME_GenerationProps
---@field get_asset fun(name: string): string|nil
---@field lib_start fun(): PROJECT_NAMEPublicModuleClass
