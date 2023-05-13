CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `radio`.`v_standard_adif` AS
select
    `l`.`qsodate` AS `qsodate`,
    `l`.`mode` AS `mode`,
    concat('<CALL:', octet_length(`l`.`callsign`), '>', `l`.`callsign`, 
    ' <BAND:', octet_length(`l`.`band`), '>', `l`.`band`, 
    ' <MODE:', octet_length(`l`.`mode`), '>', `l`.`mode`, 
    ' <QSO_DATE:', octet_length(date_format(`l`.`qsodate`, '%Y%m%d')), '>', date_format(`l`.`qsodate`, '%Y%m%d'), 
    ' <TIME_ON:', octet_length(time_format(`l`.`qsodate`, '%H%i%s')), '>', time_format(`l`.`qsodate`, '%H%i%s'), 
    ' <ADDRESS:', octet_length(replace(replace(`l`.`address`, '\r', ' '), '\n', ' ')), '>', replace(replace(`l`.`address`, '\r', ' '), '\n', ' '), 
    ' <A_INDEX:', octet_length(`l`.`aindex`), '>', `l`.`aindex`, 
    ' <ANT_AZ:', octet_length(`l`.`antaz`), '>', `l`.`antaz`, 
    ' <ANT_EL:', octet_length(`l`.`antel`), '>', `l`.`antel`, 
    ' <STATE:', octet_length(`l`.`state`), '>', `l`.`state`, 
    ' <COMMENT:', octet_length(replace(replace(`l`.`comment`, '\r', ' '), '\n', ' ')), '>', replace(replace(`l`.`comment`, '\r', ' '), '\n', ' '), 
    ' <CONT:', octet_length(`l`.`cont`), '>', `l`.`cont`, 
    ' <COUNTRY:', octet_length(`l`.`country`), '>', `l`.`country`, 
    ' <CNTY:', octet_length(`l`.`cnty`), '>', `l`.`cnty`, 
    ' <CQZ:', octet_length(`l`.`cqzone`), '>', `l`.`cqzone`, 
    ' <DISTANCE:', octet_length(`l`.`distance`), '>', `l`.`distance`, 
    ' <DXCC:', octet_length(`l`.`dxcc`), '>', `l`.`dxcc`, 
    ' <EMAIL', octet_length(`l`.`email`), '>', `l`.`email`, 
    case 
        when `q`.`eqslrcvddate` <> '' then CONCAT(' <EQSL_QSLRDATE:', octet_length(`q`.`eqslrcvddate`), '>', `q`.`eqslrcvddate`)
        else '' 
    end,
    case 
        when `q`.`eqslsentdate` <> '' then CONCAT(' <EQSL_QSLSDATE:', octet_length(`q`.`eqslsentdate`), '>', `q`.`eqslsentdate`)
        else '' 
    end,
    ' <EQSL_QSL_RCVD:', octet_length(`q`.`eqslrcvd`), '>', `q`.`eqslrcvd`, 
    ' <EQSL_QSL_SENT:', octet_length(`q`.`eqslsent`), '>', `q`.`eqslsent`, 
    ' <FREQ:', octet_length(round(`l`.`freq` / 1000, 6)), '>', round(`l`.`freq` / 1000, 6), 
    ' <GRIDSQUARE:', octet_length(`l`.`gridsquare`), '>', `l`.`gridsquare`, 
    ' <ITUZ:', octet_length(`l`.`ituzone`), '>', `l`.`ituzone`, 
    case
        when `q`.`lotwsentdate` <> '' then CONCAT(' <LOTW_QSLRDATE:', octet_length(`q`.`lotwrcvddate`), '>', `q`.`lotwrcvddate`)
        else '' 
    end, 
    case
        when `q`.`lotwsentdate` <> '' then CONCAT(' <LOTW_QSLSDATE:', octet_length(`q`.`lotwsentdate`), '>', `q`.`lotwsentdate`) 
        else '' 
    end,
    ' <LOTW_QSL_RCVD:', octet_length(`q`.`lotwrcvd`), '>', `q`.`lotwrcvd`, 
    ' <LOTW_QSL_SENT:', octet_length(`q`.`lotwsent`), '>', `q`.`lotwsent`, 
    ' <MY_CITY:', octet_length(`l`.`mycity`), '>', `l`.`mycity`, 
    ' <MY_CNTY:', octet_length(`l`.`mycnty`), '>', `l`.`mycnty`, 
    ' <MY_COUNTRY:', octet_length(`l`.`mycountry`), '>', `l`.`mycountry`, 
    ' <MY_CQ_ZONE:', octet_length(`l`.`mycqzone`), '>', `l`.`mycqzone`, 
    ' <MY_DXCC:', octet_length(`l`.`mydxcc`), '>', `l`.`mydxcc`, 
    ' <MY_GRIDSQUARE:', octet_length(`l`.`mygridsquare`), '>', `l`.`mygridsquare`, 
    ' <MY_ITU_ZONE:', octet_length(`l`.`myituZone`), '>', `l`.`myituZone`, 
    ' <MY_NAME:', octet_length(`l`.`myname`), '>', `l`.`myname`, 
    ' <MY_POSTAL_CODE:', octet_length(`l`.`mypostalcode`), '>', `l`.`mypostalcode`, 
    ' <MY_RIG:', octet_length(`l`.`myrig`), '>', `l`.`myrig`, 
    ' <MY_STATE:', octet_length(`l`.`mystate`), '>', `l`.`mystate`, 
    ' <MY_STREET:', octet_length(`l`.`mystreet`), '>', `l`.`mystreet`, 
    ' <NAME:', octet_length(`l`.`name`), '>', `l`.`name`, 
    ' <STATION_CALLSIGN:', octet_length(`l`.`stationcallsign`), '>', `l`.`stationcallsign`, 
    ' <PROGRAMID:', octet_length(`l`.`programid`), '>', `l`.`programid`, 
    ' <PROGRAMVERSION:', octet_length(`l`.`programversion`), '>', `l`.`programversion`, 
    ' <QSL_RCVD:', octet_length(`q`.`qslrcvd`), '>', `q`.`qslrcvd`, 
    ' <QSL_RCVD_VIA:', octet_length(`q`.`qslrvia`), '>', `q`.`qslrvia`, 
    ' <QSL_SENT:', octet_length(`q`.`qslsent`), '>', `q`.`qslsent`, 
    ' <QSL_SENT_VIA:', octet_length(`q`.`qslsvia`), '>', `q`.`qslsvia`, 
    ' <QSL_VIA:', octet_length(`l`.`qslvia`), '>', `l`.`qslvia`, 
    ' <QSO_COMPLETE:', octet_length(replace(replace(`l`.`qsocomplete`, '1', 'Y'), '0', 'N')), '>', replace(replace(`l`.`qsocomplete`, '1', 'Y'), '0', 'N'), 
    ' <QSO_DATE_OFF:', octet_length(date_format(`l`.`qsoenddate`, '%Y%m%d')), '>', date_format(`l`.`qsoenddate`, '%Y%m%d'), 
    ' <QTH:', octet_length(`l`.`qth`), '>', `l`.`qth`, 
    ' <RST_RCVD:', octet_length(`l`.`rstrcvd`), '>', `l`.`rstrcvd`, 
    ' <RST_SENT:', octet_length(`l`.`rstsent`), '>', `l`.`rstsent`, 
    ' <SWL:', octet_length(replace(replace(`l`.`swl`, '1', 'Y'), '0', 'N')), '>', replace(replace(`l`.`swl`, '1', 'Y'), '0', 'N'), 
    ' <TIME_OFF:', octet_length(time_format(`l`.`qsoenddate`, '%H%i%s')), '>', time_format(`l`.`qsoenddate`, '%H%i%s'), 
    ' <TX_PWR:', octet_length(round(`l`.`txpwr`, 3)), '>', round(`l`.`txpwr`, 3), 
    ' <K_INDEX:', octet_length(`l`.`kindex`), '>', `l`.`kindex`, 
    ' <LAT:', octet_length(`l`.`lat`), '>', `l`.`lat`, 
    ' <LON:', octet_length(`l`.`lon`), '>', `l`.`lon`, 
    ' <MY_LAT:', octet_length(`l`.`mylat`), '>', `l`.`mylat`, 
    ' <MY_LON:', octet_length(`l`.`mylon`), '>', `l`.`mylon`, 
    ' <MY_ANTENNA:', octet_length(`l`.`antenna`), '>', `l`.`antenna`, 
    ' <PFX:', octet_length(`l`.`pfx`), '>', `l`.`pfx`, 
    ' <QSO_RANDOM:', octet_length(replace(replace(`l`.`qsorandom`, '1', 'Y'), '0', 'N')), '>', replace(replace(`l`.`qsorandom`, '1', 'Y'), '0', 'N'), 
    ' <SFI:', octet_length(`l`.`sfi`), '>', `l`.`sfi`, 
    case 
        when `q`.`clublogsentdate` <> '' then CONCAT(' <CLUBLOG_QSO_UPLOAD_DATE:', octet_length(`q`.`clublogsentdate`), '>', `q`.`clublogsentdate`) 
        else '' 
    end, 
    ' <CLUBLOG_QSO_UPLOAD_STATUS:', octet_length(`q`.`clublogsent`), '>', `q`.`clublogsent`, 
    case
        when `q`.`hrdlogsentdate` <> '' then CONCAT(' <HRDLOG_QSO_UPLOAD_DATE:', octet_length(`q`.`hrdlogsentdate`), '>', `q`.`hrdlogsentdate`) 
        else '' 
    end, 
    ' <HRDLOG_QSO_UPLOAD_STATUS:', octet_length(`q`.`hrdlogsent`), '>', `q`.`hrdlogsent`, 
    case
        when `q`.`qrzsentdate` <> '' then CONCAT(' <QRZCOM_QSO_UPLOAD_DATE:', octet_length(`q`.`qrzsentdate`), '>', `q`.`qrzsentdate`) 
        else '' 
    end, 
    ' <QRZCOM_QSO_UPLOAD_STATUS:', octet_length(`q`.`qrzsent`), '>', `q`.`qrzsent`, 
    case
        when `q`.`hamqthsentdate` <> '' then CONCAT(' <HAMQTH_QSO_UPLOAD_DATE:', octet_length(`q`.`hamqthsentdate`), '>', `q`.`hamqthsentdate`) 
        else '' 
    end,
    ' <HAMQTH_QSO_UPLOAD_STATUS:', octet_length(`q`.`hamqthsent`), '>', `q`.`hamqthsent`, 
    ' <EOR>') AS `ADIF`
from
    (`log4om2`.`log` `l`
join `radio`.`v_qso_confirmations` `q`)
where
    `l`.`qsoid` = `q`.`qsoid`
order by
    `l`.`qsodate`;