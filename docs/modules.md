# Built-In Modules

Cherry can import built-in modules directly:

- `math`: numeric constants and functions
- `console`: `log`, `warn`, `error`, `clear`
- `time`: `now`, `unix`, `sleep`
- `random`: `float`, `int`, `bool`, `choice`
- `graph`: `plot`, `bar`, `points`
- `fs`: `readText`, `exists`
- `system`: `os`, `arch`, `env`
- `window`: `create`
- `requests`: `get`, `post`, `put`, `delete`, `head`, `fetch`, `download`

Native `.chy` packages still work. Imports look for built-ins first, then
installed project-local packages, then global packages.
