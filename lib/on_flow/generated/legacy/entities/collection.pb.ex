defmodule Entities.Collection do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :id, 1, type: :bytes
  field :transaction_ids, 2, repeated: true, type: :bytes, json_name: "transactionIds"
end

defmodule Entities.CollectionGuarantee do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :collection_id, 1, type: :bytes, json_name: "collectionId"
  field :signatures, 2, repeated: true, type: :bytes
end