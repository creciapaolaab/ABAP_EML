CLASS lhc_Supplement DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS calculateTotalSupplPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Supplement~calculateTotalSupplPrice.

ENDCLASS.

CLASS lhc_Supplement IMPLEMENTATION.

  METHOD calculateTotalSupplPrice.
    IF NOT keys IS INITIAL.
      zcl_aux_trav_det_2914=>calculate_price( it_travel_id =
      VALUE #( FOR GROUPS <booking_suppl> OF booking_key IN keys
             GROUP BY booking_key-TravelId WITHOUT MEMBERS ( <booking_suppl> ) ) ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.


CLASS lsc_supplement DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PUBLIC SECTION.
    CONSTANTS: create TYPE string VALUE 'C',
               update TYPE string VALUE 'U',
               delete TYPE string VALUE 'D'.
  PROTECTED SECTION.
    METHODS save_modified REDEFINITION.
ENDCLASS.

CLASS lsc_supplement IMPLEMENTATION.

  METHOD save_modified.
    DATA: lt_supplements TYPE STANDARD TABLE OF zbooksuppl_2914,
          lv_op_type     TYPE zde_flag_2914,
          lv_update      TYPE zde_flag_2914.
    IF NOT create-supplement IS INITIAL.
      lt_supplements = CORRESPONDING #( create-supplement ).
      lv_op_type = lsc_supplement=>create.
    ENDIF.
    IF NOT update-supplement IS INITIAL.
      lt_supplements = CORRESPONDING #( create-supplement ).
      lv_op_type = lsc_supplement=>update.
    ENDIF.
    IF NOT delete-supplement IS INITIAL.
      lt_supplements = CORRESPONDING #( create-supplement ).
      lv_op_type = lsc_supplement=>delete.
    ENDIF.

    IF NOT lt_supplements is INITIAL.


        CALL FUNCTION 'ZFM_SUPPL_2914'
          EXPORTING
            it_supplements = lt_supplements
            iv_op_type     =  lv_op_type
           IMPORTING
            ev_updated     = lv_update
          .
        if lv_update EQ abap_true.
*        reported-supplement[ 1 ]-
        ENDIF.

    ENDIF.
    ENDMETHOD.

ENDCLASS.
