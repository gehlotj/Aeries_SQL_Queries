--The following queries can be used to pull the student data from Aeries SIS.

--Grade Query
--The following query will retrieve students current grade level details for each class.
--Input needed: {0} = School Number

SELECT TOP 100000 [STU].[ID] AS [Student ID],[GBU].[GN] AS [GrdBk#], [CRS].[CO] AS [Course Name], [GBK].[NM] AS [Name],
[GBV].[CD] AS [Term], [GBV].[MK] AS [Mark], [GBV].[PC] AS [Perc], [TCH].[TF] AS [First Name], [TCH].[TLN] AS [Tchr Last Name],
CONCAT(SUBSTRING(TCH.TF,1,1),TCH.TLN),[GBK].[PD] AS [Pd],[MST].[RM] AS [Room#], [CRS].[NA] AS [NonAcademic/Honors]
FROM (SELECT [CRS].* FROM CRS WHERE DEL = 0) CRS RIGHT JOIN ((SELECT [TCH].* FROM TCH WHERE DEL = 0)
TCH RIGHT JOIN ((SELECT [MST].* FROM MST WHERE DEL = 0) MST RIGHT JOIN ((SELECT [GBE].* FROM GBE WHERE DEL = 0)
GBE RIGHT JOIN ((SELECT [GBK].* FROM GBK WHERE DEL = 0) GBK RIGHT JOIN ((SELECT [GBV].* FROM GBV WHERE DEL = 0)
GBV RIGHT JOIN ((SELECT [STU].* FROM STU WHERE DEL = 0) STU LEFT JOIN (SELECT [GBU].* FROM GBU WHERE DEL = 0)
GBU ON [STU].[SC] = [GBU].[SC] AND [STU].[SN] = [GBU].[SN])
ON [STU].[SC] = [GBV].[SC] AND [STU].[SN] = [GBV].[SN]) ON [GBK].[GN] = [GBU].[GN]) ON [GBK].[GN] = [GBE].[GN])
ON [MST].[SC] = [GBE].[SC] AND [MST].[SE] = [GBE].[SE]) ON [TCH].[SC] = [MST].[SC] AND [TCH].[TN] = [MST].[TN])
ON [CRS].[CN] = [MST].[CN] WHERE (NOT STU.TG > ' ') AND ( [GBU].[SN] = [GBV].[SN] AND [GBU].[GN] = [GBV].[GN]
AND [GBU].[TG] <> 'I')
AND [STU].SC = {0} AND [GBU].SC = {0} AND [GBV].SC = {0} AND [GBK].SC = {0} AND [GBE].SC = {0} AND [MST].SC = {0}
AND [TCH].SC = {0}
ORDER BY [STU].[LN], [STU].[FN];

--Output: StudentID, Grade Book, Course Name, Grade Book Name, Term, Mark, Percentage, Teacher First Name, Teacher Last Name, Email, Period, Room#, Academic course


--Attendance Query
--The following query will get all the attendance data for a specific student
--Input needed:   {0} = School Number
--                {1} = Attendance Code you are filtering

SELECT [STU].[ID] AS [STUDENT ID],[ATT].[A1] AS [PERIOD 1],[ATT].[A2] AS [PERIOD 2],[ATT].[A3] AS [PERIOD 3],
[ATT].[A4] AS [PERIOD 4],[ATT].[A5] AS [PERIOD 5],[ATT].[A6] AS [PERIOD 6]
FROM STU INNER JOIN ATT ON [ATT].[SN] = [STU].[SN] WHERE [STU].[SC]={0} AND ([ATT].[A1]={1} OR [ATT].[A2]={1}
OR [ATT].[A3]={1} OR [ATT].[A4]={1} OR [ATT].[A5]={1} OR [ATT].[A6]={1})
AND STU.TG = ' '

--Output: StudentID, Period 1, Period 2, Period 3, Period 4, Period 5, Period 6
