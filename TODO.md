TODO
====

* add machine-readable output option
* more test coverage
* clean up --namenode CLI option
    * constuct full URI if some parts are left out, e.g. support:
        `--namenode <hostname>`
    * add error checking
* add more checks
* test with different versions of Ruby
* add option for Nagios-compatible output
* create list of supported statuses and enforce their use by plugins
    * right now check status is a free-for-all
* fix handling of missing status and/or message
