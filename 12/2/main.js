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

const sets = new Set()

for (const id in Object.keys(map)) {

    const idExistsinSomeSet = [...sets].some(set => set.has(id))
    if (idExistsinSomeSet) continue

    const set = new Set()
    const queue = [...map[id]]
    while (queue.length) {
        const el = queue.shift()
        if (set.has(el)) continue
        set.add(el)
        queue.push(...map[el])
    }

    sets.add(set)

}

console.log(`There are ${sets.size} different groups of programs`)