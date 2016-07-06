<?php
	$requestXmlBody = '<?xml version="1.0" encoding="utf-8"?><AddMemberMessageAAQToPartnerRequest xmlns="urn:ebay:apis:eBLBaseComponents">
  <ItemID>'.$data['itemid'].'</ItemID>
  <MemberMessage>
    <Body><![CDATA['.$data['answer'].']]></Body>
	<EmailCopyToSender>true</EmailCopyToSender>
	<QuestionType>General</QuestionType>
    <RecipientID>'.$data['SenderID'].'</RecipientID>
	<Subject>'.$data['subject'].'</Subject>
  </MemberMessage>
  <RequesterCredentials>
    <eBayAuthToken>'.$userToken.'</eBayAuthToken>
  </RequesterCredentials>
</AddMemberMessageAAQToPartnerRequest>';
?>