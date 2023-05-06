-- radio.v_wsjtx_log source

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `radio`.`v_wsjtx_log` AS
select
    substr(`log4om2`.`log`.`qsodate`, 1, 10) AS `QSODateOn`,
    substr(`log4om2`.`log`.`qsodate`, 12, 8) AS `QSOTimeOn`,
    substr(`log4om2`.`log`.`qsoenddate`, 1, 10) AS `QSODateOff`,
    substr(`log4om2`.`log`.`qsoenddate`, 12, 8) AS `QSOTimeOff`,
    `log4om2`.`log`.`callsign` AS `callsign`,
    substr(`log4om2`.`log`.`gridsquare`, 1, 4) AS `gridsquare`,
    round(`log4om2`.`log`.`freq` / 1000, 6) AS `frequency`,
    `log4om2`.`log`.`mode` AS `mode`,
    `log4om2`.`log`.`rstrcvd` AS `rstrcvd`,
    `log4om2`.`log`.`rstsent` AS `rstsent`,
    concat(substring_index(`log4om2`.`log`.`txpwr`, '.', 1), 'W') AS `power`,
    `log4om2`.`log`.`comment` AS `comment`
from
    `log4om2`.`log`
where
    `log4om2`.`log`.`mode` = 'FT8';
