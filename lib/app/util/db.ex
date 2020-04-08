defmodule DB do
  import Ecto.Query
  alias App.Repo

  def last(model) do
    Repo.one(from x in model, order_by: [desc: x.id], limit: 1)
  end

  def first(model, preload \\ []) do
    Repo.one(from x in model, order_by: [asc: x.id], limit: 1, preload: ^preload)
  end

  def count(model) do
    Repo.one(from p in model, select: count())
  end

  def limit(query, limit) do
    from x in query, limit: ^limit
  end

  def delete_all_data() do
    if(Mix.env() == :dev) do
      App.Repo.delete_all(App.UserIdentities.UserIdentity)
      App.Repo.delete_all(App.Users.User)
    end
  end
end
