/**
 * Esta tabla contiene la informacion de la orden de produccion activa al momento.
 * La orden activa contiene la fecha 2099-12-31 en el campo expiracion.
 * Se utiliza principalmente para el hora por hora.
 * Esta tabla se llena automaticamente por el proceso de cambio de modelo, con la excepcion
 * de cuando se configura la linea por primera vez.
 */




SELECT * FROM dbo.LineProductionSchedule
where LineCode = 'lk' order by UtcEffectiveTime DESC

--SELECT * FROM MXSRVTRACA.APPS.dbo.pro_prod_units WHERE letter = 'LT';

--SELECT * FROM MXSRVTRACA.APPS.dbo.pro_production WHERE codew='la'