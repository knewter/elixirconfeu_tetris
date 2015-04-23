defmodule Tetris.Game do
  use GenServer
  alias Tetris.Shapes
  alias Tetris.Game.State
  alias Tetris.Game.Interaction

  @game_tick 500

  ## Public API
  def start do
    {:ok, pid} = GenServer.start(__MODULE__, [])
    :timer.send_interval(@game_tick, pid, :tick)
    {:ok, pid}
  end

  def get_state(pid) do
    GenServer.call(pid, :get_state)
  end

  def handle_input(pid, input) do
    GenServer.cast(pid, {:handle_input, input})
  end

  ## Server callbacks
  def init(_args) do
    :random.seed(:erlang.now)
    {:ok, %State{
             board: [
               [0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0]
             ],
             next: Shapes.random,
             current: Shapes.random,
             rotation: 0,
             x: 5,
             y: 0
           }
    }
  end

  def handle_call(:get_state, _from, state) do
    reply_state = %{
      board: board_with_overlaid_shape(state),
      next: Shapes.get(state.next, 0) |> colorize(state.next)
    }
    {:reply, reply_state, state}
  end

  def handle_cast({:handle_input, input}, state) do
    {:noreply, Interaction.handle_input(state, input)}
  end

  def handle_info(:tick, state) do
    {:noreply, tick_game(state)}
  end

  def board_with_overlaid_shape(%State{} = state) do
    for {row, row_i} <- Enum.with_index(state.board) do
      for {col, col_i} <- Enum.with_index(row) do
        rotated_shape_overlaps_cell = Enum.member?(State.cells_for_shape(state), {col_i, row_i})
        cond do
          rotated_shape_overlaps_cell -> Shapes.number(state.current)
          true -> col
        end
      end
    end
  end

  def tick_game(state) do
    cond do
      collision_with_bottom?(state) || collision_with_board?(state) ->
        new_state = %State{state | board: board_with_overlaid_shape(state) }
        cleared_state = State.clear_lines(new_state)
        %State{cleared_state | current: state.next, x: 5, y: 0, next: Shapes.random, rotation: 0}
      :else ->
        %State{state | y: state.y + 1}
    end
  end

  def collision_with_bottom?(state) do
    Shapes.height(state.current, state.rotation) + state.y > 19
  end

  def collision_with_board?(state) do
    next_coords = for {x, y} <- State.cells_for_shape(state), do: {x, y+1}
    Enum.any?(next_coords, fn(coords) ->
      State.cell_at(state, coords) != 0
    end)
  end

  def colorize(shape_list, name) do
    for row <- shape_list do
      for col <- row do
        col * Shapes.number(name)
      end
    end
  end
end
