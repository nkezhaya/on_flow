defmodule OnFlow.JSONCDC do
  @moduledoc """
  Decodes the JSON-CDC event values into Elixir terms.
  """

  @byte_sizes ~w(8 16 32 64 256)
  @integer_types for(type <- ~w(UInt Int Word), size <- @byte_sizes, do: type <> size)
  @float_types ~w(Fix64 UFix64)
  @literal_types ~w(String Bool Address)
  @composite_types ~w(Struct Resource Event Contract Enum)

  # Initialize atoms
  Enum.map(@composite_types, &(String.downcase(&1) |> String.to_atom()))

  @type encodable() :: String.t() | %{required(String.t()) => nil | String.t()}
  @spec decode!(encodable()) :: term()
  def decode!(event) do
    case decode(event) do
      {:ok, decoded_event} -> decoded_event
      :error -> raise "Could not decode: #{inspect(event)}"
    end
  end

  @spec decode(encodable()) :: {:ok, term()} | :error
  def decode(json) when is_binary(json) do
    case Jason.decode(json) do
      {:ok, encodable} ->
        case decode(encodable) do
          :error -> :error
          decoded -> {:ok, decoded}
        end

      _ ->
        :error
    end
  end

  def decode(%{"value" => nil}), do: nil
  def decode(%{"type" => "Void"}), do: nil
  def decode(%{"type" => "Optional", "value" => value}), do: decode(value)

  def decode(%{"type" => type, "value" => value}) when type in @literal_types,
    do: value

  def decode(%{"type" => type, "value" => value}) when type in @integer_types,
    do: String.to_integer(value)

  def decode(%{"type" => type, "value" => value}) when type in @float_types,
    do: String.to_float(value)

  def decode(%{"type" => "Array", "value" => value}), do: Enum.map(value, &decode/1)

  def decode(%{"type" => "Dictionary", "value" => values}) do
    for %{"key" => key, "value" => value} <- values, into: %{} do
      {decode(key), decode(value)}
    end
  end

  def decode(%{"type" => type, "value" => value}) when type in @composite_types do
    # "Struct" -> :struct
    type = type |> String.downcase() |> String.to_existing_atom()
    %{"fields" => fields} = value

    fields =
      for %{"name" => name, "value" => value} <- fields, into: %{} do
        {name, decode(value)}
      end

    {type, %{value | "fields" => fields}}
  end

  def decode(%{"type" => "Path", "value" => %{"domain" => domain, "identifier" => identifier}}),
    do: {:path, domain, identifier}

  def decode(%{"type" => "Type", "value" => %{"staticType" => type}}),
    do: {:type, type}

  def decode(%{"type" => "Capability", "value" => value}) do
    %{"path" => path, "address" => address, "borrowType" => borrow_type} = value
    {:capability, %{path: path, address: address, borrow_type: borrow_type}}
  end

  def decode(_event) do
    :error
  end
end
