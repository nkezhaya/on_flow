defmodule Entities.Block do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :id, 1, type: :bytes
  field :parent_id, 2, type: :bytes, json_name: "parentId"
  field :height, 3, type: :uint64
  field :timestamp, 4, type: Google.Protobuf.Timestamp

  field :collection_guarantees, 5,
    repeated: true,
    type: Entities.CollectionGuarantee,
    json_name: "collectionGuarantees"

  field :block_seals, 6, repeated: true, type: Entities.BlockSeal, json_name: "blockSeals"
  field :signatures, 7, repeated: true, type: :bytes
end