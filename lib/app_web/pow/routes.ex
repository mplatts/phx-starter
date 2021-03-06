defmodule AppWeb.Pow.Routes do
  use Pow.Phoenix.Routes
  alias AppWeb.Router.Helpers, as: Routes

  def after_sign_out_path(conn), do: Routes.page_path(conn, :index)
  def after_sign_in_path(conn), do: Routes.page_path(conn, :dashboard)
  def after_registration_path(conn), do: Routes.page_path(conn, :dashboard)
  # def user_not_authenticated_path(conn), do: Routes.pow_session_path(conn, :new)
  def after_user_deleted_path(conn), do: Routes.page_path(conn, :index)
end
