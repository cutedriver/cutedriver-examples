###########################################################################
# a MEM test for flickable
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
require "#{File.dirname(__FILE__)}/../shared/helper.rb"
require "tdriver"

class TestMemRaw < Minitest::Test
  def setup
    # Setup cuTeDriver and settings identifiers
    @sut = TDriver.sut(ENV['QTTASSERVER_SUT'] || 'sut_qt')
    @sut.set_event_type(:Touch)
    @app = @sut.run(:name => 'quickapp',
                    :arguments => '-testability')
    minitest_verify_true(1,'MainWindow is found.') {
        @app.child('appWindow')['visible'] == 'true'
    }
  end

  def test_flickable_flick
    appWindow = nil

    # find a appWindow
    minitest_verify_true(5, "ApplicationWindow can be found") {
        appWindow = @app.child(:objectName => 'appWindow')
        appWindow[:objectType] == "Window"
    }

    # then find the flickable
    flickable = nil
    minitest_verify_true(1, "Flickable can be found from appWindow") {
        flickable = appWindow.child(objectName: "flickable")
        flickable != nil
    }

    # Start FPS monitoring
    @app.log_mem(:interval => 1, :filePath => '/tmp')  

    # flick flickable
    minitest_verify_equal(0) {
        flickable.attribute('contentY').to_i
    }
    # flick down with left mouse
    minitest_verify() {
        flickable.flick(:Down, :Left)
    }
    minitest_verify_equal(0) {
        flickable.attribute('contentY').to_i
    }

    # then flick up with left mouse button which scrolls the flickable
    minitest_verify() {
        flickable.flick(:Up, :Left)
    }
    minitest_verify_greater(0) {
        flickable.attribute('contentY').to_i
    }

    # Collect and process MEM data
    rawData = @app.stop_mem_log()
    assert(rawData.length > 0, "raw data was received")
  end

  def teardown
    if @app != nil
        @app.kill
    end
  end
end
