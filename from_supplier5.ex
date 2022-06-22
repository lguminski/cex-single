defmodule FromSupplier5 do
  use CyberOS.DSL

  require Types

  alias Types.T5
  alias Types.T6

  defactor N do
    input("i", spec: T6.input_spec())
    input("h", spec: T6.input_spec())
    output("g", spec: T5.output_spec())
  end

  defcluster Supplier5 do
    input("i")
    input("h")
    output("g")

    @impl true
    def bootstrap(this, args) do
      {:ok, n} = add_component(this, "N", N, %{}, %{"i" => get_input("i"), "h" => get_input("h")})

      expose_output(this, get_output(n, "g"))
    end
  end
end
