# 443. String Compression
# Attempted
# Medium
# Topics
# premium lock iconCompanies
# Hint

# Given an array of characters chars, compress it using the following algorithm:

# Begin with an empty string s. For each group of consecutive repeating characters in chars:

#     If the group's length is 1, append the character to s.
#     Otherwise, append the character followed by the group's length.

# The compressed string s should not be returned separately, but instead, be stored in the input character array chars. Note that group lengths that are 10 or longer will be split into multiple characters in chars.

# After you are done modifying the input array, return the new length of the array.

# You must write an algorithm that uses only constant extra space.

# Note: The characters in the array beyond the returned length do not matter and should be ignored.

 

# Example 1:

# Input: chars = ["a","a","b","b","c","c","c"]
# Output: 6
# Explanation: The groups are "aa", "bb", and "ccc". This compresses to "a2b2c3".

# Example 2:

# Input: chars = ["a"]
# Output: 1
# Explanation: The only group is "a", which remains uncompressed since it's a single character.

# Example 3:

# Input: chars = ["a","b","b","b","b","b","b","b","b","b","b","b","b"]
# Output: 4
# Explanation: The groups are "a" and "bbbbbbbbbbbb". This compresses to "ab12".

## first attempt
class Solution:

    def dict2string(self, dict_of_letter):
        '''
        receives {"a": "2"}
        return "a2"

        receives {"a": "1"}
        return "a"
        '''
        for x in dict_of_letter.keys():
            letter = x
            number_of_times = dict_of_letter[x]

        #print(letter, "letter")
        #print(number_of_times, "number_of_times")
        
        if int(number_of_times) == 1:
            return f"{letter}"
        return f"{letter}{number_of_times}"

    def add_to_list(self, char, list_of_dicts):
        '''
        list_of_dicts []
        char = "a"
        return [{"a":"1"}]

        list_of_dicts [{"a":"1"}]
        char = "a"
        return [{"a":"2"}]

        list_of_dicts [{"a":"2"}]
        char = "b"
        return [{"a":"2"},{"b":"1"}]
        '''
        if not list_of_dicts:
            return [{char: "1"}]

        last_dict = list_of_dicts[-1]
        for x in last_dict.keys():
            llave = x
            value = last_dict[x]
        
        if llave != char:
            return list_of_dicts + [{char: "1"}]

        # update last dict of list
        new_value = str(int(value) + 1)
        list_of_dicts.pop(-1)
        list_of_dicts = list_of_dicts + [{char: new_value}]

        return list_of_dicts

    def compress(self, chars: List[str]) -> int:
        
        print("chars", chars)
        assert self.dict2string({"a": "2"}) == "a2"
        assert self.dict2string({"a": "1"}) == "a"

        assert self.add_to_list("a", []) == [{"a":"1"}]
        assert self.add_to_list("a",[{"a":"1"}]) == [{"a":"2"}]
        assert self.add_to_list("b",[{"a":"2"}]) == [{"a":"2"},{"b":"1"}]

        list_of_dicts = []

        for letter in chars:
            list_of_dicts = self.add_to_list(letter, list_of_dicts)
        #list_of_dicts = [{"a": "2"}, {"b":"2"}, {"c": "3"}]    

        s = []
        while list_of_dicts:
            dict_element = list_of_dicts.pop(0) 
            count_letter = self.dict2string(dict_element)
            #count_letter = "a2"
            print(list(count_letter))
            s = s + list(count_letter)
        print(s)

        chars = s
        print("chars", chars)
        return len(chars)
        