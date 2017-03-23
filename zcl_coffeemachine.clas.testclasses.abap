class ZCL_COFFEEMACHINE_TEST definition final for testing
  duration short
  risk level harmless.

  private section.
    methods:
      get_maintenance_status for testing raising cx_static_check.
endclass.


class ZCL_COFFEEMACHINE_TEST implementation.

  method get_Maintenance_Status.
    DATA sensor_Values type ref to ZCL_SENSOR_VALUES.
    DATA coffeemachine type ref to ZCL_COFFEEMACHINE.
    CREATE OBJECT sensor_Values.
    CREATE OBJECT coffeemachine.
    sensor_Values->add_Sensor_Value( exporting p_Sensor_name = `ZSENSOR_FILL_QUANTITY_WATER` p_Sensor_Value = 60 ).
    sensor_Values->add_Sensor_Value( exporting p_Sensor_name = `ZSENSOR_FILL_QUANTITY_BEANS` p_Sensor_Value = 60 ).

    coffeemachine->set_sensor_values( sensor_Values ).
    DATA(maintenance_Messages) = coffeemachine->calculate_Maintenance_Status( ).
    cl_abap_unit_assert=>assert_equals( EXP = 0 ACT = lines( maintenance_Messages ) ).
  endmethod.

endclass.