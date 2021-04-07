defmodule Execution.PingRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Execution.PingResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Execution.GetAccountAtBlockIDRequest do
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

defmodule Execution.GetAccountAtBlockIDResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          account: Entities.Account.t() | nil
        }

  defstruct [:account]

  field :account, 1, type: Entities.Account
end

defmodule Execution.ExecuteScriptAtBlockIDRequest do
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

defmodule Execution.ExecuteScriptAtBlockIDResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: binary
        }

  defstruct [:value]

  field :value, 1, type: :bytes
end

defmodule Execution.GetEventsForBlockIDsResponse.Result do
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

defmodule Execution.GetEventsForBlockIDsResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          results: [Execution.GetEventsForBlockIDsResponse.Result.t()]
        }

  defstruct [:results]

  field :results, 1, repeated: true, type: Execution.GetEventsForBlockIDsResponse.Result
end

defmodule Execution.GetEventsForBlockIDsRequest do
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

defmodule Execution.GetTransactionResultRequest do
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

defmodule Execution.GetTransactionResultResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          status_code: non_neg_integer,
          error_message: String.t(),
          events: [Entities.Event.t()]
        }

  defstruct [:status_code, :error_message, :events]

  field :status_code, 1, type: :uint32
  field :error_message, 2, type: :string
  field :events, 3, repeated: true, type: Entities.Event
end

defmodule Execution.ExecutionAPI.Service do
  @moduledoc false
  use GRPC.Service, name: "execution.ExecutionAPI"

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
