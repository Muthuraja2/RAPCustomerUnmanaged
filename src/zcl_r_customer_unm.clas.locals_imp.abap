CLASS lhc_buffer DEFINITION.
  PUBLIC SECTION.
    TYPES tt_customer TYPE STANDARD TABLE OF zmuthu_customer WITH KEY customeruuid.
    CLASS-DATA: lt_customer_buffer TYPE tt_customer.
ENDCLASS.

CLASS lhc_buffer IMPLEMENTATION.
ENDCLASS.

CLASS lhc_Customer DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Customer RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE Customer.

    METHODS bulkCreateCustomer FOR MODIFY
      IMPORTING keys   FOR ACTION Customer~bulkCreateCustomer
      RESULT    result.

ENDCLASS.

CLASS lhc_Customer IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.
    DATA tz TYPE abp_creation_tstmpl.

    LOOP AT entities INTO DATA(entity).
      CLEAR tz.
      GET TIME STAMP FIELD tz.
      DATA(uuid) = cl_system_uuid=>create_uuid_x16_static(  ).
      APPEND VALUE #(   customeruuid = uuid
                        name = entity-Name
                        city = entity-city
                        country = entity-country
                        email = entity-email
                        createdby = sy-uname
                        createdat = tz ) TO lhc_buffer=>lt_customer_buffer.
      APPEND VALUE #( %cid = entity-%cid customeruuid = uuid ) TO mapped-customer.
    ENDLOOP.
  ENDMETHOD.

  METHOD bulkCreateCustomer.

    LOOP AT keys INTO DATA(key).

      DATA(lt_input) = key-%param-data.

      MODIFY ENTITIES OF zmuthu_r_customer IN LOCAL MODE
          ENTITY Customer
          CREATE AUTO FILL CID
          WITH VALUE #( FOR input IN lt_input
                          ( %control = VALUE #( Name = if_abap_behv=>mk-on
                                                City = if_abap_behv=>mk-on
                                                Country = if_abap_behv=>mk-on
                                                Email =  if_abap_behv=>mk-on )
                            %data = VALUE #( Name = input-name
                                             City = input-city
                                             Country = input-country
                                             Email = input-email ) ) )
          MAPPED DATA(lt_mapped)
          FAILED DATA(lt_failed)
          REPORTED DATA(lt_reported).

      IF NOT ( lt_failed-customer IS INITIAL AND lt_reported-customer IS INITIAL ).
        failed = CORRESPONDING #( DEEP lt_failed ).
        reported = CORRESPONDING #(  DEEP lt_reported ).
        reported-customer = VALUE #( BASE reported-customer ( %cid = key-%cid
                             %msg = new_message_with_text(
                              text = 'Customers were not created'
                              severity = if_abap_behv_message=>severity-error
                               ) ) ).
        result = VALUE #( (  %cid = key-%cid %param-message = 'Customer Creation got failed!' ) ).
      ELSE.
        reported-customer = VALUE #( ( %cid = key-%cid
                                       %msg = new_message_with_text(
                                        text = 'Customers were created'
                                        severity = if_abap_behv_message=>severity-success
                                         ) ) ).
        result = VALUE #( (  %cid = key-%cid  %param-message = 'Customer Creation were successful' ) ).
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZMUTHU_R_CUSTOMER DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZMUTHU_R_CUSTOMER IMPLEMENTATION.

  METHOD save.

    IF ( lhc_buffer=>lt_customer_buffer IS NOT INITIAL ).
      INSERT zmuthu_customer FROM TABLE @lhc_buffer=>lt_customer_buffer.
      IF ( sy-subrc EQ 0 ).
        reported-customer = VALUE #( ( %msg = new_message_with_text(
                                          severity = if_abap_behv_message=>severity-success
                                          text = 'Data Uploaded to DB' ) ) ).
      ELSE.
        reported-customer = VALUE #( ( %msg = new_message_with_text(
                                    severity = if_abap_behv_message=>severity-error
                                    text = 'DB Upload got failed!' ) ) ).
      ENDIF.
    ENDIF.

  ENDMETHOD.

  METHOD cleanup.
    CLEAR lhc_buffer=>lt_customer_buffer.
  ENDMETHOD.

  METHOD cleanup_finalize.
    CLEAR lhc_buffer=>lt_customer_buffer.
  ENDMETHOD.

ENDCLASS.
