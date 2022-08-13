defmodule FromStage1 do
  use CyberOS.DSL

  alias Types.T17
  alias FromSupplier1.Supplier1

  defactor A do
    output("u", spec: T17.output_spec())
  end

  defcomposite Stage1 do
    output("a")
    output("b")
    output("p")

    @impl true
    def on_bootstrap(this, _args) do
      {:ok, a} = add_component(this, "A", A, %{}, %{})

      {:ok, supplier1} =
        add_component(this, "Supplier 1", Supplier1, %{}, %{"u" => get_output(a, "u")})

      expose_output(this, get_output(supplier1, "a"), as: "a")
      expose_output(this, get_output(supplier1, "b"), as: "b")
      expose_output(this, get_output(supplier1, "p"), as: "p")
    end
  end
end
