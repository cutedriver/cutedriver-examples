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

all: gems cutedriver-visualizer cutedriver-agent_qt quickapp

deps: cutedriver-agent_qt-builddep quickapp-deps

quickapp:
	cd examples/quickapp && qmake -r && make -j$(CORES)

quickapp-deps:
	sudo apt install qml-module-qtquick-dialogs qml-module-qtquick-controls

check: quickapp
	set -e; \
	source $(RVM_HOME)/.rvm/scripts/rvm;\
	cd examples/quickapp;\
	make check

quickapp-huge:
	cd examples/quickapp-huge && qmake -r && make -j$(CORES)

check-huge: quickapp-huge
	set -e; \
        source $(RVM_HOME)/.rvm/scripts/rvm;\
        cd examples/quickapp-huge;\
        make check

check-alt: quickapp
	set -e; \
	source $(RVM_HOME)/.rvm/scripts/rvm;\
	export QTTASSERVER_HOST_BINDING="localhost";\
	export QTTASSERVER_HOST_PORT=45535;\
	export QTTASSERVER_SUT="sut_qt_custom_port";\
	cd examples/quickapp;\
	make check

install: install-gems install-cutedriver-visualizer install-cutedriver-agent_qt

uninstall: uninstall-gems uninstall-cutedriver-visualizer uninstall-cutedriver-agent_qt

clean: clean-cutedriver-driver clean-cutedriver-visualizer clean-cutedriver-sut_qt clean-cutedriver-agent_qt

distclean:
	rm -rf src_tmp

###########################
# Gem related targets
gems: ruby cutedriver-driver cutedriver-sut_qt
uninstall-gems: uninstall-cutedriver-driver uninstall-cutedriver-sut_qt
install-gems: install-cutedriver-driver install-cutedriver-sut_qt

###########################
# Ruby RVM related targets
include rvm.mk

##########################
# CuteDriver Driver
include cutedriver-driver.mk

###################################
# CuteDriver SUT Qt
include cutedriver-sut_qt.mk

###################################
# CuteDriver visualizer
include cutedriver-visualizer.mk

####################################
# CuteDriver Agent Qt
include cutedriver-agent_qt.mk
