-- radio.v_wsjtx_adif source

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `radio`.`v_wsjtx_adif` AS
select
    `log4om2`.`log`.`qsodate` AS `qsodate`,
    `log4om2`.`log`.`mode` AS `mode`,
    concat('<CALL:', octet_length(`log4om2`.`log`.`callsign`), '>', `log4om2`.`log`.`callsign`,
    ' <GRIDSQUARE:', octet_length(`log4om2`.`log`.`gridsquare`), '>', `log4om2`.`log`.`gridsquare`,
    ' <MODE:', octet_length(`log4om2`.`log`.`mode`), '>', `log4om2`.`log`.`mode`,
    ' <RST_SENT:', octet_length(`log4om2`.`log`.`rstsent`), '>', `log4om2`.`log`.`rstsent`,
    ' <RST_RCVD:', octet_length(`log4om2`.`log`.`rstrcvd`), '>', `log4om2`.`log`.`rstrcvd`,
    ' <QSO_DATE:8>', date_format(`log4om2`.`log`.`qsodate`, '%Y%m%d'),
    ' <TIME_ON:6>', time_format(`log4om2`.`log`.`qsodate`, '%H%i%s'),
    ' <QSO_DATE_OFF:8>', date_format(`log4om2`.`log`.`qsoenddate`, '%Y%m%d'),
    ' <TIME_OFF:6>', time_format(`log4om2`.`log`.`qsoenddate`, '%H%i%s'),
    ' <BAND:', octet_length(`log4om2`.`log`.`band`), '>', `log4om2`.`log`.`band`,
    ' <FREQ:', octet_length(round(`log4om2`.`log`.`freq` / 1000, 6)), '>', round(`log4om2`.`log`.`freq` / 1000, 6),
    ' <STATION_CALLSIGN:', octet_length(`log4om2`.`log`.`stationcallsign`), '>', `log4om2`.`log`.`stationcallsign`,
    ' <MY_GRIDSQUARE:', octet_length(`log4om2`.`log`.`mygridsquare`), '>', `log4om2`.`log`.`mygridsquare`,
    ' <TX_PWR:', octet_length(concat(round(`log4om2`.`log`.`txpwr`, 0), 'W')), '>', concat(round(`log4om2`.`log`.`txpwr`, 0), 'W'),
    ' <COMMENT:', octet_length(`log4om2`.`log`.`comment`), '>', `log4om2`.`log`.`comment`,
    ' <EOR>') AS `ADIF`
from
    `log4om2`.`log` where mode = 'FT8';