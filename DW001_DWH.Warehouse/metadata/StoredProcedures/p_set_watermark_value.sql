CREATE PROCEDURE metadata.p_set_watermark_value
@PipelineID VARCHAR(50),
@WatermarkValue VARCHAR(50)
AS
IF EXISTS (SELECT 1 FROM metadata.watermark WHERE pipeline_id = @PipelineID)
BEGIN
UPDATE metadata.watermark
SET watermark_value = @WatermarkValue
WHERE pipeline_id = @PipelineID
END
ELSE
BEGIN
INSERT INTO metadata.watermark 
    VALUES(
        @PipelineID, @WatermarkValue
        )
END