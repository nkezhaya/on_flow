defmodule Entities.Event do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :type, 1, type: :string
  field :transaction_id, 2, type: :bytes, json_name: "transactionId"
  field :transaction_index, 3, type: :uint32, json_name: "transactionIndex"
  field :event_index, 4, type: :uint32, json_name: "eventIndex"
  field :payload, 5, type: :bytes
end