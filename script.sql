-- =============================================
-- SQL Server Agent Job: Codzienna aktualizacja tabeli MyData o 6:00
-- =============================================

USE [msdb]
GO

-- Usunięcie jobu jeśli już istnieje
IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs WHERE name = N'DailyUpdateMyData')
BEGIN
    EXEC msdb.dbo.sp_delete_job @job_name = N'DailyUpdateMyData', @delete_unused_schedule=1
END
GO

-- Utworzenie nowego jobu
EXEC msdb.dbo.sp_add_job 
    @job_name = N'DailyUpdateMyData',
    @enabled = 1,
    @description = N'Codzienna aktualizacja kolumny Text w tabeli MyData o 6:00 rano',
    @category_name = N'Database Maintenance',
    @owner_login_name = N'sa'
GO

-- Dodanie kroku do jobu
EXEC msdb.dbo.sp_add_jobstep 
    @job_name = N'DailyUpdateMyData',
    @step_name = N'Update MyData Table',
    @step_id = 1,
    @subsystem = N'TSQL',
    @command = N'UPDATE [MyData] SET [Text] = ''Text''',
    @database_name = N'master', -- ZMIEŃ NA SWOJĄ BAZĘ DANYCH!
    @on_success_action = 1, -- Quit with success
    @on_fail_action = 2, -- Quit with failure
    @retry_attempts = 3,
    @retry_interval = 5
GO

-- Utworzenie harmonogramu (codziennie o 6:00 rano)
EXEC msdb.dbo.sp_add_schedule 
    @schedule_name = N'DailyAt6AM',
    @enabled = 1,
    @freq_type = 4, -- Daily
    @freq_interval = 1, -- Every day
    @freq_subday_type = 1, -- At the specified time
    @freq_subday_interval = 0,
    @freq_relative_interval = 0,
    @freq_recurrence_factor = 1,
    @active_start_time = 060000 -- 06:00:00 (HHMMSS format)
GO

-- Przypisanie harmonogramu do jobu
EXEC msdb.dbo.sp_attach_schedule 
    @job_name = N'DailyUpdateMyData',
    @schedule_name = N'DailyAt6AM'
GO

-- Dodanie jobu do lokalnego serwera
EXEC msdb.dbo.sp_add_jobserver 
    @job_name = N'DailyUpdateMyData',
    @server_name = N'(local)'
GO

-- =============================================
-- WAŻNE: 
-- 1. Zmień @database_name w sp_add_jobstep na nazwę Twojej bazy danych
-- 2. Możesz zmienić @owner_login_name na odpowiedniego użytkownika
-- 3. Aby ręcznie uruchomić job (do testowania):
--    EXEC msdb.dbo.sp_start_job @job_name = N'DailyUpdateMyData'
-- 4. Aby wyświetlić historię wykonań:
--    SELECT * FROM msdb.dbo.sysjobhistory WHERE job_id = 
--    (SELECT job_id FROM msdb.dbo.sysjobs WHERE name = 'DailyUpdateMyData')
-- =============================================
