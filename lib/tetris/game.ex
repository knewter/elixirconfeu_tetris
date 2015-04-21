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
               [0,0,0,0,0,0,0,0,0,0]
             ],
             next: :ell,
             current: :ell,
             rotation: 0,
             x: 5,
             y: 0
           }
    }
  end

  def handle_call(:get_state, _from, state) do
    reply_state = %{
      board: board_with_overlaid_shape(state),
      next: Shapes.get(state.next, 0)
    }
    {:reply, reply_state, state}
  end

  def handle_cast({:handle_input, input}, state) do
    {:noreply, Interaction.handle_input(state, input)}
  end

  def handle_info(:tick, state) do
    IO.inspect "game tick"
    {:noreply, %State{state | y: state.y + 1}}
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
end
