defmodule FromStage2 do
  use CyberOS.DSL
  require Types
  require FromSupplier2
  require FromSupplier3
  alias Types.T4
  alias Types.T7
  alias Types.T11
  alias FromSupplier2.Supplier2
  alias FromSupplier3.Supplier3

  actor H do
    input("j", spec: T7.input_spec())
    input("n", spec: T11.input_spec())

    output("f", spec: T4.output_spec())
  end

  composite Stage2 do
    input("p")
    output("f")

    @impl true
    def initialize(this) do
      {:ok, supplier2} = add_component(this, "Supplier 2", Supplier2, %{}, %{})

      {:ok, supplier3} =
        add_component(this, "Supplier 3", Supplier3, %{}, %{"p" => pin_input("p")})

      {:ok, h} =
        add_component(this, "H", H, %{}, %{
          "j" => pin_output(supplier2, "j"),
          "n" => pin_output(supplier3, "n")
        })

      expose_output(this, pin_output(h, "f"))
    end
  end
end
