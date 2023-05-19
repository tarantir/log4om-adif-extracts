-- radio.v_qso_iota source

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `radio`.`v_qso_iota` AS
select
    `log4om2`.`log`.`qsoid` AS `qsoid`,
    ifnull(`qsoiota`.`G`, '') AS `iota`
from
    (`log4om2`.`log`
join JSON_TABLE(`log4om2`.`log`.`contactreferences`,
    '$[*]' COLUMNS (`AC` varchar(25) PATH '$.AC',
    `R` varchar(25) PATH '$.R',
    `G` varchar(25) PATH '$.G',
    `SG` varchar(25) PATH '$.SG',
    `S` varchar(25) PATH '$.S',
    `SUB` datetime PATH '$.SUB',
    `GRA` datetime PATH '$.GRA')) `qsoiota`)
where
    `qsoiota`.`AC` = 'IOTA'
order by
    `log4om2`.`log`.`qsodate`;