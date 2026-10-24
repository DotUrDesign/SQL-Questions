from pyspark.sql import SparkSession
from pyspark.sql.types import StructType, StructField, DateType, IntegerType
from datetime import date

spark = SparkSession.builder.appName("BusinessCity").getOrCreate()

# Define schema
schema = StructType([
    StructField("business_date", DateType(), True),
    StructField("city_id", IntegerType(), True)
])

# Insert data
data = [
    (date(2020, 1, 2), 3),
    (date(2020, 7, 1), 7),
    (date(2021, 1, 1), 3),
    (date(2021, 2, 3), 19),
    (date(2022, 12, 1), 3),
    (date(2022, 12, 15), 3),
    (date(2022, 2, 28), 12)
]

# Create DataFrame
business_city_df = spark.createDataFrame(data, schema)

# Display data
display(business_city_df)


############################### SOLUTION ################################

from pyspark.sql.functions import *
from pyspark.sql.types import *

df = business_city_df.groupBy("city_id")\
                    .agg(
                        min("business_date").alias("min_date")
                    )\
                    .select(
                        col("city_id"),
                        date_format(col("min_date"), "yyyy").alias("year")
                    )

# display(df)

output = df.groupBy("year")\
            .agg(count("*").alias("new_cities"))

display(output)