

---@class PROJECT_NAME_ParseEntry
---@field type string       tag type name (e.g. "variable", "code")
---@field start_tag string  opening delimiter
---@field end_tag string    closing delimiter

---@class PROJECT_NAME_ParseProps
---@field non_tag string              type name for untagged text segments
---@field entries PROJECT_NAME_ParseEntry[]  tag definitions

---@class PROJECT_NAME_ParsedNode
---@field type string    node type (matches non_tag or an entry type)
---@field content string node content (without delimiters)

---@class PROJECT_NAME_GenerationModifier
---@field before string  prepended to the node content
---@field after string   appended to the node content

---@class PROJECT_NAME_GenerationProps
---@field before string                                         prepended to the entire output
---@field after string                                          appended to the entire output
---@field modifiers table<string, PROJECT_NAME_GenerationModifier>  per-type content wrappers


---@class PROJECT_NAME_Dependencies
---@field setmetatable fun(tbl: table, mt: table): tablelib
---@field load fun(chunk: string, chunkname: string, mode: string, env: table): function,string|nil
---@field type fun(v: any): string
---@field error fun(msg: string): any

---@class PROJECT_NAMEPublicModuleClass
---@field parse fun(config: {content: string, props: PROJECT_NAME_ParseProps | nil}): PROJECT_NAME_ParsedNode[]
---@field generate fun(config: {parsed_document: PROJECT_NAME_ParsedNode[], props: PROJECT_NAME_GenerationProps | nil}): string
---@field create_parse_props fun(): PROJECT_NAME_ParseProps
---@field create_generation_props fun(): PROJECT_NAME_GenerationProps
---@field evaluate fun(config: {template: string, generation_props: PROJECT_NAME_GenerationProps | nil, parse_props: PROJECT_NAME_ParseProps | nil, env: table, deps:PROJECT_NAME_Dependencies}): string | any
---@field create_deps_props fun(): PROJECT_NAME_Dependencies