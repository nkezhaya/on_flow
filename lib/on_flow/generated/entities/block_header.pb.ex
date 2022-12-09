defmodule OnFlow.Entities.BlockHeader do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :id, 1, type: :bytes
  field :parent_id, 2, type: :bytes, json_name: "parentId"
  field :height, 3, type: :uint64
  field :timestamp, 4, type: Google.Protobuf.Timestamp
  field :payload_hash, 5, type: :bytes, json_name: "payloadHash"
  field :view, 6, type: :uint64
  field :parent_voter_ids, 7, repeated: true, type: :bytes, json_name: "parentVoterIds"
  field :parent_voter_sig_data, 8, type: :bytes, json_name: "parentVoterSigData"
  field :proposer_id, 9, type: :bytes, json_name: "proposerId"
  field :proposer_sig_data, 10, type: :bytes, json_name: "proposerSigData"
  field :chain_id, 11, type: :string, json_name: "chainId"
  field :parent_voter_indices, 12, type: :bytes, json_name: "parentVoterIndices"
end