[![alt travis-ci](https://travis-ci.org/cutedriver/cutedriver-examples.svg?branch=master)](https://travis-ci.org/cutedriver/cutedriver-examples)

# cuTeDriver examples
This repository contains helper Makefile for building, installing and testing the cuTeDriver project for ubuntu.

## Usage
 - *make deps* will install app dependencies.
 - *make* will fetch and build all.
   This will also install rvm for the current user.
 - *make install* will install the required files.
 - *make check* will execute functional tests against the examples.

### Advanced
 - *CHECKOUT_DATE=2017-04-08 make* will fetch and build all repositories like they were before 2017 April 8th. This can be used to double check the current master against some other older branch.
 - *BRANCH=somebranch make* will fetch and build all repositories from somebranch.

## Examples
### QuickApp
This application is a simple QML Window based application with few components in it. The project contains cuTeDriver tests.
