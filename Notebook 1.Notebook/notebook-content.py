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

files_to_load = [
    ("Files/CRMCustomers.csv", "em_customers"),
    ("Files/Offers.csv", "em_offers"),
    ("Files/Venues.csv", "em_venues"),
    ("Files/TicketSales.csv", "em_ticket_sales"),
    ("Files/ConferenceEvents.csv", "em_conference_events"),
    ("Files/LVAttendanceRecords.csv", "lv_attendance_records"),
    ("Files/LVAttendees_mapping.csv", "lv_attendees_mapping"),
    ("Files/LVRooms.csv", "lv_rooms"),
    ("Files/LVSchedule.csv", "lv_schedule"),
    ("Files/LVSpeakers.csv", "lv_speakers"),
    ("Files/STOCKCheck_Ins.csv", "stock_check_ins"),
    ("Files/STOCKSessions.csv", "stock_sessions"),
] 

for file_path, table_name in files_to_load: 
    df = spark.read.format("csv").option("header", "true").option("inferSchema", "true").load(file_path)
    df.write.mode("overwrite").saveAsTable(table_name)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
