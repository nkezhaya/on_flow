defmodule OnFlow.Access.PingRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule OnFlow.Access.PingResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule OnFlow.Access.GetLatestBlockHeaderRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          is_sealed: boolean
        }

  defstruct [:is_sealed]

  field :is_sealed, 1, type: :bool
end

defmodule OnFlow.Access.GetBlockHeaderByIDRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: binary
        }

  defstruct [:id]

  field :id, 1, type: :bytes
end

defmodule OnFlow.Access.GetBlockHeaderByHeightRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          height: non_neg_integer
        }

  defstruct [:height]

  field :height, 1, type: :uint64
end

defmodule OnFlow.Access.BlockHeaderResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block: OnFlow.Entities.BlockHeader.t() | nil
        }

  defstruct [:block]

  field :block, 1, type: OnFlow.Entities.BlockHeader
end

defmodule OnFlow.Access.GetLatestBlockRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          is_sealed: boolean
        }

  defstruct [:is_sealed]

  field :is_sealed, 1, type: :bool
end

defmodule OnFlow.Access.GetBlockByIDRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: binary
        }

  defstruct [:id]

  field :id, 1, type: :bytes
end

defmodule OnFlow.Access.GetBlockByHeightRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          height: non_neg_integer
        }

  defstruct [:height]

  field :height, 1, type: :uint64
end

defmodule OnFlow.Access.BlockResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block: OnFlow.Entities.Block.t() | nil
        }

  defstruct [:block]

  field :block, 1, type: OnFlow.Entities.Block
end

defmodule OnFlow.Access.GetCollectionByIDRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: binary
        }

  defstruct [:id]

  field :id, 1, type: :bytes
end

defmodule OnFlow.Access.CollectionResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          collection: OnFlow.Entities.Collection.t() | nil
        }

  defstruct [:collection]

  field :collection, 1, type: OnFlow.Entities.Collection
end

defmodule OnFlow.Access.SendTransactionRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          transaction: OnFlow.Entities.Transaction.t() | nil
        }

  defstruct [:transaction]

  field :transaction, 1, type: OnFlow.Entities.Transaction
end

defmodule OnFlow.Access.SendTransactionResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: binary
        }

  defstruct [:id]

  field :id, 1, type: :bytes
end

defmodule OnFlow.Access.GetTransactionRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: binary
        }

  defstruct [:id]

  field :id, 1, type: :bytes
end

defmodule OnFlow.Access.TransactionResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          transaction: OnFlow.Entities.Transaction.t() | nil
        }

  defstruct [:transaction]

  field :transaction, 1, type: OnFlow.Entities.Transaction
end

defmodule OnFlow.Access.TransactionResultResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          status: OnFlow.Entities.TransactionStatus.t(),
          status_code: non_neg_integer,
          error_message: String.t(),
          events: [OnFlow.Entities.Event.t()],
          block_id: binary
        }

  defstruct [:status, :status_code, :error_message, :events, :block_id]

  field :status, 1, type: OnFlow.Entities.TransactionStatus, enum: true
  field :status_code, 2, type: :uint32
  field :error_message, 3, type: :string
  field :events, 4, repeated: true, type: OnFlow.Entities.Event
  field :block_id, 5, type: :bytes
end

defmodule OnFlow.Access.GetAccountRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: binary
        }

  defstruct [:address]

  field :address, 1, type: :bytes
end

defmodule OnFlow.Access.GetAccountResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          account: OnFlow.Entities.Account.t() | nil
        }

  defstruct [:account]

  field :account, 1, type: OnFlow.Entities.Account
end

defmodule OnFlow.Access.GetAccountAtLatestBlockRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: binary
        }

  defstruct [:address]

  field :address, 1, type: :bytes
end

defmodule OnFlow.Access.AccountResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          account: OnFlow.Entities.Account.t() | nil
        }

  defstruct [:account]

  field :account, 1, type: OnFlow.Entities.Account
end

defmodule OnFlow.Access.GetAccountAtBlockHeightRequest do
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

defmodule OnFlow.Access.ExecuteScriptAtLatestBlockRequest do
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

defmodule OnFlow.Access.ExecuteScriptAtBlockIDRequest do
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

defmodule OnFlow.Access.ExecuteScriptAtBlockHeightRequest do
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

defmodule OnFlow.Access.ExecuteScriptResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: binary
        }

  defstruct [:value]

  field :value, 1, type: :bytes
end

defmodule OnFlow.Access.GetEventsForHeightRangeRequest do
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

defmodule OnFlow.Access.GetEventsForBlockIDsRequest do
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

defmodule OnFlow.Access.EventsResponse.Result do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block_id: binary,
          block_height: non_neg_integer,
          events: [OnFlow.Entities.Event.t()],
          block_timestamp: Google.Protobuf.Timestamp.t() | nil
        }

  defstruct [:block_id, :block_height, :events, :block_timestamp]

  field :block_id, 1, type: :bytes
  field :block_height, 2, type: :uint64
  field :events, 3, repeated: true, type: OnFlow.Entities.Event
  field :block_timestamp, 4, type: Google.Protobuf.Timestamp
end

defmodule OnFlow.Access.EventsResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          results: [OnFlow.Access.EventsResponse.Result.t()]
        }

  defstruct [:results]

  field :results, 1, repeated: true, type: OnFlow.Access.EventsResponse.Result
end

defmodule OnFlow.Access.GetNetworkParametersRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule OnFlow.Access.GetNetworkParametersResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          chain_id: String.t()
        }

  defstruct [:chain_id]

  field :chain_id, 1, type: :string
end

defmodule OnFlow.Access.GetLatestProtocolStateSnapshotRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule OnFlow.Access.ProtocolStateSnapshotResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          serializedSnapshot: binary
        }

  defstruct [:serializedSnapshot]

  field :serializedSnapshot, 1, type: :bytes
end

defmodule OnFlow.Access.AccessAPI.Service do
  @moduledoc false
  use GRPC.Service, name: "flow.access.AccessAPI"

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
end

defmodule OnFlow.Access.AccessAPI.Stub do
  @moduledoc false
  use GRPC.Stub, service: OnFlow.Access.AccessAPI.Service
end
