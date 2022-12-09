defmodule OnFlow.Entities.ExecutionResult do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :previous_result_id, 1, type: :bytes, json_name: "previousResultId"
  field :block_id, 2, type: :bytes, json_name: "blockId"
  field :chunks, 3, repeated: true, type: OnFlow.Entities.Chunk

  field :service_events, 4,
    repeated: true,
    type: OnFlow.Entities.ServiceEvent,
    json_name: "serviceEvents"

  field :execution_data_id, 5, type: :bytes, json_name: "executionDataId", deprecated: true
end

defmodule OnFlow.Entities.Chunk do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :CollectionIndex, 1, type: :uint32
  field :start_state, 2, type: :bytes, json_name: "startState"
  field :event_collection, 3, type: :bytes, json_name: "eventCollection"
  field :block_id, 4, type: :bytes, json_name: "blockId"
  field :total_computation_used, 5, type: :uint64, json_name: "totalComputationUsed"
  field :number_of_transactions, 6, type: :uint32, json_name: "numberOfTransactions"
  field :index, 7, type: :uint64
  field :end_state, 8, type: :bytes, json_name: "endState"
  field :execution_data_id, 9, type: :bytes, json_name: "executionDataId"
end

defmodule OnFlow.Entities.ServiceEvent do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :type, 1, type: :string
  field :payload, 2, type: :bytes
end

defmodule OnFlow.Entities.ExecutionReceiptMeta do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :executor_id, 1, type: :bytes, json_name: "executorId"
  field :result_id, 2, type: :bytes, json_name: "resultId"
  field :spocks, 3, repeated: true, type: :bytes
  field :executor_signature, 4, type: :bytes, json_name: "executorSignature"
end