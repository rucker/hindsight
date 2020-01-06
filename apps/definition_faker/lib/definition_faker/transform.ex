defmodule DefinitionFaker.Transform do
	@moduledoc false

  def default do
    %{
      version: 1,
      id: Faker.UUID.v4(),
      dataset_id: Faker.UUID.v4(),
      dictionary: [],
      steps: []
    }
  end
end
