def remove_duplicates(s):
    result = ""
    for char in s:
        if char not in result:
            result += char
    return result


# Test
text = input("Enter string: ")
print(remove_duplicates(text))