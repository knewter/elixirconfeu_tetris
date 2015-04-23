defmodule Tetris.Game.State do
  defmodule Helpers do
    def empty_line do
      1..10
      |> Enum.map(fn(_) -> 0 end)
    end
  end

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

  def clear_lines(state) do
    %__MODULE__{state|board: clear_lines(state.board, [], [])}
  end
  defp clear_lines([line|rest], accum, cleared) do
    case clearable?(line) do
      true  -> clear_lines(rest, accum, cleared ++ [line])
      false -> clear_lines(rest, accum ++ [line], cleared)
    end
  end
  defp clear_lines([], accum, cleared) do
    empty_lines = for _ <- cleared, do: Helpers.empty_line
    empty_lines ++ accum
  end

  defp clearable?(line) do
    line
    |> Enum.all?(fn(x) -> x != 0 end)
  end
end
