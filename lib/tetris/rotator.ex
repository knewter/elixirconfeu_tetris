defmodule Tetris.Rotator do
  import Enum, only: [at: 2, count: 1]

  def rotate(piece, 0), do: piece
  def rotate(piece, 90) do
    rotated_width = count(piece)
    rotated_height = count(hd(piece))
    for col <- (0..rotated_height-1), into: [] do
      for row <- (rotated_width-1..0), into: [] do
        piece |> at(row) |> at(col)
      end
    end
  end
  def rotate(piece, 180) do
    piece
    |> rotate(90)
    |> rotate(90)
  end
  def rotate(piece, 270) do
    piece
    |> rotate(180)
    |> rotate(90)
  end
  def rotate(piece, amount) when rem(amount, 90) == 0 do
    piece |> rotate(rem(amount, 360))
  end
  def rotate(_, _) do
    {:error, "Amount must be divisible by 90"}
  end
end
