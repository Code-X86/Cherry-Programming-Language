# Windows Support

Cherry is intended to build and run on:

- Linux x86_64
- Windows x86_64

Windows native packages should use `.dll` files:

```toml
[[targets]]
os = "windows"
arch = "x86_64"
file = "bin/windows-x86_64/package.dll"
sha256 = "..."
```

Linux native packages continue to use `.so` files:

```toml
[[targets]]
os = "linux"
arch = "x86_64"
file = "bin/linux-x86_64/libpackage.so"
sha256 = "..."
```

Cherry reports OS names as `windows`, `linux`, or `macos`, and architecture as
values like `x86_64` or `aarch64`.
