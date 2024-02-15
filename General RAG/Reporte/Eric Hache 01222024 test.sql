SELECT
    MLW.[Id]
    ,MLT.TM_id,
    MLT.pack_time
    ,MLW.[fecha]
    ,MLW.[Hora]
    ,MLW.[qty]
    ,MLW.[line]
    ,MLW.[part_num]
    ,MLW.[rev]
    ,MLW.[description]
    ,MLW.[codew]
    ,MLW.[master_type]
    ,MLW.[is_active]
    ,MLW.[comments]
  FROM [TRAZAB].[dbo].[Master_labels_WB] MLW
  FULL JOIN [TRAZAB].[dbo].Master_lbl_TMid MLT ON MLT.Master_id = MLW.Id
  WHERE 
  part_num IN ('85079-10','85564-10','85564-10','85564-10','85079-10') 
 -- AND rev in ('A','X02A1','X03A1','Y01A','X02A2')
--   AND fecha in ('07-Dec-2023','06-Dec-2023','05-Dec-2023','30-Nov-2023','28-Nov-2023','27-Nov-2023','20-Nov-2023','16-Nov-2023','15-Nov-2023','14-Nov-2023','13-Nov-2023','08-Nov-2023','07-Nov-2023',
-- '06-Nov-2023','02-Nov-2023','01-Nov-2023','31-Oct-2023','30-Oct-2023','26-Oct-2023','31-Aug-2023','30-Aug-2023','29-Aug-2023','25-Aug-2023','24-Aug-2023','23-Aug-2023','22-Aug-2023','18-Aug-2023','27-Jul-2023',
-- '26-Jul-2023','25-Jul-2023','21-Jul-2023','20-Jul-2023','19-Jul-2023','14-Jul-2023','12-Jul-2023','07-Jul-2023','06-Jul-2023','05-Jul-2023','04-Jul-2023','30-Jun-2023','08-Jun-2023','07-Jun-2023','25-May-2023',
-- '23-May-2023','27-Apr-2023','26-Apr-2023','25-Apr-2023','24-Apr-2023','21-Apr-2023','20-Apr-2023','19-Apr-2023','18-Apr-2023','14-Apr-2023','13-Apr-2023','11-Apr-2023','10-Apr-2023','06-Apr-2023','05-Apr-2023',
-- '04-Apr-2023','30-Mar-2023','24-Mar-2023','23-Mar-2023','22-Mar-2023','21-Mar-2023','17-Mar-2023','16-Mar-2023','15-Mar-2023','14-Mar-2023','09-Mar-2023','08-Mar-2023','07-Mar-2023','06-Mar-2023','03-Mar-2023',
-- '02-Mar-2023','01-Mar-2023','28-Feb-2023')
--AND is_active = 0 
AND [line] = 'WB LA'
  --order by id desc