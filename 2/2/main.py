#!/usr/bin/python3

f = open("input.txt")
lines = f.readlines()

lineChecksums = []
for line in lines:
    numbers = [int(n) for n in line.split("\t")]
    for i, n in enumerate(numbers):
        for j, m in enumerate(numbers[i + 1:]):
            if n % m == 0:
                lineChecksums.append(n / m)
            elif m % n == 0:
                lineChecksums.append(m / n)

checksum = sum(lineChecksums)

print(f"The checksum is {checksum}")