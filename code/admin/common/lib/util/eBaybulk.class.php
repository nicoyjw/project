<?php
	/********************************************************************************
	  * AUTHOR: Michael Hawthornthwaite - Acid Computer Services (www.acidcs.co.uk) *
	  *******************************************************************************/
set_time_limit(50000);

class eBaybulk
{
	private $requestToken;
	private $serverUrl;
	private $verb;
	
	public function __construct($userRequestToken, $serverUrl, $callName)
	{
		$this->requestToken = $userRequestToken;
		$this->verb = $callName;
        $this->serverUrl = $serverUrl;	
	}
	
	public function sendHttpRequest($requestBody)
	{
		//build eBay headers using variables passed via constructor
		$headers = $this->buildEbayHeaders();
		
		//initialise a CURL session
		$connection = curl_init();
		//set the server we are using (could be Sandbox or Production server)
		curl_setopt($connection, CURLOPT_URL, $this->serverUrl);
		
		//stop CURL from verifying the peer's certificate
		curl_setopt($connection, CURLOPT_SSL_VERIFYPEER, 0);
		curl_setopt($connection, CURLOPT_SSL_VERIFYHOST, 0);
		
		//set the headers using the array of headers
		curl_setopt($connection, CURLOPT_HTTPHEADER, $headers);
		
		//set method as POST
		curl_setopt($connection, CURLOPT_POST, 1);
		
		//set the XML body of the request
		curl_setopt($connection, CURLOPT_POSTFIELDS, $requestBody);
		
		//set it to return the transfer as a string from curl_exec
		curl_setopt($connection, CURLOPT_RETURNTRANSFER, 1);
		//Send the Request
		$response = curl_exec($connection);
		
		//close the connection
		curl_close($connection);
		
		//return the response
		return $response;
	}
	
	private function buildEbayHeaders()
	{
		$headers = array (
			//Regulates versioning of the XML interface for the API
			'X-EBAY-SOA-SECURITY-TOKEN: ' . $this->requestToken,
			//the name of the call we are requesting
			'X-EBAY-SOA-OPERATION-NAME: ' . $this->verb,			
		);
		
		return $headers;
	}
}
?>