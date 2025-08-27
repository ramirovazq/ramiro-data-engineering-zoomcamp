'''
Given a string s and a string t, return the shortest substring from s
that contains all characters from t.

s = aecdddfegbd
t = de

=> ecd, dfe, egbd

s = aecldfegbd
t = de

=> ecld, dfe

s = aaaa
t = aa

=> aa

s = abc
t = z

=> ''

'''

def transform_list(t: str) -> str:
    t_copy = [x for x in t]
    return t_copy

def minimum_substring (s:str, t: str) -> str:

    substring_answers = []
    for outer_index, letter in enumerate(s):
        if letter not in t:
            pass
        else: # finds a letter that exist in t
            substring_tmp = ''
            
            # pop letter that exist in t
            substring_tmp += letter
            index_letter = t.find(letter)
            tmp_t = t[:index_letter] + t[index_letter+1:]


            for x in range(outer_index + 1, len(s)):
                actual_letter = s[x]
                if len(tmp_t) == 0:
                    break
                if actual_letter not in tmp_t:
                    substring_tmp += actual_letter
                if actual_letter in tmp_t:
                    index_letter = tmp_t.find(actual_letter)
                    tmp_t = tmp_t[:index_letter] + tmp_t[index_letter+1:]
                    substring_tmp += actual_letter

            if len(tmp_t) == 0:
                substring_answers.append(substring_tmp)

    substring_answers = set(substring_answers)
    print(f"{substring_answers=}")

def shortest_substring(s: str, t: str) -> str:
    n = len(s)
    
    for i in range(n):
        for j in range(i, n):
            print(f"{i=}, {j=}")
            substring = s[i:j+1]
            print(f"{substring=}")

if __name__ == "__main__":

    s = "aaaa"
    t = "aa"

    s = "abc"
    t = "z"

    s = "aecxxxfgb"
    t = "de"

    s = "aecdddfegbd"
    t = "de"

    s = "abdca"
    t = "ad"

    #minimum_substring(s, t)
    shortest_substring(s, t)
