defmodule Erp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Erp.Accounts.User

  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  @doc false
  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :role, :string
    field :org_name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :captcha_response, :string, virtual: true
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password, :role, :first_name, :last_name])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> unique_constraint(:email)
    |> put_password_hash
  end

  @doc """
  Hash an inputted password for database storage.
  """
  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
        ->
          put_change(changeset, :password_hash, hashpwsalt(pass))
      _ ->
          changeset
    end
  end

end