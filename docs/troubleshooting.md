# Troubleshooting

## `cargo: command not found`

The Rust toolchain exists on this machine, but Cargo is not on `PATH` in the
default shell.

Use:

```sh
PATH="/home/mikehawk/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin:$PATH" \
/home/mikehawk/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/cargo check
```

## Installed `cherry` Is Older Than The Source

If this command:

```sh
command -v cherry
```

prints:

```text
/home/mikehawk/.cargo/bin/cherry
```

then `cherry ...` is using the installed binary. It may not include recent source
changes.

Use the local build:

```sh
target/debug/cherry run examples/tui_widgets.ch
```

Or reinstall:

```sh
PATH="/home/mikehawk/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin:$PATH" \
/home/mikehawk/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/cargo install --path .
```

## Disable First-Run Bootstrap

Cherry checks for an installed `cherry` command on startup. When it is missing,
Cherry creates:

```text
~/.cherry/bin/cherry
```

It also adds `~/.cherry/bin` to `.profile`, `.bashrc`, and `.zshrc` if needed.
Cherry updates `PATH` for its own process immediately, but it cannot permanently
export into the already-running parent shell.

Disable that behavior for one command:

```sh
CHERRY_SKIP_BOOTSTRAP=1 cherry doctor
```

## Install Rust Automatically

Cherry will not silently run a remote Rust installer. To allow Rust installation
through rustup, opt in explicitly:

```sh
CHERRY_AUTO_INSTALL_RUST=1 cherry bootstrap
```

This uses `curl` and `sh` to run the official rustup installer with:

```text
-y --profile minimal
```

## `libbz2.so.1.0` Missing When Running `cherry`

If the installed binary reports:

```text
cherry: error while loading shared libraries: libbz2.so.1.0: cannot open shared object file
```

then the binary was built with an optional ZIP backend that depends on a missing
system library. Cherry disables that optional backend in `Cargo.toml` and only
uses ZIP deflate support:

```toml
zip = { version = "0.6", default-features = false, features = ["deflate"] }
```

Reinstall Cherry:

```sh
PATH="/home/mikehawk/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin:$PATH" \
/home/mikehawk/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/cargo install --path .
```

## `native signature for 'title' is not supported in v1 FFI bridge`

This means the running Cherry binary does not include string argument FFI support.

Fix:

```sh
PATH="/home/mikehawk/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin:$PATH" \
/home/mikehawk/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/cargo install --path .
```

Then rerun:

```sh
cherry run examples/tui_widgets.ch
```

Or bypass the installed binary:

```sh
target/debug/cherry run examples/tui_widgets.ch
```

## TUI Fails In A Non-Interactive Shell

TUI packages need a real terminal. Running a TUI through a non-interactive command
capture can fail with an OS terminal error.

Run directly from your terminal:

```sh
target/debug/cherry run examples/tui_widgets.ch
```

Then press `q` to exit.

## Package SHA256 Mismatch

If a native library changes, the hash in `Ident.toml` must be updated.

From the package directory:

```sh
sha256sum bin/linux-x86_64/libwidgets.so
```

Paste the new hash into the matching `[[targets]]` entry, rebuild the `.chy`, and
install again.

## Package Installed But Import Cannot Find It

Imports search the active project-local package store first, then the global
package store.

Check where Cherry is looking:

```sh
target/debug/cherry doctor
```

If you installed a package inside a project, run Cherry from that project
directory:

```sh
cd examples/sample_project
../../target/debug/cherry run src/main.ch
```

If you run Cherry from somewhere else, it may use the global package store
instead.

## Unsupported Package Target

Packages must contain a target matching the current OS and architecture.

Check the current platform:

```sh
target/debug/cherry doctor
```

Then make sure `Ident.toml` has a matching target:

```toml
[[targets]]
os = "linux"
arch = "x86_64"
file = "bin/linux-x86_64/libwidgets.so"
sha256 = "..."
```
