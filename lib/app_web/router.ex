defmodule AppWeb.Router do
  use AppWeb, :router
  use Pow.Phoenix.Router
  use PowAssent.Phoenix.Router

  use Pow.Extension.Phoenix.Router,
    extensions: [PowResetPassword, PowEmailConfirmation]

  pipeline :skip_csrf_protection do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :marketing_layout do
    plug :put_layout, {AppWeb.LayoutView, :marketing}
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  if Mix.env() == :dev do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end

  scope "/" do
    pipe_through :skip_csrf_protection

    pow_assent_authorization_post_callback_routes()
  end

  scope "/" do
    pipe_through [:browser]

    pow_routes()
    pow_extension_routes()
    pow_assent_routes()
  end

  scope "/", AppWeb do
    pipe_through [:browser, :marketing_layout]
    get "/", PageController, :index
    get "/pricing", PageController, :pricing
    get "/privacy", PageController, :privacy
    get "/terms", PageController, :terms
  end

  # Add your protected routes here
  scope "/", AppWeb do
    pipe_through [:browser, :protected]

    get "/app", PageController, :dashboard
  end
end
