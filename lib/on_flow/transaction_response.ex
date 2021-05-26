defmodule OnFlow.TransactionResponse do
  @moduledoc """
  This module defines a struct that includes a transaction response and the
  network response to the query for its result.
  """

  defstruct [:transaction, :result]

  @type t() :: %{
          transaction: %OnFlow.Access.TransactionResponse{},
          result: nil | %OnFlow.Access.TransactionResultResponse{}
        }
end
