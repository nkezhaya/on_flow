defmodule Access.PingRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3
end

defmodule Access.PingResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3
end

defmodule Access.GetLatestBlockHeaderRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :is_sealed, 1, type: :bool, json_name: "isSealed"
end

defmodule Access.GetBlockHeaderByIDRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :id, 1, type: :bytes
end

defmodule Access.GetBlockHeaderByHeightRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :height, 1, type: :uint64
end

defmodule Access.BlockHeaderResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block, 1, type: Entities.BlockHeader
end

defmodule Access.GetLatestBlockRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :is_sealed, 1, type: :bool, json_name: "isSealed"
end

defmodule Access.GetBlockByIDRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :id, 1, type: :bytes
end

defmodule Access.GetBlockByHeightRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :height, 1, type: :uint64
end

defmodule Access.BlockResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block, 1, type: Entities.Block
end

defmodule Access.GetCollectionByIDRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :id, 1, type: :bytes
end

defmodule Access.CollectionResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :collection, 1, type: Entities.Collection
end

defmodule Access.SendTransactionRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :transaction, 1, type: Entities.Transaction
end

defmodule Access.SendTransactionResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :id, 1, type: :bytes
end

defmodule Access.GetTransactionRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :id, 1, type: :bytes
end

defmodule Access.TransactionResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :transaction, 1, type: Entities.Transaction
end

defmodule Access.TransactionResultResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :status, 1, type: Entities.TransactionStatus, enum: true
  field :status_code, 2, type: :uint32, json_name: "statusCode"
  field :error_message, 3, type: :string, json_name: "errorMessage"
  field :events, 4, repeated: true, type: Entities.Event
end

defmodule Access.GetAccountRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :address, 1, type: :bytes
end

defmodule Access.GetAccountResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :account, 1, type: Entities.Account
end

defmodule Access.GetAccountAtLatestBlockRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :address, 1, type: :bytes
end

defmodule Access.AccountResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :account, 1, type: Entities.Account
end

defmodule Access.GetAccountAtBlockHeightRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :address, 1, type: :bytes
  field :block_height, 2, type: :uint64, json_name: "blockHeight"
end

defmodule Access.ExecuteScriptAtLatestBlockRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :script, 1, type: :bytes
  field :arguments, 2, repeated: true, type: :bytes
end

defmodule Access.ExecuteScriptAtBlockIDRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_id, 1, type: :bytes, json_name: "blockId"
  field :script, 2, type: :bytes
  field :arguments, 3, repeated: true, type: :bytes
end

defmodule Access.ExecuteScriptAtBlockHeightRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_height, 1, type: :uint64, json_name: "blockHeight"
  field :script, 2, type: :bytes
  field :arguments, 3, repeated: true, type: :bytes
end

defmodule Access.ExecuteScriptResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :value, 1, type: :bytes
end

defmodule Access.GetEventsForHeightRangeRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :type, 1, type: :string
  field :start_height, 2, type: :uint64, json_name: "startHeight"
  field :end_height, 3, type: :uint64, json_name: "endHeight"
end

defmodule Access.GetEventsForBlockIDsRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :type, 1, type: :string
  field :block_ids, 2, repeated: true, type: :bytes, json_name: "blockIds"
end

defmodule Access.EventsResponse.Result do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_id, 1, type: :bytes, json_name: "blockId"
  field :block_height, 2, type: :uint64, json_name: "blockHeight"
  field :events, 3, repeated: true, type: Entities.Event
end

defmodule Access.EventsResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :results, 1, repeated: true, type: Access.EventsResponse.Result
end

defmodule Access.GetNetworkParametersRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3
end

defmodule Access.GetNetworkParametersResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :chain_id, 1, type: :string, json_name: "chainId"
end

defmodule Access.AccessAPI.Service do
  @moduledoc false
  use GRPC.Service, name: "access.AccessAPI", protoc_gen_elixir_version: "0.11.0"

  rpc :Ping, Access.PingRequest, Access.PingResponse

  rpc :GetLatestBlockHeader, Access.GetLatestBlockHeaderRequest, Access.BlockHeaderResponse

  rpc :GetBlockHeaderByID, Access.GetBlockHeaderByIDRequest, Access.BlockHeaderResponse

  rpc :GetBlockHeaderByHeight, Access.GetBlockHeaderByHeightRequest, Access.BlockHeaderResponse

  rpc :GetLatestBlock, Access.GetLatestBlockRequest, Access.BlockResponse

  rpc :GetBlockByID, Access.GetBlockByIDRequest, Access.BlockResponse

  rpc :GetBlockByHeight, Access.GetBlockByHeightRequest, Access.BlockResponse

  rpc :GetCollectionByID, Access.GetCollectionByIDRequest, Access.CollectionResponse

  rpc :SendTransaction, Access.SendTransactionRequest, Access.SendTransactionResponse

  rpc :GetTransaction, Access.GetTransactionRequest, Access.TransactionResponse

  rpc :GetTransactionResult, Access.GetTransactionRequest, Access.TransactionResultResponse

  rpc :GetAccount, Access.GetAccountRequest, Access.GetAccountResponse

  rpc :GetAccountAtLatestBlock, Access.GetAccountAtLatestBlockRequest, Access.AccountResponse

  rpc :GetAccountAtBlockHeight, Access.GetAccountAtBlockHeightRequest, Access.AccountResponse

  rpc :ExecuteScriptAtLatestBlock,
      Access.ExecuteScriptAtLatestBlockRequest,
      Access.ExecuteScriptResponse

  rpc :ExecuteScriptAtBlockID, Access.ExecuteScriptAtBlockIDRequest, Access.ExecuteScriptResponse

  rpc :ExecuteScriptAtBlockHeight,
      Access.ExecuteScriptAtBlockHeightRequest,
      Access.ExecuteScriptResponse

  rpc :GetEventsForHeightRange, Access.GetEventsForHeightRangeRequest, Access.EventsResponse

  rpc :GetEventsForBlockIDs, Access.GetEventsForBlockIDsRequest, Access.EventsResponse

  rpc :GetNetworkParameters,
      Access.GetNetworkParametersRequest,
      Access.GetNetworkParametersResponse
end

defmodule Access.AccessAPI.Stub do
  @moduledoc false
  use GRPC.Stub, service: Access.AccessAPI.Service
end