class zcl_brfplus_function definition
  public
  final
  create public .

public section.
    class-methods process
      importing p_function_name type if_fdt_types=>name
                p_sensor_values type ref to zcl_sensor_values
      returning
        value(p_maintenance_messages) type zt_maintenance_messages.
protected section.
private section.
endclass.



class zcl_brfplus_function implementation.

  method process.
    data: contextparams type abap_parmbind_tab,
          contextparam like line of contextparams.
    field-symbols <resultdataany> type any.

    get time stamp field data(currenttimestamp).

    "get defined context params of brfplus function
    data(function_id) = zcl_brfplus_metadata=>get_function_id( p_function_name  ).
    data(defined_context_params) = zcl_brfplus_metadata=>get_function_context_params( function_id ).

    "build context information by matching defined context params and sensor values
    p_sensor_values->get_sensor_values( importing p_sensor_values = data(sensor_values) ).
    loop at defined_context_params assigning field-symbol(<defined_context_param>).
      loop at sensor_values assigning field-symbol(<sensor_value>).
        if <defined_context_param>-name = <sensor_value>-name.
          "move definedcontextParams into context params format for BRFplus call.
          contextparam-name = <defined_context_param>-name.
          get reference of <sensor_value>-value into contextparam-value.
          insert contextparam into table contextparams.
        endif.
      endloop.
   endloop.

   "prepare and process BRFplus function
   cl_fdt_function_process=>get_data_object_reference( exporting iv_function_id      = function_id
                                                                iv_data_object      = 'ZTABLE_MAINTAINANCE_MESSAGES'
                                                                iv_timestamp        = currenttimestamp
                                                                iv_trace_generation = abap_false
                                                      importing er_data             = data(resultdata) ).
   assign resultdata->* to <resultdataany>.

  cl_fdt_function_process=>process( exporting iv_function_id = function_id
                                              iv_timestamp   = currenttimestamp
                                    importing ea_result      = <resultdataany>
                                    changing  ct_name_value  = contextparams ).


  "return result of brfplus function
  p_maintenance_messages = <resultdataany>.

  endmethod.

endclass.