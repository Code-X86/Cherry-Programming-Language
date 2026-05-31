# MathCore

Cherry 0.2.0 adds built-in math without requiring a package install.

```cherry
import math

print(math.pi)
print(math.sqrt(16))
print(math.pow(2, 8))
print(math.randomInt(1, 10))
```

Constants: `pi`, `tau`, `e`, `inf`, `nan`.

Functions: `abs`, `floor`, `ceil`, `round`, `trunc`, `sqrt`, `cbrt`,
`pow`, `exp`, `ln`, `log10`, `log2`, `sin`, `cos`, `tan`, `asin`, `acos`,
`atan`, `atan2`, `min`, `max`, `clamp`, `deg`, `rad`, `random`,
`randomInt`.

Invalid domains report runtime errors. For example, `math.sqrt(-1)` fails
because Cherry does not create complex numbers in v0.2.0.
