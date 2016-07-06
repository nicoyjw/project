<?php
	if($data['str'] ==''){
	$requestXmlBody = '<?xml version="1.0" encoding="utf-8"?><GetMyMessagesRequest xmlns="urn:ebay:apis:eBLBaseComponents"><RequesterCredentials><eBayAuthToken>'.$userToken.'</eBayAuthToken></RequesterCredentials><DetailLevel>ReturnHeaders</DetailLevel><FolderID>0</FolderID><StartTime>'.$data[start].'</StartTime><EndTime>'.$data[end].'</EndTime><Pagination><EntriesPerPage>200</EntriesPerPage><PageNumber>'.$page.'</PageNumber></Pagination></GetMyMessagesRequest>';
	}else{
	$requestXmlBody = '<?xml version="1.0" encoding="utf-8"?><GetMyMessagesRequest xmlns="urn:ebay:apis:eBLBaseComponents"><RequesterCredentials><eBayAuthToken>'.$userToken.'</eBayAuthToken></RequesterCredentials><DetailLevel>ReturnMessages</DetailLevel><FolderID>0</FolderID><MessageIDs>'.$data[str].'</MessageIDs><Pagination><EntriesPerPage>200</EntriesPerPage><PageNumber>'.$page.'</PageNumber></Pagination></GetMyMessagesRequest>';
	}
?>