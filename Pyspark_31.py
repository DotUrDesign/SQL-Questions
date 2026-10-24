from pyspark.sql import SparkSession
from pyspark.sql.types import StructType, StructField, IntegerType, StringType

spark = SparkSession.builder.appName("Employee").getOrCreate()

# Define schema
schema = StructType([
    StructField("emp_id", IntegerType(), True),
    StructField("company", StringType(), True),
    StructField("salary", IntegerType(), True)
])

# Employee data
data = [
    (1, 'A', 2341),
    (2, 'A', 341),
    (3, 'A', 15),
    (4, 'A', 15314),
    (5, 'A', 451),
    (6, 'A', 513),
    (7, 'B', 15),
    (8, 'B', 13),
    (9, 'B', 1154),
    (10, 'B', 1345),
    (11, 'B', 1221),
    (12, 'B', 234),
    (13, 'C', 2345),
    (14, 'C', 2645),
    (15, 'C', 2645),
    (16, 'C', 2652),
    (17, 'C', 65)
]

# Create DataFrame
employee_df = spark.createDataFrame(data, schema)

# Display the data
employee_df.show()


############################# SOLUTION ###################################

from pyspark.sql.functions import *
from pyspark.sql.types import *
from pyspark.sql.window import Window

windowFunc = Window.partitionBy("company").orderBy(col("salary").asc())
windowFuncCnt = Window.partitionBy("company")

df = employee_df.withColumn(
                        "rn",
                        row_number().over(windowFunc)
                    )\
                .withColumn(
                        "count",
                        count("*").over(windowFuncCnt)   
                    )\
                .filter(
                        ( (col("count")%2 != 0) & ((col("count")+1)/2 == col("rn")) )
                        |
                        ( (col("count")%2 == 0) & ( (col("count")/2 == col("rn")) | ((col("count")/2) + 1 == col("rn")) ) )
                    )\
                .groupBy(col("company"))\
                .agg(
                    avg(col("salary")).alias("median_salary")
                )\
                .select(
                        col("company"),
                        col("median_salary"),
                    )

display(df)