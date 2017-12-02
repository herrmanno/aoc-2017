#!/usr/bin/python3

f = open("input.txt")
lines = f.readlines()

lineChecksums = []
for line in lines:
    numbers = [int(n) for n in line.split("\t")]
    lineChecksum = max(numbers) - min(numbers)
    lineChecksums.append(lineChecksum)

checksum = sum(lineChecksums)

print(f"The checksum is {checksum}")