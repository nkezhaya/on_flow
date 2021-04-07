defmodule Entities.Collection do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: binary,
          transaction_ids: [binary]
        }

  defstruct [:id, :transaction_ids]

  field :id, 1, type: :bytes
  field :transaction_ids, 2, repeated: true, type: :bytes
end

defmodule Entities.CollectionGuarantee do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          collection_id: binary,
          signatures: [binary]
        }

  defstruct [:collection_id, :signatures]

  field :collection_id, 1, type: :bytes
  field :signatures, 2, repeated: true, type: :bytes
end
