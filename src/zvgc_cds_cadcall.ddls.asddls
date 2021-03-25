@EndUserText.label: 'FM CALL'
@ObjectModel.query.implementedBy: 'ABAP:ZVGC_CL_TEST_CADCALL'


@UI.headerInfo: { typeName:       'Date, time and time zone information' ,
                  typeNamePlural: 'Date, time and time zone information' ,
                  title: { type: #STANDARD, label: 'General information for ', value: 'ex_date' } }

define custom entity ZVGC_CDS_CADCALL
{
      @UI.lineItem :  [{label: 'Time Zone', position: 10  }]
      @UI.identification:[ { position: 10, label: 'Airline' } ]
      @EndUserText.quickInfo: 'Huso horario.'
  key ex_time_zone : abap.string;
      @UI.lineItem :  [{label: 'Date', position: 20 ,importance: #HIGH }]
      @Semantics.systemDateTime.createdAt: true
  key ex_date      : abap.dats;
      @UI.lineItem :  [{label: 'Time', position: 30 ,importance: #HIGH }]
  key ex_time      : abap.tims;

}
