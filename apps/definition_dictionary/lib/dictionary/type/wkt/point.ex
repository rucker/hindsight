defmodule Dictionary.Type.Wkt.Point do
  use Definition, schema: Dictionary.Type.Wkt.Point.V1
  use Dictionary.JsonEncoder

  defstruct version: 1,
            name: nil,
            description: ""

  defimpl Dictionary.Type.Normalizer, for: __MODULE__ do
    def normalize(_field, value) do
      case String.Chars.impl_for(value) do
        nil -> Ok.error(:invalid_string)
        _ -> value |> to_string |> String.trim() |> Ok.ok()
      end
    end
  end
end

defmodule Dictionary.Type.Wkt.Point.V1 do
  use Definition.Schema

  @impl true
  def s do
    schema(%Dictionary.Type.Wkt.Point{
      version: version(1),
      name: lowercase_string(),
      description: string()
    })
  end
end
