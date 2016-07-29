defmodule BattleSnakeServer.GameChannelTest do
  use BattleSnakeServer.ChannelCase

  alias BattleSnakeServer.GameChannel

  setup do
    {:ok, _, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(GameChannel, "game:lobby")

    {:ok, socket: socket}
  end

  test "start replies with status ok", %{socket: socket} do
    ref = push socket, "start", %{"hello" => "there"}
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "shout broadcasts to game:lobby", %{socket: socket} do
    push socket, "tick", %{"hello" => "all"}
    assert_broadcast "tick", %{"hello" => "all"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "tick", %{"some" => "data"}
    assert_push "tick", %{"some" => "data"}
  end
end