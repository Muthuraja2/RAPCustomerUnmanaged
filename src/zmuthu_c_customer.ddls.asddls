@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'C view for Customer'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZMUTHU_C_CUSTOMER
  provider contract transactional_query
  as projection on ZMUTHU_R_CUSTOMER
{
  key Customeruuid,
      Name,
      City,
      Country,
      Email,
      Createdby,
      Lastchangedby,
      Createdat,
      Changedat
}
