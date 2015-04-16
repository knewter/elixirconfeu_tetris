defmodule Tetris.Websocket do
  @render_interval 100

  def run(socket) do
    :timer.send_interval(@render_interval, self, :tick)
    loop(socket)
  end

  def loop(socket) do
    receive do
      :tick ->
        IO.puts "tick"
        Phoenix.Channel.push socket, "tetris:state", %{
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
      _ -> :ok
    end
    loop(socket)
  end
end
