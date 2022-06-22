defmodule FromStage3 do
  use CyberOS.DSL

  require FromSupplier4
  require FromSupplier5
  require FromSupplier6

  alias FromSupplier4.Supplier4
  alias FromSupplier5.Supplier5
  alias FromSupplier6.Supplier6

  defcluster Stage3 do
    input("f")
    output("c")

    @impl true
    def bootstrap(this, args) do
      {:ok, supplier4} = add_component(this, "Supplier 4", Supplier4, %{}, %{})

      {:ok, supplier5} =
        add_component(this, "Supplier 5", Supplier5, %{}, %{
          "i" => get_output(supplier4, "i"),
          "h" => get_output(supplier4, "h")
        })

      {:ok, supplier6} =
        add_component(this, "Supplier 6", Supplier6, %{}, %{
          "g" => get_output(supplier5, "g"),
          "f" => get_input("f")
        })

      expose_output(this, get_output(supplier6, "c"))
    end
  end
end
