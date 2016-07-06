<?php
	$requestXmlBody = '<?xml version="1.0" encoding="utf-8"?>
<GetSellerTransactionsRequest xmlns="urn:ebay:apis:eBLBaseComponents">
  <RequesterCredentials>
    <eBayAuthToken>'.$userToken.'</eBayAuthToken>
  </RequesterCredentials>  
  <OutputSelector>PaginationResult</OutputSelector>
  <OutputSelector>Seller.UserID</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.AmountPaid</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.FinalValueFee</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.OrderLineItemID</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.TransactionSiteID</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.Buyer.BuyerInfo</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.Buyer.Email</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.Buyer.UserID</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.ContainingOrder.OrderID</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.ContainingOrder.OrderStatus</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.CreatedDate</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.Status.eBayPaymentStatus</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.Status.CompleteStatus</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.PaidTime</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.ShippedTime</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.BuyerCheckoutMessage</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.ShippingDetails.ShipmentTrackingDetails.ShipmentTrackingNumber</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.TransactionID</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.ExternalTransaction.ExternalTransactionID</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.ExternalTransaction.PaymentOrRefundAmount</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.ExternalTransaction.FeeOrCreditAmount</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.Item.ItemID</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.ShippingServiceSelected.ShippingService</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.ShippingServiceSelected.ShippingServiceCost</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.ShippingDetails.SellingManagerSalesRecordNumber</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.Item.Currency</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.Item.Country</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.Item.ItemID</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.Item.Title</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.Item.SKU</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.Item.SellingStatus.CurrentPrice</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.Item.SellingStatus.BidCount</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.QuantityPurchased</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.Item.StartPrice</OutputSelector>
  <OutputSelector>TransactionArray.Transaction.PayPalEmailAddress</OutputSelector>
  <DetailLevel>ReturnAll</DetailLevel>
      <ModTimeFrom>'.$data[start].'</ModTimeFrom>
      <ModTimeTo>'.$data[end].'</ModTimeTo>
	  <Pagination>
        <EntriesPerPage>199</EntriesPerPage>
        <PageNumber>'.$page.'</PageNumber>
      </Pagination>
		  <IncludeFinalValueFee>true</IncludeFinalValueFee>
      <IncludeContainingOrder>true</IncludeContainingOrder>
</GetSellerTransactionsRequest>';
?>