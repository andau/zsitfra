class ZCL_BRFPLUS_METADATA_V3 definition
  public
  final
  create public .

public section.

CLASS-METHODS: get_Function_Id importing p_Function_name type IF_FDT_TYPES=>NAME
                             returning value(p_Function_Id) type IF_FDT_TYPES=>ID.
ENDCLASS.



CLASS ZCL_BRFPLUS_METADATA_V3 IMPLEMENTATION.


method Get_Function_Id.

  CL_FDT_FACTORY=>get_instance( p_Function_Id )->get_query(
        iv_object_type = if_fdt_constants=>gc_object_type_function )->get_ids(
                     exporting iv_name = p_Function_name
                     importing ets_object_id = DATA(ids_Of_Matching_Functions) ) .

  p_Function_Id = ids_Of_Matching_Functions[ 1 ].

endmethod.
ENDCLASS.