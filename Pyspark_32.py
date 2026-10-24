from pyspark.sql import SparkSession
from pyspark.sql.types import StructType, StructField, IntegerType, StringType

spark = SparkSession.builder.appName("Employee").getOrCreate()

# Define schema
schema = StructType([
    StructField("emp_id", IntegerType(), True),
    StructField("emp_name", StringType(), True),
    StructField("salary", IntegerType(), True),
    StructField("manager_id", IntegerType(), True),
    StructField("emp_age", IntegerType(), True),
    StructField("dep_id", IntegerType(), True),
    StructField("dep_name", StringType(), True),
    StructField("gender", StringType(), True)
])

# Insert employee records
data = [
    (1, 'Ankit', 14300, 4, 39, 100, 'Analytics', 'Female'),
    (2, 'Mohit', 14000, 5, 48, 200, 'IT', 'Male'),
    (3, 'Vikas', 12100, 4, 37, 100, 'Analytics', 'Female'),
    (4, 'Rohit', 7260, 2, 16, 100, 'Analytics', 'Female'),
    (5, 'Mudit', 15000, 6, 55, 200, 'IT', 'Male'),
    (6, 'Agam', 15600, 2, 14, 200, 'IT', 'Male'),
    (7, 'Sanjay', 12000, 2, 13, 200, 'IT', 'Male'),
    (8, 'Ashish', 7200, 2, 12, 200, 'IT', 'Male'),
    (9, 'Mukesh', 7000, 6, 51, 300, 'HR', 'Male'),
    (10, 'Rakesh', 8000, 6, 50, 300, 'HR', 'Male'),
    (11, 'Akhil', 4000, 1, 31, 500, 'Ops', 'Male')
]

# Create DataFrame
emp_df = spark.createDataFrame(data, schema)

# Display DataFrame
display(emp_df)



############################# SOLUTION ##########################


from pyspark.sql.functions import * 
from pyspark.sql.types import * 
from pyspark.sql.window import Window

windowFunc = Window.partitionBy("dep_id").orderBy(col("salary").desc())
windowFunCnt = Window.partitionBy("dep_id")

df = emp_df.withColumn(
                    "rnk",
                    rank().over(windowFunc)
                )\
            .withColumn(
                    "cnt",
                    count("*").over(windowFunCnt)   
            )\
            .filter(
                (col("rnk") == 3)
                | 
                ((col("cnt") < 3) & (col("rnk") == col("cnt")))
            )\
            .select(
                col("emp_id"),
                col("emp_name"),
                col("salary"),
                col("dep_id"),
                col("dep_name")
            )

display(df)