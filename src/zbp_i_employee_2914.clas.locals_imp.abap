CLASS lhc_Z_I_EMPLOYEE_2914 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR z_i_employee_2914 RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE z_i_employee_2914.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE z_i_employee_2914.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE z_i_employee_2914.

    METHODS read FOR READ
      IMPORTING keys FOR READ z_i_employee_2914 RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK z_i_employee_2914.

ENDCLASS.

CLASS lhc_Z_I_EMPLOYEE_2914 IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_Z_I_EMPLOYEE_2914 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_Z_I_EMPLOYEE_2914 IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
