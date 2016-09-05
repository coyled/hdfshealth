hdfshealth
==========

[![Project Status: WIP - Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)

[![Build Status](https://travis-ci.org/coyled/hdfshealth.svg?branch=master)](https://travis-ci.org/coyled/hdfshealth)

[![Code Climate](https://codeclimate.com/repos/56b557a42ffae3007100494f/badges/7868eb018fd5ecaec77f/gpa.svg)](https://codeclimate.com/repos/56b557a42ffae3007100494f/feed)


Overview
--------

`hdfshealth` is a plugin-driven tool for running and collecting
assorted HDFS health checks.


Usage
-----

```
    $ git clone https://github.com/coyled/hdfshealth
    $ cd hdfshealth
    $ bundle install
    $ bin/hdfshealth --namenode http://<namenode_host>:50070/jmx
```


Sample output
-------------

```
% bin/hdfshealth --namenode http://10.1.1.10:50070/jmx
[ 2016-02-06 18:24:30 UTC ] CheckLastCheckpointTime status: CRITICAL  last checkpoint is at least 42 hours old
[ 2016-02-06 18:24:30 UTC ] CheckMissingBlocks status: OK  no reported missing blocks
[ 2016-02-06 18:24:30 UTC ] CheckSafeMode status: OK  NN not in safe mode
[ 2016-02-06 18:24:30 UTC ] CheckTotalSpaceUsed status: CRITICAL  89.92% of total space used (56776560640 of 63143141376 bytes)
```


Requirements
------------

* Ruby 2.2.2
  * may work with other versions but this was the only one tested
* the Bundler gem (`gem install bundler`)
* Hadoop
  * tested with Cloudera's CDH5.5.1


Testing
-------

From the repo's top-level directory:

```
    $ rspec
```

Sample output:

```
    $ rspec

    CheckMissingBlocks
      Verifies there are no missing blocks
      Verifies there are missing blocks

    CheckSafeMode
      Verifies HDFS safe mode is off
      Verifies HDFS safe mode is on

    CheckTotalSpaceUsed
      Verifies HDFS is using less than 60% of total space
      Verifies HDFS is using more than 70% of total space

    Finished in 0.0071 seconds (files took 0.2247 seconds to load)
    6 examples, 0 failures

    $
```


Adding a plugin
---------------

See the existing plugins in [`lib/hdfshealth/plugins/`](lib/hdfshealth/plugins)

* copy one of the existing plugins to a new file
* create a unique class name
* create a `run` method
* set `@status` and `@message`
* create relevant tests in the `spec` dir


If you wanted to add another source, e.g. datanode JMX output, you
could create something along the lines of the `load_nn_jmx.rb` plugin
and require it where needed.


Improvements
------------

See [`TODO.md`](TODO.md)
