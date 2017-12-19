const fs = require("fs")

const instructions = fs.readFileSync(__dirname + "/" + "input.txt").toString().split("\n")

class Program {

    constructor(instructions, id, sndQueue, rcvQueue) {
        this.instructions = instructions
        this.id = id
        this.sndQueue = sndQueue
        this.rcvQueue = rcvQueue
        this.send = 0
        this.ip = 0
        this.registers = new Proxy({p: id}, {
            get(target, key) {
                return target[key] || 0
            },
            set(target, key, value) {
                target[key] = value
                return true
            }
        })
    }

    get(s) {
        if (s >= 'a') {
            return this.registers[s]
        } else {
            return +s
        }
    }

    set(s, v) {
        return this.registers[s] = this.get(v)
    }

}

function run(prog) {
    let ic = prog.ip < prog.instructions.length ? 0 : -1    
    loop: while (prog.ip < prog.instructions.length) {
        const [cmd, arg1, arg2] = prog.instructions[prog.ip].split(" ")
        switch (cmd) {
            case "snd": prog.sndQueue.push(prog.get(arg1)); prog.send++ ; break
            case "set": prog.set(arg1, arg2); break
            case "add": prog.set(arg1, prog.get(arg1) + prog.get(arg2)); break
            case "mul": prog.set(arg1, prog.get(arg1) * prog.get(arg2)); break
            case "mod": prog.set(arg1, prog.get(arg1) % prog.get(arg2)); break
            case "rcv": {
                if (prog.rcvQueue.length) {
                    prog.set(arg1, prog.rcvQueue.shift())
                    break
                } else {
                    break loop
                }
            }
            case "jgz": {
                if (prog.get(arg1) > 0) {
                    prog.ip += (prog.get(arg2) - 1)
                }
            }
        }
        prog.ip++
        ic++
    }
    return ic
}

const q0_1 = []
const q1_0 = []
const prog0 = new Program(instructions, 0, q0_1, q1_0)
const prog1 = new Program(instructions, 1, q1_0, q0_1)


let i = 0
const progs = [prog0, prog1]
let state = [-1, -1]
while (true) {
    state[i] = run(progs[i])
    if (state.every(ic => ic === -1)) {
        console.log("Both programs finished")
        break
    } else if(state.every(ic => ic === 0)) {
        console.log("Deadlock:")
        break
    }
    i ^= 1
}

console.log(`Program 1 send ${prog1.send} times`)