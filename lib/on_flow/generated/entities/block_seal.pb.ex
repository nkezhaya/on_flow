defmodule OnFlow.Entities.BlockSeal do
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

  field :final_state, 5, type: :bytes, json_name: "finalState"
  field :result_id, 6, type: :bytes, json_name: "resultId"

  field :aggregated_approval_sigs, 7,
    repeated: true,
    type: OnFlow.Entities.AggregatedSignature,
    json_name: "aggregatedApprovalSigs"
end

defmodule OnFlow.Entities.AggregatedSignature do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :verifier_signatures, 1, repeated: true, type: :bytes, json_name: "verifierSignatures"
  field :signer_ids, 2, repeated: true, type: :bytes, json_name: "signerIds"
end