defmodule FromStage3 do
  use CyberOS.DSL

  alias FromSupplier4.Supplier4
  alias FromSupplier5.Supplier5
  alias FromSupplier6.Supplier6

  defcomposite Stage3 do
    input("f")
    output("c")

    @impl true
    def on_bootstrap(this, _args) do
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

      expose_output(this, get_output(supplier6, "c"), as: "c")
    end
  end
end
