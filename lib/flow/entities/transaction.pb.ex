defmodule Flow.Entities.TransactionStatus do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3
  @type t :: integer | :UNKNOWN | :PENDING | :FINALIZED | :EXECUTED | :SEALED | :EXPIRED

  field :UNKNOWN, 0

  field :PENDING, 1

  field :FINALIZED, 2

  field :EXECUTED, 3

  field :SEALED, 4

  field :EXPIRED, 5
end

defmodule Flow.Entities.Transaction.ProposalKey do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: binary,
          key_id: non_neg_integer,
          sequence_number: non_neg_integer
        }

  defstruct [:address, :key_id, :sequence_number]

  field :address, 1, type: :bytes
  field :key_id, 2, type: :uint32
  field :sequence_number, 3, type: :uint64
end

defmodule Flow.Entities.Transaction.Signature do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: binary,
          key_id: non_neg_integer,
          signature: binary
        }

  defstruct [:address, :key_id, :signature]

  field :address, 1, type: :bytes
  field :key_id, 2, type: :uint32
  field :signature, 3, type: :bytes
end

defmodule Flow.Entities.Transaction do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          script: binary,
          arguments: [binary],
          reference_block_id: binary,
          gas_limit: non_neg_integer,
          proposal_key: Flow.Entities.Transaction.ProposalKey.t() | nil,
          payer: binary,
          authorizers: [binary],
          payload_signatures: [Flow.Entities.Transaction.Signature.t()],
          envelope_signatures: [Flow.Entities.Transaction.Signature.t()]
        }

  defstruct [
    :script,
    :arguments,
    :reference_block_id,
    :gas_limit,
    :proposal_key,
    :payer,
    :authorizers,
    :payload_signatures,
    :envelope_signatures
  ]

  field :script, 1, type: :bytes
  field :arguments, 2, repeated: true, type: :bytes
  field :reference_block_id, 3, type: :bytes
  field :gas_limit, 4, type: :uint64
  field :proposal_key, 5, type: Flow.Entities.Transaction.ProposalKey
  field :payer, 6, type: :bytes
  field :authorizers, 7, repeated: true, type: :bytes
  field :payload_signatures, 8, repeated: true, type: Flow.Entities.Transaction.Signature
  field :envelope_signatures, 9, repeated: true, type: Flow.Entities.Transaction.Signature
end
