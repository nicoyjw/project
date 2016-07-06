<?php
   $requestXmlBody = '<?xml version="1.0" encoding="utf-8"?> 
<GetFeedbackRequest xmlns="urn:ebay:apis:eBLBaseComponents"> 
  <RequesterCredentials> 
    <eBayAuthToken>'.$userToken.'</eBayAuthToken> 
  </RequesterCredentials> 
  <OutputSelector>FeedbackDetailArray.FeedbackDetail.CommentingUser</OutputSelector>
  <OutputSelector>FeedbackDetailArray.FeedbackDetail.CommentText</OutputSelector>
  <OutputSelector>FeedbackDetailArray.FeedbackDetail.CommentTime</OutputSelector>
  <OutputSelector>FeedbackDetailArray.FeedbackDetail.CommentType</OutputSelector>
  <OutputSelector>FeedbackDetailArray.FeedbackDetail.ItemID</OutputSelector>
  <OutputSelector>FeedbackDetailArray.FeedbackDetail.FeedbackResponse</OutputSelector>
  <OutputSelector>FeedbackDetailArray.FeedbackDetail.FeedbackID</OutputSelector>
  <OutputSelector>FeedbackDetailArray.FeedbackDetail.TransactionID</OutputSelector>
  <OutputSelector>FeedbackDetailArray.FeedbackDetail.ItemTitle</OutputSelector>
  <OutputSelector>FeedbackDetailArray.FeedbackDetail.ItemPrice</OutputSelector>
<DetailLevel>ReturnAll</DetailLevel>
 <CommentType>Positive</CommentType>
 <CommentType>Negative</CommentType>
 <CommentType>Neutral</CommentType>
 <CommentType>Withdrawn</CommentType>
    <Pagination>
	<PageNumber>'.$page.'</PageNumber>
    <EntriesPerPage>200</EntriesPerPage>
  </Pagination>
</GetFeedbackRequest>';
?>