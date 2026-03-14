from collections import Counter
from collections import defaultdict

import time

s = "hola mundo de codigo"
counter = Counter(s)
print(counter)

def is_anagram_counter(s, t):
    return Counter(s) == Counter(t)

def is_anagram_sort(s, t):
    s = sorted(s) # n logn
    t = sorted(t) # n logn
    return s == t

def is_anagram_charly(s: str, t: str) -> bool: # O(3n)
    counter = defaultdict(int)
    for c in s:
        counter[c] += 1
    for c in t:
        counter[c] -= 1
    for k,v in counter.items():
        if v != 0:
            return False
    return True


if __name__ == "__main__":

    s = "the quick brown fox jumps over the lazy dogs and runs swiftly through the vibrant forest of dreams"
    t = "dogs the lazy over the quick brown fox jumps and runs swiftly through vibrant forest of dreams the"

    s = "a multitude of colorful and vibrant expressions fills the air as dreams arise from the depths of imagination, painting the canvas of life with remarkable shades and hues. within the corridors of creativity, ideas flow like rivers, merging with thoughts and aspirations to create a symphony of artistry that resonates in the hearts of those who dare to dream and embrace the wonderful journey of living with passion and purpose, wherever it may lead."
    t = "the corridors of creativity fill with a multitude of colorful and vibrant expressions, painting life’s canvas with remarkable shades and hues. from the depths of imagination, dreams arise to create a symphony of artistry that flows like rivers, merging thoughts and aspirations in the air as ideas ignite and resonate in the hearts of those who embrace this wonderful journey of living with passion and purpose, wherever it may lead them to explore and discover."

    inicio = time.perf_counter()
    print(is_anagram_counter(s, t))
    fin = time.perf_counter()
    print("Counter Tiempo de ejecución:", fin - inicio, "segundos")

    inicio = time.perf_counter()
    print(is_anagram_sort(s, t))
    fin = time.perf_counter()
    print("Sort Tiempo de ejecución:", fin - inicio, "segundos")

    inicio = time.perf_counter()
    print(is_anagram_charly(s, t))
    fin = time.perf_counter()
    print("Charly Tiempo de ejecución:", fin - inicio, "segundos")