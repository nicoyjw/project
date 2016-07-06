<?php
 $config = array (
   'ServiceURL' => $serviceUrl,
   'ProxyHost' => null,
   'ProxyPort' => -1,
   'MaxErrorRetry' => 3,
 );
 require_once(CFG_PATH_LIB."amazon/report/client.php");
 $service = new MarketplaceWebService_Client( $AWS_ACCESS_KEY_ID,$AWS_SECRET_ACCESS_KEY,$config,$APPLICATION_NAME,'2009-01-01'); 
?>