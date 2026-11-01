# You are given an integer array nums consisting of n elements, and an integer k.
 
# Your task is to find a contiguous subarray of nums (whose length is exactly k) that has the highest average value.

# output 
# 

k = 3
arr = [1,2,3,4,5,56,4]
n = len(arr)
sum = 0
for i in range(k):
    sum += arr[i]

i, j = 0, k-1
mxsum, idx = sum, 0
while(j < n):
    j += 1
    sum += arr[j]
    sum -= arr[i]
    if(mxsum < sum):
        mxsum = sum
        idx = i+1
    i += 1

ans = []
for i in range(idx, idx+k):
    ans.append(arr[i])

return ans



##############################################


Given a list of strings, group the anagrams together.
 
Input: ["eat", "tea", "tan", "ate", "nat", "bat"]
Output: [["eat", "tea", "ate"], ["tan", "nat"], ["bat"]]


def findAnagrams(self, arr):
    n = len(arr)
    ans = []
    res = []
    vis = [-1]*n

    for i in range(n):
        if(vis[i] != 1):
            res = []
            s1 = arr[i]
            vis[i] = 1
            sorted_s1 = sorted(s1)
            res.append(s1)
            for j in range(i+1, n):
                s2 = arr[j]
                sorted_s2 = sorted(s2)
                if(sorted_s1 == sorted_s2):
                    vis[j] = 1
                    res.append(s2)
            ans.append(res)

    return ans




#########################################################



# You have:
# existing_df → already processed data
# new_df → incoming data for the day
# Both have:
# id INT
# name STRING
# last_updated TIMESTAMP
# Task
# Write PySpark logic to:
# 1. Insert new records
# 2. Update existing records only if last_updated is newer


from pyspark.sql.functions import *
from pyspark.sql.types import *

output_df = new_df.alias("s").merge(existing_df.alias("e"), "s.id == e.id & s.last_updated > e.last_updated")\
                            .whenMatched(set = {
                                "e.id" = "s.id",
                                "e.name" = "s.name",
                                "e.last_updated" = "s.last_updated"
                            })\
                            .whenNotMatched(insert = {
                                "e.id" = "s.id",
                                "e.name" = "s.name",
                                "e.last_updated" = "s.last_updated"
                            })\
                            .execute()

display(output_df)



target_df
source_df

temp_df = source_df.alias("s").join(target_df.alias("t"), "s.id == t.id", "left")\








