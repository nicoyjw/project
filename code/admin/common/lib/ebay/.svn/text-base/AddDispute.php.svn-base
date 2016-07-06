<?php
   $requestXmlBody = '<?xml version="1.0" encoding="utf-8"?>
<AddDisputeRequest xmlns="urn:ebay:apis:eBLBaseComponents">
<WarningLevel>High</WarningLevel>
  <DisputeExplanation>'.(($type==1)?'OtherExplanation':'BuyerHasNotPaid').'</DisputeExplanation>
  <DisputeReason>TransactionMutuallyCanceled</DisputeReason>
  <OrderLineItemID>'.$OrderLineItemID.'</OrderLineItemID>
  <RequesterCredentials> 
    <eBayAuthToken>'.$userToken.'</eBayAuthToken> 
  </RequesterCredentials> 
</AddDisputeRequest>';
?>