def count_set_bits(n):
    count = 0
    while n:
        print("---start")
        print(bin(n)[2:])
        count += n & 1  # Increment count if LSB is 1
        print("....")
        print(n & 1)
        print(count)
        n >>= 1         # Right shift to check the next bit
        print(bin(n)[2:])
        print("---end")
    return count