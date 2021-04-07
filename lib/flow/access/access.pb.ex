defmodule Flow.Access.PingRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Flow.Access.PingResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Flow.Access.GetLatestBlockHeaderRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          is_sealed: boolean
        }

  defstruct [:is_sealed]

  field :is_sealed, 1, type: :bool
end

defmodule Flow.Access.GetBlockHeaderByIDRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: binary
        }

  defstruct [:id]

  field :id, 1, type: :bytes
end

defmodule Flow.Access.GetBlockHeaderByHeightRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          height: non_neg_integer
        }

  defstruct [:height]

  field :height, 1, type: :uint64
end

defmodule Flow.Access.BlockHeaderResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block: Flow.Entities.BlockHeader.t() | nil
        }

  defstruct [:block]

  field :block, 1, type: Flow.Entities.BlockHeader
end

defmodule Flow.Access.GetLatestBlockRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          is_sealed: boolean
        }

  defstruct [:is_sealed]

  field :is_sealed, 1, type: :bool
end

defmodule Flow.Access.GetBlockByIDRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: binary
        }

  defstruct [:id]

  field :id, 1, type: :bytes
end

defmodule Flow.Access.GetBlockByHeightRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          height: non_neg_integer
        }

  defstruct [:height]

  field :height, 1, type: :uint64
end

defmodule Flow.Access.BlockResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block: Flow.Entities.Block.t() | nil
        }

  defstruct [:block]

  field :block, 1, type: Flow.Entities.Block
end

defmodule Flow.Access.GetCollectionByIDRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: binary
        }

  defstruct [:id]

  field :id, 1, type: :bytes
end

defmodule Flow.Access.CollectionResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          collection: Flow.Entities.Collection.t() | nil
        }

  defstruct [:collection]

  field :collection, 1, type: Flow.Entities.Collection
end

defmodule Flow.Access.SendTransactionRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          transaction: Flow.Entities.Transaction.t() | nil
        }

  defstruct [:transaction]

  field :transaction, 1, type: Flow.Entities.Transaction
end

defmodule Flow.Access.SendTransactionResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: binary
        }

  defstruct [:id]

  field :id, 1, type: :bytes
end

defmodule Flow.Access.GetTransactionRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: binary
        }

  defstruct [:id]

  field :id, 1, type: :bytes
end

defmodule Flow.Access.TransactionResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          transaction: Flow.Entities.Transaction.t() | nil
        }

  defstruct [:transaction]

  field :transaction, 1, type: Flow.Entities.Transaction
end

defmodule Flow.Access.TransactionResultResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          status: Flow.Entities.TransactionStatus.t(),
          status_code: non_neg_integer,
          error_message: String.t(),
          events: [Flow.Entities.Event.t()],
          block_id: binary
        }

  defstruct [:status, :status_code, :error_message, :events, :block_id]

  field :status, 1, type: Flow.Entities.TransactionStatus, enum: true
  field :status_code, 2, type: :uint32
  field :error_message, 3, type: :string
  field :events, 4, repeated: true, type: Flow.Entities.Event
  field :block_id, 5, type: :bytes
end

defmodule Flow.Access.GetAccountRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: binary
        }

  defstruct [:address]

  field :address, 1, type: :bytes
end

defmodule Flow.Access.GetAccountResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          account: Flow.Entities.Account.t() | nil
        }

  defstruct [:account]

  field :account, 1, type: Flow.Entities.Account
end

defmodule Flow.Access.GetAccountAtLatestBlockRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: binary
        }

  defstruct [:address]

  field :address, 1, type: :bytes
end

defmodule Flow.Access.AccountResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          account: Flow.Entities.Account.t() | nil
        }

  defstruct [:account]

  field :account, 1, type: Flow.Entities.Account
end

defmodule Flow.Access.GetAccountAtBlockHeightRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: binary,
          block_height: non_neg_integer
        }

  defstruct [:address, :block_height]

  field :address, 1, type: :bytes
  field :block_height, 2, type: :uint64
end

defmodule Flow.Access.ExecuteScriptAtLatestBlockRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          script: binary,
          arguments: [binary]
        }

  defstruct [:script, :arguments]

  field :script, 1, type: :bytes
  field :arguments, 2, repeated: true, type: :bytes
end

defmodule Flow.Access.ExecuteScriptAtBlockIDRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block_id: binary,
          script: binary,
          arguments: [binary]
        }

  defstruct [:block_id, :script, :arguments]

  field :block_id, 1, type: :bytes
  field :script, 2, type: :bytes
  field :arguments, 3, repeated: true, type: :bytes
end

defmodule Flow.Access.ExecuteScriptAtBlockHeightRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block_height: non_neg_integer,
          script: binary,
          arguments: [binary]
        }

  defstruct [:block_height, :script, :arguments]

  field :block_height, 1, type: :uint64
  field :script, 2, type: :bytes
  field :arguments, 3, repeated: true, type: :bytes
end

defmodule Flow.Access.ExecuteScriptResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: binary
        }

  defstruct [:value]

  field :value, 1, type: :bytes
end

