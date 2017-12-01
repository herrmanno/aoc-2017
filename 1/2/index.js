const fs = require("fs")

const input = fs.readFileSync("input.txt").toString()

let numbers = input.split('').map(Number)
// numbers = [...numbers, ...numbers.slice(-1)]

const sum = numbers.reduce((sum, n, i, arr) => {
	const idx = (i + arr.length / 2) % arr.length
	let add = 0
	if (n === arr[idx]) {
		add = n
	}
	return sum + add
}, 0)

console.log(`The sum is ${sum}`)
