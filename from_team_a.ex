defmodule FromTeamA do
  use CyberOS.DSL
  require Types
  alias Types.T8
  alias Types.T9

  actor K do
    output("l", spec: T9.output_spec())
  end

  actor J do
    output("k", spec: T8.output_spec())
  end

  composite TeamA do
    output("l")
    output("k")

    @impl true
    def bootstrap(this) do
      {:ok, k} = add_component(this, "K", K, %{}, %{})
      {:ok, j} = add_component(this, "J", J, %{}, %{})

      expose_output(this, get_output(k, "l"))
      expose_output(this, get_output(j, "k"))
    end
  end
end
