defmodule Tetris.Game.Interaction do
  alias Tetris.Game.State

  def handle_input(original_state, event) do
    do_handle_input(original_state, event)
  end

  def do_handle_input(state, :move_right) do
    %State{state | x: state.x + 1}
  end
  def do_handle_input(state, :move_left) do
    %State{state | x: state.x - 1}
  end
  def do_handle_input(state, _), do: state
end
