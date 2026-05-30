<div align="center">

<img src="assets/logo2.png" width="200" alt="Cherry Logo">

# Cherry

A fast, simple, Rust-powered programming language.

**Easy to learn. Fast to run. Built for developers.**

</div>

---

## What is Cherry?

Cherry is an independent programming language written in Rust. While Cherry is implemented in Rust, Cherry code is **not Rust code** and does not require Rust to run. Cherry has its own lexer, parser, runtime, package manager, and execution engine.

Cherry was created as a hobby project with a simple goal:

> Make a language that feels as easy and productive as Python while providing a cleaner architecture, faster parsing, native extensibility, and a modern package system.

Unlike transpilers or wrappers, Cherry executes its own source code directly through the Cherry runtime.

```text
Cherry Source (.ch)
        ↓
   Cherry Parser
        ↓
   Cherry Runtime
        ↓
      Output