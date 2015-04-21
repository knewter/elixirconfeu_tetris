defmodule Tetris.Game.State do
  alias Tetris.Shapes

  defstruct [:board, :next, :current, :rotation, :x, :y]

  def cells_for_shape(state) do
    shape = Shapes.shapes[state.current]
    rotated_shape = shape |> Enum.at(state.rotation)
    for {row, row_i} <- Enum.with_index(rotated_shape) do
      for {col, col_i} <- Enum.with_index(row), col != 0 do
        {col_i + state.x, row_i + state.y}
      end
    end |> List.flatten
  end

  def cell_at(state, {x, y}) do
    state.board
    |> Enum.at(y)
    |> Enum.at(x)
  end
end
