###########################################################################
# This is a helper Makefile for building and running CuteDriver
#
# Author(s):
#    2017, Juhapekka Piiroinen <juhapekka.piiroinen@link-motion.com>
#
# Copyright (c) 2017, Link Motion Oy
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#      notice, this list of conditions and the following disclaimer.
#    * Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
#    * Neither the name of the <organization> nor the
#      names of its contributors may be used to endorse or promote products
#      derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
###########################################################################
include shared.mk

src-ruby: src-rvm

ruby: ruby-2.1

ruby-2.1: rvm
ifeq ($(wildcard ${RVM_HOME}/.rvm/rubies/ruby-2.1.10/),)
	source $(RVM_HOME)/.rvm/scripts/rvm; \
	rvm install 2.1.10
endif
	source $(RVM_HOME)/.rvm/scripts/rvm; \
	rvm use --default 2.1.10; \
	rm -rf $(RVM_HOME)/.rvm/rubies/ruby-2.1.10/lib/ruby/2.1.0/minitest
	@echo "Ruby 2.1.10 is installed."

curl:
ifeq ($(wildcard /usr/bin/curl),)
	@echo "curl was not installed."
	sudo apt-get install curl
endif

rvm-update:
	@echo "Updating rvm.."
	source $(RVM_HOME)/.rvm/scripts/rvm; \
	rvm get stable

ruby-reinstall:
	rvm reinstall 2.1.10
	source $(RVM_HOME)/.rvm/scripts/rvm; \
	rvm use --default 2.1.10
	make gems

src-rvm: curl
ifeq ($(wildcard src/rvm-installer),)
	set -e; \
	mkdir -p $(SOURCE_ROOT); \
	cd $(SOURCE_ROOT); \
	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3; \
	curl -O https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer; \
	curl -O https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer.asc; \
	gpg --verify rvm-installer.asc
endif

rvm: src-rvm
ifeq ($(wildcard $(RVM_HOME)/.rvm/scripts/rvm),)
	@echo "RVM was not installed.. installing.."
	set -e; \
	cd $(SOURCE_ROOT); \
	gpg --verify rvm-installer.asc; \
	mkdir -p ${RVM_HOME}/.rvm; \
	bash rvm-installer --path $(RVM_HOME)/.rvm stable
endif

uninstall-rvm:
	rm -rf $(RVM_HOME)/.rvm
