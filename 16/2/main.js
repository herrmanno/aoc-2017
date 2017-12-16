const fs = require("fs")

const input = fs.readFileSync(__dirname + "/input.txt").toString().split(",")

function dance(input, progs) {
    for (const cmd of input) {
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
    return progs
}

const origProgs = Array.apply(null, {length: 16}).map((_, i) => String.fromCharCode(97 + i))
let progs = [...origProgs]
const states = [origProgs.join("")]

const ONE_BILLION = 1000000000
for (let i = 0; i < ONE_BILLION; i++) {
    progs = dance(input, [...progs])
    stateStr = progs.join("")
    if (states.indexOf(stateStr) !== -1) {
        const diff = (i+1) - states.indexOf(stateStr)
        i += ~~((ONE_BILLION - i) / diff) * diff
    }
    states.push(progs.join(""))
}

console.log(`The progs stand in the folloing order after one billion dances: ${progs.join("")}`)