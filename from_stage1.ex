defmodule FromStage1 do
  use CyberOS.DSL
  require Types
  require FromSupplier1
  alias Types.T17
  alias FromSupplier1.Supplier1

  actor A do
    output("u", spec: T17.output_spec())
  end

  composite Stage1 do
    output("a")
    output("b")
    output("p")

    @impl true
    def initialize(this) do
      {:ok, a} = add_component(this, "A", A, %{}, %{})

      {:ok, supplier1} =
        add_component(this, "Supplier 1", Supplier1, %{}, %{"u" => pin_output(a, "u")})

      expose_output(this, pin_output(supplier1, "a"))
      expose_output(this, pin_output(supplier1, "b"))
      expose_output(this, pin_output(supplier1, "p"))
    end
  end
end
