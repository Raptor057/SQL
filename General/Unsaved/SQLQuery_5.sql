SELECT g.comp_no, g.comp_rev, e.EtiNo FROM dbo.gamma g
--LEFT
JOIN dbo.PointOfUseEtis e
    ON e.ComponentNo = g.comp_no AND e.PointOfUseCode = g.point_of_use_code
    AND e.UtcUsageTime IS NOT NULL AND e.UtcExpirationTime IS NULL
    AND e.UtcUsageTime <= GETUTCDATE() AND (e.UtcExpirationTime IS NULL OR GETUTCDATE() < dbo.UfnToLocalTime(e.UtcExpirationTime))
WHERE g.part_no = '85265' AND g.part_rev = 'LB';

create table Processes (
    ProcessID NVARCHAR(16) NOT NULL PRIMARY KEY,
    ProcessName NVARCHAR(50) NOT NULL UNIQUE,
    IsEnabled BIT DEFAULT(1) NOT NULL
);

CREATE TABLE LineProcesses (
    LineCode CHAR(2) NOT NULL,
    ProcessID NVARCHAR(16) NOT NULL,
    CONSTRAINT PK_LineProcesses PRIMARY KEY(LineCode, ProcessID),
    CONSTRAINT FK_LineProcesses_Processes FOREIGN KEY (ProcessID) REFERENCES Processes(ProcessID))

CREATE TABLE LineProcessPointsOfUse (
    LineCode CHAR(2) NOT NULL,
    ProcessID NVARCHAR(16) NOT NULL,
    PointOfUseCode VARCHAR(4) NOT NULL,
    UtcEffectiveTime DATETIME NOT NULL DEFAULT(GETUTCDATE()),
    UtcExpirationTime DATETIME NOT NULL DEFAULT('2099-12-31 23:59:59.997'),
    CONSTRAINT PK_LineProcessPointsOfUse PRIMARY KEY(LineCode, ProcessID, PointOfUseCode, UtcExpirationTime),
    CONSTRAINT FK_LineProcessPointsOfUse_Processes FOREIGN KEY (ProcessID) REFERENCES Processes(ProcessID));

CREATE TABLE ProcessHistory (
    UtcTimeStamp DATETIME DEFAULT(GETUTCDATE()) NOT NULL,
    UnitID BIGINT NOT NULL,
    ProcessID NVARCHAR(16) NOT NULL,
    CONSTRAINT FK_ProcessHistory_Processes FOREIGN KEY(ProcessID) REFERENCES Processes(ProcessID),
    CONSTRAINT PK_ProcessHistory PRIMARY KEY (UtcTimeStamp, UnitID));