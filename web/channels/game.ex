defmodule Tetris.GameChannel do
  use Phoenix.Channel

  def join("game:play", _auth_msg, socket) do
    {:ok, socket}
  end
end
