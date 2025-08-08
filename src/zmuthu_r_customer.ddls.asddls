@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R view for Customer'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZMUTHU_R_CUSTOMER
  as select from ZMUTHU_I_CUSTOMER
{
  key Customeruuid,
      Name,
      City,
      Country,
      Email,
      @Semantics.user.createdBy: true
      Createdby,
      @Semantics.user.lastChangedBy: true
      Lastchangedby,
      @Semantics.systemDateTime.createdAt: true
      Createdat,
      @Semantics.systemDateTime.lastChangedAt: true
      Changedat
}
