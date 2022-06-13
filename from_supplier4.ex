defmodule FromSupplier4 do
  use CyberOS.DSL
  require Types
  alias Types.T6

  actor O do
    output("i", spec: T6.output_spec())
  end

  actor P do
    output("h", spec: T6.output_spec())
  end

  composite Supplier4 do
    output("i")
    output("h")

    @impl true
    def bootstrap(this) do
      {:ok, o} = add_component(this, "O", O, %{}, %{})
      {:ok, p} = add_component(this, "P", P, %{}, %{})

      expose_output(this, get_output(o, "i"))
      expose_output(this, get_output(p, "h"))
    end
  end
end
