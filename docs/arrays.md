# Arrays And Ranges

Arrays use square brackets and can be indexed with integers.

```cherry
let nums = [1, 2, 3]
nums.push(4)
nums[0] = 99
print(nums.len())
print(nums.pop())
```

Methods: `len()`, `push(value)`, `pop()`, `clear()`, `contains(value)`, and
`reverse()`.

Ranges use `..` for exclusive end and `..=` for inclusive end.

```cherry
for i in 0..10 {
    print(i)
}

for i in 1..=3 {
    print(i)
}
```
