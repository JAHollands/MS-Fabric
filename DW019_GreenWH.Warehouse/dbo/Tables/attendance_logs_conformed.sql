CREATE TABLE [dbo].[attendance_logs_conformed] (

	[unique_attendance_log_id] bigint NULL, 
	[master_session_id] varchar(8000) NOT NULL, 
	[attendee_customer_id] int NULL, 
	[scan_timestamp] datetime2(6) NULL
);