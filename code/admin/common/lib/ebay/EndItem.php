<?php
   $requestXmlBody = '<?xml version="1.0" encoding="utf-8"?>
<EndItemRequest xmlns="urn:ebay:apis:eBLBaseComponents">
<WarningLevel>High</WarningLevel>
  <EndingReason>NotAvailable</EndingReason>
  <ItemID>'.$itemid.'</ItemID>
  <RequesterCredentials> 
    <eBayAuthToken>'.$userToken.'</eBayAuthToken> 
  </RequesterCredentials> 
</EndItemRequest>';
?>