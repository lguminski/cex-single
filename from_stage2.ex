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

  defactor H do
    input("j", spec: T7.input_spec())
    input("n", spec: T11.input_spec())

    output("f", spec: T4.output_spec())
  end

  defcomposite Stage2 do
    input("p")
    output("f")

    @impl true
    def on_bootstrap(this, _args) do
      {:ok, supplier2} = add_component(this, "Supplier 2", Supplier2, %{}, %{})

      {:ok, supplier3} =
        add_component(this, "Supplier 3", Supplier3, %{}, %{"p" => get_input("p")})

      {:ok, h} =
        add_component(this, "H", H, %{}, %{
          "j" => get_output(supplier2, "j"),
          "n" => get_output(supplier3, "n")
        })

      expose_output(this, get_output(h, "f"), as: "f")
    end
  end
end
