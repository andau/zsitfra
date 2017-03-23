class zcl_brfplus_metadata definition
  public
  final
  create public .

public section.

class-methods: get_function_id
                     importing p_function_name type if_fdt_types=>name
                     returning value(p_function_id) type if_fdt_types=>id,

               get_function_context_params
                     importing p_function_id type if_fdt_types=>id
                     returning  value(p_context_params) type zt_context_params,

               get_function_name
                     importing p_function_id type if_fdt_types=>id
                     returning  value(p_function_name) type if_fdt_types=>name.

protected section.
private section.
endclass.



class zcl_brfplus_metadata implementation.



method get_function_id.

* get function Id by searching the BRFplus application by the function name
  cl_fdt_factory=>get_instance(  )->get_query(
        iv_object_type = if_fdt_constants=>gc_object_type_function )->get_ids(
                     exporting iv_name = p_function_name
                     importing ets_object_id = data(ids_of_matching_functions) ) .

* returning first found id
  p_function_id = ids_of_matching_functions[ 1 ].

endmethod.






method get_function_context_params.
  data: context_param like line of p_context_params.

* get all context Ids
  data(context_object_ids) = cl_fdt_factory=>get_instance(
                                )->get_function( p_function_id )->get_context_data_objects( ).

  loop at context_object_ids assigning field-symbol(<context_object_id>).

* get instance by context id
      cl_fdt_factory=>get_instance_generic(
                    exporting iv_id         = <context_object_id>
                    importing eo_instance   = data(lo_instance) ).

* populate result table
      context_param-name = lo_instance->get_name( ).
      context_param-type = conv string( cast if_fdt_element( lo_instance )->get_element_type( ) ).
      append context_param to p_context_params.

  endloop.

endmethod.



method get_function_name.

  cl_fdt_factory=>get_instance_generic(
             exporting iv_id    = p_function_id
             importing eo_instance   = data(lo_instance) ).

  p_function_name = lo_instance->get_name( ).

endmethod.
endclass.