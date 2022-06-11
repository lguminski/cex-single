defmodule MyTypes do
  use CyberOS.DSL
  type(SensorProtocol, implements: SemanticVersioning)
end

defmodule MyApplication do
  use CyberOS.DSL
  alias MyTypes.SensorProtocol

  actor Sensor, type: Actor.OCIContainer do
    output("api", spec: SensorProtocol.output_spec("1.0.0"))

    @impl true
    def initialize(_this) do
    end
  end

  composite ACA do
    param("count", default: 10)

    @impl true
    def initialize(this) do
      for i <- 0..get_parameter_value(this, "count"),
          do: {:ok, _sensor} = add_component(this, "sensor #{i}", Sensor, %{}, %{})
    end
  end
end
