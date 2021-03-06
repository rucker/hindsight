defmodule Persist.Load.Supervisor do
  use Management.Supervisor, name: __MODULE__

  import Definition, only: [identifier: 1]

  @impl Management.Supervisor
  def say_my_name(%Load{} = load) do
    Persist.Load.Registry.via(:"#{identifier(load)}")
  end

  @impl Management.Supervisor
  def on_start_child(%Load{} = load, name) do
    {Persist.Loader, load: load, name: name}
  end
end
