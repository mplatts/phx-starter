defmodule App.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  use PowAssent.Ecto.Schema

  use Pow.Extension.Ecto.Schema,
    extensions: [PowResetPassword, PowEmailConfirmation]

  schema "users" do
    pow_user_fields()
    field :first_name, :string
    field :last_name, :string
    field :avatar, :string
    field :role, :string, default: "user"

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> pow_extension_changeset(attrs)
  end

  @spec changeset_role(Ecto.Schema.t() | Ecto.Changeset.t(), map()) :: Ecto.Changeset.t()
  def changeset_role(user_or_changeset, attrs) do
    user_or_changeset
    |> Ecto.Changeset.cast(attrs, [:role])
    |> Ecto.Changeset.validate_inclusion(:role, ~w(user admin))
  end

  def user_identity_changeset(user_or_changeset, user_identity, attrs, user_id_attrs) do
    attrs =
      Map.merge(attrs, %{
        "first_name" => attrs["given_name"],
        "last_name" => attrs["family_name"],
        "avatar" => attrs["picture"],
        "email_verified" => true
      })

    user_or_changeset
    |> Ecto.Changeset.cast(attrs, [:first_name, :last_name, :avatar])
    |> pow_assent_user_identity_changeset(user_identity, attrs, user_id_attrs)
  end
end
