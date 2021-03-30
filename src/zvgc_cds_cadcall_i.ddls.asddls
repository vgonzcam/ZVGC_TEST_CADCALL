@AbapCatalog.sqlViewName: 'ZVGC_V_CADCALL_I'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS (Items)'
define view ZVGC_CDS_CADCALL_I
  as select from zvgc_t_cadcall_i
  association to parent ZVGC_CDS_CADCALL_H as _Header 
  on $projection.HeaderId = _Header.HeaderId
{
  key header_id    as HeaderId,
  key pos_id       as PosId,
      servcode     as Servcode,
      servdescr    as Servdescr,
      itemstatus   as Itemstatus,
      partcost     as Partcost,
      labourcode   as Labourcode,
      labourcat    as Labourcat,
      labstarttime as Labstarttime,
      labendtime   as Labendtime,
      //Associations
      _Header
}
