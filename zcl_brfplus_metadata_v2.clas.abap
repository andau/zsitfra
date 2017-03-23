class ZCL_BRFPLUS_METADATA_V2 definition
  public
  final
  create public .

public section.

CLASS-METHODS: get_Function_Id importing p_Function_name type IF_FDT_TYPES=>NAME
                             returning value(p_Function_Id) type IF_FDT_TYPES=>ID.
ENDCLASS.



CLASS ZCL_BRFPLUS_METADATA_V2 IMPLEMENTATION.

method Get_Function_Id.


  DATA(fdt_Factory) = CL_FDT_FACTORY=>get_instance( exporting iv_application_id = p_Function_Id ).
  DATA(object_Type) = if_fdt_constants=>gc_object_type_function.

  DATA(fdt_Query) = fdt_Factory->get_query( exporting iv_object_type = object_Type ).
  fdt_Query->get_ids( exporting iv_name = p_Function_name
                     importing ets_object_id = DATA(object_Ids) ).

  read table object_Ids INDEX 1 into p_Function_Id.

endmethod.

ENDCLASS.