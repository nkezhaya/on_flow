defmodule OnFlow.Access.PingRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3
end

defmodule OnFlow.Access.PingResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3
end

defmodule OnFlow.Access.GetLatestBlockHeaderRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :is_sealed, 1, type: :bool, json_name: "isSealed"
end

defmodule OnFlow.Access.GetBlockHeaderByIDRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :id, 1, type: :bytes
end

defmodule OnFlow.Access.GetBlockHeaderByHeightRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :height, 1, type: :uint64
end

defmodule OnFlow.Access.BlockHeaderResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block, 1, type: OnFlow.Entities.BlockHeader
  field :block_status, 2, type: OnFlow.Entities.BlockStatus, json_name: "blockStatus", enum: true
end

defmodule OnFlow.Access.GetLatestBlockRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :is_sealed, 1, type: :bool, json_name: "isSealed"
  field :full_block_response, 2, type: :bool, json_name: "fullBlockResponse"
end

defmodule OnFlow.Access.GetBlockByIDRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :id, 1, type: :bytes
  field :full_block_response, 2, type: :bool, json_name: "fullBlockResponse"
end

defmodule OnFlow.Access.GetBlockByHeightRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :height, 1, type: :uint64
  field :full_block_response, 2, type: :bool, json_name: "fullBlockResponse"
end

defmodule OnFlow.Access.BlockResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block, 1, type: OnFlow.Entities.Block
  field :block_status, 2, type: OnFlow.Entities.BlockStatus, json_name: "blockStatus", enum: true
end

defmodule OnFlow.Access.GetCollectionByIDRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :id, 1, type: :bytes
end

defmodule OnFlow.Access.CollectionResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :collection, 1, type: OnFlow.Entities.Collection
end

defmodule OnFlow.Access.SendTransactionRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :transaction, 1, type: OnFlow.Entities.Transaction
end

defmodule OnFlow.Access.SendTransactionResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :id, 1, type: :bytes
end

defmodule OnFlow.Access.GetTransactionRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :id, 1, type: :bytes
end

defmodule OnFlow.Access.GetTransactionByIndexRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_id, 1, type: :bytes, json_name: "blockId"
  field :index, 2, type: :uint32
end

defmodule OnFlow.Access.GetTransactionsByBlockIDRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_id, 1, type: :bytes, json_name: "blockId"
end

defmodule OnFlow.Access.TransactionResultsResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :transaction_results, 1,
    repeated: true,
    type: OnFlow.Access.TransactionResultResponse,
    json_name: "transactionResults"
end

defmodule OnFlow.Access.TransactionsResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :transactions, 1, repeated: true, type: OnFlow.Entities.Transaction
end

defmodule OnFlow.Access.TransactionResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :transaction, 1, type: OnFlow.Entities.Transaction
end

defmodule OnFlow.Access.TransactionResultResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :status, 1, type: OnFlow.Entities.TransactionStatus, enum: true
  field :status_code, 2, type: :uint32, json_name: "statusCode"
  field :error_message, 3, type: :string, json_name: "errorMessage"
  field :events, 4, repeated: true, type: OnFlow.Entities.Event
  field :block_id, 5, type: :bytes, json_name: "blockId"
  field :transaction_id, 6, type: :bytes, json_name: "transactionId"
  field :collection_id, 7, type: :bytes, json_name: "collectionId"
  field :block_height, 8, type: :uint64, json_name: "blockHeight"
end

defmodule OnFlow.Access.GetAccountRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :address, 1, type: :bytes
end

defmodule OnFlow.Access.GetAccountResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :account, 1, type: OnFlow.Entities.Account
end

defmodule OnFlow.Access.GetAccountAtLatestBlockRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :address, 1, type: :bytes
end

defmodule OnFlow.Access.AccountResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :account, 1, type: OnFlow.Entities.Account
end

defmodule OnFlow.Access.GetAccountAtBlockHeightRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :address, 1, type: :bytes
  field :block_height, 2, type: :uint64, json_name: "blockHeight"
end

defmodule OnFlow.Access.ExecuteScriptAtLatestBlockRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :script, 1, type: :bytes
  field :arguments, 2, repeated: true, type: :bytes
end

defmodule OnFlow.Access.ExecuteScriptAtBlockIDRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_id, 1, type: :bytes, json_name: "blockId"
  field :script, 2, type: :bytes
  field :arguments, 3, repeated: true, type: :bytes
end

defmodule OnFlow.Access.ExecuteScriptAtBlockHeightRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_height, 1, type: :uint64, json_name: "blockHeight"
  field :script, 2, type: :bytes
  field :arguments, 3, repeated: true, type: :bytes
end

defmodule OnFlow.Access.ExecuteScriptResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :value, 1, type: :bytes
end

defmodule OnFlow.Access.GetEventsForHeightRangeRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :type, 1, type: :string
  field :start_height, 2, type: :uint64, json_name: "startHeight"
  field :end_height, 3, type: :uint64, json_name: "endHeight"
end

defmodule OnFlow.Access.GetEventsForBlockIDsRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :type, 1, type: :string
  field :block_ids, 2, repeated: true, type: :bytes, json_name: "blockIds"
end

