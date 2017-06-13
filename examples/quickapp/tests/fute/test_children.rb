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

  def test_children_with_objectName
    grid = nil
    repeater = nil

    # find a child
    minitest_verify() { grid = @app.child(:objectName => 'grid') }
    minitest_verify() { repeater = grid.child(:objectName => 'repeater') }

    minitest_verify_equal(53, 1, "grid has 53 children") {
        grid.children({}).count
    }

    minitest_verify_equal(52, 1, "repeater has 52 children") {
        repeater.children({}).count
    }
  end

  def test_children_with_objectName_regex
    # find a child using regex syntax
    grid_regex = nil
    repeater_regex = nil
    minitest_verify() { grid_regex = @app.child(:objectName => /^grid$/) }
    minitest_verify() { repeater_regex = grid_regex.child(:objectName => /^repeater$/) }

    minitest_verify_equal(53, 1, "grid_regex has 53 children") {
      grid_regex.children({}).count
    }

    minitest_verify_equal(50, 1, "repeater_regex has 50 children") {
      repeater_regex.children({}).count
    }
  end

  def test_children_with_name
      grid = nil
      repeater = nil

      # find a child
      minitest_verify() { grid = @app.child(name: 'grid') }
      minitest_verify() { repeater = grid.child(name: 'repeater') }

      minitest_verify_equal(53, 1, "grid has 53 children") {
          grid.children({}).count
      }

      minitest_verify_equal(52, 1, "repeater has 52 children") {
          repeater.children({}).count
      }
  end

  def test_children_with_name_regex
      # find a child using regex syntax
      grid_regex = nil
      repeater_regex = nil
      minitest_verify() { grid_regex = @app.child(name: /^grid$/) }
      minitest_verify() { repeater_regex = grid_regex.child(name: /^repeater$/) }

      minitest_verify_equal(53, 1, "grid_regex has 53 children") {
          grid_regex.children({}).count
      }

      minitest_verify_equal(50, 1, "repeater_regex has 50 children") {
          repeater_regex.children({}).count
      }
  end

  def test_children_with_name_filter
    grid = nil

    # find a child
    minitest_verify() { grid = @app.child(name: 'grid') }

    minitest_verify_equal(10, 1, "10 children can be found using ruby regex /^Rect_1\d+$/)") {
        grid.children(name: /^Rect_1\d+$/).count.to_i
    }
  end

  def test_children_with_duplicate_name_grid
    grid = nil

    # find a child
    minitest_verify() { grid = @app.child(name: 'grid') }

    minitest_verify_equal(2, 1, "2 duplicate objects can be found using 'Rect_duplicate'") {
        grid.children(name: "Rect_duplicate").count.to_i
    }
  end

  def test_children_with_duplicate_name_grid_regex
    grid = nil

    # find a child
    minitest_verify() { grid = @app.child(name: 'grid') }

    minitest_verify_equal(2, 1, "2 duplicate objects can be found using regex /^Rect_duplicate$/") {
        grid.children(name: /^Rect_duplicate$/).count.to_i
    }
  end

  def test_children_with_duplicate_name_grid2
    grid2 = nil

    # find a child
    minitest_verify() { grid2 = @app.child(name: 'grid2') }

    minitest_verify_equal(2, 1, "2 duplicate objects can be found using regex 'Rect2_duplicate'") {
        grid2.children(name: 'Rect2_duplicate').count.to_i
    }
  end

  def test_children_with_duplicate_name_grid2_regex
    grid2 = nil

    # find a child
    minitest_verify() { grid2 = @app.child(name: 'grid2') }

    minitest_verify_equal(2, 1, "2 duplicate objects can be found using regex /^Rect2_duplicate$/") {
        grid2.children(name: /^Rect2_duplicate$/).count.to_i
    }
  end

  ####
  # with objectname
  ####
  def test_children_with_duplicate_objectName_grid
    grid = nil

    # find a child
    minitest_verify() { grid = @app.child(objectName: 'grid') }

    minitest_verify_equal(2, 1, "2 duplicate objects can be found using 'Rect_duplicate'") {
        grid.children(objectName: "Rect_duplicate").count.to_i
    }
  end

  def test_children_with_duplicate_objectName_grid_regex
    grid = nil

    # find a child
    minitest_verify() { grid = @app.child(objectName: 'grid') }

    minitest_verify_equal(2, 1, "2 duplicate objects can be found using regex /^Rect_duplicate$/") {
        grid.children(objectName: /^Rect_duplicate$/).count.to_i
    }
  end

  def test_children_with_duplicate_objectName_grid2
    grid2 = nil

    # find a child
    minitest_verify() { grid2 = @app.child(objectName: 'grid2') }

    minitest_verify_equal(2, 1, "2 duplicate objects can be found using regex 'Rect2_duplicate'") {
        grid2.children(objectName: 'Rect2_duplicate').count.to_i
    }
  end

  def test_children_with_duplicate_objectName_grid2_regex
    grid2 = nil

    # find a child
    minitest_verify() { grid2 = @app.child(objectName: 'grid2') }

    minitest_verify_equal(2, 1, "2 duplicate objects can be found using regex /^Rect2_duplicate$/") {
        grid2.children(objectName: /^Rect2_duplicate$/).count.to_i
    }
  end



  def teardown
    if @app != nil
        @app.kill
    end
  end
end
