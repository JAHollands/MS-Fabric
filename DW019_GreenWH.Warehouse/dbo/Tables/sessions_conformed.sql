CREATE TABLE [dbo].[sessions_conformed] (

	[master_session_id] varchar(14) NOT NULL, 
	[conference_id] int NOT NULL, 
	[session_name] varchar(8000) NULL, 
	[master_speaker_id] varchar(14) NOT NULL, 
	[speaker_name] varchar(8000) NULL, 
	[stage_name] varchar(8000) NULL, 
	[session_date] date NULL, 
	[session_length] int NULL, 
	[session_start_time] datetime2(6) NULL, 
	[last_modified_date] datetime2(6) NULL
);