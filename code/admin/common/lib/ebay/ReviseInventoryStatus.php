<?php
	$requestXmlBody = '<?xml version="1.0" encoding="utf-8"?>
<ReviseInventoryStatusRequest xmlns="urn:ebay:apis:eBLBaseComponents">
  <RequesterCredentials>
    <eBayAuthToken>'.$userToken.'</eBayAuthToken>
  </RequesterCredentials>
  <Version>777</Version>
  <ErrorLanguage>en_US</ErrorLanguage>
  <WarningLevel>High</WarningLevel>
<InventoryStatus>
    <ItemID>'.$info['ItemID'].'</ItemID>';
	if($info['SKU']) $requestXmlBody .= '<SKU>'.$info['SKU'].'</SKU>';
	$requestXmlBody .= '<StartPrice>'.$info['StartPrice'].'</StartPrice>
    <Quantity>'.$info['Quantity'].'</Quantity>
  </InventoryStatus>
</ReviseInventoryStatusRequest>';
?>