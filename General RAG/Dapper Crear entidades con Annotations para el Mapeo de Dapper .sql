DECLARE @TableName sysname = 'SaleStatuses';

SELECT @TableName = name
FROM sys.tables
WHERE name = @TableName;

DECLARE @Result VARCHAR(MAX) = 'using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

public class ' + @TableName + '
{';

-- Generar propiedades estándar, excluyendo claves primarias
SELECT @Result = @Result + '
    public ' + ColumnType + NullableSign + ' ' + ColumnName + ' { get; set; }'
FROM (
    SELECT 
        REPLACE(c.name, ' ', '_') AS ColumnName,
        c.column_id AS ColumnId,
        CASE t.name
            WHEN 'bigint' THEN 'long'
            WHEN 'binary' THEN 'byte[]'
            WHEN 'bit' THEN 'bool'
            WHEN 'char' THEN 'string'
            WHEN 'date' THEN 'DateTime'
            WHEN 'datetime' THEN 'DateTime'
            WHEN 'datetime2' THEN 'DateTime'
            WHEN 'datetimeoffset' THEN 'DateTimeOffset'
            WHEN 'decimal' THEN 'decimal'
            WHEN 'float' THEN 'float'
            WHEN 'image' THEN 'byte[]'
            WHEN 'int' THEN 'int'
            WHEN 'money' THEN 'decimal'
            WHEN 'nchar' THEN 'string'
            WHEN 'ntext' THEN 'string'
            WHEN 'numeric' THEN 'decimal'
            WHEN 'nvarchar' THEN 'string'
            WHEN 'real' THEN 'double'
            WHEN 'smalldatetime' THEN 'DateTime'
            WHEN 'smallint' THEN 'short'
            WHEN 'smallmoney' THEN 'decimal'
            WHEN 'text' THEN 'string'
            WHEN 'time' THEN 'TimeSpan'
            WHEN 'timestamp' THEN 'DateTime'
            WHEN 'tinyint' THEN 'byte'
            WHEN 'uniqueidentifier' THEN 'Guid'
            WHEN 'varbinary' THEN 'byte[]'
            WHEN 'varchar' THEN 'string'
            ELSE 'UNKNOWN_' + t.name
        END AS ColumnType,
        CASE 
            WHEN c.is_nullable = 1 AND t.name IN (
                'bigint', 'bit', 'date', 'datetime', 'datetime2', 'datetimeoffset',
                'decimal', 'float', 'int', 'money', 'numeric', 'real',
                'smalldatetime', 'smallint', 'smallmoney', 'time',
                'tinyint', 'uniqueidentifier'
            ) THEN '?'
            ELSE ''
        END AS NullableSign
    FROM sys.columns c
    JOIN sys.types t ON c.user_type_id = t.user_type_id
    WHERE c.object_id = OBJECT_ID(@TableName)
      AND c.column_id NOT IN (
          SELECT ic.column_id
          FROM sys.key_constraints kc
          JOIN sys.index_columns ic ON kc.parent_object_id = ic.object_id
          WHERE kc.type = 'PK' AND kc.parent_object_id = OBJECT_ID(@TableName)
      )
) cols
ORDER BY ColumnId;

-- Agregar claves primarias
SELECT @Result = @Result + '
    [Key]
    public ' + ColumnType + ' ' + ColumnName + ' { get; set; }'
FROM (
    SELECT 
        REPLACE(c.name, ' ', '_') AS ColumnName,
        CASE t.name
            WHEN 'bigint' THEN 'long'
            WHEN 'binary' THEN 'byte[]'
            WHEN 'bit' THEN 'bool'
            WHEN 'char' THEN 'string'
            WHEN 'date' THEN 'DateTime'
            WHEN 'datetime' THEN 'DateTime'
            WHEN 'datetime2' THEN 'DateTime'
            WHEN 'datetimeoffset' THEN 'DateTimeOffset'
            WHEN 'decimal' THEN 'decimal'
            WHEN 'float' THEN 'float'
            WHEN 'image' THEN 'byte[]'
            WHEN 'int' THEN 'int'
            WHEN 'money' THEN 'decimal'
            WHEN 'nchar' THEN 'string'
            WHEN 'ntext' THEN 'string'
            WHEN 'numeric' THEN 'decimal'
            WHEN 'nvarchar' THEN 'string'
            WHEN 'real' THEN 'double'
            WHEN 'smalldatetime' THEN 'DateTime'
            WHEN 'smallint' THEN 'short'
            WHEN 'smallmoney' THEN 'decimal'
            WHEN 'text' THEN 'string'
            WHEN 'time' THEN 'TimeSpan'
            WHEN 'timestamp' THEN 'DateTime'
            WHEN 'tinyint' THEN 'byte'
            WHEN 'uniqueidentifier' THEN 'Guid'
            WHEN 'varbinary' THEN 'byte[]'
            WHEN 'varchar' THEN 'string'
            ELSE 'UNKNOWN_' + t.name
        END AS ColumnType
    FROM sys.key_constraints kc
    JOIN sys.index_columns ic ON kc.parent_object_id = ic.object_id
    JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
    JOIN sys.types t ON c.user_type_id = t.user_type_id
    WHERE kc.type = 'PK' AND kc.parent_object_id = OBJECT_ID(@TableName)
) keys;

-- Agregar claves foráneas
SELECT @Result = @Result + '
    [ForeignKey("' + FKColumnName + '")]
    public ' + ReferencedTableName + ' ' + ReferencedTableName + ' { get; set; }'
FROM (
    SELECT 
        REPLACE(fk.name, ' ', '_') AS FKColumnName,
        OBJECT_NAME(fkc.referenced_object_id) AS ReferencedTableName
    FROM sys.foreign_keys fk
    JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
    WHERE fk.parent_object_id = OBJECT_ID(@TableName)
) fks;

-- Finalizar la clase
SET @Result = @Result + '
}';

-- Imprimir el resultado
PRINT @Result;
