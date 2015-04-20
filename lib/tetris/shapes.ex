defmodule Tetris.Shapes do
  import Tetris.Rotator, only: [rotate: 2]

  @ell [
    [1, 0],
    [1, 0],
    [1, 1]
  ]

  @jay [
    [0, 1],
    [0, 1],
    [1, 1]
  ]

  @ess [
    [0, 1, 1],
    [1, 1, 0]
  ]

  @zee [
    [1, 1, 0],
    [0, 1, 1]
  ]

  @bar [
    [1, 1, 1, 1]
  ]

  @oh [
    [1, 1],
    [1, 1]
  ]

  @tee [
    [1, 1, 1],
    [0, 1, 0]
  ]

  @shapes %{
    ell: [@ell, rotate(@ell, 90), rotate(@ell, 180), rotate(@ell, 270)],
    jay: [@jay, rotate(@jay, 90), rotate(@jay, 180), rotate(@jay, 270)],
    ess: [@ess, rotate(@ess, 90), rotate(@ess, 180), rotate(@ess, 270)],
    zee: [@zee, rotate(@zee, 90), rotate(@zee, 180), rotate(@zee, 270)],
    bar: [@bar, rotate(@bar, 90), rotate(@bar, 180), rotate(@bar, 270)],
    oh:  [@oh,  rotate(@oh, 90),  rotate(@oh, 180),  rotate(@oh, 270)],
    tee: [@tee, rotate(@tee, 90), rotate(@tee, 180), rotate(@tee, 270)],
  }

  def shapes, do: @shapes

  def get(shape, rotation) do
    @shapes[shape]
    |> Enum.at(rotation)
  end

  def width(shape, rotation) do
    get(shape, rotation)
    |> width
  end

  def height(shape, rotation) do
    get(shape, rotation)
    |> height
  end

  def width(shape) do
    shape
    |> hd
    |> length
  end

  def height(shape) do
    shape
    |> length
  end

  def random do
    by_number(:random.uniform(7))
  end

  def by_number(1), do: :ell
  def by_number(2), do: :jay
  def by_number(3), do: :ess
  def by_number(4), do: :zee
  def by_number(5), do: :bar
  def by_number(6), do: :oh
  def by_number(7), do: :tee

  def number(:ell), do: 1
  def number(:jay), do: 2
  def number(:ess), do: 3
  def number(:zee), do: 4
  def number(:bar), do: 5
  def number(:oh),  do: 6
  def number(:tee), do: 7
end
