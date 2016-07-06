<?php
 $config = array (
   'ServiceURL' => $serviceUrl,
   'ProxyHost' => null,
   'ProxyPort' => -1,
   'MaxErrorRetry' => 3,
 );
 require_once(CFG_PATH_LIB."amazon/Client.php");
 $service = new MarketplaceWebServiceOrders_Client($AWS_ACCESS_KEY_ID,$AWS_SECRET_ACCESS_KEY,$APPLICATION_NAME,$APPLICATION_VERSION,$config);
?>