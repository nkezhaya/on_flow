defmodule Google.Protobuf.Timestamp do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :seconds, 1, optional: true, type: :int64
  field :nanos, 2, optional: true, type: :int32
end
