defmodule Entities.Account do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: binary,
          balance: non_neg_integer,
          code: binary,
          keys: [Entities.AccountKey.t()]
        }

  defstruct [:address, :balance, :code, :keys]

  field :address, 1, type: :bytes
  field :balance, 2, type: :uint64
  field :code, 3, type: :bytes
  field :keys, 4, repeated: true, type: Entities.AccountKey
end

defmodule Entities.AccountKey do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          index: non_neg_integer,
          public_key: binary,
          sign_algo: non_neg_integer,
          hash_algo: non_neg_integer,
          weight: non_neg_integer,
          sequence_number: non_neg_integer
        }

  defstruct [:index, :public_key, :sign_algo, :hash_algo, :weight, :sequence_number]

  field :index, 1, type: :uint32
  field :public_key, 2, type: :bytes
  field :sign_algo, 3, type: :uint32
  field :hash_algo, 4, type: :uint32
  field :weight, 5, type: :uint32
  field :sequence_number, 6, type: :uint32
end
