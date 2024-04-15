CREATE FUNCTION dbo.CountComponentsBom(@part_no VARCHAR(50), @revision VARCHAR(50))
RETURNS INT
AS
BEGIN
    DECLARE @CountComponentsCegid INT,
            @CountComponentsTrazab INT,
            @Result INT;
    
    SELECT @CountComponentsCegid = COUNT(n.NOKTCODPF)
    FROM MXSRVCEGID.PMI.dbo.NOMENC n WITH (NOLOCK)
    JOIN MXSRVCEGID.PMI.dbo.ARTICLE a WITH (NOLOCK) ON a.ARKTSOC = n.NOKTSOC
        AND a.ARCTFATN != 17
        AND a.ARKTCODART = n.NOCTCODECP
        AND a.ARKTCOMART = n.NOCTCOMCPT
    LEFT JOIN MXSRVCEGID.PMI.dbo.UARTICLE u WITH (NOLOCK) ON n.NOCTCODECP = u.ARKTCODART
        AND n.NOCTCOMCPT = u.ARKTCOMART
    JOIN MXSRVCEGID.PMI.dbo.ARTICLE z WITH (NOLOCK) ON z.ARKTCODART = n.NOKTCODPF
        AND z.ARKTCOMART = n.NOKTCOMPF
        AND z.ARCTFATN != 17
    WHERE n.NOKTSOC = '300'
        AND RTRIM(n.NOKTCODPF) = UPPER(@part_no)
        AND RTRIM(n.NOKTCOMPF) = UPPER(@revision)
        AND NOT (n.NOCTCODOPE = '' OR n.NOCTCODOPE IS NULL);
    
    SELECT @CountComponentsTrazab = COUNT(NOKTCODPF)
    FROM [MXSRVTRACA].[TRAZAB].[cegid].[bom]
    WHERE NOKTCODPF = @part_no AND NOKTCOMPF = @revision;
    
    IF @CountComponentsCegid = @CountComponentsTrazab
    BEGIN
        SET @Result = 1;
    END
    ELSE
    BEGIN
        SET @Result = 0;
    END
    
    RETURN @Result;
END;
