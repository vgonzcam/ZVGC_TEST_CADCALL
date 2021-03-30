CLASS zvgc_cl_generate_data_cadcall DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zvgc_cl_generate_data_cadcall IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    data: lit_cds TYPE STANDARD TABLE OF zvgc_cds_cadcall_h.

          SELECT *
          FROM zvgc_cds_cadcall_h
          into TABLE @data(lit_cds_tmp).

    DATA: lit_h TYPE STANDARD TABLE OF zvgc_t_cadcall_h.
    DATA: lit_i TYPE STANDARD TABLE OF zvgc_t_cadcall_i.

    GET TIME STAMP FIELD DATA(ts1).

    DATA(ts2) = cl_abap_tstmp=>subtractsecs(
                    tstmp = ts1
                    secs  = 28800 ).


    lit_h = VALUE #( ( header_id = '0000000001' status = 'O' priority = '1' estcost = '100.00' currkey = 'EUR')
                     ( header_id = '0000000002' status = 'D' priority = '1' estcost = '50.00' currkey = 'EUR') ) ##NO_TEXT.

    lit_i = VALUE #( ( header_id = '0000000001' pos_id = '001' servcode = 'PROGSAP' servdescr = 'IT SAP'
                       itemstatus = 'O' partcost = '52.50' labourcode = 'COD_BACK' labourcat = 'P'
                       labstarttime = ts2 labendtime = ts1 )
                     ( header_id = '0000000001' pos_id = '002' servcode = 'FUNCSAP' servdescr = 'Functional SAP'
                       itemstatus = 'O' partcost = '55.50' labourcode = 'FUNC_BACK' labourcat = 'P'
                       labstarttime = ts2 labendtime = ts1 )
                     ( header_id = '0000000002' pos_id = '001' servcode = 'PROGSAP' servdescr = 'IT SAP'
                       itemstatus = 'D' partcost = '52.50' labourcode = 'COD_BACK' labourcat = 'P'
                       labstarttime = ts2 labendtime = ts1 )
                     ( header_id = '0000000002' pos_id = '002' servcode = 'FUNCSAP' servdescr = 'Functional SAP'
                       itemstatus = 'D' partcost = '55.50' labourcode = 'FUNC_BACK' labourcat = 'P'
                       labstarttime = ts2 labendtime = ts1 ) ) ##NO_TEXT.

    "*   Delete the possible entries in the database table - in case it was already filled
    DELETE FROM zvgc_t_cadcall_h.
    "*   insert the new table entries
    INSERT zvgc_t_cadcall_h FROM TABLE @lit_h.

    "*   check the result
    SELECT * FROM zvgc_t_cadcall_h INTO TABLE @lit_h.
    out->write( sy-dbcnt ).
    out->write( 'data inserted successfully!').


    "*   Delete the possible entries in the database table - in case it was already filled
    DELETE FROM zvgc_t_cadcall_i.
    "*   insert the new table entries
    INSERT zvgc_t_cadcall_i FROM TABLE @lit_i.

    "*   check the result
    SELECT * FROM zvgc_t_cadcall_i INTO TABLE @lit_i.
    out->write( sy-dbcnt ).
    out->write( 'data inserted successfully!').



  ENDMETHOD .

ENDCLASS.
