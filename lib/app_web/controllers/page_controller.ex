defmodule AppWeb.PageController do
  use AppWeb, :controller

  def dashboard(conn, _params) do
    render(conn, "dashboard.html")
  end

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def pricing(conn, _params) do
    render(conn, "pricing.html")
  end

  def privacy(conn, _params) do
    render(conn, "privacy.html")
  end

  def terms(conn, _params) do
    render(conn, "terms.html")
  end
end
