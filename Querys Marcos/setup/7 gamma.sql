/**
 * Contiene un snapshoot de la gamma valida al momento de activarse una orden de fabricacion.
 * Esta informacion se llena al momento de hacer el cambio de modelo, con la excepcion de que se tiene
 * que hacer manualmente la primera vez que se corre el programa (cuando se configura).
 */

-- se hace una imagen de la estructura cargada anteriormente


SELECT * FROM dbo.LineGamma WHERE LineCode = 'Lt';

-- EXEC dbo.UspUpdateLineGamma 'LF', '82015', 'LF';