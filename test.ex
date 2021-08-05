defmodule Test do
  require Logger
  use CyberOS.DSL, version: 1.0
  alias MyTypes.{MySQL, HTTP}

  def print, do: Logger.error("HI")
  defmodule Test do
    require Logger
    def print2, do: Logger.error("HI2")
  end

  function Processor, type: Function.DockerService do

    input :mysql, type: MySQL.range(min: 5.7, max: 8)
    output :www, type: HTTP.define()

    param :name, default: "dsdsdkd"

    @impl true
    def initialize_docker(this) do
      _mysql_dep = get_input_details(this, :mysql)
    end
  end
end

