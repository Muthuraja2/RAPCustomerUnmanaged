@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view - Customer'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMUTHU_I_CUSTOMER
  as select from zmuthu_customer
{
  key customeruuid  as Customeruuid,
      name          as Name,
      city          as City,
      country       as Country,
      email         as Email,
      createdby     as Createdby,
      lastchangedby as Lastchangedby,
      createdat     as Createdat,
      changedat     as Changedat
}
