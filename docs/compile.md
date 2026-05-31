# Compile

`cherry compile <file.ch>` turns a Cherry source file into a native Linux ELF
executable.

```sh
cherry compile app.ch
./app
```

You can choose the output path:

```sh
cherry compile app.ch ./dist/my-app
```

The compiled executable embeds the `.ch` source and links the Cherry interpreter
into the native binary. It runs the embedded script immediately when launched,
so users do not need to run `cherry run`.

Notes:

- Linux ELF output is supported first.
- `cargo` is required at compile time.
- The result does not need the `cherry` command to run.
- Native `.chy` package imports still need those packages installed where the
  embedded app runs.
