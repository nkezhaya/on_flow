defmodule OnFlow.Entities.Collection do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :id, 1, type: :bytes
  field :transaction_ids, 2, repeated: true, type: :bytes, json_name: "transactionIds"
end

defmodule OnFlow.Entities.CollectionGuarantee do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :collection_id, 1, type: :bytes, json_name: "collectionId"
  field :signatures, 2, repeated: true, type: :bytes
  field :reference_block_id, 3, type: :bytes, json_name: "referenceBlockId"
  field :signature, 4, type: :bytes
  field :signer_ids, 5, repeated: true, type: :bytes, json_name: "signerIds"
  field :signer_indices, 6, type: :bytes, json_name: "signerIndices"
end