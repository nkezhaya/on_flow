defmodule Flow.Entities.Account.ContractsEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: binary
        }

  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: :bytes
end

defmodule Flow.Entities.Account do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: binary,
          balance: non_neg_integer,
          code: binary,
          keys: [Flow.Entities.AccountKey.t()],
          contracts: %{String.t() => binary}
        }

  defstruct [:address, :balance, :code, :keys, :contracts]

  field :address, 1, type: :bytes
  field :balance, 2, type: :uint64
  field :code, 3, type: :bytes
  field :keys, 4, repeated: true, type: Flow.Entities.AccountKey
  field :contracts, 5, repeated: true, type: Flow.Entities.Account.ContractsEntry, map: true
end

defmodule Flow.Entities.AccountKey do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          index: non_neg_integer,
          public_key: binary,
          sign_algo: non_neg_integer,
          hash_algo: non_neg_integer,
          weight: non_neg_integer,
          sequence_number: non_neg_integer,
          revoked: boolean
        }

  defstruct [:index, :public_key, :sign_algo, :hash_algo, :weight, :sequence_number, :revoked]

  field :index, 1, type: :uint32
  field :public_key, 2, type: :bytes
  field :sign_algo, 3, type: :uint32
  field :hash_algo, 4, type: :uint32
  field :weight, 5, type: :uint32
  field :sequence_number, 6, type: :uint32
  field :revoked, 7, type: :bool
end
