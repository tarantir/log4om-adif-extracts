# log4om-adif-extracts
Extracts data from the LOG4OM2 MySQL/MariaDB Database

The views assume the LOG4OM 2 database is using the default name of log4om2 on the same database host.

1. In the database of your choice, create the MySQL/MariaDB views located in the Scripts folder.
2. The first time you execute adif-export.py 
    2.1 Should create the directory .adifexporter
    2.2 Prompts for the configuration values and stores the config file in the .adifexporter directory
3. Subsuquent executions of adif-export.py will prompt for the database password (otherwise the password would be stored in clear text)
