{:error,
 {:bad_return,
  {{CyberOS.ACA.Loader, :start,
    [
      :normal,
      [
        :"Elixir.cyberos aca: M2.MyApplication.Broker",
        {:parent_cid, "00:01.3f8a7810"},
        {:parameters, %{}},
        {:name, "M2"}
      ]
    ]},
   {:EXIT,
    {%CyberOS.RuntimeError{
       message:
         "Input lacks mandatory keys [\"sensorData\"]. :\"Elixir.cyberos aca: M2.MyApplication.Broker\" requires inputs to be provided as a list2: %{\"sensorData\" => input_0}"
     },
     [
       {RaiseUtil, :cyberos_raise, 2, [file: 'lib/cyberos_kernel/circuit/errors.ex', line: 53]},
       {CyberOS.ACA.Loader, :_start, 7, [file: 'lib/cyberos_kernel/aca/loader.ex', line: 207]},
       {CyberOS.ACA.Loader, :start, 4, [file: 'lib/cyberos_kernel/aca/loader.ex', line: 143]},
       {CyberOS.ACA.Loader, :start, 2, [file: 'lib/cyberos_kernel/aca/loader.ex', line: 134]}
     ]}}}}}
