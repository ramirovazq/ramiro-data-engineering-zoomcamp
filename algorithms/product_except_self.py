from typing import List

def productExceptSelf_1(nums: List[int]) -> List[int]:

    result = [1 for x in range(0,len(nums))]
    print(f"{result=}")

    for i in range(0,len(nums)):
        print(i)
        temp_product = 1
        for j in range(i+1,len(nums)):
            print(f'{j=}')
            temp_product = temp_product * nums[j]
        result[i] = temp_product
    
    print(f"{result=}")

    print("--------------")

    l = [x*-1 for x in list(range(0+1,len(nums)+1))]
    print(">>>>>>>>>>>....")
    for i in range(0,len(l)):
        print(f"{l[i]=}")
        temp_product = 1
        for j in range(i+1,len(l)):
            print(f"{l[j]=}")
            temp_product = temp_product * nums[l[j]]
        result[l[i]] = result[l[i]] * temp_product
    print(">>>>>>>>>>>")
    print(f"{result=}")

    return result

def productExceptSelf(nums: List[int]) -> List[int]:

    answer = [1 for x in range(0,len(nums))]

    
    #product = 1
    #for x in nums: 
    #    product *= x
    # A way more elegant way

    from functools import reduce
    product = reduce(lambda x,y: x*y, nums)


    for indice, x in enumerate(nums):
        try:
            answer[indice]= product // x 
        except ZeroDivisionError:
            answer[indice] = 0

    return answer

def productExceptSelf_2(nums: List[int]) -> List[int]:

    result = [1 for x in range(0,len(nums))]
    result_reverse = [1 for x in range(0,len(nums))]

    for i in range(0,len(nums)):
        temp_product = 1
        for j in range(i+1,len(nums)):
            temp_product = temp_product * nums[j]
        result[i] = temp_product
    
    nums.reverse()

    for i in range(0,len(nums)):
        temp_product = 1
        for j in range(i+1,len(nums)):
            temp_product = temp_product * nums[j]
        result_reverse[i] = temp_product
    
    result_reverse.reverse()

    final_result = []
    for x,y in zip(result, result_reverse):
        final_result.append(x*y)

    return final_result


if __name__ == "__main__":

    # debug your code below
    assert productExceptSelf_2([1, 2, 3, 4]) == [24, 12, 8, 6], "If it's not equal to expected, raise this message"
    assert productExceptSelf_2([0,0]) == [0, 0], "If it's not equal to expected, raise this message"
    assert productExceptSelf_2([4, 5, 1, 8, 2])  == [80, 64, 320, 40, 160], "If it's not equal to expected, raise this message"
    assert productExceptSelf_2([-2, 1, -3, 4, -1]) == [12, -24, 8, -6, 24], "If it's not equal to expected, raise this message"