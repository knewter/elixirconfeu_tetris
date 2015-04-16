defmodule Tetris.GameChannel do
  use Phoenix.Channel

  def join("game:play", _auth_msg, socket) do
    send(self, :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    push socket, "tetris:state", %{board: []}
    {:noreply, socket}
  end
end
