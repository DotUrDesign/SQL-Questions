from pyspark.sql import SparkSession
from pyspark.sql.types import StructType, StructField, StringType, IntegerType

spark = SparkSession.builder.appName("Movie").getOrCreate()

# Define schema
schema = StructType([
    StructField("seat", StringType(), True),
    StructField("occupancy", IntegerType(), True)
])

# Insert data
data = [
    ('a1', 1), ('a2', 1), ('a3', 0), ('a4', 0), ('a5', 0),
    ('a6', 0), ('a7', 1), ('a8', 1), ('a9', 0), ('a10', 0),

    ('b1', 0), ('b2', 0), ('b3', 0), ('b4', 1), ('b5', 1),
    ('b6', 1), ('b7', 1), ('b8', 0), ('b9', 0), ('b10', 0),

    ('c1', 0), ('c2', 1), ('c3', 0), ('c4', 1), ('c5', 1),
    ('c6', 0), ('c7', 1), ('c8', 0), ('c9', 0), ('c10', 1)
]

# Create DataFrame
movie_df = spark.createDataFrame(data, schema)

# Display data
display(movie_df)



############################# SOLUTION ##################################


from pyspark.sql.functions import *
from pyspark.sql.types import *
from pyspark.sql.window import Window

windowFunc = Window.partitionBy("seat_grp").orderBy("seat_no")

df = movie_df.filter(col("occupancy") == 0)\
            .withColumn(
                "seat_grp",
                substring(col("seat"), 1, 1)
            )\
            .withColumn(
                "seat_no",
                substring(col("seat"), 2, length("seat")-1).cast("int")
            )\
            .withColumn(
                "rn",
                row_number().over(windowFunc)
            )\
            .withColumn(
                "grp",
                col("rn")-col("seat_no")
            )
# display(df)

grp_df = df.groupBy("seat_grp", "grp")\
            .agg(count("*").alias("cnt"))\
            .filter(col("cnt") >= 4)
# display(grp_df)

output = df.join(grp_df, (df['seat_grp'] == grp_df['seat_grp']) & (df['grp'] == grp_df['grp']), "inner")\
            .select(
                col("seat")
            )
display(output)