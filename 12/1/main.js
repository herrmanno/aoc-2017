const fs = require("fs")

const input = fs.readFileSync("input.txt").toString()
const lines = input.split("\n")

const map = {}
for (const line of lines) {
    const [_, from, toList] = line.split(/(\d+) <-> (.*)/)
    const tos = toList.split(",").map(t => t.trim())
    map[from] = map[from] || new Set()
    tos.forEach(t => map[from].add(t))
    for (const to of tos) {
        map[to] = map[to] || new Set()
        map[to].add(from)
    }
}

const set = new Set()
const queue = [...map["0"]]
while (queue.length) {
    const el = queue.shift()
    if (set.has(el)) continue
    set.add(el)
    queue.push(...map[el])
}

console.dir(`There are ${set.size} programs that can talk with program "0"`)