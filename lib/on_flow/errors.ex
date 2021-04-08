defmodule OnFlow.MissingKeysError do
  defexception [:message]

  @impl true
  def exception(attrs) do
    message = """
    Expected a map with `:public_key` and `:private_key`, instead received:

      #{inspect(attrs)}
    """

    %__MODULE__{message: message}
  end
end
