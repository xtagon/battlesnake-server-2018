defmodule BsWeb.StatusController do
  use BsWeb, :controller

  alias Bs.Game
  # The compiler says that this View is unused?
  # alias BsWeb.GameStateView

  def show(conn, %{"id" => id}) do
    state = Game.get_game_state(id)

    conn
    |> render(game_state: state)
  end
end
