const fs = require("fs")

const instructions = fs.readFileSync(__dirname + "/" + "input.txt").toString().split("\n")

let send = null
let registers = new Proxy({}, {
    get(target, key) {
        return target[key] || 0
    },
    set(target, key, value) {
        return (target[key] = value)
    }
})

function get(s) {
    if (s >= 'a') {
        return registers[s]
    } else {
        return +s
    }
}

function set(s, v) {
    return registers[s] = get(v)
}

let ip = 0
while (ip < instructions.length) {
    const [cmd, arg1, arg2] = instructions[ip].split(" ")
    switch (cmd) {
        case "snd": send = get(arg1); break
        case "set": set(arg1, arg2); break
        case "add": set(arg1, get(arg1) + get(arg2)); break
        case "mul": set(arg1, get(arg1) * get(arg2)); break
        case "mod": set(arg1, get(arg1) % get(arg2)); break
        case "rcv": console.log(`Recovered value is: ${send}`); return
        case "jgz": {
            if (get(arg1) > 0) {
                ip += (get(arg2) - 1)
            }
        }
    }
    ip++
}