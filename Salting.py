spark.conf.set("spark.sql.shuffle.partitions", "3")
spark.conf.get("spark.sql.shuffle.partitions")
spark.conf.set("spark.sql.adaptive.enabled", "false")

df_uniform = spark.createDataFrame([i for i in range(100000)], IntegerType())
df_uniform.show(5, False)

df_uniform = df_uniform.withColumn("partition", F.spark_partition_id())\
                        .groupBy("partition")\
                        .count()\
                        .orderBy("partition")\
                        .show(15, False)

df0 = spark.createDataFrame([0] * 999990, IntegerType()).repartition(1)
df1 = spark.createDataFrame([1] * 15, IntegerType()).repartition(1)
df2 = spark.createDataFrame([2] * 10, IntegerType()).repartition(1)
df3 = spark.createDataFrame([3] * 5, IntegerType()).repartition(1)
df_skew = df0.union(df1).union(df2).union(df3)
df_skew.show()


df_skew = df_skew.withColumn("partition", F.spark_partition_id())\
                .groupBy("partition")\
                .count()\
                .orderBy("partition")\
                .show()


df_joined = df_uniform.join(df_skew, "value", "inner")
df_joined.show()



df_joined = df_joined.withColumn("partition", F.spark_partition_id())\
                    .groupBy("partition")\
                    .count()\
                    .orderBy("partition")\
                    .show(15, False)

# Uniform distribution using salting 

salt_no = int(spark.conf.get("spark.sql.shuffle.partitions"))

df_skew = df_skew.withColumn("salt", (F.rand() * salt_no).cast("int") )

df_uniform = df_uniform.withColumn("salt_values", array([i for i in range(salt_no)]))\
                        .withColumn("salt", explode(col("salt_values")))

df_joined = df_skew.join(df_uniform, ["value", "salt"], "inner")

df_joined = df_joined.withColumn("partition", F.spark_partition_id())\
                    .groupBy("partition")\
                    .count()\
                    .orderBy("partition")\
                    .show(15, False)



# Salting - Data skewness

df_skew = df_skew.groupBy("value").count().show()


df_skew = df_skew.withColumn("salt", (F.rand() * salt_no).cast("int"))

df_skew = df_skew.groupBy("value", "salt")\
                .agg(count("*").alias("cnt"))\
                .groupBy("value")\
                .agg(sum("cnt").alias("cnt"))\
                .show()