defmodule Flow.Access.GetEventsForHeightRangeRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          type: String.t(),
          start_height: non_neg_integer,
          end_height: non_neg_integer
        }

  defstruct [:type, :start_height, :end_height]

  field :type, 1, type: :string
  field :start_height, 2, type: :uint64
  field :end_height, 3, type: :uint64
end

defmodule Flow.Access.GetEventsForBlockIDsRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          type: String.t(),
          block_ids: [binary]
        }

  defstruct [:type, :block_ids]

  field :type, 1, type: :string
  field :block_ids, 2, repeated: true, type: :bytes
end

defmodule Flow.Access.EventsResponse.Result do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block_id: binary,
          block_height: non_neg_integer,
          events: [Flow.Entities.Event.t()],
          block_timestamp: Google.Protobuf.Timestamp.t() | nil
        }

  defstruct [:block_id, :block_height, :events, :block_timestamp]

  field :block_id, 1, type: :bytes
  field :block_height, 2, type: :uint64
  field :events, 3, repeated: true, type: Flow.Entities.Event
  field :block_timestamp, 4, type: Google.Protobuf.Timestamp
end

defmodule Flow.Access.EventsResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          results: [Flow.Access.EventsResponse.Result.t()]
        }

  defstruct [:results]

  field :results, 1, repeated: true, type: Flow.Access.EventsResponse.Result
end

defmodule Flow.Access.GetNetworkParametersRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Flow.Access.GetNetworkParametersResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          chain_id: String.t()
        }

  defstruct [:chain_id]

  field :chain_id, 1, type: :string
end

defmodule Flow.Access.GetLatestProtocolStateSnapshotRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Flow.Access.ProtocolStateSnapshotResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          serializedSnapshot: binary
        }

  defstruct [:serializedSnapshot]

  field :serializedSnapshot, 1, type: :bytes
end

defmodule Flow.Access.AccessAPI.Service do
  @moduledoc false
  use GRPC.Service, name: "flow.access.AccessAPI"

  rpc :Ping, Flow.Access.PingRequest, Flow.Access.PingResponse

  rpc :GetLatestBlockHeader,
      Flow.Access.GetLatestBlockHeaderRequest,
      Flow.Access.BlockHeaderResponse

  rpc :GetBlockHeaderByID, Flow.Access.GetBlockHeaderByIDRequest, Flow.Access.BlockHeaderResponse

  rpc :GetBlockHeaderByHeight,
      Flow.Access.GetBlockHeaderByHeightRequest,
      Flow.Access.BlockHeaderResponse

  rpc :GetLatestBlock, Flow.Access.GetLatestBlockRequest, Flow.Access.BlockResponse

  rpc :GetBlockByID, Flow.Access.GetBlockByIDRequest, Flow.Access.BlockResponse

  rpc :GetBlockByHeight, Flow.Access.GetBlockByHeightRequest, Flow.Access.BlockResponse

  rpc :GetCollectionByID, Flow.Access.GetCollectionByIDRequest, Flow.Access.CollectionResponse

  rpc :SendTransaction, Flow.Access.SendTransactionRequest, Flow.Access.SendTransactionResponse

  rpc :GetTransaction, Flow.Access.GetTransactionRequest, Flow.Access.TransactionResponse

  rpc :GetTransactionResult,
      Flow.Access.GetTransactionRequest,
      Flow.Access.TransactionResultResponse

  rpc :GetAccount, Flow.Access.GetAccountRequest, Flow.Access.GetAccountResponse

  rpc :GetAccountAtLatestBlock,
      Flow.Access.GetAccountAtLatestBlockRequest,
      Flow.Access.AccountResponse

  rpc :GetAccountAtBlockHeight,
      Flow.Access.GetAccountAtBlockHeightRequest,
      Flow.Access.AccountResponse

  rpc :ExecuteScriptAtLatestBlock,
      Flow.Access.ExecuteScriptAtLatestBlockRequest,
      Flow.Access.ExecuteScriptResponse

  rpc :ExecuteScriptAtBlockID,
      Flow.Access.ExecuteScriptAtBlockIDRequest,
      Flow.Access.ExecuteScriptResponse

  rpc :ExecuteScriptAtBlockHeight,
      Flow.Access.ExecuteScriptAtBlockHeightRequest,
      Flow.Access.ExecuteScriptResponse

  rpc :GetEventsForHeightRange,
      Flow.Access.GetEventsForHeightRangeRequest,
      Flow.Access.EventsResponse

  rpc :GetEventsForBlockIDs, Flow.Access.GetEventsForBlockIDsRequest, Flow.Access.EventsResponse

  rpc :GetNetworkParameters,
      Flow.Access.GetNetworkParametersRequest,
      Flow.Access.GetNetworkParametersResponse

  rpc :GetLatestProtocolStateSnapshot,
      Flow.Access.GetLatestProtocolStateSnapshotRequest,
      Flow.Access.ProtocolStateSnapshotResponse
end

defmodule Flow.Access.AccessAPI.Stub do
  @moduledoc false
  use GRPC.Stub, service: Flow.Access.AccessAPI.Service
end
