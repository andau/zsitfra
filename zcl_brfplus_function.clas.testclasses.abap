class ltcl_ definition final for testing
  duration short
  risk level harmless.

  private section.
    data brfplus_function type ref to zcl_brfplus_function.
    methods:
      setup,
      ok_test_2_sensors for testing raising cx_static_check,
      ok_test_3_sensors for testing raising cx_static_check,
      ok_test_with_decision_table for testing raising cx_static_check,
      ok_test_2_sensors_input_from_3 for testing raising cx_static_check,
      fail_test_2_sensors for testing raising cx_static_check,

      generate_data_for_2_sensors
         importing p_sensor_fill_quantity_beans type int2
                   p_sensor_fill_quantity_water type int2
         returning value(p_sensor_values) type ref to zcl_sensor_values,
      generate_data_for_3_sensors
         importing p_sensor_fill_quantity_beans type int2
                   p_sensor_fill_quantity_water type int2
                   p_sensor_fill_quantity_trash type int2
         returning value(p_sensor_values) type ref to zcl_sensor_values.

endclass.


class ltcl_ implementation.

  method setup.
    create object brfplus_function.
  endmethod.

  method ok_test_2_sensors.

    data(sensor_values) = generate_data_for_2_sensors( exporting p_sensor_fill_quantity_beans = 80
                                                                p_sensor_fill_quantity_water = 80 ).
    data(maintenance_messages) = brfplus_function->process( exporting p_function_name = `COFFEE_MACHINE_STATUS` p_sensor_values = sensor_values ).


    cl_abap_unit_assert=>assert_equals( exp = 0 act = lines( maintenance_messages ) ).

  endmethod.

  method ok_test_with_decision_table.

    data(sensor_values) = generate_data_for_2_sensors( exporting p_sensor_fill_quantity_beans = 20
                                                                p_sensor_fill_quantity_water = 20 ).
    data(maintenance_messages) = brfplus_function->process( exporting p_function_name = `COFFEE_MACHINE_STATUS_M_DT` p_sensor_values = sensor_values ).


    cl_abap_unit_assert=>assert_equals( exp = 2 act = lines( maintenance_messages ) ).

  endmethod.

  method ok_test_3_sensors.

    data(sensorvalues) = generate_data_for_3_sensors( exporting p_sensor_fill_quantity_beans = 80
                                                            p_sensor_fill_quantity_water = 80
                                                            p_sensor_fill_quantity_trash = 20    ).
    data(maintenance_messages) = brfplus_function->process( exporting p_function_name = `COFFEE_MACHINE_STATUS_3SENSORS` p_sensor_values = sensorvalues ).


    cl_abap_unit_assert=>assert_equals( exp = 0 act = lines( maintenance_messages ) ).

 endmethod.

  method ok_test_2_sensors_input_from_3.

    data(sensor_values) = generate_data_for_3_sensors( exporting p_sensor_fill_quantity_beans = 80
                                                            p_sensor_fill_quantity_water = 80
                                                            p_sensor_fill_quantity_trash = 80 ).
    data(maintenance_messages) = brfplus_function->process( exporting p_function_name = `COFFEE_MACHINE_STATUS` p_sensor_values = sensor_values ).

    cl_abap_unit_assert=>assert_equals( exp = 0 act = lines( maintenance_messages ) ).

  endmethod.

  method fail_test_2_sensors.

    data(sensor_values) = generate_data_for_2_sensors( exporting p_sensor_fill_quantity_beans = 20
                                                            p_sensor_fill_quantity_water = 80 ).
    data(maintenance_messages) = brfplus_function->process( exporting p_function_name = `COFFEE_MACHINE_STATUS` p_sensor_values = sensor_values ).
    cl_abap_unit_assert=>assert_equals( exp = 1 act = lines( maintenance_messages ) ).

    sensor_values = generate_data_for_2_sensors( exporting p_sensor_fill_quantity_beans = 80
                                                      p_sensor_fill_quantity_water = 10 ).
    maintenance_messages = brfplus_function->process( exporting p_function_name = `COFFEE_MACHINE_STATUS` p_sensor_values = sensor_values ).
    cl_abap_unit_assert=>assert_equals( exp = 1 act = lines( maintenance_messages ) ).

  endmethod.


  method generate_data_for_2_sensors.

    create object p_sensor_values.
    p_sensor_values->add_sensor_value( p_sensor_name = `ZSENSOR_FILL_QUANTITY_BEANS`
                                 p_sensor_value = p_sensor_fill_quantity_beans  ).
    p_sensor_values->add_sensor_value( p_sensor_name = `ZSENSOR_FILL_QUANTITY_WATER`
                                 p_sensor_value = p_sensor_fill_quantity_water ).
  endmethod.

  method generate_data_for_3_sensors.

    create object p_sensor_values.
    p_sensor_values->add_sensor_value( p_sensor_name = `ZSENSOR_FILL_QUANTITY_BEANS`
                                 p_sensor_value = p_sensor_fill_quantity_beans  ).
    p_sensor_values->add_sensor_value( p_sensor_name = `ZSENSOR_FILL_QUANTITY_WATER`
                                 p_sensor_value = p_sensor_fill_quantity_water ).
    p_sensor_values->add_sensor_value( p_sensor_name = `ZSENSOR_FILL_QUANTITY_TRASH`
                                 p_sensor_value = p_sensor_fill_quantity_trash ).

  endmethod.

endclass.