defmodule MyTypes do
  use CyberOS.DSL, version: 1.0
  type(MySQL, implements: VersionedType)
end

defmodule MyApplication do
  use CyberOS.DSL, version: 1.0

  alias MyTypes.{MySQL}

  actor DatabaseProvider, type: Actor.OCIContainer do
    output(:mysql12, type: MySQL.define(version: 8.0))

    @impl true
    def initialize(_this) do
    end
  end

  main do
    param(:count, default: 18)

    @impl true
    def initialize(this) do
      for i <- 0..10,
          do:
            {:ok, _database_provider} =
              add_component(this, "database#{i}", DatabaseProvider, [], [])
    end
  end
end
