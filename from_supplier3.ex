defmodule FromSupplier3 do
  use ClusterOS.DSL

  alias Types.T11
  alias Types.T12
  alias Types.T13

  defactor E do
    output("o", spec: T12.output_spec())
  end

  defactor F do
    input("o", spec: T12.input_spec())
    input("p", spec: T13.input_spec())

    output("n", spec: T11.output_spec())
  end

  defcomposite Supplier3 do
    input("p")
    output("n")

    @impl true
    def on_bootstrap(this, _args) do
      {:ok, e} = add_component(this, "E", E, %{}, %{})

      {:ok, f} =
        add_component(this, "F", F, %{}, %{"p" => get_input("p"), "o" => get_output(e, "o")})

      expose_output(this, get_output(f, "n"), as: "n")
    end
  end
end
