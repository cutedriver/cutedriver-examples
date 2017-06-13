###########################################################################
# a test for QML Button
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
require "minitest/autorun"
require "tdriver"

class TestWindow < Minitest::Test
  def setup
    # Setup cuTeDriver and settings identifiers
    @sut = TDriver.sut('sut_qt')
    @sut.set_event_type(:Touch)
    @app = @sut.run(:name => 'quickapp',
                    :arguments => '-testability')
    minitest_verify_true(1,'MainWindow is found.') {
        @app.child('appWindow')['visible'] == 'true'
    }
  end

  def test_button_tap_and_signal
    appWindow = nil

    # find a appWindow
    minitest_verify() { appWindow = @app.child(:objectName => 'appWindow') }

    # then find the button
    btn = nil
    minitest_verify_true(1, "button can be found from appWindow") {
        btn = appWindow.child(name: "aButton")
        btn != nil
    }

    minitest_verify_equal("Hello World") {
        appWindow.attribute('title').to_s
    }

    # expect signal when button is clicked
    btn.minitest_verify_signal(1, "clicked()") {
        btn.tap
    }

    minitest_verify_equal("clicked") {
        appWindow.attribute('title').to_s
    }
  end

  def teardown
    if @app != nil
        @app.kill
    end
  end
end
