require "./input"

a = BigInt.new(A)
b = BigInt.new(B)
matchCount = 0

0..40_000_000.times {
    a = (a * 16807) % 2147483647
    b = (b * 48271) % 2147483647

    if ((a & 65535) == (b & 65535))
        matchCount += 1
    end
}

puts("There are #{matchCount} matching pairs in the first 40 million rounds")