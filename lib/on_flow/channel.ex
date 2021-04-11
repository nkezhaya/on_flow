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
  def connect do
    GenServer.call(__MODULE__, :connect)
  end

  @doc """
  Connects to the GRPC server asynchronously.
  """
  def connect_async do
    GenServer.cast(__MODULE__, :connect_async)
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

    connected? = connect_on_start?()

    channel =
      case arg do
        %GRPC.Channel{} -> arg
        _ -> if connected?, do: new_channel(), else: nil
      end

    state = %{channel: channel, connected?: connected?}

    {:ok, state}
  end

  @impl true
  def handle_call(:connect, _from, state) do
    channel = new_channel()
    {:reply, channel, %{state | channel: channel}}
  end

  def handle_call(:get_channel, _from, %{channel: channel} = state) do
    {:reply, channel, state}
  end

  @impl true
  def handle_cast(:connect_async, state) do
    {:noreply, %{state | channel: new_channel()}}
  end

  @impl true
  def handle_info(:ping, %{channel: nil} = state) do
    {:noreply, state}
  end

  def handle_info(:ping, %{channel: channel} = state) do
    request = OnFlow.Access.PingRequest.new()

    channel
    |> OnFlow.Access.AccessAPI.Stub.ping(request)
    |> handle_pong()

    schedule_ping()

    {:noreply, state}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end

  defp new_channel do
    {:ok, channel} = GRPC.Stub.connect(host())
    channel
  end

  defp schedule_ping do
    Process.send_after(self(), :ping, 60_000)
  end

  defp handle_pong({:ok, %OnFlow.Access.PingResponse{}}), do: :ok
  defp handle_pong(_error), do: connect_async()

  defp host do
    Application.get_env(:on_flow, :host)
  end

  defp connect_on_start? do
    Application.get_env(:on_flow, :connect_on_start, true)
  end
end
