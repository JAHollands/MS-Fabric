# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "d6929aa7-8c0d-4cfb-a98a-a82f0f648abc",
# META       "default_lakehouse_name": "DW018_BronzeLH",
# META       "default_lakehouse_workspace_id": "cd8c0321-7e9e-4900-9b26-9fbf777bc530",
# META       "known_lakehouses": [
# META         {
# META           "id": "d6929aa7-8c0d-4cfb-a98a-a82f0f648abc"
# META         }
# META       ]
# META     }
# META   }
# META }

# CELL ********************

# MAGIC %%sql
# MAGIC UPDATE em_customers
# MAGIC SET customer_name = 'Wayne Johnson', modified=current_timestamp()
# MAGIC WHERE customer_id = 16;
# MAGIC 
# MAGIC INSERT INTO em_customers (customer_id, customer_name, customer_email, modified)
# MAGIC VALUES
# MAGIC   (5002, 'Henry McAll', 'henrymac@example.com', current_timestamp()),
# MAGIC   (5003, 'Bob Teler', 'bobteler@example.com', current_timestamp());
# MAGIC 
# MAGIC DELETE FROM em_customers
# MAGIC WHERE customer_id IN (8,9)

# METADATA ********************

# META {
# META   "language": "sparksql",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

df = spark.sql("SELECT * FROM DW018_BronzeLH.em_customers WHERE customer_id = 5002")
display(df)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
