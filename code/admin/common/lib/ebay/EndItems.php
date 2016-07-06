<?php
   $requestXmlBody = '<?xml version="1.0" encoding="utf-8"?>
<EndItemsRequest xmlns="urn:ebay:apis:eBLBaseComponents">
<WarningLevel>High</WarningLevel>
<EndItemRequestContainer>
  <EndingReason>NotAvailable</EndingReason>';
  for($n=0;$n<count($itemlist);$n++){
  $requestXmlBody .= '<ItemID>'.$itemlist[$n].'</ItemID>';
  }
  $requestXmlBody .= '</EndItemRequestContainer><RequesterCredentials> 
    <eBayAuthToken>'.$userToken.'</eBayAuthToken> 
  </RequesterCredentials> 
</EndItemsRequest>';
?>