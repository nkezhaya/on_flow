defmodule OnFlow.Entities.BlockStatus do
  @moduledoc false
  use Protobuf, enum: true, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :BLOCK_UNKNOWN, 0
  field :BLOCK_FINALIZED, 1
  field :BLOCK_SEALED, 2
end

defmodule OnFlow.Entities.Block do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :id, 1, type: :bytes
  field :parent_id, 2, type: :bytes, json_name: "parentId"
  field :height, 3, type: :uint64
  field :timestamp, 4, type: Google.Protobuf.Timestamp

  field :collection_guarantees, 5,
    repeated: true,
    type: OnFlow.Entities.CollectionGuarantee,
    json_name: "collectionGuarantees"

  field :block_seals, 6, repeated: true, type: OnFlow.Entities.BlockSeal, json_name: "blockSeals"
  field :signatures, 7, repeated: true, type: :bytes

  field :execution_receipt_metaList, 8,
    repeated: true,
    type: OnFlow.Entities.ExecutionReceiptMeta,
    json_name: "executionReceiptMetaList"

  field :execution_result_list, 9,
    repeated: true,
    type: OnFlow.Entities.ExecutionResult,
    json_name: "executionResultList"

  field :block_header, 10, type: OnFlow.Entities.BlockHeader, json_name: "blockHeader"
end