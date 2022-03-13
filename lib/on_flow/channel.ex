defmodule OnFlow.Channel do
  use GenServer

  @doc false
  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @doc """
  Connects to the GRPC server. Blocks the process until a connection is
  established.
  """
  def connect(host \\ host(), opts \\ default_opts()) do
    GenServer.call(__MODULE__, {:connect, host, opts})
  end

  @doc """
  Connects to the GRPC server asynchronously.
  """
  def connect_async(host \\ host(), opts \\ default_opts()) do
    GenServer.cast(__MODULE__, {:connect_async, host, opts})
  end

  @doc """
  Returns the current GRPC channel.
  """
  def get_channel do
    GenServer.call(__MODULE__, :get_channel)
  end

  @doc """
  Sets the current GRPC channel. OnFlow will pull the channel from this
  GenServer to make requests, so use this to manage the channel manually if
  needed.
  """
  def put_channel(%GRPC.Channel{} = channel) do
    GenServer.call(__MODULE__, {:put_channel, channel})
  end

  @impl true
  def init(arg) do
    schedule_ping()

    connect? = connect_on_start?()

    channel =
      case arg do
        %GRPC.Channel{} -> arg
        _ -> if connect?, do: new_channel(host(), default_opts()), else: nil
      end

    state = %{channel: channel, connected?: connect?}

    {:ok, state}
  end

  @impl true
  def handle_call({:connect, host, opts}, _from, state) do
    channel = new_channel(host, opts)
    {:reply, channel, %{state | channel: channel}}
  end

  def handle_call(:get_channel, _from, %{channel: channel} = state) do
    {:reply, channel, state}
  end

  @impl true
  def handle_cast({:connect_async, host, opts}, state) do
    {:noreply, %{state | channel: new_channel(host, opts)}}
  end

  @impl true
  def handle_info(:ping, %{channel: nil} = state) do
    {:noreply, state}
  end

  def handle_info(:ping, %{channel: channel} = state) do
    request = OnFlow.Access.PingRequest.new()

    channel
    |> OnFlow.Access.AccessAPI.Stub.ping(request, default_opts())
    |> handle_pong()

    schedule_ping()

    {:noreply, state}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end

  defp new_channel(host, opts) do
    {:ok, channel} = GRPC.Stub.connect(host, opts)
    channel
  end

  defp default_opts do
    case metadata() do
      nil -> []
      metadata -> [metadata: metadata]
    end
  end

  defp schedule_ping do
    Process.send_after(self(), :ping, 60_000)
  end

  defp handle_pong({:ok, %OnFlow.Access.PingResponse{}}), do: :ok
  defp handle_pong(_error), do: connect_async()

  defp host, do: Application.get_env(:on_flow, :host)
  defp connect_on_start?, do: Application.get_env(:on_flow, :connect_on_start, true)
  defp metadata, do: Application.get_env(:on_flow, :metadata)
end
