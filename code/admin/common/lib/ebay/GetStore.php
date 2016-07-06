<?php
   $requestXmlBody = '<?xml version="1.0" encoding="utf-8"?>
<GetStoreRequest xmlns="urn:ebay:apis:eBLBaseComponents">
  <RequesterCredentials> 
    <eBayAuthToken>'.$userToken.'</eBayAuthToken> 
  </RequesterCredentials> 
  <LevelLimit>3</LevelLimit>
</GetStoreRequest>';
?>