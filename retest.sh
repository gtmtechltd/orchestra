#!/bin/bash

gem uninstall orchestra --executables
rake build
gem install pkg/orchestra
orchestra -v
