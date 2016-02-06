hdfshealth
==========

[![Project Status: WIP - Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)

[![Build Status](https://semaphoreci.com/api/v1/coyled/hdfshealth/branches/master/shields_badge.svg)](https://semaphoreci.com/coyled/hdfshealth)

[![Code Climate](https://codeclimate.com/repos/56b557a42ffae3007100494f/badges/7868eb018fd5ecaec77f/gpa.svg)](https://codeclimate.com/repos/56b557a42ffae3007100494f/feed)


Overview
--------

`hdfshealth` is a plugin-driven tool for running and collecting
assorted HDFS health checks.


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


Requirements
------------

* Ruby 2.2.2
  * may work with other versions but this was the only one tested
* the Bundler gem (`gem install bundler`)
* Hadoop
  * tested with Cloudera's CDH5.5.1


Usage
-----

```
    $ git clone https://github.com/coyled/hdfshealth
    $ cd hdfshealth
    $ bundle install
    $ bin/hdfshealth --namenode http://<namenode_host>:50070/jmx
```


Improvements
------------

See [`TODO.md`](TODO.md)
