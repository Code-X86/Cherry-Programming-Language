# Bootstrap

Bootstrap installs or updates the `cherry` executable in the user Cherry bin
directory:

- Linux: `~/.cherry/bin/cherry`
- Windows: `%USERPROFILE%\.cherry\bin\cherry.exe`

```sh
cherry bootstrap
cherry bootstrap --yes
cherry bootstrap --force
cherry bootstrap --target /custom/path
cherry bootstrap --no-path-edit
```

Flags:

- `--yes`: approve prompts automatically
- `--force`: replace existing files even when version checks are not useful
- `--target <path>`: install to a custom file or directory
- `--no-path-edit`: do not edit shell startup files or the user PATH

If an executable already exists at the target path, Cherry creates a `.bak`
backup before replacing it.
