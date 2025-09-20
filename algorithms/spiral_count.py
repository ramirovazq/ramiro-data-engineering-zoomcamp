from typing import List

def spiral_copy(inputMatrix: List[List[int]]) -> List[int]:

    answer = []

    while True:
        try:
            first_index = 0
            first = inputMatrix.pop(first_index)

            for x in first:
                answer.append(x)

            last_index = -1
            last = inputMatrix.pop(last_index)
            last.reverse()

            for x in inputMatrix:
                answer.append(x.pop(-1))

            for x in last:
                answer.append(x)

            for x in inputMatrix[::-1]:
                answer.append(x.pop(0))
            
        except IndexError:
            print("no more elements to pop")
            return answer


#    print(f"{inputMatrix[first+1:last]}=")
 #   print(f"{inputMatrix[last]}=")

    return answer
  
# debug your code below

inputMatrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]
result = spiral_copy(inputMatrix)
expected = [1, 2, 3, 6, 9, 8, 7, 4, 5]
assert result == expected, "not equal"

inputMatrix = [
    [5],[1],[45]
]
result = spiral_copy(inputMatrix)
expected = [5, 1, 45]
assert result == expected, "not equal"

inputMatrix = [
    [5],
]
result = spiral_copy(inputMatrix)
expected = [5]
assert result == expected, "not equal"

inputMatrix = [
    [1, 2, 3],
]
result = spiral_copy(inputMatrix)
expected = [1,2,3]
assert result == expected, "not equal"

inputMatrix = [
]
result = spiral_copy(inputMatrix)
expected = []
assert result == expected, "not equal"

inputMatrix  = [ [1,    2,   3,  4,    5],
                         [6,    7,   8,  9,   10],
                         [11,  12,  13,  14,  15],
                         [16,  17,  18,  19,  20] ]
result = spiral_copy(inputMatrix)
expected = [1, 2, 3, 4, 5, 10, 15, 20, 19, 18, 17, 16, 11, 6, 7, 8, 9, 14, 13, 12]
assert result == expected, "not equal"



#l = [23,27]
#print(l[1:-1]
print("----------")
#l = [12,13,14,15]
#l.pop(2)
#l.pop(23)