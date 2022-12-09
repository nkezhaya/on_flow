defmodule OnFlow.Execution.PingRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3
end

defmodule OnFlow.Execution.PingResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3
end

defmodule OnFlow.Execution.GetAccountAtBlockIDRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_id, 1, type: :bytes, json_name: "blockId"
  field :address, 2, type: :bytes
end

defmodule OnFlow.Execution.GetAccountAtBlockIDResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :account, 1, type: OnFlow.Entities.Account
end

defmodule OnFlow.Execution.ExecuteScriptAtBlockIDRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_id, 1, type: :bytes, json_name: "blockId"
  field :script, 2, type: :bytes
  field :arguments, 3, repeated: true, type: :bytes
end

defmodule OnFlow.Execution.ExecuteScriptAtBlockIDResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :value, 1, type: :bytes
end

defmodule OnFlow.Execution.GetEventsForBlockIDsResponse.Result do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_id, 1, type: :bytes, json_name: "blockId"
  field :block_height, 2, type: :uint64, json_name: "blockHeight"
  field :events, 3, repeated: true, type: OnFlow.Entities.Event
end

defmodule OnFlow.Execution.GetEventsForBlockIDsResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :results, 1, repeated: true, type: OnFlow.Execution.GetEventsForBlockIDsResponse.Result
end

defmodule OnFlow.Execution.GetEventsForBlockIDsRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :type, 1, type: :string
  field :block_ids, 2, repeated: true, type: :bytes, json_name: "blockIds"
end

defmodule OnFlow.Execution.GetTransactionResultRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_id, 1, type: :bytes, json_name: "blockId"
  field :transaction_id, 2, type: :bytes, json_name: "transactionId"
end

defmodule OnFlow.Execution.GetTransactionByIndexRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_id, 1, type: :bytes, json_name: "blockId"
  field :index, 2, type: :uint32
end

defmodule OnFlow.Execution.GetTransactionResultResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :status_code, 1, type: :uint32, json_name: "statusCode"
  field :error_message, 2, type: :string, json_name: "errorMessage"
  field :events, 3, repeated: true, type: OnFlow.Entities.Event
end

defmodule OnFlow.Execution.GetTransactionsByBlockIDRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_id, 1, type: :bytes, json_name: "blockId"
end

defmodule OnFlow.Execution.GetTransactionResultsResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :transaction_results, 1,
    repeated: true,
    type: OnFlow.Execution.GetTransactionResultResponse,
    json_name: "transactionResults"
end

defmodule OnFlow.Execution.GetRegisterAtBlockIDRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_id, 1, type: :bytes, json_name: "blockId"
  field :register_owner, 2, type: :bytes, json_name: "registerOwner"
  field :register_key, 4, type: :bytes, json_name: "registerKey"
end

defmodule OnFlow.Execution.GetRegisterAtBlockIDResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :value, 1, type: :bytes
end

defmodule OnFlow.Execution.GetLatestBlockHeaderRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :is_sealed, 1, type: :bool, json_name: "isSealed"
end

defmodule OnFlow.Execution.GetBlockHeaderByIDRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :id, 1, type: :bytes
end

defmodule OnFlow.Execution.BlockHeaderResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block, 1, type: OnFlow.Entities.BlockHeader
end

defmodule OnFlow.Execution.ExecutionAPI.Service do
  @moduledoc false
  use GRPC.Service, name: "flow.execution.ExecutionAPI", protoc_gen_elixir_version: "0.11.0"

  rpc :Ping, OnFlow.Execution.PingRequest, OnFlow.Execution.PingResponse

  rpc :GetAccountAtBlockID,
      OnFlow.Execution.GetAccountAtBlockIDRequest,
      OnFlow.Execution.GetAccountAtBlockIDResponse

  rpc :ExecuteScriptAtBlockID,
      OnFlow.Execution.ExecuteScriptAtBlockIDRequest,
      OnFlow.Execution.ExecuteScriptAtBlockIDResponse

  rpc :GetEventsForBlockIDs,
      OnFlow.Execution.GetEventsForBlockIDsRequest,
      OnFlow.Execution.GetEventsForBlockIDsResponse

  rpc :GetTransactionResult,
      OnFlow.Execution.GetTransactionResultRequest,
      OnFlow.Execution.GetTransactionResultResponse

  rpc :GetTransactionResultByIndex,
      OnFlow.Execution.GetTransactionByIndexRequest,
      OnFlow.Execution.GetTransactionResultResponse

  rpc :GetTransactionResultsByBlockID,
      OnFlow.Execution.GetTransactionsByBlockIDRequest,
      OnFlow.Execution.GetTransactionResultsResponse

  rpc :GetRegisterAtBlockID,
      OnFlow.Execution.GetRegisterAtBlockIDRequest,
      OnFlow.Execution.GetRegisterAtBlockIDResponse

  rpc :GetLatestBlockHeader,
      OnFlow.Execution.GetLatestBlockHeaderRequest,
      OnFlow.Execution.BlockHeaderResponse

  rpc :GetBlockHeaderByID,
      OnFlow.Execution.GetBlockHeaderByIDRequest,
      OnFlow.Execution.BlockHeaderResponse
end

defmodule OnFlow.Execution.ExecutionAPI.Stub do
  @moduledoc false
  use GRPC.Stub, service: OnFlow.Execution.ExecutionAPI.Service
end