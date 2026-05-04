<div align="center">

# Luminar
![Lua Logo](https://img.shields.io/badge/Luminar-0.0.1-blue?style=for-the-badge&logo=lua)
[![GitHub Release](https://img.shields.io/github/release/OUIsolutions/Luminar.svg?style=for-the-badge)](https://github.com/OUIsolutions/Luminar/releases)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](https://github.com/OUIsolutions/Luminar/blob/main/LICENSE)
![Status](https://img.shields.io/badge/Status-Alpha-orange?style=for-the-badge)
![Platforms](https://img.shields.io/badge/Platforms-Windows%20|%20Linux%20|%20macOS-lightgrey?style=for-the-badge)

</div>

---

## ⚠️ Important Notice

> **This is alpha software!** Use at your own risk. While we're working hard to make it stable, bugs are expected. Perfect for learning and prototyping! 🧪

---

### Overview

**Luminar** is a lightweight, embeddable Lua template engine that lets you mix plain text with variables and Lua code blocks. It works by parsing a template string into typed nodes, generating a self-contained Lua closure from those nodes, and evaluating the closure against a provided environment table — all without external dependencies.

### Key Features

- **Simple syntax** — embed variables with `{!name}` and Lua code blocks with `eval-lua: ...`
- **Pure Lua** — single-file library, no C extensions or external dependencies
- **Customizable** — bring your own delimiters and generation modifiers via `parse_props` / `generation_props`
- **Safe evaluation** — templates run in an isolated environment table; globals are only exposed when you opt in
- **High-level API** — `Luminar.evaluate()` handles parse → generate → load → run in one call
- **Cross-platform** — works on Windows, Linux, and macOS

## Quick Example

```lua
---@type LuminarPublicModuleClass
local Luminar = require("Luminar")


local result = Luminar.evaluate({
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
```

## Releases

| **File** | **Description** |
|----------|-----------------|
| [Luminar.lua](https://github.com/OUIsolutions/Luminar/releases/download/0.0.1/Luminar.lua) | The library in plain lua code |
| [LuminarTypes.lua](https://github.com/OUIsolutions/Luminar/releases/download/0.0.1/LuminarTypes.lua) | The library type annotations |

## Installation Tutorials

To install the library, you just need to download it and import it with `require`.

### Download the lib 
```bash
curl -L "https://github.com/OUIsolutions/Luminar/releases/download/0.0.1/Luminar.lua" -o "Luminar.lua"
```

### Import the lib
```lua
local Luminar = require("Luminar")
```

## [Public API](docs/public_api.md)
Click here [Public API](docs/public_api.md) to see the full list of public API functions.

## Documentation & Samples 

| **Documentation** | **Description** |
|-------------------|-----------------|
| [Build](docs/build.md) | How to build the project |
| [Samples](/samples) | Examples of how to use the library |

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---