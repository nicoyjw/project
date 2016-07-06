<?php
$requestXmlBody = '<?xml version="1.0" encoding="utf-8"?>
<findBestMatchItemDetailsBySellerRequest xmlns="http://www.ebay.com/marketplace/search/v1/services">
 <categoryId>'.$cat_id.'</categoryId>
  <ignoreFeatured>true</ignoreFeatured>
  <paginationInput>
    <entriesPerPage>100</entriesPerPage>
    <pageNumber>'.$page.'</pageNumber>
  </paginationInput>
   <sellerUserName>'.$APISellerUserID.'</sellerUserName>
</findBestMatchItemDetailsBySellerRequest>';
?>