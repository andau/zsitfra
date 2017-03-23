class ZCL_BRFPLUS_METADATA_UNIT definition FOR TESTING.
"#AU Risk_Level Harmless
  PUBLIC SECTION.
  private section.
  CONSTANTS: teched_Function_Id   type if_fdt_types=>id
                                VALUE '0241750C32391EE6B4BDF2BAC8533BFF',
             teched_Function_Name type IF_FDT_TYPES=>NAME
                                VALUE 'TECHED_FUNCTION_STRING2NUMBER',
             sit_fra_Function_Id   type if_fdt_types=>id
                                VALUE '0241750C32391EE6B4D8A1790D2D5E0C',
             sit_fra_Function_Name type IF_FDT_TYPES=>NAME
                                VALUE 'COFFEE_MACHINE_STATUS'.

  METHODS: test_Get_Function_Definition FOR TESTING,
           test_Get_Function_Cont_Params FOR TESTING,
           test_Get_Function_Id FOR TESTING.

ENDCLASS.

CLASS ZCL_BRFPLUS_METADATA_UNIT IMPLEMENTATION.

 method test_Get_Function_Definition.

   DATA(function_name) = ZCL_BRFPLUS_METADATA=>get_function_name(
                                     p_Function_Id = sit_fra_Function_Id ).
   CL_AUNIT_ASSERT=>assert_equals( EXP = sit_fra_Function_Name  ACT = function_Name ).
 endmethod.

 method test_Get_Function_Cont_Params.

   DATA(context_Params)  = ZCL_BRFPLUS_METADATA=>get_Function_Context_Params(
                                       p_Function_Id = sit_fra_Function_Id ).
   CL_AUNIT_ASSERT=>assert_equals( EXP = 2  ACT = lines( context_Params ) ).

   read table context_Params with key name = 'ZSENSOR_FILL_QUANTITY_BEANS' into DATA(context_Param).
   CL_AUNIT_ASSERT=>assert_equals( EXP = 'T' ACT = context_Param-type  ).

   clear context_Param.
   read table context_Params with key name = 'SENSOR_NOT_EXISTING' into context_Param.
   CL_AUNIT_ASSERT=>assert_initial( context_Param ).

 endmethod.

 method test_Get_Function_Id.

    DATA(function_Id_Result) = ZCL_BRFPLUS_METADATA=>get_Function_Id(
                                        teched_Function_Name  ).
    CL_AUNIT_ASSERT=>assert_equals( EXP = teched_Function_Id ACT = function_Id_Result ).

 endmethod.

ENDCLASS.