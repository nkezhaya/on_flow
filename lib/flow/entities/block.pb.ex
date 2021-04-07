defmodule Flow.Entities.Block do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: binary,
          parent_id: binary,
          height: non_neg_integer,
          timestamp: Google.Protobuf.Timestamp.t() | nil,
          collection_guarantees: [Flow.Entities.CollectionGuarantee.t()],
          block_seals: [Flow.Entities.BlockSeal.t()],
          signatures: [binary]
        }

  defstruct [
    :id,
    :parent_id,
    :height,
    :timestamp,
    :collection_guarantees,
    :block_seals,
    :signatures
  ]

  field :id, 1, type: :bytes
  field :parent_id, 2, type: :bytes
  field :height, 3, type: :uint64
  field :timestamp, 4, type: Google.Protobuf.Timestamp
  field :collection_guarantees, 5, repeated: true, type: Flow.Entities.CollectionGuarantee
  field :block_seals, 6, repeated: true, type: Flow.Entities.BlockSeal
  field :signatures, 7, repeated: true, type: :bytes
end
