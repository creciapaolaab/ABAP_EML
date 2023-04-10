CLASS lcl_buffer DEFINITION.
  PUBLIC SECTION.

    CONSTANTS: create TYPE c LENGTH 1 VALUE 'C',
               update TYPE c LENGTH 1 VALUE 'U',
               delete TYPE c LENGTH 1 VALUE 'D'.

    TYPES: BEGIN OF ty_buffer_master.
             INCLUDE TYPE zhc_master_2914 AS data.
    TYPES:   flag TYPE c LENGTH 1,
           END OF ty_buffer_master.
    TYPES: tt_master TYPE SORTED TABLE OF ty_buffer_master WITH UNIQUE KEY e_number.

    CLASS-DATA: mt_buffer_master TYPE tt_master.

ENDCLASS.



CLASS lhc_HCMMaster DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR HCMMaster RESULT result.

    METHODS: create FOR MODIFY IMPORTING entities FOR CREATE HCMMaster,
      update FOR MODIFY IMPORTING entities FOR UPDATE HCMMaster,
      delete FOR MODIFY IMPORTING keys FOR DELETE HCMMaster.

    METHODS read FOR READ
      IMPORTING keys FOR READ HCMMaster RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK HCMMaster.

ENDCLASS.

CLASS lhc_HCMMaster IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.


GET TIME STAMP FIELD DATA(lv_time_stamp).
DATA(lv_uname) = cl_abap_context_info=>get_user_technical_name( ).

    SELECT MAX( e_number ) FROM zhc_master_2914
    INTO @DATA(lv_max_employee_number).

    LOOP AT entities INTO DATA(ls_entities).
      ls_entities-%data-CreaDateTime = lv_time_stamp.
      ls_entities-%data-CreaUname = lv_uname.
      ls_entities-%data-ENumber = lv_max_employee_number + 1.

      INSERT VALUE #( flag = lcl_buffer=>create
                    data = CORRESPONDING #( ls_entities-%data ) )
                    INTO TABLE lcl_buffer=>mt_buffer_master.

      IF NOT ls_entities-%cid IS INITIAL.
        INSERT VALUE #( %cid = ls_entities-%cid
                        ENumber = ls_entities-ENumber

                        ) into table mapped-hcmmaster.
      ENDIF.


    ENDLOOP.
  ENDMETHOD.

  METHOD update.

    GET TIME STAMP FIELD DATA(lv_time_stamp).

    DATA(lv_uname) = cl_abap_context_info=>get_user_technical_name( ).



    LOOP AT entities INTO DATA(ls_entities).

    SELECT single * FROM zhc_master_2914
     WHERE e_number eq @ls_entities-ENumber
     INTO @DATA(ls_ddbb).

      ls_entities-%data-LchgDateTime = lv_time_stamp.
      ls_entities-%data-LchgUname = lv_uname.

      INSERT VALUE #( flag = lcl_buffer=>update
                    data = VALUE #( e_number = ls_entities-%data-ENumber
                                    e_name = cond #( when ls_entities-%control-EName eq if_abap_behv=>mk-on
                                    then ls_entities-%data-EName
                                    else ls_ddbb-e_name )
                                    e_department = cond #( when ls_entities-%control-EDepartment eq if_abap_behv=>mk-on
                                    then ls_entities-%data-EDepartment
                                    else ls_ddbb-e_department )
                                    status = cond #( when ls_entities-%control-status eq if_abap_behv=>mk-on
                                    then ls_entities-%data-Status
                                    else ls_ddbb-status )
                                    job_title  = cond #( when ls_entities-%control-JobTitle  eq if_abap_behv=>mk-on
                                    then ls_entities-%data-JobTitle
                                    else ls_ddbb-job_title )
                                    start_date   = cond #( when ls_entities-%control-StartDate  eq if_abap_behv=>mk-on
                                    then ls_entities-%data-StartDate
                                    else ls_ddbb-start_date )
                                    end_date   = cond #( when ls_entities-%control-EndDate eq if_abap_behv=>mk-on
                                    then ls_entities-%data-EndDate
                                    else ls_ddbb-end_date )
                                    email    = cond #( when ls_entities-%control-Email eq if_abap_behv=>mk-on
                                    then ls_entities-%data-Email
                                    else ls_ddbb-email  )
                                    m_number    = cond #( when ls_entities-%control-MNumber eq if_abap_behv=>mk-on
                                    then ls_entities-%data-MNumber
                                    else ls_ddbb-m_number  )
                                    m_name    = cond #( when ls_entities-%control-MName eq if_abap_behv=>mk-on
                                    then ls_entities-%data-MName
                                    else ls_ddbb-m_name  )
                                    m_department    = cond #( when ls_entities-%control-MDepartment eq if_abap_behv=>mk-on
                                    then ls_entities-%data-MDepartment
                                    else ls_ddbb-m_department  )
                                    crea_date_time   =  ls_ddbb-crea_date_time
                                    crea_uname       = ls_ddbb-crea_uname

                                  ) ) INTO TABLE lcl_buffer=>mt_buffer_master.

      IF NOT ls_entities-ENumber IS INITIAL.
        INSERT VALUE #( %cid = ls_entities-%data-ENumber
                        ENumber = ls_entities-%data-ENumber ) into table mapped-hcmmaster.
      ENDIF.


    ENDLOOP.
  ENDMETHOD.

  METHOD delete.

  loop at keys into data(ls_keys).

  insert value #( flag = lcl_buffer=>delete
                  data = value #( e_number = ls_keys-ENumber ) ) into table  lcl_buffer=>mt_buffer_master.
  if not ls_keys-ENumber is initial.
  insert value #( %cid = ls_keys-%key-ENumber
                  ENumber = ls_keys-%key-ENumber   ) into table mapped-hcmmaster.
  endif.

  endloop.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_HCMMaster DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS: finalize REDEFINITION,
      check_before_save REDEFINITION,
      save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_HCMMaster IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  data: lt_data_created type STANDARD TABLE OF zhc_master_2914,
        lt_data_update type STANDARD TABLE OF zhc_master_2914,
        lt_data_delete type STANDARD TABLE OF zhc_master_2914.

lt_data_created = VALUE #( FOR <row> IN lcl_buffer=>mt_buffer_master
WHERE ( flag = lcl_buffer=>create ) ( <row>-data ) ).

  IF not lt_data_created is INITIAL.
  insert zhc_master_2914 from table @lt_data_created.
  ENDIF.

  lt_data_update = value #( For <row> IN lcl_buffer=>mt_buffer_master
  WHERE ( flag = lcl_buffer=>update ) ( <row>-data ) ).

  IF not lt_data_update is INITIAL.
  update zhc_master_2914 from table @lt_data_update.
  ENDIF.

  lt_data_delete = value #( For <row> IN lcl_buffer=>mt_buffer_master
  WHERE ( flag = lcl_buffer=>delete ) ( <row>-data ) ).

  IF not lt_data_delete is INITIAL.
  delete zhc_master_2914 from table @lt_data_delete.
  ENDIF.

    CLEAR lcl_buffer=>mt_buffer_master.


  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
