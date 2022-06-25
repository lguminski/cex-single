defmodule FromSupplier1 do
  use CyberOS.DSL

  require Types

  alias Types.T1
  alias Types.T13
  alias Types.T14
  alias Types.T15
  alias Types.T16
  alias Types.T17

  defactor B do
    input("u", spec: T17.input_spec())
    output("r", spec: T14.output_spec())
    output("t", spec: T16.output_spec())
  end

  defactor C do
    input("r", spec: T14.input_spec())
    output("s", spec: T15.output_spec())
    output("p", spec: T13.output_spec())
  end

  defactor D do
    input("s", spec: T15.input_spec())
    input("t", spec: T16.input_spec())
    output("a", spec: T1.output_spec())
    output("b", spec: T1.output_spec())
  end

  defcluster Supplier1 do
    input("u")
    output("a")
    output("b")
    output("p")

    @impl true
    def on_bootstrap(this, _args) do
      {:ok, b} = add_component(this, "B", B, %{}, %{"u" => get_input("u")})
      {:ok, c} = add_component(this, "C", C, %{}, %{"r" => get_output(b, "r")})

      {:ok, d} =
        add_component(this, "D", D, %{}, %{"t" => get_output(b, "t"), "s" => get_output(c, "s")})

      expose_output(this, get_output(d, "a"))
      expose_output(this, get_output(d, "b"))
      expose_output(this, get_output(c, "p"))
    end
  end
end
