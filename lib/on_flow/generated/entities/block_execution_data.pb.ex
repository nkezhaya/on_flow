defmodule OnFlow.Entities.BlockExecutionData do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_id, 1, type: :bytes, json_name: "blockId"

  field :chunk_execution_data, 2,
    repeated: true,
    type: OnFlow.Entities.ChunkExecutionData,
    json_name: "chunkExecutionData"
end

defmodule OnFlow.Entities.ChunkExecutionData do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :collection, 1, type: OnFlow.Entities.ExecutionDataCollection
  field :events, 2, repeated: true, type: OnFlow.Entities.Event
  field :trieUpdate, 3, type: OnFlow.Entities.TrieUpdate
end

defmodule OnFlow.Entities.ExecutionDataCollection do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :transactions, 1, repeated: true, type: OnFlow.Entities.Transaction
end

defmodule OnFlow.Entities.TrieUpdate do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :root_hash, 1, type: :bytes, json_name: "rootHash"
  field :paths, 2, repeated: true, type: :bytes
  field :payloads, 3, repeated: true, type: OnFlow.Entities.Payload
end

defmodule OnFlow.Entities.Payload do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :keyPart, 1, repeated: true, type: OnFlow.Entities.KeyPart
  field :value, 2, type: :bytes
end

defmodule OnFlow.Entities.KeyPart do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :type, 1, type: :uint32
  field :value, 2, type: :bytes
end