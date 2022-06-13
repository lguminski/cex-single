defmodule FromSupplier3 do
  use CyberOS.DSL

  require Types

  alias Types.T11
  alias Types.T12
  alias Types.T13

  actor E do
    output("o", spec: T12.output_spec())
  end

  actor F do
    input("o", spec: T12.input_spec())
    input("p", spec: T13.input_spec())

    output("n", spec: T11.output_spec())
  end

  composite Supplier3 do
    input("p")
    output("n")

    @impl true
    def bootstrap(this) do
      {:ok, e} = add_component(this, "E", E, %{}, %{})

      {:ok, f} =
        add_component(this, "F", F, %{}, %{"p" => get_input("p"), "o" => get_output(e, "o")})

      expose_output(this, get_output(f, "n"))
    end
  end
end
