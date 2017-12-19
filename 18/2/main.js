const fs = require("fs")

const instructions = fs.readFileSync(__dirname + "/" + "input.txt").toString().split("\n")

class Program {

    constructor(instructions, id, queue) {
        this.instructions = instructions
        this.id = id
        this.queue = queue
        this.ip = 0
        this.registers = new Proxy({}, {
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

    receive(regName) {
        while (this.queue.length === 0) {
            ;
        }
        this.receiving = false
        this.set(regName, this.queue.shift())
    }

    run() {
        let sendCount = 0
        while (this.ip < this.instructions.length) {
            const [cmd, arg1, arg2] = this.instructions[this.ip].split(" ")
            switch (cmd) {
                case "snd": this.queue.push(this.get(arg1)); sendCount++ ; break
                case "set": this.set(arg1, arg2); break
                case "add": this.set(arg1, this.get(arg1) + this.get(arg2)); break
                case "mul": this.set(arg1, this.get(arg1) * this.get(arg2)); break
                case "mod": this.set(arg1, this.get(arg1) % this.get(arg2)); break
                case "rcv": this.receive(arg1); break
                case "jgz": {
                    if (this.get(arg1) > 0) {
                        this.ip += (this.get(arg2) - 1)
                    }
                }
            }
            this.ip++
        }
        return sendCount
    }
}

const q0_1 = []
const q1_0 = []
const prog0 = new Program(instructions, 0, q0_1)
const prog1 = new Program(instructions, 0, q1_0)


const sndCountProm = new Promise((r) => r(prog0.run()))
new Promise((r) => r(prog1.run()))


sndCountProm.then(sndCount => {
    console.log(sndCount)
})


setInterval(() => {
    if (prog0.receiving && prog1.receiving) {
        console.log("Deadlock")
    }
}, 1000)