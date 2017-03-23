*&---------------------------------------------------------------------*
*& Status of coffeemachine
*&---------------------------------------------------------------------*
report zamc_receive_coffeemachine.

parameters: status type string default 'WAIT FOR INPUT'.

data: gt_message_list type table of string.

class lcl_amc_test_text definition
  final
  create public .

  public section.
    interfaces if_amc_message_receiver_pcp .
  private section.
    methods: call_brfplus_with_sensor_data
               importing p_pcp_fields type pcp_fields
                         p_brfplus_function type string
               returning value(p_maintenance_messages) type zt_maintenance_messages.
    data pcp_fields type pcp_fields.
    data sensor_values type ref to zcl_sensor_values.
    data coffeemachine type ref to zcl_coffeemachine.

endclass.

class lcl_amc_test_text implementation.



  method if_amc_message_receiver_pcp~receive.
      create object coffeemachine.
      create object sensor_values.
      try.

         i_message->get_fields( changing c_fields = pcp_fields ).
         data(maintenance_messages) = call_brfplus_with_sensor_data(
                exporting p_pcp_fields = pcp_fields
                          p_brfplus_function = 'COFFEE_MACHINE_STATUS' ).

         if ( lines( maintenance_messages ) = 0 ).
              append 'STATE OK - Take a coffee' to gt_message_list.
         else.
              loop at maintenance_messages assigning field-symbol(<maintenance_message>).
                append <maintenance_message> to gt_message_list.
              endloop.
         endif.

      catch cx_ac_message_type_pcp_error.
         message `Unexpected error` type 'E'.
      endtry.
    endmethod.




    method call_brfplus_with_sensor_data.
         loop at p_pcp_fields assigning field-symbol(<pcp_field>).
            if <pcp_field>-name cs 'ZSENSOR'.
               sensor_values->add_sensor_value( exporting p_sensor_name = <pcp_field>-name
                                                    p_sensor_value = conv int2( <pcp_field>-value ) ).
            endif.
         endloop.

         coffeemachine->set_sensor_values(  sensor_values ).
         p_maintenance_messages = coffeemachine->calculate_maintenance_status( ).
    endmethod.

endclass.

start-of-selection.

try.
  data(lo_consumer) = cl_amc_channel_manager=>create_message_consumer(
    i_application_id = 'ZAMC_COFFEEMACHINE'
    i_channel_id = '/heartbeat' ).

  data(lo_receiver_text) = new lcl_amc_test_text( ).

  lo_consumer->start_message_delivery( i_receiver = lo_receiver_text ).
catch cx_amc_error into data(lx_amc_error).
     message lx_amc_error->get_text( ) type 'E'.
endtry.

  wait for messaging channels until lines( gt_message_list ) >= 1 up to 2000 seconds.

  if sy-subrc = 8 and  lines( gt_message_list ) = 0.
     write: ')-: Time out occured and no message received :-('.
  else.
    loop at gt_message_list into data(lv_message).
      write: / sy-tabix, lv_message.
    endloop.
  endif.