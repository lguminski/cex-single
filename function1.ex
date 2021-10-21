defmodule MyTypes do
  use CyberOS.DSL, version: 1.0
  type(MySQL, implements: VersionedType)
end

defmodule MyApplication do
  use CyberOS.DSL, version: 1.0

  alias MyTypes.{MySQL}

  function DatabaseProvider, type: Function.DockerService do
    output(:mysql12, type: MySQL.define(version: 8.0))

    @impl true
    def initialize_docker(_this) do
    end
  end

  main do
    param(:count, default: 18)

    @impl true
    def initialize_composite(this) do
      for i <- 0..10,
          do:
            {:ok, _database_provider} =
              add_component(this, "database#{i}", DatabaseProvider, [], [])
    end

    @impl true
    def initialize_application(_this) do
      Logger.debug("application #{inspect(Application.get_application(__MODULE__))}")
      #      set_author(this, "Arnold S", "arnold@hotmail.com")
      # 			set_version(this, "0.2.0")
    end
  end
end
