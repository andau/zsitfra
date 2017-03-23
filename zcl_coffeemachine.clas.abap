class zcl_coffeemachine definition
  public
  final
  create public .

public section.
    methods: calculate_Maintenance_Status  returning  value(p_Maintenance_Messages) type ZT_MAINTENANCE_MESSAGES,
             set_Sensor_Values importing p_Sensor_Values type ref to ZCL_SENSOR_VALUES.

protected section.
private section.
  DATA sensor_Values type ref to ZCL_SENSOR_VALUES.
endclass.



class zcl_coffeemachine implementation.

  method calculate_Maintenance_Status.
      DATA(brfplus_Function) = NEW zcl_brfplus_function( ).
      p_Maintenance_Messages = brfplus_Function->process(
            exporting p_Function_Name = `COFFEE_MACHINE_STATUS`
                      p_Sensor_Values = sensor_Values ).
  endmethod.

  method set_Sensor_Values.
    sensor_Values = p_Sensor_Values.
  endmethod.

endclass.