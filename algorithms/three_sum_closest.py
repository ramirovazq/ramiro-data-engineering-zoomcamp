#[-1,2,1,-4], target = 1
from typing import List

def threeSumClosest(nums: List[int], target: int) -> int:

    nums.sort()

    if len(nums) < 3:
        return 0

    min_diff = float('inf')
    resultSum = nums[0] + nums[1] + nums[2]
    
    for i in range(0, len(nums)-2):
        j = i + 1
        k = len(nums) - 1

        while j < k:
            actualSum = nums[i] + nums[j] + nums[k]
            if actualSum == target:
                return actualSum
            elif actualSum < target:
                j+=1
            else: 
                k-=1

            if abs(actualSum - target) < min_diff:
                min_diff = abs(resultSum - target)
                resultSum = actualSum 

    return resultSum

if __name__ == "__main__":
    #       0  1  2  3
    nums = [-1,2,1,-4]
    target = 1
    my_result = threeSumClosest(nums, target)
    print(my_result)
    assert my_result == 2