from typing import List, Tuple

def tuple_continuity(my_tuple):
    # (0, 1), 
    # (0, 2), 
    # (0, 1, 2), 
    # (0, 1, 3), 
    # (0, 1, 2, 3)
    if len(my_tuple) == 1:
        return True, my_tuple
    
    first = my_tuple[0]
    for x in my_tuple: # miro cada tupla (0, 1, 2)        
        if x == first:
            pass
        else:
            if first + 1 == x:
                first = x
            else:
                return False, my_tuple
    return True, my_tuple

def verify_continuity(list_of_tuples):
    # [(0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3)]
    # [(0, 1, 2), (0, 1, 3), (0, 2, 3), (1, 2, 3)]
    # [(0, 1, 2, 3)]
    final_list = []
    for tuple_ in list_of_tuples:
        answer, returned_tuple = tuple_continuity(tuple_)
        if answer:
            final_list.append(returned_tuple)
    return final_list

def max_subarray_sum(nums: List[int]) -> int:
    from itertools import combinations

    list_index = list(range(0,len(nums)))
    print(f"{list_index=}")

    all_combinatons = []
    for x in range(1,len(nums)+1):
        z = list(combinations(list_index, x))
        all_combinatons.append(z)
    
    print(f"{all_combinatons=}")

    all_continius_combinations = []
    for sub_list in all_combinatons:
            sub_list_continuity = verify_continuity(sub_list)   
            all_continius_combinations.append(sub_list_continuity)
    print(f"{all_continius_combinations=}")

    max_sum = None
    #[[(0,), (1,), (2,), (3,)], [(0, 1), (1, 2), (2, 3)], [(0, 1, 2), (1, 2, 3)], [(0, 1, 2, 3)]]
    for list_of_tuples in all_continius_combinations:
        for tuple_ in list_of_tuples:


    # 0 1 2 3 <-- original
    # 0
    # 0 1
    # 0 1 2
    # 0 1 2 3 
    # 1
    # 1 2 
    # 1 2 3
    # 2
    # 2 3 
    # 3
    return 0

if __name__ == "__main__":


    # print(tuple_continuity((0,)))
    # print(tuple_continuity((1,)))
    # print(tuple_continuity((2,)))
    # print(tuple_continuity((0,1)))
    # print(tuple_continuity((0,2)))
    # print(tuple_continuity((0,1,2)))
    # print(tuple_continuity((0,1,3)))
    # print(tuple_continuity((0,1,2,3)))
    # print(tuple_continuity((0,1,3,4)))
    # (0,), 
    # (1,),
    # (2,),
    # (0, 1), 
    # (0, 2), 
    # (0, 1, 2), 
    # (0, 1, 3), 
    # (0, 1, 2, 3)


    nums = [2, 3, -2, 4]  
    output = max_subarray_sum(nums)
    output_expected = 7  
    assert output_expected == output, "not equal"

    # Explanation: Maximum sum is 2 + 3 + (-2) + 4 = 7.

    # nums = [1, -1, -5, -4]  
    # output_expected = 1  
    # Explanation: The maximum sum is 1, which is the single element with the highest value.