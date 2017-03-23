class ZCL_APC_WSP_EXT_ZAPC_COFFEEMAC definition
  public
  inheriting from CL_APC_WSP_EXT_STATELESS_BASE
  final
  create public .

public section.
  METHODS: if_apc_wsp_extension~on_message REDEFINITION,
           if_apc_wsp_extension~on_start REDEFINITION.
protected section.
private section.
ENDCLASS.



CLASS ZCL_APC_WSP_EXT_ZAPC_COFFEEMAC IMPLEMENTATION.
  METHOD IF_APC_WSP_EXTENSION~ON_MESSAGE.

  ENDMETHOD.

  METHOD IF_APC_WSP_EXTENSION~ON_START.

  ENDMETHOD.

ENDCLASS.