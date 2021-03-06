defmodule Dataset.V1 do
  @moduledoc """
  Defines the dataset implementation of the
  `Definition.Schema` behaviour and the
  dataset `s/0` function.

  Returns a valid Norm schema representing a
  dataset for validation and defaults the current
  struct version.
  """
  use Definition.Schema

  @impl true
  def s do
    schema(%Dataset{
      version: version(1),
      id: id(),
      owner_id: id(),
      name: required_string(),
      description: string(),
      keywords: spec(is_list()),
      license: required_string(),
      created_ts: spec(ts?()),
      profile:
        schema(%{
          updated_ts: optional_ts(),
          profiled_ts: optional_ts(),
          modified_ts: optional_ts(),
          spatial: optional_bbox(),
          temporal: optional_range()
        })
    })
  end

  defp optional_ts, do: spec(empty?() or ts?())
  defp optional_bbox, do: spec((is_list() and empty?()) or bbox?())
  defp optional_range, do: spec((is_list() and empty?()) or temporal_range?())
end
