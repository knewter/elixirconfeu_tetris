defmodule Tetris.Game do
  use GenServer

  defmodule State do
    defstruct [:board, :next]
  end

  ## Public API
  def start do
    {:ok, pid} = GenServer.start(__MODULE__, [])
  end

  def get_state(pid) do
    GenServer.call(pid, :get_state)
  end

  ## Server callbacks
  def init(_args) do
    {:ok, %Tetris.Game.State{
             board: [
               [0,0,0,0,1,0,0,0,0,0],
               [0,0,0,0,1,0,0,0,0,0],
               [0,0,0,0,1,1,0,0,0,0],
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
             next: [
               [1, 0],
               [1, 0],
               [1, 1]
             ]
           }
    }
  end

  def handle_call(:get_state, _from, state) do
    reply_state = %{
      board: state.board,
      next: state.next
    }
    {:reply, reply_state, state}
  end
end
