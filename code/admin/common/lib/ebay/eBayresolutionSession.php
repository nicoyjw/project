<?php
set_time_limit(50000);
$serverUrl = 'https://svcs.ebay.com/services/resolution/v1/ResolutionCaseManagementService'; 
$siteID = 0;

class eBayresolutionSession
{
	private $requestToken;
	private $serverUrl;
	private $siteID;
	private $verb;
	
	public function __construct($userRequestToken, $serverUrl, $siteToUseID, $callName)
	{
		$this->requestToken = $userRequestToken;
		$this->siteID = $siteToUseID;
		$this->verb = $callName;
        $this->serverUrl = $serverUrl;	
	}
	
	public function sendHttpRequest($requestBody)
	{
		$headers = $this->buildEbayHeaders();
		$connection = curl_init();
		curl_setopt($connection, CURLOPT_URL, $this->serverUrl);
		curl_setopt($connection, CURLOPT_SSL_VERIFYPEER, 0);
		curl_setopt($connection, CURLOPT_SSL_VERIFYHOST, 0);
		curl_setopt($connection, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($connection, CURLOPT_POST, 1);
		curl_setopt($connection, CURLOPT_POSTFIELDS, $requestBody);
		curl_setopt($connection, CURLOPT_RETURNTRANSFER, 1);
		$response = curl_exec($connection);
		curl_close($connection);
		return $response;
	}
	
	private function buildEbayHeaders()
	{
		$headers = array (
			'X-EBAY-SOA-SECURITY-TOKEN: '.$this->requestToken,
			'X-EBAY-SOA-OPERATION-NAME: ' . $this->verb,			
			'X-EBAY-API-SITEID: ' . $this->siteID,
		);
		
		return $headers;
	}
}
?>