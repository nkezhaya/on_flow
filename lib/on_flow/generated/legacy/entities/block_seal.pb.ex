defmodule Entities.BlockSeal do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_id, 1, type: :bytes, json_name: "blockId"
  field :execution_receipt_id, 2, type: :bytes, json_name: "executionReceiptId"

  field :execution_receipt_signatures, 3,
    repeated: true,
    type: :bytes,
    json_name: "executionReceiptSignatures"

  field :result_approval_signatures, 4,
    repeated: true,
    type: :bytes,
    json_name: "resultApprovalSignatures"
end