defmodule Access.PingRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Access.PingResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Access.GetLatestBlockHeaderRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          is_sealed: boolean
        }

  defstruct [:is_sealed]

  field :is_sealed, 1, type: :bool
end

defmodule Access.GetBlockHeaderByIDRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: binary
        }

  defstruct [:id]

  field :id, 1, type: :bytes
end

defmodule Access.GetBlockHeaderByHeightRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          height: non_neg_integer
        }

  defstruct [:height]

  field :height, 1, type: :uint64
end

defmodule Access.BlockHeaderResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block: Entities.BlockHeader.t() | nil
        }

  defstruct [:block]

  field :block, 1, type: Entities.BlockHeader
end

defmodule Access.GetLatestBlockRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          is_sealed: boolean
        }

  defstruct [:is_sealed]

  field :is_sealed, 1, type: :bool
end

defmodule Access.GetBlockByIDRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: binary
        }

  defstruct [:id]

  field :id, 1, type: :bytes
end

defmodule Access.GetBlockByHeightRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          height: non_neg_integer
        }

  defstruct [:height]

  field :height, 1, type: :uint64
end

defmodule Access.BlockResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block: Entities.Block.t() | nil
        }

  defstruct [:block]

  field :block, 1, type: Entities.Block
end

defmodule Access.GetCollectionByIDRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: binary
        }

  defstruct [:id]

  field :id, 1, type: :bytes
end

defmodule Access.CollectionResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          collection: Entities.Collection.t() | nil
        }

  defstruct [:collection]

  field :collection, 1, type: Entities.Collection
end

defmodule Access.SendTransactionRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          transaction: Entities.Transaction.t() | nil
        }

  defstruct [:transaction]

  field :transaction, 1, type: Entities.Transaction
end

defmodule Access.SendTransactionResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: binary
        }

  defstruct [:id]

  field :id, 1, type: :bytes
end

defmodule Access.GetTransactionRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: binary
        }

  defstruct [:id]

  field :id, 1, type: :bytes
end

defmodule Access.TransactionResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          transaction: Entities.Transaction.t() | nil
        }

  defstruct [:transaction]

  field :transaction, 1, type: Entities.Transaction
end

defmodule Access.TransactionResultResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          status: Entities.TransactionStatus.t(),
          status_code: non_neg_integer,
          error_message: String.t(),
          events: [Entities.Event.t()]
        }

  defstruct [:status, :status_code, :error_message, :events]

  field :status, 1, type: Entities.TransactionStatus, enum: true
  field :status_code, 2, type: :uint32
  field :error_message, 3, type: :string
  field :events, 4, repeated: true, type: Entities.Event
end

defmodule Access.GetAccountRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: binary
        }

  defstruct [:address]

  field :address, 1, type: :bytes
end

defmodule Access.GetAccountResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          account: Entities.Account.t() | nil
        }

  defstruct [:account]

  field :account, 1, type: Entities.Account
end

defmodule Access.GetAccountAtLatestBlockRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: binary
        }

  defstruct [:address]

  field :address, 1, type: :bytes
end

defmodule Access.AccountResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          account: Entities.Account.t() | nil
        }

  defstruct [:account]

  field :account, 1, type: Entities.Account
end

defmodule Access.GetAccountAtBlockHeightRequest do
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

defmodule Access.ExecuteScriptAtLatestBlockRequest do
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

defmodule Access.ExecuteScriptAtBlockIDRequest do
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

defmodule Access.ExecuteScriptAtBlockHeightRequest do
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

defmodule Access.ExecuteScriptResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: binary
        }

  defstruct [:value]

  field :value, 1, type: :bytes
end

defmodule Access.GetEventsForHeightRangeRequest do
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

defmodule Access.GetEventsForBlockIDsRequest do
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

defmodule Access.EventsResponse.Result do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block_id: binary,
          block_height: non_neg_integer,
          events: [Entities.Event.t()]
        }

  defstruct [:block_id, :block_height, :events]

  field :block_id, 1, type: :bytes
  field :block_height, 2, type: :uint64
  field :events, 3, repeated: true, type: Entities.Event
end

defmodule Access.EventsResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          results: [Access.EventsResponse.Result.t()]
        }

  defstruct [:results]

  field :results, 1, repeated: true, type: Access.EventsResponse.Result
end

defmodule Access.GetNetworkParametersRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Access.GetNetworkParametersResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          chain_id: String.t()
        }

  defstruct [:chain_id]

  field :chain_id, 1, type: :string
end

defmodule Access.AccessAPI.Service do
  @moduledoc false
  use GRPC.Service, name: "access.AccessAPI"

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
