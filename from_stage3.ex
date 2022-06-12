defmodule FromStage3 do
  use CyberOS.DSL
  require FromSupplier4
  require FromSupplier5
  require FromSupplier6
  alias FromSupplier4.Supplier4
  alias FromSupplier5.Supplier5
  alias FromSupplier6.Supplier6

  composite Stage3 do
    input("f")
    output("c")

    @impl true
    def initialize(this) do
      {:ok, supplier4} = add_component(this, "Supplier 4", Supplier4, %{}, %{})

      {:ok, supplier5} =
        add_component(this, "Supplier 5", Supplier5, %{}, %{
          "i" => pin_output(supplier4, "i"),
          "h" => pin_output(supplier4, "h")
        })

      {:ok, supplier6} =
        add_component(this, "Supplier 6", Supplier6, %{}, %{
          "g" => pin_output(supplier5, "g"),
          "f" => pin_input("f")
        })

      expose_output(this, pin_output(supplier6, "c"))
    end
  end
end
