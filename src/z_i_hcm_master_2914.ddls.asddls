@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'HCM MASTER'
define root view entity Z_I_HCM_MASTER_2914 
as select from zhc_master_2914 as HCMMaster
{
    
key e_number as ENumber,
e_name as EName,
e_department as EDepartment,
status as Status,
job_title as JobTitle,
start_date as StartDate,
end_date as EndDate,
email as Email,
m_number as MNumber,
m_name as MName,
m_department as MDepartment,
crea_date_time as CreaDateTime,
crea_uname as CreaUname,
lchg_date_time as LchgDateTime,
lchg_uname as LchgUname

}
