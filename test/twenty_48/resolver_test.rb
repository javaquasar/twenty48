# frozen_string_literal: true

require_relative 'helper'

class ResolverTest < Twenty48Test
  include Twenty48

  def check(board_size, max_exponent, expected)
    (0...(expected.length)).each do |moves|
      resolver = Resolver.new(board_size, max_exponent, moves)
      assert_states_equal expected.take(moves + 1), resolver.win_states

      builder = Builder.new(board_size, max_exponent, moves)
      expected.take(moves + 1).each.with_index do |state_array, move|
        state = State.new(state_array)
        assert_equal move, builder.moves_to_definite_win(state)
      end
    end
    assert_raises { Resolver.new(board_size, max_exponent, expected.length) }
  end

  def test_resolved_win_states_2x2_to_4
    check 2, 2, [[
      0, 0,
      0, 2
    ], [
      0, 0,
      1, 1
    ], [
      0, 1,
      1, 0
    ]]
  end

  def test_resolved_win_states_2x2_to_8
    check 2, 3, [[
      0, 0,
      0, 3
    ], [
      0, 0,
      2, 2
    ], [ # down, right
      0, 1,
      2, 1
    ], [ # left, down, right
      0, 1,
      1, 2
    ]]
  end

  def test_resolved_win_states_2x2_to_16
    check 2, 4, [[
      0, 0,
      0, 4
    ], [
      0, 0,
      3, 3
    ], [
      0, 2,
      3, 2
    ], [
      0, 2,
      2, 3
    ]]
  end

  def test_resolved_win_states_2x2_to_32
    check 2, 5, [[
      0, 0,
      0, 5
    ], [
      0, 0,
      4, 4
    ], [
      0, 3,
      4, 3
    ], [
      0, 3,
      3, 4
    ]]
  end

  def test_resolved_win_states_2x2_to_64
    check 2, 6, [[
      0, 0,
      0, 6
    ], [
      0, 0,
      5, 5
    ], [
      0, 4,
      5, 4
    ], [
      0, 4,
      4, 5
    ]]
  end

  def test_resolved_win_states_3x3_to_4
    check 3, 2, [[
      0, 0, 0,
      0, 0, 0,
      0, 0, 2
    ], [
      0, 0, 0,
      0, 0, 0,
      0, 1, 1
    ], [
      0, 0, 0,
      0, 0, 1,
      0, 1, 0
    ]]
  end

  def test_resolved_win_states_3x3_to_8
    check 3, 3, [[
      0, 0, 0,
      0, 0, 0,
      0, 0, 3
    ], [
      0, 0, 0,
      0, 0, 0,
      0, 2, 2
    ], [
      0, 0, 0,
      0, 0, 0,
      1, 1, 2
    ], [
      0, 0, 0,
      0, 0, 1,
      2, 1, 0
    ]]
  end

  def test_resolved_win_states_3x3_to_16
    check 3, 4, [[
      0, 0, 0,
      0, 0, 0,
      0, 0, 4
    ], [
      0, 0, 0,
      0, 0, 0,
      0, 3, 3
    ], [
      0, 0, 0,
      0, 0, 0,
      2, 2, 3
    ], [
      0, 0, 0,
      0, 0, 1,
      3, 2, 1
    ]]
  end

  def test_resolved_win_states_3x3_to_32
    check 3, 5, [[
      0, 0, 0,
      0, 0, 0,
      0, 0, 5
    ], [
      0, 0, 0,
      0, 0, 0,
      0, 4, 4
    ], [
      0, 0, 0,
      0, 0, 0,
      3, 3, 4
    ], [
      0, 0, 0,
      0, 0, 2,
      4, 3, 2
    ], [
      0, 0, 0,
      0, 1, 1,
      4, 3, 2
    ], [
      0, 0, 1,
      0, 1, 0,
      4, 3, 2
    ]]
  end

  def test_resolved_win_states_3x3_to_64
    check 3, 6, [[
      0, 0, 0,
      0, 0, 0,
      0, 0, 6
    ], [
      0, 0, 0,
      0, 0, 0,
      0, 5, 5
    ], [
      0, 0, 0,
      0, 0, 0,
      4, 4, 5
    ], [
      0, 0, 0,
      0, 0, 3,
      5, 4, 3
    ], [
      0, 0, 0,
      0, 2, 2,
      5, 4, 3
    ], [
      0, 0, 0,
      1, 1, 2,
      5, 4, 3
    ], [
      0, 1, 0,
      1, 0, 2,
      5, 4, 3
    ]]
  end

  def test_resolved_win_states_3x3_to_128
    check 3, 7, [[
      0, 0, 0,
      0, 0, 0,
      0, 0, 7
    ], [
      0, 0, 0,
      0, 0, 0,
      0, 6, 6
    ], [
      0, 0, 0,
      0, 0, 0,
      5, 5, 6
    ], [
      0, 0, 0,
      0, 0, 4,
      6, 5, 4
    ], [
      0, 0, 0,
      0, 3, 3,
      6, 5, 4
    ], [
      0, 0, 0,
      2, 2, 3,
      6, 5, 4
    ], [
      0, 0, 1,
      3, 2, 1,
      4, 5, 6
    ]]
  end

  def test_resolved_win_states_4x4_to_4
    check 4, 2, [[
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 2
    ], [
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 1, 1
    ], [
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 1,
      0, 0, 1, 0
    ]]
  end

  def test_resolved_win_states_4x4_to_8
    check 4, 3, [[
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 3
    ], [
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 2, 2
    ], [
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 1, 1, 2
    ], [
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 1,
      0, 2, 1, 0
    ]]
  end

  def test_resolved_win_states_4x4_to_16
    check 4, 4, [[
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 4
    ], [
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 3, 3
    ], [
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 2, 2, 3
    ], [
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      1, 1, 2, 3
    ], [
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 1,
      3, 2, 1, 0
    ]]
  end

  def test_resolved_win_states_4x4_to_32
    check 4, 5, [[
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 5
    ], [
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 4, 4
    ], [
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 3, 3, 4
    ], [
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      2, 2, 3, 4
    ], [
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 1,
      4, 3, 2, 1
    ], [
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 1, 0,
      4, 3, 2, 1
    ]]
  end

  def test_resolved_lose_state_2x2
    resolver = Resolver.new(2, 2, 0)
    assert_equal State.new([
      0, 0,
      0, 0
    ]), resolver.lose_state

    resolver = Resolver.new(2, 2, 1)
    assert_equal State.new([
      0, 0,
      0, 0
    ]), resolver.lose_state
  end
end
