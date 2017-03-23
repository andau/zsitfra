*&---------------------------------------------------------------------*
*& Report zcl_brfplus_test_performance
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zcl_brfplus_test_performance.

Data(stopWatch) = CL_FS_STOPWATCH=>S_CREATE( ).
stopWatch->start( ).

do 1000 times.
  data: brfplus_function type ref to zcl_brfplus_function,
        sensor_values type ref to zcl_sensor_values.

      create object sensor_values.
      sensor_values->add_sensor_value( p_sensor_name = `ZSENSOR_FILL_QUANTITY_BEANS`
                                   p_sensor_value = '10'  ).
      sensor_values->add_sensor_value( p_sensor_name = `ZSENSOR_FILL_QUANTITY_WATER`
                                   p_sensor_value = '80' ).

      create object brfplus_function.

      data(maintenance_messages) = brfplus_function->process( exporting p_function_name = `COFFEE_MACHINE_STATUS` p_sensor_values = sensor_values ).
      write `.`.
enddo.

stopWatch->stop( ).
write `Duration: ` && stopWatch->get_time( ) && ` milliseconds for 1000 times`.