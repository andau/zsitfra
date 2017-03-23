class zcl_sensor_values definition
  public
  final
  create public .

public section.

  TYPES ty_sensorvalues type table of zstruct_sensor_value.
  METHODS: get_Sensor_Values exporting p_Sensor_Values TYPE ty_sensorvalues,
           add_Sensor_Value importing p_Sensor_name  type string   p_Sensor_value TYPE int2.
protected section.
private section.
  DATA sensor_Values type table of zstruct_sensor_value.
endclass.

class zcl_sensor_values implementation.
  method get_Sensor_Values.
    p_Sensor_Values = me->sensor_values.
  endmethod.


  method add_Sensor_Value.
     DATA sensor_Value type zstruct_sensor_value.
     sensor_Value-name = p_Sensor_name.
     sensor_Value-value = p_Sensor_value.
     append sensor_Value to sensor_Values.
  endmethod.

endclass.