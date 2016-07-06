<?php
	/********************************************************************************
	  * AUTHOR: Michael Hawthornthwaite - Acid Computer Services (www.acidcs.co.uk) *
	  *******************************************************************************/
set_time_limit(50000);

class eBayBestmatchSession
{
	private $userToken;
	private $verb;
	public function __construct( $userToken, $callName,$globalid='EBAY-US')
	{
		$this->userToken = $userToken;
		$this->verb = $callName;
        $this->serverUrl = 'https://svcs.ebay.com/services/search/BestMatchItemDetailsService/v1'; 
		$this->globalid = $globalid;
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
		if($response === false)
		{
			return curl_error($connection);
		}
		curl_close($connection);
		return $response;
	}
	private function buildEbayHeaders()
	{
		$headers = array (
			'X-EBAY-SOA-SERVICE-NAME:  BestMatchItemDetailsService',
			'X-EBAY-SOA-OPERATION-NAME: '.$this->verb,
			'X-EBAY-SOA-SERVICE-VERSION: 1.5.0',
			'X-EBAY-SOA-GLOBAL-ID: '.$this->globalid,
			'X-EBAY-SOA-SECURITY-TOKEN: '.$this->userToken,
		);
		return $headers;
	}
}

?>