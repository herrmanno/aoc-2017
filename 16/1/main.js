const fs = require("fs")

const input = fs.readFileSync(__dirname + "/input.txt").toString()

let progs = Array.apply(null, {length: 16}).map((_, i) => String.fromCharCode(97 + i))
for (const cmd of input.split(",")) {
    switch (cmd[0]) {
    case "s": {
        const amount = +cmd.match(/s(\d+)/)[1]
        progs = [...progs.slice(-1 * amount), ...progs.slice(0, -1 * amount)]
        break
    }
    case "x": {
        const [n, m] = cmd.match(/x(\d+)\/(\d+)/).slice(1)
        progs.splice(n, 1, progs.splice(m, 1, progs[n])[0])
        break
    }
    case "p": {
        const [a, b] = cmd.match(/p(\w)\/(\w)/).slice(1)
        const [n, m] = [a, b].map(e => progs.indexOf(e))
        progs.splice(n, 1, progs.splice(m, 1, progs[n])[0])
        break
    }
    }
}

console.log(`The programs stand in the following order after dancing: ${progs.join("")}`)