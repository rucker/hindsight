defmodule Persist.Init do
  use Initializer,
    name: __MODULE__,
    supervisor: Persist.Load.Supervisor

  def on_start(state) do
    Persist.Load.Store.get_all!()
    |> Enum.map(fn load -> {load, Persist.Load.Store.is_being_compacted?(load)} end)
    |> Enum.each(&start/1)

    {:ok, state}
  end

  defp start({load, false = _compacted?}) do
    Persist.Load.Supervisor.start_child({Persist.Loader, load: load})
  end

  defp start({load, true = _compacted?}) do
    Persist.Compact.Supervisor.start_child({Persist.Compaction, load: load})
  end
end
