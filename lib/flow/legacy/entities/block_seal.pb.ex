defmodule Entities.BlockSeal do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block_id: binary,
          execution_receipt_id: binary,
          execution_receipt_signatures: [binary],
          result_approval_signatures: [binary]
        }

  defstruct [
    :block_id,
    :execution_receipt_id,
    :execution_receipt_signatures,
    :result_approval_signatures
  ]

  field :block_id, 1, type: :bytes
  field :execution_receipt_id, 2, type: :bytes
  field :execution_receipt_signatures, 3, repeated: true, type: :bytes
  field :result_approval_signatures, 4, repeated: true, type: :bytes
end
