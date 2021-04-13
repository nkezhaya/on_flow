defmodule OnFlow.Emulator do
  use GenServer
  require Logger

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    priv = :code.priv_dir(:on_flow) |> to_string()
    zombie = Path.join(priv, "zombie.sh")
    config = Path.join(priv, "flow.json")
    {flow, _} = System.cmd("which", ["flow"])
    flow = String.trim(flow)
    args = [flow, "emulator", "start", "-f", config]

    port = Port.open({:spawn_executable, zombie}, [:binary, args: args])

    :timer.sleep(500)

    OnFlow.Channel.connect()

    {:ok, port}
  end

  @impl true
  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
