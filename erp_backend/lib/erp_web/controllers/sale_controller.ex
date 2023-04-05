defmodule ErpWeb.SaleController do
@moduledoc """
A module that acts as the controller for system sales.
"""
  use ErpWeb, :controller

    @doc """
  Process a singular sale of a bike.
  """
  def process_sale(conn,  %{"sale" => sale_params}) do
    user = Guardian.Plug.current_resource(conn)
    case Erp.Sale.add_sale(sale_params, user) do
      {:ok} ->
        json(conn, %{success: ":)"})
      {:error, error} ->
        {:error, error}
    end
  end
end
