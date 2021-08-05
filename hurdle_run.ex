defmodule MyApplication do
  use CyberOS.DSL, version: 1.0

  require Test
  alias MyTypes.{MySQL}
	alias Test.Processor


  function DatabaseProvider, type: Function.DockerService do

    output :mysql12, type: MySQL.define(version: 8.0)
    param :param8, default: 43

    @impl true
    def initialize_docker(_this) do
    end
  end

  composite DatabaseBroker do

    input :mysql8
    output :mysql9

    @impl true
    def initialize_composite(this) do
      Test.print()
      expose_output(this, pin_input(:mysql8), as: :mysql9)
    end
  end

  composite DatabaseBrokerParent do

    input :mysql6
    output :mysql7

    @impl true
    def initialize_composite(this) do
      Test.Test.print2()
      {:ok, broker} = add_component(this, "database_broker", DatabaseBroker, [], [mysql8: pin_input(:mysql6)])
      expose_output(this, pin_output(broker, :mysql9), as: :mysql7)
    end
  end

  composite DatabaseBrokerGrandParent do

    input :mysql8
    output :mysql9

    @impl true
    def initialize_composite(this) do
      {:ok, broker} = add_component(this, "database_broker", DatabaseBrokerParent, [], [mysql6: pin_input(:mysql8)])
      expose_output(this, pin_output(broker, :mysql7), as: :mysql9)
    end
  end

  main do

    param :param1, default: 21
    param :param2, default: 333

    output :www3

    @impl true
    def initialize_composite(this) do
      {:ok, database_provider} = add_component(this, "database", DatabaseProvider, [], [])

      {:ok, database_broker1} = add_component(this, "broker1", DatabaseBrokerGrandParent, [], [mysql8: pin_output(database_provider, :mysql12)])
      {:ok, database_broker2} = add_component(this, "broker2", DatabaseBrokerGrandParent, [], [mysql8: pin_output(database_broker1, :mysql9)])
      {:ok, database_broker3} = add_component(this, "broker3", DatabaseBrokerGrandParent, [], [mysql8: pin_output(database_broker2, :mysql9)])
      {:ok, database_broker4} = add_component(this, "broker4", DatabaseBrokerGrandParent, [], [mysql8: pin_output(database_broker3, :mysql9)])

      {:ok, processor} = add_component(
       this,
       "processor",
       Processor,
       [],
       [mysql: pin_output(database_broker4, :mysql9)])

     expose_output(this, pin_output(processor, :www), as: :www3)
    end

    @impl true
    def initialize_application(_this) do
      Logger.debug "application #{inspect Application.get_application(__MODULE__)}"
      #      set_author(this, "Arnold S", "arnold@hotmail.com")
      #			set_version(this, "0.2.0")
    end
  end
end

