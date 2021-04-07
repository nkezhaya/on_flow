defmodule Flow.Entities.Event do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          type: String.t(),
          transaction_id: binary,
          transaction_index: non_neg_integer,
          event_index: non_neg_integer,
          payload: binary
        }

  defstruct [:type, :transaction_id, :transaction_index, :event_index, :payload]

  field :type, 1, type: :string
  field :transaction_id, 2, type: :bytes
  field :transaction_index, 3, type: :uint32
  field :event_index, 4, type: :uint32
  field :payload, 5, type: :bytes
end
