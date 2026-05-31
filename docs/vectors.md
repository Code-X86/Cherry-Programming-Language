# Vectors

Cherry has `vec2`, `vec3`, and `vec4` constructors.

```cherry
let a = vec3(1, 2, 3)
let b = vec3(4, 5, 6)

print(a.x)
print(a + b)
print(a.dot(b))
print(a.cross(b))
print(a.normalize())
```

Supported fields are `x`, `y`, `z`, and `w` when present. Supported operators
are vector addition, vector subtraction, vector multiplied by a number, and
vector divided by a number.

Methods: `length()`, `lengthSquared()`, `normalize()`, `dot(other)`,
`distance(other)`, `lerp(other, t)`, and `cross(other)` for `vec3`.
