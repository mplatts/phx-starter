defmodule AppWeb.HelpersView do
  use AppWeb, :view

  def get_notification_color_classes(color) do
    case color do
      "red" -> "bg-red-100 border-red-400 text-red-700"
      "green" -> "bg-green-100 border-green-400 text-green-700"
      "blue" -> "bg-blue-100 border-blue-400 text-blue-700"
      "yellow" -> "bg-yellow-100 border-yellow-400 text-yellow-700"
    end
  end
end
