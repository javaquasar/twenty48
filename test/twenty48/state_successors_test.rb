# frozen_string_literal: true

require_relative 'helper'
require_relative 'common/state_successors_tests'

class StateSuccessorsTest < Twenty48Test
  include Twenty48

  # This is where most of the tests are actually defined. They call
  # #state_random_successors. TODO: actually true?
  include CommonStateSuccessorsTests

  def test_random_successors_2x2
    state = make_state([0, 0, 0, 0])
    assert_states_equal [
      [1, 0, 0, 0],
      [2, 0, 0, 0],
      [0, 1, 0, 0],
      [0, 2, 0, 0],
      [0, 0, 1, 0],
      [0, 0, 2, 0],
      [0, 0, 0, 1],
      [0, 0, 0, 2]
    ], state.random_successors
  end

  def test_random_successors_hash_2x2
    hash = State.new([
      0, 0,
      0, 1
    ]).random_successors_hash

    assert_close hash[State.new([
      0, 0,
      1, 1
    ])], 0.6
    assert_close hash[State.new([
      0, 1,
      1, 0
    ])], 0.3
    assert_close hash[State.new([
      0, 0,
      1, 2
    ])], 2 * 0.1 / 3
    assert_close hash[State.new([
      0, 1,
      2, 0
    ])], 1 * 0.1 / 3
  end
end
