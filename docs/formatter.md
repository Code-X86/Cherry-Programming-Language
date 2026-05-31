# Formatter

Format a Cherry source file in place:

```sh
cherry fmt src/main.ch
```

The formatter parses the file and prints it back with consistent indentation,
brace placement, comma spacing, and operator spacing. Comments are not preserved
yet because Cherry's parser currently stores syntax, not trivia.
