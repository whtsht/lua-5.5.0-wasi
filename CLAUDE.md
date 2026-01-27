# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is Lua 5.5.0, a lightweight embeddable scripting language written in ISO C (C99). Released December 15, 2025.

## Build Commands

```bash
# Build for current platform (auto-detect)
make

# Build for specific platform
make linux        # Linux
make macosx       # macOS
make mingw        # Windows MinGW
make freebsd      # FreeBSD/NetBSD/OpenBSD
make posix        # Generic POSIX
make c89          # C89 compatibility mode

# Show available platforms
make help

# Clean build artifacts
make clean

# Test (runs lua -v to verify build)
make test

# Install system-wide (to /usr/local by default)
sudo make install

# Install locally (creates install/ subdirectory)
make local
```

## Build Output

All build artifacts are in `src/`:
- `lua` - Lua interpreter
- `luac` - Lua bytecode compiler
- `liblua.a` - Static library

## Running Lua

```bash
src/lua              # Interactive REPL
src/lua script.lua   # Run a script
src/lua -v           # Show version
src/luac -o out.luac script.lua  # Compile to bytecode
src/luac -l script.lua           # List bytecode disassembly
```

## Architecture

All source code is in `src/`. The codebase has three main layers:

### Core VM (CORE_O)
The virtual machine and runtime:
- `lvm.c` - VM execution engine (main interpreter loop)
- `lparser.c` / `llex.c` / `lcode.c` - Parser, lexer, code generator
- `lgc.c` - Garbage collector (generational/incremental)
- `ldo.c` - Stack and call management
- `ltable.c` - Table (hash table) implementation
- `lstring.c` - String interning
- `lobject.c` - Object type system
- `lstate.c` - Lua state management
- `lapi.c` - C API implementation

### Standard Libraries (LIB_O)
Libraries available to Lua scripts:
- `lbaselib.c` - Base functions (print, assert, type, etc.)
- `lstrlib.c` - String library
- `ltablib.c` - Table library
- `lmathlib.c` - Math library
- `liolib.c` - I/O library
- `loslib.c` - OS library
- `lcorolib.c` - Coroutine library
- `ldblib.c` - Debug library
- `lutf8lib.c` - UTF-8 library
- `loadlib.c` - Package/module loading
- `linit.c` - Library initialization

### Entry Points
- `lua.c` - Stand-alone interpreter
- `luac.c` - Bytecode compiler

### Key Headers
- `lua.h` - Main API
- `luaconf.h` - Configuration (customize Lua features here)
- `lauxlib.h` - Auxiliary library for C extensions
- `lualib.h` - Standard library interface

## Compiler Flags

The Makefile uses `gcc -std=gnu99 -O2 -Wall -Wextra`. Platform-specific defines:
- `LUA_USE_LINUX` - Linux (dlopen, readline)
- `LUA_USE_MACOSX` - macOS
- `LUA_USE_POSIX` - Generic POSIX
- `LUA_USE_C89` - C89 compatibility

Custom flags via `MYCFLAGS`, `MYLDFLAGS`, `MYLIBS` variables.

## Documentation

Full documentation in `doc/`:
- `doc/readme.html` - Installation guide
- `doc/manual.html` - Complete reference manual
