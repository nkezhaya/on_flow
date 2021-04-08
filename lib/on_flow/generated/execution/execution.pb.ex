defmodule OnFlow.Execution.PingRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule OnFlow.Execution.PingResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule OnFlow.Execution.GetAccountAtBlockIDRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block_id: binary,
          address: binary
        }

  defstruct [:block_id, :address]

  field :block_id, 1, type: :bytes
  field :address, 2, type: :bytes
end

defmodule OnFlow.Execution.GetAccountAtBlockIDResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          account: OnFlow.Entities.Account.t() | nil
        }

  defstruct [:account]

  field :account, 1, type: OnFlow.Entities.Account
end

defmodule OnFlow.Execution.ExecuteScriptAtBlockIDRequest do
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

defmodule OnFlow.Execution.ExecuteScriptAtBlockIDResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: binary
        }

  defstruct [:value]

  field :value, 1, type: :bytes
end

defmodule OnFlow.Execution.GetEventsForBlockIDsResponse.Result do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block_id: binary,
          block_height: non_neg_integer,
          events: [OnFlow.Entities.Event.t()]
        }

  defstruct [:block_id, :block_height, :events]

  field :block_id, 1, type: :bytes
  field :block_height, 2, type: :uint64
  field :events, 3, repeated: true, type: OnFlow.Entities.Event
end

defmodule OnFlow.Execution.GetEventsForBlockIDsResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          results: [OnFlow.Execution.GetEventsForBlockIDsResponse.Result.t()]
        }

  defstruct [:results]

  field :results, 1, repeated: true, type: OnFlow.Execution.GetEventsForBlockIDsResponse.Result
end

defmodule OnFlow.Execution.GetEventsForBlockIDsRequest do
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

defmodule OnFlow.Execution.GetTransactionResultRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block_id: binary,
          transaction_id: binary
        }

  defstruct [:block_id, :transaction_id]

  field :block_id, 1, type: :bytes
  field :transaction_id, 2, type: :bytes
end

defmodule OnFlow.Execution.GetTransactionResultResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          status_code: non_neg_integer,
          error_message: String.t(),
          events: [OnFlow.Entities.Event.t()]
        }

  defstruct [:status_code, :error_message, :events]

  field :status_code, 1, type: :uint32
  field :error_message, 2, type: :string
  field :events, 3, repeated: true, type: OnFlow.Entities.Event
end

defmodule OnFlow.Execution.ExecutionAPI.Service do
  @moduledoc false
  use GRPC.Service, name: "flow.execution.ExecutionAPI"

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
end

defmodule OnFlow.Execution.ExecutionAPI.Stub do
  @moduledoc false
  use GRPC.Stub, service: OnFlow.Execution.ExecutionAPI.Service
end
