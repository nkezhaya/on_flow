defmodule OnFlow.Access.GetExecutionDataByBlockIDRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_id, 1, type: :bytes, json_name: "blockId"
end

defmodule OnFlow.Access.GetExecutionDataByBlockIDResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_execution_data, 1,
    type: OnFlow.Entities.BlockExecutionData,
    json_name: "blockExecutionData"
end

defmodule OnFlow.Access.ExecutionDataAPI.Service do
  @moduledoc false
  use GRPC.Service, name: "flow.access.ExecutionDataAPI", protoc_gen_elixir_version: "0.11.0"

  rpc :GetExecutionDataByBlockID,
      OnFlow.Access.GetExecutionDataByBlockIDRequest,
      OnFlow.Access.GetExecutionDataByBlockIDResponse
end

defmodule OnFlow.Access.ExecutionDataAPI.Stub do
  @moduledoc false
  use GRPC.Stub, service: OnFlow.Access.ExecutionDataAPI.Service
end