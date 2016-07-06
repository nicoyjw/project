<?php
/** 
 *  PHP Version 5
 *
 *  @category    Amazon
 *  @package     MarketplaceWebServiceProducts
 *  @copyright   Copyright 2008-2013 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *  @link        http://aws.amazon.com
 *  @license     http://aws.amazon.com/apache2.0  Apache License, Version 2.0
 *  @version     2011-10-01
 */
 
/******************************************************************************* 
 * 
 *  Marketplace Web Service Products PHP5 Library
 *  Generated: Wed Sep 25 16:54:47 GMT 2013
 * 
 */

/**
 *  @see MarketplaceWebServiceProducts_Model
 */

require_once (dirname(__FILE__) . '/../Model.php');


/**
 * MarketplaceWebServiceProducts_Model_OfferType
 * 
 * Properties:
 * <ul>
 * 
 * <li>BuyingPrice: MarketplaceWebServiceProducts_Model_PriceType</li>
 * <li>RegularPrice: MarketplaceWebServiceProducts_Model_MoneyType</li>
 * <li>FulfillmentChannel: string</li>
 * <li>ItemCondition: string</li>
 * <li>ItemSubCondition: string</li>
 * <li>SellerId: string</li>
 * <li>SellerSKU: string</li>
 *
 * </ul>
 */

 class MarketplaceWebServiceProducts_Model_OfferType extends MarketplaceWebServiceProducts_Model {

    public function __construct($data = null)
    {
        $this->_fields = array (
            'BuyingPrice' => array('FieldValue' => null, 'FieldType' => 'MarketplaceWebServiceProducts_Model_PriceType'),
            'RegularPrice' => array('FieldValue' => null, 'FieldType' => 'MarketplaceWebServiceProducts_Model_MoneyType'),
            'FulfillmentChannel' => array('FieldValue' => null, 'FieldType' => 'string'),
            'ItemCondition' => array('FieldValue' => null, 'FieldType' => 'string'),
            'ItemSubCondition' => array('FieldValue' => null, 'FieldType' => 'string'),
            'SellerId' => array('FieldValue' => null, 'FieldType' => 'string'),
            'SellerSKU' => array('FieldValue' => null, 'FieldType' => 'string'),
        );
	    parent::__construct($data);
    }

    /**
     * Get the value of the BuyingPrice property.
     *
     * @return PriceType BuyingPrice.
     */
    public function getBuyingPrice()
	{
	    return $this->_fields['BuyingPrice']['FieldValue'];
    }

    /**
     * Set the value of the BuyingPrice property.
     *
     * @param MarketplaceWebServiceProducts_Model_PriceType buyingPrice
     * @return this instance
     */
    public function setBuyingPrice($value)
	{
	    $this->_fields['BuyingPrice']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if BuyingPrice is set.
     *
     * @return true if BuyingPrice is set.
     */
    public function isSetBuyingPrice()
	{
	            return !is_null($this->_fields['BuyingPrice']['FieldValue']);
		    }

    /**
     * Set the value of BuyingPrice, return this.
     *
     * @param buyingPrice
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withBuyingPrice($value)
	{
        $this->setBuyingPrice($value);
        return $this;
    }

    /**
     * Get the value of the RegularPrice property.
     *
     * @return MoneyType RegularPrice.
     */
    public function getRegularPrice()
	{
	    return $this->_fields['RegularPrice']['FieldValue'];
    }

    /**
     * Set the value of the RegularPrice property.
     *
     * @param MarketplaceWebServiceProducts_Model_MoneyType regularPrice
     * @return this instance
     */
    public function setRegularPrice($value)
	{
	    $this->_fields['RegularPrice']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if RegularPrice is set.
     *
     * @return true if RegularPrice is set.
     */
    public function isSetRegularPrice()
	{
	            return !is_null($this->_fields['RegularPrice']['FieldValue']);
		    }

    /**
     * Set the value of RegularPrice, return this.
     *
     * @param regularPrice
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withRegularPrice($value)
	{
        $this->setRegularPrice($value);
        return $this;
    }

    /**
     * Get the value of the FulfillmentChannel property.
     *
     * @return String FulfillmentChannel.
     */
    public function getFulfillmentChannel()
	{
	    return $this->_fields['FulfillmentChannel']['FieldValue'];
    }

    /**
     * Set the value of the FulfillmentChannel property.
     *
     * @param string fulfillmentChannel
     * @return this instance
     */
    public function setFulfillmentChannel($value)
	{
	    $this->_fields['FulfillmentChannel']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if FulfillmentChannel is set.
     *
     * @return true if FulfillmentChannel is set.
     */
    public function isSetFulfillmentChannel()
	{
	            return !is_null($this->_fields['FulfillmentChannel']['FieldValue']);
		    }

    /**
     * Set the value of FulfillmentChannel, return this.
     *
     * @param fulfillmentChannel
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withFulfillmentChannel($value)
	{
        $this->setFulfillmentChannel($value);
        return $this;
    }

    /**
     * Get the value of the ItemCondition property.
     *
     * @return String ItemCondition.
     */
    public function getItemCondition()
	{
	    return $this->_fields['ItemCondition']['FieldValue'];
    }

    /**
     * Set the value of the ItemCondition property.
     *
     * @param string itemCondition
     * @return this instance
     */
    public function setItemCondition($value)
	{
	    $this->_fields['ItemCondition']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if ItemCondition is set.
     *
     * @return true if ItemCondition is set.
     */
    public function isSetItemCondition()
	{
	            return !is_null($this->_fields['ItemCondition']['FieldValue']);
		    }

    /**
     * Set the value of ItemCondition, return this.
     *
     * @param itemCondition
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withItemCondition($value)
	{
        $this->setItemCondition($value);
        return $this;
    }

    /**
     * Get the value of the ItemSubCondition property.
     *
     * @return String ItemSubCondition.
     */
    public function getItemSubCondition()
	{
	    return $this->_fields['ItemSubCondition']['FieldValue'];
    }

    /**
     * Set the value of the ItemSubCondition property.
     *
     * @param string itemSubCondition
     * @return this instance
     */
    public function setItemSubCondition($value)
	{
	    $this->_fields['ItemSubCondition']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if ItemSubCondition is set.
     *
     * @return true if ItemSubCondition is set.
     */
    public function isSetItemSubCondition()
	{
	            return !is_null($this->_fields['ItemSubCondition']['FieldValue']);
		    }

    /**
     * Set the value of ItemSubCondition, return this.
     *
     * @param itemSubCondition
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withItemSubCondition($value)
	{
        $this->setItemSubCondition($value);
        return $this;
    }

    /**
     * Get the value of the SellerId property.
     *
     * @return String SellerId.
     */
    public function getSellerId()
	{
	    return $this->_fields['SellerId']['FieldValue'];
    }

    /**
     * Set the value of the SellerId property.
     *
     * @param string sellerId
     * @return this instance
     */
    public function setSellerId($value)
	{
	    $this->_fields['SellerId']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if SellerId is set.
     *
     * @return true if SellerId is set.
     */
    public function isSetSellerId()
	{
	            return !is_null($this->_fields['SellerId']['FieldValue']);
		    }

    /**
     * Set the value of SellerId, return this.
     *
     * @param sellerId
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withSellerId($value)
	{
        $this->setSellerId($value);
        return $this;
    }

    /**
     * Get the value of the SellerSKU property.
     *
     * @return String SellerSKU.
     */
    public function getSellerSKU()
	{
	    return $this->_fields['SellerSKU']['FieldValue'];
    }

    /**
     * Set the value of the SellerSKU property.
     *
     * @param string sellerSKU
     * @return this instance
     */
    public function setSellerSKU($value)
	{
	    $this->_fields['SellerSKU']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if SellerSKU is set.
     *
     * @return true if SellerSKU is set.
     */
    public function isSetSellerSKU()
	{
	            return !is_null($this->_fields['SellerSKU']['FieldValue']);
		    }

    /**
     * Set the value of SellerSKU, return this.
     *
     * @param sellerSKU
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withSellerSKU($value)
	{
        $this->setSellerSKU($value);
        return $this;
    }

}
