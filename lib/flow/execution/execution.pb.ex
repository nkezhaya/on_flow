defmodule Flow.Execution.PingRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Flow.Execution.PingResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Flow.Execution.GetAccountAtBlockIDRequest do
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

defmodule Flow.Execution.GetAccountAtBlockIDResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          account: Flow.Entities.Account.t() | nil
        }

  defstruct [:account]

  field :account, 1, type: Flow.Entities.Account
end

defmodule Flow.Execution.ExecuteScriptAtBlockIDRequest do
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

defmodule Flow.Execution.ExecuteScriptAtBlockIDResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: binary
        }

  defstruct [:value]

  field :value, 1, type: :bytes
end

defmodule Flow.Execution.GetEventsForBlockIDsResponse.Result do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block_id: binary,
          block_height: non_neg_integer,
          events: [Flow.Entities.Event.t()]
        }

  defstruct [:block_id, :block_height, :events]

  field :block_id, 1, type: :bytes
  field :block_height, 2, type: :uint64
  field :events, 3, repeated: true, type: Flow.Entities.Event
end

defmodule Flow.Execution.GetEventsForBlockIDsResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          results: [Flow.Execution.GetEventsForBlockIDsResponse.Result.t()]
        }

  defstruct [:results]

  field :results, 1, repeated: true, type: Flow.Execution.GetEventsForBlockIDsResponse.Result
end

defmodule Flow.Execution.GetEventsForBlockIDsRequest do
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

defmodule Flow.Execution.GetTransactionResultRequest do
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

defmodule Flow.Execution.GetTransactionResultResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          status_code: non_neg_integer,
          error_message: String.t(),
          events: [Flow.Entities.Event.t()]
        }

  defstruct [:status_code, :error_message, :events]

  field :status_code, 1, type: :uint32
  field :error_message, 2, type: :string
  field :events, 3, repeated: true, type: Flow.Entities.Event
end

defmodule Flow.Execution.ExecutionAPI.Service do
  @moduledoc false
  use GRPC.Service, name: "flow.execution.ExecutionAPI"

  rpc :Ping, Flow.Execution.PingRequest, Flow.Execution.PingResponse

  rpc :GetAccountAtBlockID,
      Flow.Execution.GetAccountAtBlockIDRequest,
      Flow.Execution.GetAccountAtBlockIDResponse

  rpc :ExecuteScriptAtBlockID,
      Flow.Execution.ExecuteScriptAtBlockIDRequest,
      Flow.Execution.ExecuteScriptAtBlockIDResponse

  rpc :GetEventsForBlockIDs,
      Flow.Execution.GetEventsForBlockIDsRequest,
      Flow.Execution.GetEventsForBlockIDsResponse

  rpc :GetTransactionResult,
      Flow.Execution.GetTransactionResultRequest,
      Flow.Execution.GetTransactionResultResponse
end

defmodule Flow.Execution.ExecutionAPI.Stub do
  @moduledoc false
  use GRPC.Stub, service: Flow.Execution.ExecutionAPI.Service
end