defmodule OnFlow.Access.EventsResponse.Result do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_id, 1, type: :bytes, json_name: "blockId"
  field :block_height, 2, type: :uint64, json_name: "blockHeight"
  field :events, 3, repeated: true, type: OnFlow.Entities.Event
  field :block_timestamp, 4, type: Google.Protobuf.Timestamp, json_name: "blockTimestamp"
end

defmodule OnFlow.Access.EventsResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :results, 1, repeated: true, type: OnFlow.Access.EventsResponse.Result
end

defmodule OnFlow.Access.GetNetworkParametersRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3
end

defmodule OnFlow.Access.GetNetworkParametersResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :chain_id, 1, type: :string, json_name: "chainId"
end

defmodule OnFlow.Access.GetLatestProtocolStateSnapshotRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3
end

defmodule OnFlow.Access.ProtocolStateSnapshotResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :serializedSnapshot, 1, type: :bytes
end

defmodule OnFlow.Access.GetExecutionResultForBlockIDRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_id, 1, type: :bytes, json_name: "blockId"
end

defmodule OnFlow.Access.ExecutionResultForBlockIDResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :execution_result, 1, type: OnFlow.Entities.ExecutionResult, json_name: "executionResult"
end

defmodule OnFlow.Access.AccessAPI.Service do
  @moduledoc false
  use GRPC.Service, name: "flow.access.AccessAPI", protoc_gen_elixir_version: "0.11.0"

  rpc :Ping, OnFlow.Access.PingRequest, OnFlow.Access.PingResponse

  rpc :GetLatestBlockHeader,
      OnFlow.Access.GetLatestBlockHeaderRequest,
      OnFlow.Access.BlockHeaderResponse

  rpc :GetBlockHeaderByID, OnFlow.Access.GetBlockHeaderByIDRequest, OnFlow.Access.BlockHeaderResponse

  rpc :GetBlockHeaderByHeight,
      OnFlow.Access.GetBlockHeaderByHeightRequest,
      OnFlow.Access.BlockHeaderResponse

  rpc :GetLatestBlock, OnFlow.Access.GetLatestBlockRequest, OnFlow.Access.BlockResponse

  rpc :GetBlockByID, OnFlow.Access.GetBlockByIDRequest, OnFlow.Access.BlockResponse

  rpc :GetBlockByHeight, OnFlow.Access.GetBlockByHeightRequest, OnFlow.Access.BlockResponse

  rpc :GetCollectionByID, OnFlow.Access.GetCollectionByIDRequest, OnFlow.Access.CollectionResponse

  rpc :SendTransaction, OnFlow.Access.SendTransactionRequest, OnFlow.Access.SendTransactionResponse

  rpc :GetTransaction, OnFlow.Access.GetTransactionRequest, OnFlow.Access.TransactionResponse

  rpc :GetTransactionResult,
      OnFlow.Access.GetTransactionRequest,
      OnFlow.Access.TransactionResultResponse

  rpc :GetTransactionResultByIndex,
      OnFlow.Access.GetTransactionByIndexRequest,
      OnFlow.Access.TransactionResultResponse

  rpc :GetTransactionResultsByBlockID,
      OnFlow.Access.GetTransactionsByBlockIDRequest,
      OnFlow.Access.TransactionResultsResponse

  rpc :GetTransactionsByBlockID,
      OnFlow.Access.GetTransactionsByBlockIDRequest,
      OnFlow.Access.TransactionsResponse

  rpc :GetAccount, OnFlow.Access.GetAccountRequest, OnFlow.Access.GetAccountResponse

  rpc :GetAccountAtLatestBlock,
      OnFlow.Access.GetAccountAtLatestBlockRequest,
      OnFlow.Access.AccountResponse

  rpc :GetAccountAtBlockHeight,
      OnFlow.Access.GetAccountAtBlockHeightRequest,
      OnFlow.Access.AccountResponse

  rpc :ExecuteScriptAtLatestBlock,
      OnFlow.Access.ExecuteScriptAtLatestBlockRequest,
      OnFlow.Access.ExecuteScriptResponse

  rpc :ExecuteScriptAtBlockID,
      OnFlow.Access.ExecuteScriptAtBlockIDRequest,
      OnFlow.Access.ExecuteScriptResponse

  rpc :ExecuteScriptAtBlockHeight,
      OnFlow.Access.ExecuteScriptAtBlockHeightRequest,
      OnFlow.Access.ExecuteScriptResponse

  rpc :GetEventsForHeightRange,
      OnFlow.Access.GetEventsForHeightRangeRequest,
      OnFlow.Access.EventsResponse

  rpc :GetEventsForBlockIDs, OnFlow.Access.GetEventsForBlockIDsRequest, OnFlow.Access.EventsResponse

  rpc :GetNetworkParameters,
      OnFlow.Access.GetNetworkParametersRequest,
      OnFlow.Access.GetNetworkParametersResponse

  rpc :GetLatestProtocolStateSnapshot,
      OnFlow.Access.GetLatestProtocolStateSnapshotRequest,
      OnFlow.Access.ProtocolStateSnapshotResponse

  rpc :GetExecutionResultForBlockID,
      OnFlow.Access.GetExecutionResultForBlockIDRequest,
      OnFlow.Access.ExecutionResultForBlockIDResponse
end

defmodule OnFlow.Access.AccessAPI.Stub do
  @moduledoc false
  use GRPC.Stub, service: OnFlow.Access.AccessAPI.Service
end