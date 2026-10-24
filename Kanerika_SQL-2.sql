write the deduplication logic

df = df.dropDuplicates(col("id"))

from pyspark.sql.types import *
from pyspark.sql.window import Window 

windowFunc = Window.partitionBy("id").orderBy(col("timestamp").desc())

df = df.withColumn(
                "rn", 
                row_number().over(windowFunc)   
            )\
            .filter(col("rn") == 1)\
            .orderBy(col("id"))

display(df)