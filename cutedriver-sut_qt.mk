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

cutedriver-sut_qt: src-cutedriver-sut_qt cutedriver-driver
ifeq ($(wildcard $(SOURCE_ROOT)/cutedriver-sut_qt/pkg/cutedriver-qt-sut-plugin-*.gem),)
	set -e; \
	source $(RVM_HOME)/.rvm/scripts/rvm;\
	cd $(SOURCE_ROOT)/cutedriver-sut_qt;\
	rm -rf pkg/*; \
	rake gem
else
	@echo "cutedriver-qt-sut-plugin is already built."
endif

src-cutedriver-sut_qt:
	./getsource $(REPO_URI) $(SOURCE_ROOT) cutedriver-sut_qt

install-cutedriver-sut_qt:
ifeq ($(wildcard $(SOURCE_ROOT)/cutedriver-sut_qt/pkg/cutedriver-qt-sut-plugin-*.gem),)
	make cutedriver-sut_qt
endif
	make uninstall-cutedriver-sut_qt
	source $(RVM_HOME)/.rvm/scripts/rvm; \
	cd $(SOURCE_ROOT)/cutedriver-sut_qt;\
	set -e;\
	gem install pkg/*.gem

uninstall-cutedriver-sut_qt:
	source ${HOME}/.rvm/scripts/rvm; \
	set +e;\
	gem uninstall cutedriver-qt-sut-plugin -qa --force -x

clean-cutedriver-sut_qt:
	rm -rf $(SOURCE_ROOT)/cutedriver-sut_qt/pkg/*
