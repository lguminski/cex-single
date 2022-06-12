{:error,
 {{:shutdown,
   {:failed_to_start_child, :membrane,
    {%CyberOS.CompileError{
       message:
         "Parameters [\"test\"] not provided for Sensor. Provide them as parameters or set defaults e.g:\n\nparameter(\"test\"), default: 10\n"
     },
     [
       {RaiseUtil, :cyberos_raise, 2, [file: 'lib/cyberos_kernel/circuit/errors.ex', line: 53]},
       {Circuit.Component, :refine_params, 2,
        [file: 'lib/cyberos_kernel/circuit/component.ex', line: 572]},
       {Circuit.Component, :initial_state, 2,
        [file: 'lib/cyberos_kernel/circuit/component.ex', line: 517]},
       {Circuit.Actor, :initial_state, 2,
        [file: 'lib/cyberos_kernel/circuit/actor.ex', line: 253]},
       {Circuit.Actor.OCIContainer, :initial_state, 2,
        [file: 'lib/cyberos_kernel/circuit/actors/oci_container.ex', line: 56]}
     ]}}},
  {:child, :undefined, 0,
   {Circuit.Component.Loader, :start_link,
    [
      %Circuit.Component.InitParams{
        cid: "01:00.42e7e1ce",
        inputs: %{},
        module: MyApplication.Sensor,
        name: "sensor 0",
        params: %{},
        parent: %Maybe{
          id: :just,
          value: %Circuit.Component.Descriptor{
            cid: "01.c3cacceb",
            name: "root",
            pid: 444,
            type: :composite
          }
        },
        resource: 444,
        source: {".app_data/dev/nonode@nohost/projects/MultipleActors/sources/aca.ex", 25},
        stage: :compiletime,
        this: nil
      }
    ]}, :permanent, false, :infinity, :supervisor, [Circuit.Component.Loader]}}}
