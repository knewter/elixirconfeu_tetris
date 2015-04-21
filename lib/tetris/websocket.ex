defmodule Tetris.Websocket do
  @render_interval 100

  def run(game, socket) do
    :timer.send_interval(@render_interval, self, :tick)
    loop(game, socket)
  end

  def loop(game, socket) do
    receive do
      :tick ->
        Phoenix.Channel.push socket, "tetris:state", Tetris.Game.get_state(game)
      _ -> :ok
    end
    loop(game, socket)
  end
end
