#!/usr/bin/python3
'''
 Extracts Standard ADIF structure from Log4om2 Database
 Version: 20230506

 Requires: v_standard_adif, v_wsjtx_adif, v_wsjtx_log, v_qso_confirmations

 WARNING!! There is no garantee the database password is passed securely.

 Author: Randall Tarantino (rtaranti AT gmail DOT com) is a HAM Radio enthusiast 
 not affiliated with Log4OM. Log4OM (https://www.log4om.com/) is made by 
 Daniele Pistollato - IW3HMH and G4POP Terry Genes.
 
 This code is licensed under:

 MIT License

 Copyright (c) 2023 Randall Tarantino (rtaranti AT gmail DOT com)

 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the “Software”), to deal in the
 Software without restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 Software, and to permit persons to whom the Software is furnished to do so, subject
 to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
 OR OTHER DEALINGS IN THE SOFTWARE.
 
'''

import csv
import os
import configparser
import getpass
import pandas as pd
import mysql.connector as connection

DBHOST = ''
DBNAME = ''
DBUSER = ''
DBPASS = ''
S_ADIF_PATH = ''
W_ADIF_PATH = ''
W_LOG_PATH = ''
USER_HOME = os.path.expanduser("~")
APP_CONFIG_DIR = os.path.join(USER_HOME, ".adifexporter")
APP_CONFIG = os.path.join(APP_CONFIG_DIR,"config")

if not os.path.isdir(APP_CONFIG_DIR) :
    os.makedirs(APP_CONFIG_DIR)

config = configparser.ConfigParser()

try:
    config.read(APP_CONFIG)
    DBHOST = config['GENERAL']['DBHOST']
    DBNAME = config['GENERAL']['DBNAME']
    DBUSER = config['GENERAL']['DBUSER']
    S_ADIF_PATH = config['GENERAL']['S_ADIF_PATH']
    W_ADIF_PATH = config['GENERAL']['W_ADIF_PATH']
    W_LOG_PATH = config['GENERAL']['W_LOG_PATH']
except Exception as e:
    print(str(e))

if DBHOST == '' or DBNAME == '' or DBUSER == '' or S_ADIF_PATH == '' or W_ADIF_PATH == '' or W_LOG_PATH == '':
    print ("Configuration")
    DBHOST = input("DBHOST : ")
    DBNAME = input("DBNAME : ")
    DBUSER = input("DBUSER : ")
    S_ADIF_PATH = input("Standard ADIF Extract File (e.g. /ADIF/STDADIF.adi) : ")
    W_ADIF_PATH = input("Standard ADIF Extract File (e.g. /ADIF/wsjtx.adi) : ")
    W_LOG_PATH = input("Standard ADIF Extract File (e.g. /ADIF/wsjtx.log) : ")
    print ("Save config to ", APP_CONFIG)
    config.add_section('GENERAL')
    config.set('GENERAL', 'DBHOST', DBHOST)
    config.set('GENERAL', 'DBNAME', DBNAME)
    config.set('GENERAL', 'DBUSER', DBUSER)
    config.set('GENERAL', 'S_ADIF_PATH', S_ADIF_PATH)
    config.set('GENERAL', 'W_ADIF_PATH', W_ADIF_PATH)
    config.set('GENERAL', 'W_LOG_PATH', W_LOG_PATH)
    config.write(open(APP_CONFIG, 'w'))

print("\033[1;36;40m[Database]:\033[0;37;40m",DBNAME,"\033[1;36;40m[Host]:\033[0;37;40m",DBHOST,"\033[1;36;40m[User]:\033[0;37;40m",DBUSER)
DBPASS = getpass.getpass()

if DBPASS == '':
    print("No password provided, exiting")
    exit()

def do_standard_adif():
    '''
    This section generates a standard ADIF output
    '''
    s_adif_result = pd.read_sql_query('Select * from v_standard_adif;',do_db_connect())
    s_adif = s_adif_result["ADIF"]
    s_adif_count = pd.DataFrame.count(s_adif_result)
    s_adif.to_csv(
        S_ADIF_PATH,
        header=False,
        index=False,
        quoting=csv.QUOTE_NONE,
        quotechar="",
        escapechar="\\"
        )
    print('Exported Standard ADIF Rows:', s_adif_count["ADIF"])

def do_wsjtx_adif():
    '''
    This section generates a ADIF specifically for WSJTX; databae view is filtered by mode = FT8
    '''
    w_adif_result = pd.read_sql_query('Select * from v_wsjtx_adif;',do_db_connect())
    w_adif = w_adif_result["ADIF"]
    w_adif_count = pd.DataFrame.count(w_adif_result)
    w_adif.to_csv(
        W_ADIF_PATH,
        header=False,
        index=False,
        quoting=csv.QUOTE_NONE,
        quotechar="",
        escapechar="\\"
        )
    print('Exported WSJTX ADIF Rows:', w_adif_count["ADIF"])

def do_wsjtx_log():
    '''
    This section generates a log file specifically for WSJTX; databse view is filtered by mode = FT8
    '''
    w_log = pd.read_sql_query('Select * from v_wsjtx_log;',do_db_connect())
    w_log_count = pd.DataFrame.count(w_log)
    w_log.to_csv(
        W_LOG_PATH,
        header=False,
        index=False,
        quoting=csv.QUOTE_NONE,
        quotechar="",
        escapechar="\\"
        )
    print('Exported WSJTX Log Rows:', w_log_count["QSODateOn"])

def do_db_connect():
    mydb = connection.connect(
        host=DBHOST,
        database=DBNAME,
        user=DBUSER,
        passwd=DBPASS,
        use_pure=True
        )
    return mydb

do_standard_adif()
do_wsjtx_adif()
do_wsjtx_log()
