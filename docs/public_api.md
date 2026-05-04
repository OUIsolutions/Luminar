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

## Luminar.create_parse_props()

Returns the default parse props with `{!...}` as variable tags and `eval-lua: ...\n` as code tags.

**Returns** `Luminar_ParseProps`

---

## Luminar.create_generation_props()

Returns the default generation props that produce a self-contained Lua closure using an internal accumulator table.

**Returns** `Luminar_GenerationProps`
