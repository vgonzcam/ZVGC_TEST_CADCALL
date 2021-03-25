FUNCTION zvgc_fm_test_cadcall.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     REFERENCE(EX_TIME_ZONE) TYPE  STRING
*"     REFERENCE(EX_DATE) TYPE  STRING
*"     REFERENCE(EX_TIME) TYPE  STRING
*"  RAISING
*"      CX_ROOT
*"----------------------------------------------------------------------
  ex_time_zone = cl_abap_context_info=>get_user_time_zone( ).
  ex_date = cl_abap_context_info=>get_system_date( ).
  ex_time = cl_abap_context_info=>get_system_time( ).

ENDFUNCTION.
