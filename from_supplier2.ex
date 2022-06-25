defmodule FromSupplier2 do
  use CyberOS.DSL

  require Types
  require FromTeamA

  alias Types.T7
  alias Types.T8
  alias Types.T9
  alias Types.T10
  alias FromTeamA.TeamA

  defactor G do
    input("k", spec: T8.input_spec())
    input("l", spec: T9.input_spec())
    input("m", spec: T10.input_spec())

    output("j", spec: T7.output_spec())
  end

  defactor L do
    output("m", spec: T10.output_spec())
  end

  defcluster Supplier2 do
    output("j")

    @impl true
    def on_bootstrap(this, _args) do
      {:ok, team_A} = add_component(this, "team A", TeamA, %{}, %{})
      {:ok, l} = add_component(this, "L", L, %{}, %{})

      {:ok, g} =
        add_component(this, "G", G, %{}, %{
          "k" => get_output(team_A, "k"),
          "l" => get_output(team_A, "l"),
          "m" => get_output(l, "m")
        })

      expose_output(this, get_output(g, "j"))
    end
  end
end
