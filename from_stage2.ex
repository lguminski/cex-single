defmodule FromStage2 do
  use CyberOS.DSL

  require Types
  require FromSupplier2
  require FromSupplier3

  defactor H do
    input("j", spec: Types.T7.input_spec())
    input("n", spec: Types.T11.input_spec())

    output("f", spec: Types.T4.output_spec())
  end

  defcomposite Stage2 do
    input("p")
    output("f")

    @impl true
    def on_bootstrap(this, _args) do
      {:ok, supplier2} = add_component(this, "Supplier 2", FromSupplier2.Supplier2, %{}, %{})

      {:ok, supplier3} =
        add_component(this, "Supplier 3", FromSupplier3.Supplier3, %{}, %{"p" => get_input("p")})

      {:ok, h} =
        add_component(this, "H", H, %{}, %{
          "j" => get_output(supplier2, "j"),
          "n" => get_output(supplier3, "n")
        })

      expose_output(this, get_output(h, "f"), as: "f")
    end
  end
end
