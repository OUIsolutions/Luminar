# Luminar Public API

## Luminar.parse(config)

Parses a template string and returns a list of typed nodes.

**Parameters**

| Field | Type | Description |
|---|---|---|
| `config.content` | `string` | The template string to parse |
| `config.props` | `Luminar_ParseProps` | Tag definitions (use `create_parse_props()` for defaults) |

`Luminar_ParseProps`:

| Field | Type | Description |
|---|---|---|
| `non_tag` | `string` | Type name assigned to plain text between tags (e.g. `"text"`) |
| `entries` | `Luminar_ParseEntry[]` | Array of tag descriptor objects |

`Luminar_ParseEntry`:

| Field | Type | Description |
|---|---|---|
| `type` | `string` | Type name for nodes matched by this entry (e.g. `"variable"`, `"code"`) |
| `start_tag` | `string` | Opening delimiter string (e.g. `"{!"`) |
| `end_tag` | `string` | Closing delimiter string (e.g. `"}"`, `"\n"`) |

**Returns** `Luminar_ParsedNode[]` — ordered list of nodes:

| Field | Type | Description |
|---|---|---|
| `type` | `string` | Node type (`non_tag` value or an entry `type`) |
| `content` | `string` | Extracted content, without the delimiters |

**Example**

```lua
local Luminar = require("Luminar")

local parsed = Luminar.parse({
    content = "Hello {!name}, you are eval-lua: age\n years old.",
    props = {
        non_tag = "text",
        entries = {
            {type = "variable", start_tag = "{!", end_tag = "}"},
            {type = "code",     start_tag = "eval-lua: ", end_tag = "\n"},
        }
    }
})
-- parsed[1] = {type="text",     content="Hello "}
-- parsed[2] = {type="variable", content="name"}
-- parsed[3] = {type="text",     content=", you are "}
-- parsed[4] = {type="code",     content="age"}
-- parsed[5] = {type="text",     content=" years old."}
```

---

## Luminar.generate(config)

Converts a parsed document into a code string by applying per-type modifiers.

**Parameters**

| Field | Type | Description |
|---|---|---|
| `config.parsed_document` | `Luminar_ParsedNode[]` | Output of `Luminar.parse()` |
| `config.props` | `Luminar_GenerationProps` | Generation options (use `create_generation_props()` for defaults) |

`Luminar_GenerationProps`:

| Field | Type | Description |
|---|---|---|
| `before` | `string` | Prepended to the output (before the first node) |
| `after` | `string` | Appended to the output (after the last node) |
| `modifiers` | `table<string, Luminar_GenerationModifier>` | Map from node type to a modifier. Node types with no entry are emitted as raw content. |

`Luminar_GenerationModifier`:

| Field | Type | Description |
|---|---|---|
| `before` | `string` | Prepended to the node's content |
| `after` | `string` | Appended to the node's content |

**Returns** `string` — the generated output, with each piece joined by newlines.

**Example**

```lua
local generation = Luminar.generate({
    parsed_document = parsed,
    props = {
        before = "return (function() local buf = {}",
        after  = "return table.concat(buf,'') end)()",
        modifiers = {
            variable = {before = "buf[#buf+1] = ",       after = ";"},
            text     = {before = "buf[#buf+1] = [[ ",    after = " ]];"},
        }
    }
})
```

---

## Evaluating the generated code

`Luminar.generate()` returns a plain Lua string — a self-contained closure that, when executed, renders the template.  
Use the standard `load()` function to compile and run it, passing a table that exposes your template variables as the chunk's environment.

```lua
local env = { name = "Alice", age = 25 }
setmetatable(env, { __index = _G })   -- fall back to globals for built-ins

local fn, err = load(generation, "template", "t", env)
if not fn then
    error("failed to load generated code: " .. tostring(err))
end

local result = fn()
-- result is the rendered string
print(result)
```

**How it works**

| Step | What happens |
|---|---|
| `load(generation, ...)` | Compiles the generated Lua string into a callable function |
| `env` table | Supplies the template variables (`name`, `age`, …) that the code references |
| `setmetatable(env, {__index=_G})` | Lets the template code still call Lua built-ins (`tostring`, `pairs`, …) |
| `fn()` | Executes the closure and returns the rendered string |

**Error handling**

`load` returns `nil, error_message` when the generated code has a syntax error.  
The rendered closure itself can raise a runtime error (e.g. calling a nil variable).  
Wrap both in `pcall` for production use:

```lua
local fn, load_err = load(generation, "template", "t", env)
assert(fn, load_err)

local ok, result = pcall(fn)
if not ok then
    -- result contains the runtime error message
    error("template render failed: " .. result)
end
print(result)
```

---

## Luminar.create_parse_props()

Returns the default parse props with `{!...}` as variable tags and `eval-lua: ...\n` as code tags.

**Returns** `Luminar_ParseProps`

---

## Luminar.create_generation_props()

Returns the default generation props that produce a self-contained Lua closure using an internal accumulator table.

**Returns** `Luminar_GenerationProps`
