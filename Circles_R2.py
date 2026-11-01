# i/p 
# string 
# 156.2.73.254 - valid 

# criteria 
# - each part between 0 and 255


def validIpAddress(self, ip):
    n = len(ip)
    s = ""
    for i in range(n):
        if(ip[i] == '.'):
            num = s.cast("int")
            if(num < 0 or num > 255):
                return False
            s = ""
        else:
            s += ip[i]

    return True


