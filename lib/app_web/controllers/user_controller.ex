defmodule AppWeb.UserController do
  use AppWeb, :controller

  def account(conn, _params) do
    render(conn, "account.html")
  end
end
