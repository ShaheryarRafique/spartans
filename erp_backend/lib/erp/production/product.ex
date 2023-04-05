defmodule Erp.Production.Product do
  @moduledoc """
  The Product context.
  """
  use Ecto.Schema
  import Ecto.Changeset

  #Each product has a list of attributes.
  @derive {Jason.Encoder, only: [:name, :product_id, :quantity, :start_time, :plant_id]}
  @primary_key {:product_id, :integer, []}
  @derive {Phoenix.Param, key: :product_id}
  schema "products" do
    field :name, :string
    field :quantity, :integer
    field :start_time, :naive_datetime
    field :plant_id, :integer

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :product_id, :quantity, :start_time])
    |> validate_required([:name, :product_id, :quantity, :start_time])
    |> unique_constraint(:product_id)
    |> foreign_key_constraint(:plant_id)
  end
end
