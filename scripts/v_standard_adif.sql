CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `radio`.`v_standard_adif` AS
select
    `l`.`qsodate` AS `qsodate`,
    `l`.`mode` AS `mode`,
    concat('<CALL:', octet_length(`l`.`callsign`), '>', `l`.`callsign`,
    case
        when octet_length(`l`.`band`) > 0 then CONCAT(' <BAND:', octet_length(`l`.`band`), '>', `l`.`band`)
        else ''
    end,
    case
        when octet_length(`l`.`mode`) > 0 then CONCAT(' <MODE:', octet_length(`l`.`mode`), '>', `l`.`mode`)
        else ''
    end,
    case
        when octet_length(`l`.`qsodate`) > 0 then CONCAT(' <QSO_DATE:', octet_length(date_format(`l`.`qsodate`, '%Y%m%d')), '>', date_format(`l`.`qsodate`, '%Y%m%d'))
        else ''
    end,
    case
        when octet_length(`l`.`qsodate`) > 0 then CONCAT(' <TIME_ON:', octet_length(time_format(`l`.`qsodate`, '%H%i%s')), '>', time_format(`l`.`qsodate`, '%H%i%s'))
        else ''
    end,
    case
        when octet_length(`l`.`address`) > 0 then CONCAT(' <ADDRESS:', octet_length(replace(`l`.`address`, '\r\n', ' ')), '>', replace(`l`.`address`, '\r\n', ' '))
        else ''
    end,
    case
        when octet_length(`l`.`aindex`) > 0 then CONCAT(' <A_INDEX:', octet_length(`l`.`aindex`), '>', `l`.`aindex`)
        else ''
    end,
    case
        when octet_length(`l`.`antaz`) > 0 then CONCAT(' <ANT_AZ:', octet_length(`l`.`antaz`), '>', `l`.`antaz`)
        else ''
    end,
    case
        when octet_length(`l`.`antel`) > 0 then CONCAT(' <ANT_EL:', octet_length(`l`.`antel`), '>', `l`.`antel`)
        else ''
    end,
    case
        when octet_length(`l`.`state`) > 0 then CONCAT(' <STATE:', octet_length(`l`.`state`), '>', `l`.`state`)
        else ''
    end,
    case
        when octet_length(`l`.`comment`) > 0 then CONCAT(' <COMMENT:', octet_length(replace(replace(`l`.`comment`, '\r', ' '), '\n', ' ')), '>', replace(replace(`l`.`comment`, '\r', ' '), '\n', ' '))
        else ''
    end,
    case
        when octet_length(`l`.`cont`) > 0 then CONCAT(' <CONT:', octet_length(`l`.`cont`), '>', `l`.`cont`)
        else ''
    end,
    case
        when octet_length(`l`.`country`) > 0 then CONCAT(' <COUNTRY:', octet_length(`l`.`country`), '>', `l`.`country`)
        else ''
    end,
    case
        when octet_length(`l`.`cnty`) > 0 then CONCAT(' <CNTY:', octet_length(`l`.`cnty`), '>', `l`.`cnty`)
        else ''
    end,
    case
        when octet_length(`l`.`cqzone`) > 0 then CONCAT(' <CQZ:', octet_length(`l`.`cqzone`), '>', `l`.`cqzone`)
        else ''
    end,
    case
        when octet_length(`l`.`distance`) > 0 then CONCAT(' <DISTANCE:', octet_length(`l`.`distance`), '>', `l`.`distance`)
        else ''
    end,
    case
        when octet_length(`l`.`dxcc`) > 0 then CONCAT(' <DXCC:', octet_length(`l`.`dxcc`), '>', `l`.`dxcc`)
        else ''
    end,
    case
        when octet_length(`l`.`email`) > 0 then CONCAT(' <EMAIL', octet_length(`l`.`email`), '>', `l`.`email`)
        else ''
    end,
    case
        when octet_length(`q`.`eqslrcvddate`) > 0 then CONCAT(' <EQSL_QSLRDATE:', octet_length(`q`.`eqslrcvddate`), '>', `q`.`eqslrcvddate`)
        else ''
    end,
    case
        when octet_length(`q`.`eqslsentdate`) > 0 then CONCAT(' <EQSL_QSLSDATE:', octet_length(`q`.`eqslsentdate`), '>', `q`.`eqslsentdate`)
        else ''
    end,
    case
        when octet_length(`q`.`eqslrcvd`) > 0 then CONCAT(' <EQSL_QSL_RCVD:', octet_length(`q`.`eqslrcvd`), '>', `q`.`eqslrcvd`)
        else ''
    end,
    case
        when octet_length(`q`.`eqslsent`) > 0 then CONCAT(' <EQSL_QSL_SENT:', octet_length(`q`.`eqslsent`), '>', `q`.`eqslsent`)
        else ''
    end,
    case
        when octet_length(`l`.`freq`) > 0 then CONCAT(' <FREQ:', octet_length(round(`l`.`freq` / 1000, 6)), '>', round(`l`.`freq` / 1000, 6))
        else ''
    end,
    case
        when octet_length(`l`.`gridsquare`) > 0 then CONCAT(' <GRIDSQUARE:', octet_length(`l`.`gridsquare`), '>', `l`.`gridsquare`)
        else ''
    end,
    case
        when octet_length(`l`.`ituzone`) > 0 then CONCAT(' <ITUZ:', octet_length(`l`.`ituzone`), '>', `l`.`ituzone`)
        else ''
    end,
    case
        when octet_length(`q`.`lotwrcvddate`) > 0 then CONCAT(' <LOTW_QSLRDATE:', octet_length(`q`.`lotwrcvddate`), '>', `q`.`lotwrcvddate`)
        else ''
    end,
    case
        when octet_length(`q`.`lotwsentdate`) > 0 then CONCAT(' <LOTW_QSLSDATE:', octet_length(`q`.`lotwsentdate`), '>', `q`.`lotwsentdate`)
        else ''
    end,
    case
        when octet_length(`q`.`lotwrcvd`) > 0 then CONCAT(' <LOTW_QSL_RCVD:', octet_length(`q`.`lotwrcvd`), '>', `q`.`lotwrcvd`)
        else ''
    end,
    case
        when octet_length(`q`.`lotwsent`) > 0 then CONCAT(' <LOTW_QSL_SENT:', octet_length(`q`.`lotwsent`), '>', `q`.`lotwsent`)
        else ''
    end,
    case
        when octet_length(`l`.`mycity`) > 0 then CONCAT(' <MY_CITY:', octet_length(`l`.`mycity`), '>', `l`.`mycity`)
        else ''
    end,
    case
        when octet_length(`l`.`mycnty`) > 0 then CONCAT(' <MY_CNTY:', octet_length(`l`.`mycnty`), '>', `l`.`mycnty`)
        else ''
    end,
    case
        when octet_length(`l`.`mycountry`) > 0 then CONCAT(' <MY_COUNTRY:', octet_length(`l`.`mycountry`), '>', `l`.`mycountry`)
        else ''
    end,
    case
        when octet_length(`l`.`mycqzone`) > 0 then CONCAT(' <MY_CQ_ZONE:', octet_length(`l`.`mycqzone`), '>', `l`.`mycqzone`)
        else ''
    end,
    case
        when octet_length(`l`.`mydxcc`) > 0 then CONCAT(' <MY_DXCC:', octet_length(`l`.`mydxcc`), '>', `l`.`mydxcc`)
        else ''
    end,
    case
        when octet_length(`l`.`mygridsquare`) > 0 then CONCAT(' <MY_GRIDSQUARE:', octet_length(`l`.`mygridsquare`), '>', `l`.`mygridsquare`)
        else ''
    end,
    case
        when octet_length(`l`.`myituZone`) > 0 then CONCAT(' <MY_ITU_ZONE:', octet_length(`l`.`myituZone`), '>', `l`.`myituZone`)
        else ''
    end,
    case
        when octet_length(`l`.`myname`) > 0 then CONCAT(' <MY_NAME:', octet_length(`l`.`myname`), '>', `l`.`myname`)
        else ''
    end,
    case
        when octet_length(`l`.`mypostalcode`) > 0 then CONCAT(' <MY_POSTAL_CODE:', octet_length(`l`.`mypostalcode`), '>', `l`.`mypostalcode`)
        else ''
    end,
    case
        when octet_length(`l`.`myrig`) > 0 then CONCAT(' <MY_RIG:', octet_length(`l`.`myrig`), '>', `l`.`myrig`)
        else ''
    end,
    case
        when octet_length(`l`.`mystate`) > 0 then CONCAT(' <MY_STATE:', octet_length(`l`.`mystate`), '>', `l`.`mystate`)
        else ''
    end,
    case
        when octet_length(`l`.`mystreet`) > 0 then CONCAT(' <MY_STREET:', octet_length(`l`.`mystreet`), '>', `l`.`mystreet`)
        else ''
    end,
    case
        when octet_length(`l`.`name`) > 0 then CONCAT(' <NAME:', octet_length(`l`.`name`), '>', `l`.`name`)
        else ''
    end,
    case
        when octet_length(`l`.`stationcallsign`) > 0 then CONCAT(' <STATION_CALLSIGN:', octet_length(`l`.`stationcallsign`), '>', `l`.`stationcallsign`)
        else ''
    end,
    case
        when octet_length(`l`.`programid`) > 0 then CONCAT(' <PROGRAMID:', octet_length(`l`.`programid`), '>', `l`.`programid`)
        else ''
    end,
    case
        when octet_length(`l`.`programversion`) > 0 then CONCAT(' <PROGRAMVERSION:', octet_length(`l`.`programversion`), '>', `l`.`programversion`)
        else ''
    end,
    case
        when octet_length(`q`.`qslrcvd`) > 0 then CONCAT(' <QSL_RCVD:', octet_length(`q`.`qslrcvd`), '>', `q`.`qslrcvd`)
        else ''
    end,
    case
        when octet_length(`q`.`qslrvia`) > 0 then CONCAT(' <QSL_RCVD_VIA:', octet_length(`q`.`qslrvia`), '>', `q`.`qslrvia`)
        else ''
    end,
    case
        when octet_length(`q`.`qslsent`) > 0 then CONCAT(' <QSL_SENT:', octet_length(`q`.`qslsent`), '>', `q`.`qslsent`)
        else ''
    end,
    case
        when octet_length(`q`.`qslsvia`) > 0 then CONCAT(' <QSL_SENT_VIA:', octet_length(`q`.`qslsvia`), '>', `q`.`qslsvia`)
        else ''
    end,
    case
        when octet_length(`l`.`qslvia`) > 0 then CONCAT(' <QSL_VIA:', octet_length(`l`.`qslvia`), '>', `l`.`qslvia`)
        else ''
    end,
    case
        when octet_length(`l`.`qsocomplete`) > 0 then CONCAT(' <QSO_COMPLETE:', octet_length(replace(replace(`l`.`qsocomplete`, '1', 'Y'), '0', 'N')), '>', replace(replace(`l`.`qsocomplete`, '1', 'Y'), '0', 'N'))
        else ''
    end,
    case
        when octet_length(`l`.`qsoenddate`) > 0 then CONCAT(' <QSO_DATE_OFF:', octet_length(date_format(`l`.`qsoenddate`, '%Y%m%d')), '>', date_format(`l`.`qsoenddate`, '%Y%m%d'))
        else ''
    end,
    case
        when octet_length(`l`.`qth`) > 0 then CONCAT(' <QTH:', octet_length(`l`.`qth`), '>', `l`.`qth`)
        else ''
    end,
    case
        when octet_length(`l`.`rstrcvd`) > 0 then CONCAT(' <RST_RCVD:', octet_length(`l`.`rstrcvd`), '>', `l`.`rstrcvd`)
        else ''
    end,
    case
        when octet_length(`l`.`rstsent`) > 0 then CONCAT(' <RST_SENT:', octet_length(`l`.`rstsent`), '>', `l`.`rstsent`)
        else ''
    end,
    case
        when octet_length(`l`.`swl`) > 0 then CONCAT(' <SWL:', octet_length(replace(replace(`l`.`swl`, '1', 'Y'), '0', 'N')), '>', replace(replace(`l`.`swl`, '1', 'Y'), '0', 'N'))
        else ''
    end,
    case
        when octet_length(`l`.`qsoenddate`) > 0 then CONCAT(' <TIME_OFF:', octet_length(time_format(`l`.`qsoenddate`, '%H%i%s')), '>', time_format(`l`.`qsoenddate`, '%H%i%s'))
        else ''
    end,
    case
        when octet_length(`l`.`txpwr`) > 0 then CONCAT(' <TX_PWR:', octet_length(round(`l`.`txpwr`, 3)), '>', round(`l`.`txpwr`, 3))
        else ''
    end,
    case
        when octet_length(`l`.`kindex`) > 0 then CONCAT(' <K_INDEX:', octet_length(`l`.`kindex`), '>', `l`.`kindex`)
        else ''
    end,
    case
        when octet_length(`l`.`lat`) > 0 then CONCAT(' <LAT:', octet_length(`l`.`lat`), '>', `l`.`lat`)
        else ''
    end,
    case
        when octet_length(`l`.`lon`) > 0 then CONCAT(' <LON:', octet_length(`l`.`lon`), '>', `l`.`lon`)
        else ''
    end,
    case
        when octet_length(`l`.`mylat`) > 0 then CONCAT(' <MY_LAT:', octet_length(`l`.`mylat`), '>', `l`.`mylat`)
        else ''
    end,
    case
        when octet_length(`l`.`mylon`) > 0 then CONCAT(' <MY_LON:', octet_length(`l`.`mylon`), '>', `l`.`mylon`)
        else ''
    end,
    case
        when octet_length(`l`.`antenna`) > 0 then CONCAT(' <MY_ANTENNA:', octet_length(`l`.`antenna`), '>', `l`.`antenna`)
        else ''
    end,
    case
        when octet_length(`l`.`pfx`) > 0 then CONCAT(' <PFX:', octet_length(`l`.`pfx`), '>', `l`.`pfx`)
        else ''
    end,
    case
        when octet_length(`l`.`qsorandom`) > 0 then CONCAT(' <QSO_RANDOM:', octet_length(replace(replace(`l`.`qsorandom`, '1', 'Y'), '0', 'N')), '>', replace(replace(`l`.`qsorandom`, '1', 'Y'), '0', 'N'))
        else ''
    end,
    case
        when octet_length(`l`.`sfi`) > 0 then CONCAT(' <SFI:', octet_length(`l`.`sfi`), '>', `l`.`sfi`)
        else ''
    end,
    case
        when octet_length(`q`.`clublogsentdate`) > 0 then CONCAT(' <CLUBLOG_QSO_UPLOAD_DATE:', octet_length(`q`.`clublogsentdate`), '>', `q`.`clublogsentdate`)
        else ''
    end,
    case
        when octet_length(`q`.`clublogsent`) > 0 then CONCAT(' <CLUBLOG_QSO_UPLOAD_STATUS:', octet_length(`q`.`clublogsent`), '>', `q`.`clublogsent`)
        else ''
    end,
    case
        when octet_length(`q`.`hrdlogsentdate`) > 0 then CONCAT(' <HRDLOG_QSO_UPLOAD_DATE:', octet_length(`q`.`hrdlogsentdate`), '>', `q`.`hrdlogsentdate`)
        else ''
    end,
    case
        when octet_length(`q`.`hrdlogsent`) > 0 then CONCAT(' <HRDLOG_QSO_UPLOAD_STATUS:', octet_length(`q`.`hrdlogsent`), '>', `q`.`hrdlogsent`)
        else ''
    end,
    case
        when octet_length(`q`.`qrzsentdate`) > 0 then CONCAT(' <QRZCOM_QSO_UPLOAD_DATE:', octet_length(`q`.`qrzsentdate`), '>', `q`.`qrzsentdate`)
        else ''
    end,
    case
        when octet_length(`q`.`qrzsent`) > 0 then CONCAT(' <QRZCOM_QSO_UPLOAD_STATUS:', octet_length(`q`.`qrzsent`), '>', `q`.`qrzsent`)
        else ''
    end,
    case
        when octet_length(`q`.`hamqthsentdate`) > 0 then CONCAT(' <HAMQTH_QSO_UPLOAD_DATE:', octet_length(`q`.`hamqthsentdate`), '>', `q`.`hamqthsentdate`)
        else ''
    end,
    case
        when octet_length(`q`.`hamqthsent`) > 0 then CONCAT(' <HAMQTH_QSO_UPLOAD_STATUS:', octet_length(`q`.`hamqthsent`), '>', `q`.`hamqthsent`)
        else ''
    end,
    ' <EOR>') AS `ADIF`
from
    (`log4om2`.`log` `l`
join `radio`.`v_qso_confirmations` `q`)
where
    `l`.`callsign` <> ''
    and `l`.`qsoid` = `q`.`qsoid`
order by
    `l`.`qsodate` desc