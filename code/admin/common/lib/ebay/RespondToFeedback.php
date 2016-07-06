<?php
	$requestXmlBody = '<?xml version="1.0" encoding="utf-8"?><RespondToFeedbackRequest xmlns="urn:ebay:apis:eBLBaseComponents">
<TargetUserID>'.$data['CommentingUser'].'</TargetUserID>
<FeedbackID>'.$data['FeedbackID'].'</FeedbackID>
  <ItemID>'.$data['ItemID'].'</ItemID>
  <TransactionID>'.$data['TransactionID'].'</TransactionID>
  <ResponseType>'.$data['ResponseType'].'</ResponseType>
  <ResponseText>'.$data['FeedbackResponse'].'</ResponseText>	
  <RequesterCredentials>
    <eBayAuthToken>'.$userToken.'</eBayAuthToken>
  </RequesterCredentials>
</RespondToFeedbackRequest>';
?>