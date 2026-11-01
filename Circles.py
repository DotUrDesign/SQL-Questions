# string of expressions 
# String s=({}){}[]
# valid

# s=}{}{}{
# invalid

# example 3:
# s={((()))}
# valid


arr = []
n = len(s)

if(n%2 != 0):
    return False

for i in range(n):
    if(s[i] == '(' or s[i] == '{' or s[i] == '['):
        arr.append(s[i])
    else:
        if(s[i] == ')'):
            last = arr.pop()
            if(last != '('):
                return False
        elif(s[i] == '}'):
            last = arr.pop()
            if(last != '{'):
                return False
        elif(s[i] == ']'):
            last = arr.pop()
            if(last != '['):
                return False  
return True  