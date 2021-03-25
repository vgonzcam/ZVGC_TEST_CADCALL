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

    " Info:
    " Casos para estudiar...
    " https://help.sap.com/viewer/923180ddb98240829d935862025004d6/Cloud/en-US/254f68c7d5374e94a88241b7ce3bd414.html

    DATA: ex_time_zone TYPE string,
          ex_date      TYPE string,
          ex_time      TYPE string,
          lt_data      TYPE TABLE OF zvgc_cds_cadcall.

    TRY.
        CALL FUNCTION 'ZVGC_FM_TEST_CADCALL'
          IMPORTING
            ex_time_zone = ex_time_zone
            ex_date      = ex_date
            ex_time      = ex_time.

        lt_data = VALUE #( ( ex_time_zone = ex_time_zone ex_date = ex_date  ex_time =  ex_time ) ).

      CATCH cx_root.

    ENDTRY.


    CASE io_request->get_entity_id( ).

      WHEN 'ZVGC_CDS_CADCALL' .

        DATA(lv_search_string) = io_request->get_search_expression( ).
        DATA(lv_search_sql) = |DESCRIPTION LIKE '%{ cl_abap_dyn_prg=>escape_quotes( lv_search_string ) }%'|.


        IF io_request->is_data_requested( ).

          DATA(lv_top)           = io_request->get_paging( )->get_page_size( ).
          DATA(lv_skip)          = io_request->get_paging( )->get_offset( ).
          DATA(lt_clause)        = io_request->get_filter( )->get_as_sql_string( ).
          DATA(lt_fields)        = io_request->get_requested_elements( ).
          DATA(lt_sort)          = io_request->get_sort_elements( ).

          DATA(lv_max_rows)  = COND #( WHEN lv_top = if_rap_query_paging=>page_size_unlimited THEN 0
                                       ELSE lv_top ).

          TRY.
              DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ).
            CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).
          ENDTRY.

          io_response->set_total_number_of_records( lines( lt_data ) ).
          io_response->set_data( lt_data ).

        ELSEIF io_request->is_total_numb_of_rec_requested( ).

          io_response->set_total_number_of_records( lines( lt_data ) ).

        ENDIF.

      WHEN OTHERS.

    ENDCASE.


  ENDMETHOD.
ENDCLASS.
