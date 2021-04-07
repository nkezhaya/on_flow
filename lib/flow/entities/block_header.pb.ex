defmodule Flow.Entities.BlockHeader do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: binary,
          parent_id: binary,
          height: non_neg_integer,
          timestamp: Google.Protobuf.Timestamp.t() | nil
        }

  defstruct [:id, :parent_id, :height, :timestamp]

  field :id, 1, type: :bytes
  field :parent_id, 2, type: :bytes
  field :height, 3, type: :uint64
  field :timestamp, 4, type: Google.Protobuf.Timestamp
end
