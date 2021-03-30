@AbapCatalog.sqlViewName: 'ZVGC_V_CADCALL_H'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS (Header)'
@ObjectModel.query.implementedBy: 'ABAP:ZVGC_CL_TEST_CADCALL'
define root view ZVGC_CDS_CADCALL_H
  as select from zvgc_t_cadcall_h
  association [0..*] to ZVGC_CDS_CADCALL_I as _Item 
  on $projection.HeaderId = _Item.HeaderId
{
  key header_id as HeaderId,
      status    as Status,
      priority  as Priority,
      estcost   as Estcost,
      currkey   as Currkey,
      //Associations
      _Item
}
