defmodule Execution.PingRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3
end

defmodule Execution.PingResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3
end

defmodule Execution.GetAccountAtBlockIDRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_id, 1, type: :bytes, json_name: "blockId"
  field :address, 2, type: :bytes
end

defmodule Execution.GetAccountAtBlockIDResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :account, 1, type: Entities.Account
end

defmodule Execution.ExecuteScriptAtBlockIDRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_id, 1, type: :bytes, json_name: "blockId"
  field :script, 2, type: :bytes
  field :arguments, 3, repeated: true, type: :bytes
end

defmodule Execution.ExecuteScriptAtBlockIDResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :value, 1, type: :bytes
end

defmodule Execution.GetEventsForBlockIDsResponse.Result do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_id, 1, type: :bytes, json_name: "blockId"
  field :block_height, 2, type: :uint64, json_name: "blockHeight"
  field :events, 3, repeated: true, type: Entities.Event
end

defmodule Execution.GetEventsForBlockIDsResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :results, 1, repeated: true, type: Execution.GetEventsForBlockIDsResponse.Result
end

defmodule Execution.GetEventsForBlockIDsRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :type, 1, type: :string
  field :block_ids, 2, repeated: true, type: :bytes, json_name: "blockIds"
end

defmodule Execution.GetTransactionResultRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_id, 1, type: :bytes, json_name: "blockId"
  field :transaction_id, 2, type: :bytes, json_name: "transactionId"
end

defmodule Execution.GetTransactionResultResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :status_code, 1, type: :uint32, json_name: "statusCode"
  field :error_message, 2, type: :string, json_name: "errorMessage"
  field :events, 3, repeated: true, type: Entities.Event
end

defmodule Execution.ExecutionAPI.Service do
  @moduledoc false
  use GRPC.Service, name: "execution.ExecutionAPI", protoc_gen_elixir_version: "0.11.0"

  rpc :Ping, Execution.PingRequest, Execution.PingResponse

  rpc :GetAccountAtBlockID,
      Execution.GetAccountAtBlockIDRequest,
      Execution.GetAccountAtBlockIDResponse

  rpc :ExecuteScriptAtBlockID,
      Execution.ExecuteScriptAtBlockIDRequest,
      Execution.ExecuteScriptAtBlockIDResponse

  rpc :GetEventsForBlockIDs,
      Execution.GetEventsForBlockIDsRequest,
      Execution.GetEventsForBlockIDsResponse

  rpc :GetTransactionResult,
      Execution.GetTransactionResultRequest,
      Execution.GetTransactionResultResponse
end

defmodule Execution.ExecutionAPI.Stub do
  @moduledoc false
  use GRPC.Stub, service: Execution.ExecutionAPI.Service
end