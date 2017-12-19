const fs = require("fs")

const input = fs.readFileSync(__dirname + "/input.txt").toString()
const maze = input.split("\n").map(line => line.split("").map(c => c.trim()))

let pos = [0, maze[0].findIndex(Boolean)]
let lastPos = [-1, pos[1]]

let steps = 0

const path = []
while (true) {
    const [lastY, lastX] = lastPos
    const [y, x] = pos
    const direction = (() => {
        if (y > lastY) return "DOWN"
        if (y < lastY) return "UP"
        if (x > lastX) return "RIGHT"
        if (x < lastX) return "LEFT"
    })()
    const next = {
        up: maze[y - 1] && maze[y - 1][x],
        down: maze[y + 1] && maze[y + 1][x],
        left: maze[y][x - 1],
        right: maze[y][x + 1]
    }
    
    lastPos = pos
    steps++

    if (/\w/.test(maze[y][x])) {
        path.push(maze[y][x])
    }

    if (direction === "DOWN") {
        if (next.down) {
            pos = [y + 1, x]
        } else if (next.right) {
            pos = [y, x + 1]
        } else if (next.left) {
            pos = [y, x - 1]
        } else {
            break
        }
    }

    else if (direction === "UP") {
        if (next.up) {
            pos = [y - 1, x]
        } else if (next.right) {
            pos = [y, x + 1]
        } else if (next.left) {
            pos = [y, x - 1]
        } else {
            break
        }
    }

    else if (direction === "RIGHT") {
        if (next.right) {
            pos = [y, x + 1]
        } else  if (next.up) {
            pos = [y - 1, x]
        } else  if (next.down) {
            pos = [y + 1, x]
        } else {
            break
        }
    }

    else if (direction === "LEFT") {
        if (next.left) {
            pos = [y, x - 1]
        } else  if (next.up) {
            pos = [y - 1, x]
        } else  if (next.down) {
            pos = [y + 1, x]
        } else {
            break
        }
    }    
}

console.dir(`The packet passed the following Letters on its path: ${path.join("")}`)
console.dir(`The packet took ${steps}  steps on its path`)