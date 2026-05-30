# Package System

Cherry packages use `.chy` archives. A `.chy` file is a ZIP file with a specific
layout and an `Ident.toml` manifest.

## Archive Layout

```text
Ident.toml
README.md
LICENSE
bin/
  windows-x86_64/package.dll
  linux-x86_64/libpackage.so
  macos-aarch64/libpackage.dylib
```

Only the target for the current OS and architecture is required for local testing,
but publishable packages should include every supported target listed in
`Ident.toml`.

## Manifest

Example:

```toml
name = "widgets"
version = "0.1.0"
type = "app"
description = "Configurable terminal UI widgets for Cherry"
author = "Austin Miller"
license = "MIT"
cherry_version = ">=0.1.0"
entry = "widgets"

[dependencies]

[permissions]
filesystem = false
network = false
process = false
terminal = true
keyboard = true
camera = false
microphone = false

[capabilities]
kind = "tui"
interactive = true
entry = "run"

[exports]
name = "widgets"
version_code = 1
supports_buttons = true

[exports.theme]
primary = "red"
accent = "green"

[[targets]]
os = "linux"
arch = "x86_64"
file = "bin/linux-x86_64/libwidgets.so"
sha256 = "..."

[api.run]
args = []
returns = "none"
```

## Top-Level Fields

`name`
: Package import name.

`version`
: Package version.

`type`
: Package kind. Current examples use `library` or `app`.

`description`
: Human-readable description shown by `cherry info`.

`author`
: Package author.

`license`
: License name.

`cherry_version`
: Declares compatible Cherry versions. This is parsed but not fully enforced yet.

`entry`
: Main package namespace.

## Dependencies

Dependencies are parsed from:

```toml
[dependencies]
stringtools = "^1.2.0"
```

Cherry currently parses dependency metadata but does not yet resolve or download
transitive dependencies.

## Permissions

Supported permission fields:

```toml
[permissions]
filesystem = false
network = false
process = false
terminal = false
keyboard = false
camera = false
microphone = false
```

Permission enforcement is basic in v1. Cherry displays requested permissions
during install and records them in the package manifest. Native package authors
are expected to declare the permissions they use.

`terminal` and `keyboard` are used for interactive TUI packages.

## Capabilities

Capabilities describe package behavior:

```toml
[capabilities]
kind = "tui"
interactive = true
entry = "run"
```

`kind`
: Describes the package category, such as `library`, `terminal`, or `tui`.

`interactive`
: Marks packages that take over terminal interaction.

`entry`
: Suggested main function to call.

## Exports

Packages can expose static data without recompiling Cherry:

```toml
[exports]
title = "Cherry TUI Demo"
version_code = 1
interactive = true

[exports.theme]
primary = "red"
accent = "pink"
```

Cherry code:

```cherry
import tuidemo

fn main() {
    print(tuidemo.title)
    print(tuidemo.theme.primary)
}
```

Supported export value types:

- string
- integer
- float
- boolean
- nested TOML tables

Unsupported export value types:

- arrays
- dates
- dynamic native-generated objects

## Targets

Targets declare native binaries:

```toml
[[targets]]
os = "linux"
arch = "x86_64"
file = "bin/linux-x86_64/libwidgets.so"
sha256 = "..."
```

Installer behavior:

1. detects current OS and architecture
2. finds a matching target
3. reads the target binary from the archive
4. computes SHA256
5. rejects the package if the hash does not match

Unsupported target error format:

```text
Package 'mathplus' does not support:
OS: freebsd
ARCH: x86_64

Supported targets:
- windows x86_64
- linux x86_64
- macos aarch64
```

## API

API entries describe callable native functions:

```toml
[api.button]
args = ["string", "string"]
returns = "none"
```

The interpreter checks argument count and type before calling the native symbol.

## Install Location

Cherry supports project-local and global package stores.

If `cherry install` is run inside a directory tree containing `Cherry.toml`,
packages are extracted to the project:

```text
./.cherry/packages/<name>/<version>/
```

The project lockfile is:

```text
./.cherry/Cherry.lock
```

If no `Cherry.toml` is found in the current directory or any parent directory,
packages are installed globally:

```text
~/.cherry/packages/<name>/<version>/
```

The global lockfile is:

```text
~/.cherry/Cherry.lock
```

Example project-local install:

```sh
cd examples/sample_project
../../target/debug/cherry install ../widgets.chy
```

This creates:

```text
examples/sample_project/.cherry/packages/widgets/0.1.0/
```

## Import Search Order

When Cherry loads:

```cherry
import widgets
```

it searches:

1. active project-local package store
2. global package store

That lets a project pin or override a package without changing the global
installation.

## Global Install Example

From a directory that is not inside a Cherry project:

```text
~/.cherry/packages/widgets/0.1.0/
```
