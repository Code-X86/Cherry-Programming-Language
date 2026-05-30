# Native Packages

Native packages are Rust `cdylib` crates loaded by Cherry at runtime.

They do not require recompiling Cherry. The package is compiled separately,
archived as `.chy`, installed with `cherry install`, and then imported from
Cherry source.

## Minimal Native Package

Rust:

```rust
#[no_mangle]
pub extern "C" fn add(a: i64, b: i64) -> i64 {
    a + b
}
```

Manifest:

```toml
[api.add]
args = ["int", "int"]
returns = "int"
```

Cherry:

```cherry
import mathplus

fn main() {
    print(mathplus.add(2, 3))
}
```

## Rust Crate Settings

`Cargo.toml`:

```toml
[lib]
crate-type = ["cdylib"]
```

## Function ABI

Every exported function uses C ABI:

```rust
#[no_mangle]
pub extern "C" fn open() {
    // ...
}
```

## Supported Native Signatures

Current FFI support:

```text
() -> none
() -> int
() -> float
() -> bool
(int) -> int
(float) -> float
(int, int) -> int
(float, float) -> float
(string) -> none
(string, string) -> none
```

Cherry type mapping:

```text
int    -> i64
float  -> f64
bool   -> bool
string -> *const c_char
none   -> void
```

## String Arguments

Cherry string arguments are passed as null-terminated C strings.

Rust native function:

```rust
use std::ffi::{c_char, CStr};

#[no_mangle]
pub extern "C" fn title(value: *const c_char) {
    if value.is_null() {
        return;
    }

    let text = unsafe { CStr::from_ptr(value) }
        .to_str()
        .unwrap_or("");

    println!("{text}");
}
```

Manifest:

```toml
[api.title]
args = ["string"]
returns = "none"
```

Cherry:

```cherry
widgets.title("Cherry Widget Builder")
```

## Building a Package

From the native package directory:

```sh
PATH="/home/mikehawk/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin:$PATH" \
/home/mikehawk/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/cargo build --release
```

Copy the produced library:

```sh
mkdir -p bin/linux-x86_64
cp target/release/libwidgets.so bin/linux-x86_64/libwidgets.so
```

Compute SHA256:

```sh
sha256sum bin/linux-x86_64/libwidgets.so
```

Paste the hash into `Ident.toml`.

Create the `.chy` archive:

```sh
zip -qr ../widgets.chy Ident.toml README.md LICENSE bin
```

Install it:

```sh
target/debug/cherry install examples/widgets.chy
```

## Package Examples

### `native_mathplus`

Location:

```text
examples/native_mathplus/
```

Exports:

- `add(int, int) -> int`
- `mul(int, int) -> int`

### `native_wikiview`

Location:

```text
examples/native_wikiview/
```

Uses:

- `reqwest`
- Wikimedia page summary endpoint
- stdin/stdout

API:

```text
open() -> none
```

Cherry:

```cherry
import wikiview

fn main() {
    wikiview.open()
}
```

### `native_tui_demo`

Location:

```text
examples/native_tui_demo/
```

Uses:

- `crossterm`
- terminal alternate screen
- keyboard input

API:

```text
open() -> none
```

### `native_tui_widgets`

Location:

```text
examples/native_tui_widgets/
```

Uses string arguments to configure a TUI from Cherry source.

API:

```text
clear() -> none
title(string) -> none
label(string) -> none
button(string, string) -> none
status(string) -> none
run() -> none
```

