class zcl_brfplus_metadata_unit definition for testing.
"#AU Risk_Level Harmless
  public section.
  private section.
  constants: sit_wdf_function_id   type if_fdt_types=>id
                                value '0241750C32391EE6B4D8A1790D2D5E0C',
             sit_wdf_function_name type if_fdt_types=>name
                                value 'COFFEE_MACHINE_STATUS'.

  methods: test_get_function_id for testing.

endclass.

class zcl_brfplus_metadata_unit implementation.


 method test_get_function_id.

    data(function_id_result) = zcl_brfplus_metadata_v3=>get_function_id(
                                        sit_wdf_function_name  ).
    cl_aunit_assert=>assert_equals( exp = sit_wdf_function_id act = sit_wdf_function_id ).

 endmethod.

endclass.