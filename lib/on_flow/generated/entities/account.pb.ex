defmodule OnFlow.Entities.Account.ContractsEntry do
  @moduledoc false
  use Protobuf, map: true, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :key, 1, type: :string
  field :value, 2, type: :bytes
end

defmodule OnFlow.Entities.Account do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :address, 1, type: :bytes
  field :balance, 2, type: :uint64
  field :code, 3, type: :bytes
  field :keys, 4, repeated: true, type: OnFlow.Entities.AccountKey
  field :contracts, 5, repeated: true, type: OnFlow.Entities.Account.ContractsEntry, map: true
end

defmodule OnFlow.Entities.AccountKey do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :index, 1, type: :uint32
  field :public_key, 2, type: :bytes, json_name: "publicKey"
  field :sign_algo, 3, type: :uint32, json_name: "signAlgo"
  field :hash_algo, 4, type: :uint32, json_name: "hashAlgo"
  field :weight, 5, type: :uint32
  field :sequence_number, 6, type: :uint32, json_name: "sequenceNumber"
  field :revoked, 7, type: :bool
end