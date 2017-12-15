require "big_int"
require "./input"

a = BigInt.new(A)
b = BigInt.new(B)
matchCount = 0

0..5_000_000.times {
    loop do 
        a = (a * 16807) % 2147483647
        break if a % 4 == 0
    end
    loop do 
        b = (b * 48271) % 2147483647
        break if b % 8 == 0
    end

    # puts("#{a}\t#{b}")

    if ((a & 65535) == (b & 65535))
        matchCount += 1
    end
}

puts("There are #{matchCount} matching pairs in the first 5 million rounds")