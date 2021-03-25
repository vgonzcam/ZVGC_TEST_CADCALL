CLASS zvgc_cl_test_cadcall DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zvgc_cl_test_cadcall IMPLEMENTATION.


  METHOD if_rap_query_provider~select.


    IF io_request->is_data_requested( ).

      DATA: ex_time_zone TYPE string,
            ex_date      TYPE string,
            ex_time      TYPE string,
            lt_data      TYPE STANDARD TABLE OF zvgc_cds_cadcall.

      "DATA(lv_offset) = io_request->get_paging( )->get_offset( ).
      "DATA(lv_page_size) = io_request->get_paging( )->get_page_size( ).
      "DATA(lv_max_rows) = COND #( WHEN lv_page_size = if_rap_query_paging=>page_size_unlimited THEN 0
      "                            ELSE lv_page_size ).

      TRY.
          CALL FUNCTION 'ZVGC_FM_TEST_CADCALL'
            IMPORTING
              ex_time_zone = ex_time_zone
              ex_date      = ex_date
              ex_time      = ex_time.
        CATCH cx_root.

      ENDTRY.

      lt_data = VALUE #( ( ex_time_zone = ex_time_zone ex_date = ex_date  ex_time =  ex_time ) ).

      io_response->set_total_number_of_records( lines( lt_data ) ).
      io_response->set_data( lt_data ).

    ENDIF.


  ENDMETHOD.
ENDCLASS.
