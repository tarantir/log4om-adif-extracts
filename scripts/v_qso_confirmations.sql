-- radio.v_qso_confirmations source

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `radio`.`v_qso_confirmations` AS
select
    `log4om2`.`log`.`qsoid` AS `qsoid`,
    ifnull(left(`qsoeqsl`.`S`, 1), 'N') AS `eqslsent`,
    ifnull(left(`qsoeqsl`.`R`, 1), 'N') AS `eqslrcvd`,
    ifnull(date_format(`qsoeqsl`.`SD`, '%Y%m%d'), '') AS `eqslsentdate`,
    ifnull(date_format(`qsoeqsl`.`RD`, '%Y%m%d'), '') AS `eqslrcvddate`,
    ifnull(left(`qsolotw`.`S`, 1), 'N') AS `lotwsent`,
    ifnull(left(`qsolotw`.`R`, 1), 'N') AS `lotwrcvd`,
    ifnull(date_format(`qsolotw`.`SD`, '%Y%m%d'), '') AS `lotwsentdate`,
    ifnull(date_format(`qsolotw`.`RD`, '%Y%m%d'), '') AS `lotwrcvddate`,
    ifnull(date_format(`qsoclublog`.`SD`, '%Y%m%d'), '') AS `clublogsentdate`,
    ifnull(left(`qsoclublog`.`S`, 1), 'N') AS `clublogsent`,
    ifnull(date_format(`qsohrdlog`.`SD`, '%Y%m%d'), '') AS `hrdlogsentdate`,
    ifnull(left(`qsohrdlog`.`S`, 1), 'N') AS `hrdlogsent`,
    ifnull(date_format(`qsoqrzcom`.`SD`, '%Y%m%d'), '') AS `qrzsentdate`,
    ifnull(left(`qsoqrzcom`.`S`, 1), 'N') AS `qrzsent`,
    ifnull(date_format(`qsohamqth`.`SD`, '%Y%m%d'), '') AS `hamqthsentdate`,
    ifnull(left(`qsohamqth`.`S`, 1), 'N') AS `hamqthsent`,
    ifnull(left(`qsoqsl`.`R`, 1), '') AS `qslrcvd`,
    ifnull(left(`qsoqsl`.`RV`, 1), '') AS `qslrvia`,
    ifnull(left(`qsoqsl`.`S`, 1), '') AS `qslsent`,
    ifnull(left(`qsoqsl`.`SV`, 1), '') AS `qslsvia`
from
    (((((((`log4om2`.`log`
join JSON_TABLE(`log4om2`.`log`.`qsoconfirmations`,
    '$[*]' COLUMNS (`CT` varchar(25) PATH '$.CT',
    `S` varchar(25) PATH '$.S',
    `R` varchar(25) PATH '$.R',
    `SV` varchar(25) PATH '$.SV',
    `RV` varchar(25) PATH '$.RV',
    `SD` datetime PATH '$.SD',
    `RD` datetime PATH '$.RD')) `qsoeqsl`)
join JSON_TABLE(`log4om2`.`log`.`qsoconfirmations`,
    '$[*]' COLUMNS (`CT` varchar(25) PATH '$.CT',
    `S` varchar(25) PATH '$.S',
    `R` varchar(25) PATH '$.R',
    `SV` varchar(25) PATH '$.SV',
    `RV` varchar(25) PATH '$.RV',
    `SD` datetime PATH '$.SD',
    `RD` datetime PATH '$.RD')) `qsolotw`)
join JSON_TABLE(`log4om2`.`log`.`qsoconfirmations`,
    '$[*]' COLUMNS (`CT` varchar(25) PATH '$.CT',
    `S` varchar(25) PATH '$.S',
    `R` varchar(25) PATH '$.R',
    `SV` varchar(25) PATH '$.SV',
    `RV` varchar(25) PATH '$.RV',
    `SD` datetime PATH '$.SD',
    `RD` datetime PATH '$.RD')) `qsoqsl`)
join JSON_TABLE(`log4om2`.`log`.`qsoconfirmations`,
    '$[*]' COLUMNS (`CT` varchar(25) PATH '$.CT',
    `S` varchar(25) PATH '$.S',
    `R` varchar(25) PATH '$.R',
    `SV` varchar(25) PATH '$.SV',
    `RV` varchar(25) PATH '$.RV',
    `SD` datetime PATH '$.SD',
    `RD` datetime PATH '$.RD')) `qsoclublog`)
join JSON_TABLE(`log4om2`.`log`.`qsoconfirmations`,
    '$[*]' COLUMNS (`CT` varchar(25) PATH '$.CT',
    `S` varchar(25) PATH '$.S',
    `R` varchar(25) PATH '$.R',
    `SV` varchar(25) PATH '$.SV',
    `RV` varchar(25) PATH '$.RV',
    `SD` datetime PATH '$.SD',
    `RD` datetime PATH '$.RD')) `qsoqrzcom`)
join JSON_TABLE(`log4om2`.`log`.`qsoconfirmations`,
    '$[*]' COLUMNS (`CT` varchar(25) PATH '$.CT',
    `S` varchar(25) PATH '$.S',
    `R` varchar(25) PATH '$.R',
    `SV` varchar(25) PATH '$.SV',
    `RV` varchar(25) PATH '$.RV',
    `SD` datetime PATH '$.SD',
    `RD` datetime PATH '$.RD')) `qsohrdlog`)
join JSON_TABLE(`log4om2`.`log`.`qsoconfirmations`,
    '$[*]' COLUMNS (`CT` varchar(25) PATH '$.CT',
    `S` varchar(25) PATH '$.S',
    `R` varchar(25) PATH '$.R',
    `SV` varchar(25) PATH '$.SV',
    `RV` varchar(25) PATH '$.RV',
    `SD` datetime PATH '$.SD',
    `RD` datetime PATH '$.RD')) `qsohamqth`)
where
    `qsoeqsl`.`CT` = 'EQSL'
    and `qsolotw`.`CT` = 'LOTW'
    and `qsoqsl`.`CT` = 'QSL'
    and `qsoclublog`.`CT` = 'CLUBLOG'
    and `qsohrdlog`.`CT` = 'HRDLOG'
    and `qsoqrzcom`.`CT` = 'QRZCOM'
    and `qsohamqth`.`CT` = 'HAMQTH'
order by
    `log4om2`.`log`.`qsodate`;