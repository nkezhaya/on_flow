defmodule Entities.TransactionStatus do
  @moduledoc false
  use Protobuf, enum: true, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :UNKNOWN, 0
  field :PENDING, 1
  field :FINALIZED, 2
  field :EXECUTED, 3
  field :SEALED, 4
  field :EXPIRED, 5
end

defmodule Entities.Transaction.ProposalKey do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :address, 1, type: :bytes
  field :key_id, 2, type: :uint32, json_name: "keyId"
  field :sequence_number, 3, type: :uint64, json_name: "sequenceNumber"
end

defmodule Entities.Transaction.Signature do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :address, 1, type: :bytes
  field :key_id, 2, type: :uint32, json_name: "keyId"
  field :signature, 3, type: :bytes
end

defmodule Entities.Transaction do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :script, 1, type: :bytes
  field :arguments, 2, repeated: true, type: :bytes
  field :reference_block_id, 3, type: :bytes, json_name: "referenceBlockId"
  field :gas_limit, 4, type: :uint64, json_name: "gasLimit"
  field :proposal_key, 5, type: Entities.Transaction.ProposalKey, json_name: "proposalKey"
  field :payer, 6, type: :bytes
  field :authorizers, 7, repeated: true, type: :bytes

  field :payload_signatures, 8,
    repeated: true,
    type: Entities.Transaction.Signature,
    json_name: "payloadSignatures"

  field :envelope_signatures, 9,
    repeated: true,
    type: Entities.Transaction.Signature,
    json_name: "envelopeSignatures"
end