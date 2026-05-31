import math
import graph

fn main() {
    let radius = 4
    let area = math.pi * radius ** 2
    print(area)

    let nums = [1, 4, 9, 16]
    nums.push(25)
    print(nums.len())
    print(math.sqrt(nums[2]))

    for i in 0..=4 {
        print(i)
    }

    graph.bar(nums)
}
