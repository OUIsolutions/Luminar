

---@type PrivateModuleClass
PrivateModule = PrivateModule

-- Each entry in the assets array holds one embedded asset file.
---@class PROJECT_NAME_AssetEntry
---@field path string    asset filename (e.g. "darkmode.css")
---@field content string asset file contents as a string

---@type PROJECT_NAME_AssetEntry[]
PROJECT_NAME_AssetsObject = PROJECT_NAME_AssetsObject

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
