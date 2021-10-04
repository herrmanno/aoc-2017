# Part 2

Check how many numbers in the range 106500,106517,..123500 are not prime

- Set b to lower and c to upper limit
- Increment d and e in nested loops:
    - Set f is g * e divides b    
    - Increment e
    - check if e now divides b, if yes continue
    - Increment d
    - check if d now divides b, if yes continue
- Increment h if f was set
- Increment b by offset (=17)


