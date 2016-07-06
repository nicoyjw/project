<?php
	$requestXmlBody = '<?xml version="1.0" encoding="utf-8"?><AddMemberMessageRTQRequest xmlns="urn:ebay:apis:eBLBaseComponents">
  <ItemID>'.$data['itemid'].'</ItemID>
  <MemberMessage>
    <Body><![CDATA['.$data['answer'].']]></Body>
	<DisplayToPublic>'.$ispub.'</DisplayToPublic>
	<EmailCopyToSender>false</EmailCopyToSender>
    <ParentMessageID>'.$data['messageid'].'</ParentMessageID>
    <RecipientID>'.$data['SenderID'].'</RecipientID>
  </MemberMessage>
  <RequesterCredentials>
    <eBayAuthToken>'.$userToken.'</eBayAuthToken>
  </RequesterCredentials>
</AddMemberMessageRTQRequest>';
?>