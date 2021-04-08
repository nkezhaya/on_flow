defmodule OnFlow.Channel do
  @moduledoc false
  use GenServer

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def connect do
    GenServer.call(__MODULE__, :connect)
  end

  def cast_reconnect do
    GenServer.cast(__MODULE__, :reconnect)
  end

  def get_channel do
    GenServer.call(__MODULE__, :get_channel)
  end

  @impl true
  def init(arg) do
    schedule_ping()

    channel =
      case arg do
        %GRPC.Channel{} -> arg
        _ -> new_channel()
      end

    {:ok, channel}
  end

  @impl true
  def handle_call(:connect, _from, _channel) do
    channel = new_channel()
    {:reply, channel, channel}
  end

  def handle_call(:get_channel, _from, channel) do
    {:reply, channel, channel}
  end

  @impl true
  def handle_cast(:reconnect, _channel) do
    channel = new_channel()
    {:noreply, channel}
  end

  @impl true
  def handle_info(:ping, channel) do
    request = OnFlow.Access.PingRequest.new()

    channel
    |> OnFlow.Access.AccessAPI.Stub.ping(request)
    |> handle_ping_response()

    schedule_ping()

    {:noreply, channel}
  end

  def handle_info(_msg, channel) do
    {:noreply, channel}
  end

  defp new_channel do
    {:ok, channel} = GRPC.Stub.connect(host())
    channel
  end

  defp schedule_ping do
    Process.send_after(self(), :ping, 60_000)
  end

  defp handle_ping_response({:ok, %OnFlow.Access.PingResponse{}}), do: :ok
  defp handle_ping_response(_error), do: cast_reconnect()

  defp host do
    Application.get_env(:on_flow, :host)
  end
end
