defmodule AppWeb.Pow.Mailer do
  use Pow.Phoenix.Mailer
  use Bamboo.Mailer, otp_app: :app

  import Bamboo.Email

  @impl true
  def cast(%{user: user, subject: subject, text: text, html: html}) do
    new_email(
      to: user.email,
      from: "app@example.com",
      subject: subject,
      html_body: html,
      text_body: text
    )
  end

  @impl true
  def process(email) do
    deliver_later(email)
  end
end
