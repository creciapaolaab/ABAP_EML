@EndUserText.label: 'Consuption HCM MASTER'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity Z_C_HCM_MASTER_2914
provider contract transactional_query
  as projection on Z_I_HCM_MASTER_2914
{
@ObjectModel.text.element: ['EmployeeName']
  key ENumber      as EmployeeNumber,
      EName        as EmployeeName,
      EDepartment  as EmployeeDepartament,
      Status       as EmployeeStatus,
      JobTitle     as JobTitle,
      StartDate    as StartDate,
      EndDate      as EndDate,
      Email        as Email,
      MNumber      as ManagerNumber,
@ObjectModel.text.element: ['ManagerName']
      MName        as ManagerName,
      MDepartment  as ManagerDepartament,
@Semantics.user.createdBy: true
      CreaDateTime as CreatedOn,
@Semantics.user.lastChangedBy: true
      CreaUname    as CreatedBy,
      LchgDateTime as ChangedOn,
      LchgUname    as ChangedBy
}
