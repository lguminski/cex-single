defmodule MyTypes do
  use CyberOS.DSL, version: 1.0
  type(SensorProtocol, implements: DotVersionedType)
end

defmodule MyApplication do
  use CyberOS.DSL, version: 1.0
  alias MyTypes.SensorProtocol

  actor Sensor, type: Actor.OCIContainer do
    output(:api, spec: SensorProtocol.output_spec(version: 1.0))

    @impl true
    def initialize(_this) do
    end
  end

  composite ACA do
    param(:count, default: 18)

    @impl true
    def initialize(this) do
      for i <- 0..10,
          do: {:ok, _sensor} = add_component(this, "sensor #{i}", Sensor, [], [])
    end
  end
end
