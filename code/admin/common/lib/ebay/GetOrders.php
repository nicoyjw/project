<?php
   $requestXmlBody = '<?xml version="1.0" encoding="utf-8"?> 
<GetOrdersRequest xmlns="urn:ebay:apis:eBLBaseComponents"> 
 <DetailLevel>ReturnAll</DetailLevel>
  <RequesterCredentials> 
    <eBayAuthToken>'.$userToken.'</eBayAuthToken> 
  </RequesterCredentials> 
  <CreateTimeFrom>'.$data[start].'</CreateTimeFrom> 
  <CreateTimeTo>'.$data[end].'</CreateTimeTo> 
  <OrderRole>Seller</OrderRole> 
  <OrderStatus>Completed</OrderStatus> 
  <Pagination>
      <EntriesPerPage>199</EntriesPerPage>
      <PageNumber>'.$page.'</PageNumber>
  </Pagination>
</GetOrdersRequest>';
?>