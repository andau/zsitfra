*&---------------------------------------------------------------------*
*& AMC sender
*&
*&---------------------------------------------------------------------*
REPORT ZAMC_SEND_COFFEEMACHINE_3SENS.

PARAMETERS: water TYPE string DEFAULT '80',
            beans type string DEFAULT '80',
            trash type string default '20'.

TRY.
   DATA(messageProducer) = CAST if_amc_message_producer_pcp(
     cl_amc_channel_manager=>create_message_producer(
        i_application_id = 'ZAMC_COFFEEMACHINE'
        i_channel_id = '/heartbeat' ) ).

   DATA(pcpMessage) = cl_ac_message_type_pcp=>create( ).
   pcpMessage->set_text( 'Status of coffeemachine status').
   pcpMessage->set_field( i_name = 'ZSENSOR_FILL_QUANTITY_WATER' i_value = water ).
   pcpMessage->set_field( i_name = 'ZSENSOR_FILL_QUANTITY_BEANS' i_value = beans ).
   pcpMessage->set_field( i_name = 'ZSENSOR_FILL_QUANTITY_TRASH' i_value = trash ).

   messageProducer->send( pcpMessage ).

   CATCH cx_amc_error INTO DATA(lx_amc_error).
     MESSAGE lx_amc_error->get_text( ) TYPE 'E'.
ENDTRY.