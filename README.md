<div align="center">

<img src="assets/logo2.png" width="200" alt="Cherry Logo">

# Cherry

A fast, simple, Rust-powered programming language.

**Easy to learn. Fast to run. Built for developers.**

</div>

---

## What is Cherry?

Cherry is an independent programming language written in Rust. While Cherry itself is implemented in Rust, Cherry programs are **not Rust programs** and do not require Rust to execute. Cherry has its own lexer, parser, runtime, package manager, and execution engine.

Cherry was created as a hobby project with a simple goal:

> Build a language that feels as easy and productive as Python while providing a cleaner architecture, faster parsing, native extensibility, and a modern package system.

Unlike wrappers, transpilers, or Python frontends, Cherry executes its own source code through the Cherry runtime.

```text
Cherry Source (.ch)
        ↓
   Cherry Parser
        ↓
   Cherry Runtime
        ↓
      Output
```

Rust powers the implementation, but Rust does not execute Cherry programs. The Cherry runtime does.

---

## Why Cherry?

* Simple syntax inspired by Python
* Fast Rust-powered implementation
* Custom parser designed for speed and simplicity
* Native package system
* Cross-platform support
* Easy-to-read code
* Designed for hobbyists, students, and developers
* Built to grow beyond Python's limitations
* Native Rust extension support

---

## Native Packages

Cherry packages use the `.chy` format.

A `.chy` package is a compressed package archive containing metadata and native modules built in Rust.

```text
mathplus.chy
├── Ident.toml
└── bin/
```

Packages can expose functions directly to Cherry:

```cherry
import mathplus

print(mathplus.add(5, 10))
```

Native packages are compiled for their target platforms and can provide high-performance functionality while remaining easy to use from Cherry code.

---

## Development

Cherry is primarily developed with assistance from OpenAI's GPT-5.5. Large portions of the codebase, architecture, documentation, and prototypes are generated with AI assistance.

All generated code is reviewed, modified, debugged, optimized, and maintained by the me. Many systems have been manually adjusted, improved, and refactored beyond their original generated versions.

---

## Example

```cherry
import mathplus

fn main() {
    let result = mathplus.add(5, 10)
    print(result)
}
```

---

## Goals

Cherry aims to be:

* Simpler than large modern languages
* Faster to parse than traditional scripting languages
* Easy to extend with native modules
* Friendly for beginners
* Powerful enough for real projects
* Fun to experiment with and build

---

## Warning

Cherry is currently an experimental hobby project.

Cherry is under active development and is **not recommended for security-sensitive, safety-critical, or commercial production applications at this time**.

This includes, but is not limited to:

* Authentication systems
* Financial software
* Medical software
* Critical infrastructure
* Enterprise production systems
* Security tools

The language, runtime, package system, APIs, and specifications may change without notice, and bugs or security issues may exist.

Use Cherry for learning, experimentation, hobby projects, prototypes, and exploration while the language matures.

---

## Status

Early Development

Features, syntax, package formats, APIs, and runtime behavior are subject to change as the language evolves.
