###########################################################################
# a test for children
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

class TestObjectExists < Minitest::Test
  def setup
    # Setup cuTeDriver and settings identifiers
    @sut = TDriver.sut(ENV['QTTASSERVER_SUT'] || 'sut_qt')
    @sut.set_event_type(:Touch)
    @app = @sut.run(:name => 'quickapp',
                    :arguments => '-testability')
    @appWindow = nil
    minitest_verify_true(1,'MainWindow is found.') {
        @appWindow = @app.child('appWindow')
        @appWindow['visible'] == 'true'
    }
  end

  def test_test_object_exists__objectname
    minitest_verify_true(1, "grid is found from appWindow") { @appWindow.test_object_exists?({objectName: 'grid'}) }   
  end

  def test_test_object_exists__name
    minitest_verify_true(1, "grid is found from appWindow") { @appWindow.test_object_exists?({name: 'grid'}) }   
  end

  def test_test_object_exists__type
    minitest_verify_true(1, "grid is found from appWindow using type") { @appWindow.test_object_exists?({type: 'QQuickGrid'}) }   
  end

  def test_test_object_exists__type__name
    minitest_verify_true(1, "grid is found from appWindow using type and name") { @appWindow.test_object_exists?({type: 'QQuickGrid', name: 'grid'}) }   
  end

  def test_test_object_exists__objectname__regexp
    minitest_verify_true(1, "grid is found from appWindow using regexp in objectName") { @appWindow.test_object_exists?({objectName: /^grid$/}) }   
  end

  def test_test_object_exists__name__regexp
    minitest_verify_true(1, "grid is found from appWindow using regexp in name") { @appWindow.test_object_exists?({name: /^grid$/}) }   
  end

  def teardown
    if @app != nil
        @app.kill
    end
  end
end
