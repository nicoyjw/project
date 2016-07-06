<?php
/** 
 *  PHP Version 5
 *
 *  @category    Amazon
 *  @package     MarketplaceWebService
 *  @copyright   Copyright 2009 Amazon Technologies, Inc.
 *  @link        http://aws.amazon.com
 *  @license     http://aws.amazon.com/apache2.0  Apache License, Version 2.0
 *  @version     2009-01-01
 */
/******************************************************************************* 

 *  Marketplace Web Service PHP5 Library
 *  Generated: Thu May 07 13:07:36 PDT 2009
 * 
 */

/**
 * Get Report  Sample
 */

   define ('DATE_FORMAT', 'Y-m-d\TH:i:s\Z');
	define('AWS_ACCESS_KEY_ID', 'AKIAJMFC24444LZMYHRQ');
    define('AWS_SECRET_ACCESS_KEY', '9XPcMunb1fw5iQdPSd0iIgz+DQwkA1ShJFHR3WKU');
    define('APPLICATION_NAME', 'softsilkroad');
    define('APPLICATION_VERSION', '2009-01-01');
    define ('MERCHANT_ID', 'A2AABCJ3W6HI6H');
    define ('MARKETPLACE_ID', 'A1F83G8C2ARO7P');
 require_once("client.php");
 require_once("GetReportRequest.php");
 require_once("Exception.php");

/************************************************************************
* Uncomment to configure the client instance. Configuration settings
* are:
*
* - MWS endpoint URL
* - Proxy host and port.
* - MaxErrorRetry.
***********************************************************************/
// IMPORTANT: Uncomment the approiate line for the country you wish to
// sell in:
// United States:
//$serviceUrl = "https://mws.amazonservices.com";
// United Kingdom
$serviceUrl = "https://mws.amazonservices.co.uk";
// Germany
//$serviceUrl = "https://mws.amazonservices.de";
// France
//$serviceUrl = "https://mws.amazonservices.fr";
// Italy
//$serviceUrl = "https://mws.amazonservices.it";
// Japan
//$serviceUrl = "https://mws.amazonservices.jp";
// China
//$serviceUrl = "https://mws.amazonservices.com.cn";
// Canada
//$serviceUrl = "https://mws.amazonservices.ca";
// India
//$serviceUrl = "https://mws.amazonservices.in";

$config = array (
  'ServiceURL' => $serviceUrl,
  'ProxyHost' => null,
  'ProxyPort' => -1,
  'MaxErrorRetry' => 3,
);

/************************************************************************
 * Instantiate Implementation of MarketplaceWebService
 * 
 * AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY constants 
 * are defined in the .config.inc.php located in the same 
 * directory as this sample
 ***********************************************************************/
 $service = new MarketplaceWebService_Client(
     AWS_ACCESS_KEY_ID, 
     AWS_SECRET_ACCESS_KEY, 
     $config,
     APPLICATION_NAME,
     APPLICATION_VERSION);
 
/************************************************************************
 * Uncomment to try out Mock Service that simulates MarketplaceWebService
 * responses without calling MarketplaceWebService service.
 *
 * Responses are loaded from local XML files. You can tweak XML files to
 * experiment with various outputs during development
 *
 * XML files available under Mock tree
 *
 ***********************************************************************/
 // $service = new MarketplaceWebService_Mock();

/************************************************************************
 * Setup request parameters and uncomment invoke to try out 
 * sample for Get Report Action
 ***********************************************************************/
 // @TODO: set request. Action can be passed as MarketplaceWebService_Model_GetReportRequest
 // object or array of parameters
 $reportId = '12952884104';
 $myHandle = @fopen('abc.txt', 'rw+');
 $parameters = array (
   'Merchant' => MERCHANT_ID,
   'Report' => $myHandle,
   'ReportId' => $reportId,
 );
 $request = new MarketplaceWebService_Model_GetReportRequest($parameters);

//$request = new MarketplaceWebService_Model_GetReportRequest();
//$request->setMerchant(MERCHANT_ID);
//$request->setReport(@fopen('php://memory', 'rw+'));
//$request->setReportId($reportId);
 
print_r($service->getReport($request));die();
//rewind($myHandle);
$response = stream_get_contents($myHandle);
			$fp = fopen('abc.csv', 'w');
			fputs($fp, $response);
			fclose($fp);
?>