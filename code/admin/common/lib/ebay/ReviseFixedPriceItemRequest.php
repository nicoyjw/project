<?php
   $requestXmlBody = '<?xml version="1.0" encoding="utf-8"?>
<ReviseFixedPriceItemRequest xmlns="urn:ebay:apis:eBLBaseComponents">
<WarningLevel>High</WarningLevel>
<Item>
  <ItemID>'.$itemid.'</ItemID>
  <Variation>
  <SKU>RLauren_Wom_TShirt_Blu_L</SKU>
  <Quantity>10</Quantity>
  </Variation>
  </Item>
  <RequesterCredentials> 
    <eBayAuthToken>'.$userToken.'</eBayAuthToken> 
  </RequesterCredentials> 
</ReviseFixedPriceItemRequest>';
?>