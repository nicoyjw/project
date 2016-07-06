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
 * MarketplaceWebServiceProducts_Model_CompetitivePricingType
 * 
 * Properties:
 * <ul>
 * 
 * <li>CompetitivePrices: MarketplaceWebServiceProducts_Model_CompetitivePriceList</li>
 * <li>NumberOfOfferListings: MarketplaceWebServiceProducts_Model_NumberOfOfferListingsList</li>
 * <li>TradeInValue: MarketplaceWebServiceProducts_Model_MoneyType</li>
 *
 * </ul>
 */

 class MarketplaceWebServiceProducts_Model_CompetitivePricingType extends MarketplaceWebServiceProducts_Model {

    public function __construct($data = null)
    {
        $this->_fields = array (
            'CompetitivePrices' => array('FieldValue' => null, 'FieldType' => 'MarketplaceWebServiceProducts_Model_CompetitivePriceList'),
            'NumberOfOfferListings' => array('FieldValue' => null, 'FieldType' => 'MarketplaceWebServiceProducts_Model_NumberOfOfferListingsList'),
            'TradeInValue' => array('FieldValue' => null, 'FieldType' => 'MarketplaceWebServiceProducts_Model_MoneyType'),
        );
	    parent::__construct($data);
    }

    /**
     * Get the value of the CompetitivePrices property.
     *
     * @return CompetitivePriceList CompetitivePrices.
     */
    public function getCompetitivePrices()
	{
	    return $this->_fields['CompetitivePrices']['FieldValue'];
    }

    /**
     * Set the value of the CompetitivePrices property.
     *
     * @param MarketplaceWebServiceProducts_Model_CompetitivePriceList competitivePrices
     * @return this instance
     */
    public function setCompetitivePrices($value)
	{
	    $this->_fields['CompetitivePrices']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if CompetitivePrices is set.
     *
     * @return true if CompetitivePrices is set.
     */
    public function isSetCompetitivePrices()
	{
	            return !is_null($this->_fields['CompetitivePrices']['FieldValue']);
		    }

    /**
     * Set the value of CompetitivePrices, return this.
     *
     * @param competitivePrices
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withCompetitivePrices($value)
	{
        $this->setCompetitivePrices($value);
        return $this;
    }

    /**
     * Get the value of the NumberOfOfferListings property.
     *
     * @return NumberOfOfferListingsList NumberOfOfferListings.
     */
    public function getNumberOfOfferListings()
	{
	    return $this->_fields['NumberOfOfferListings']['FieldValue'];
    }

    /**
     * Set the value of the NumberOfOfferListings property.
     *
     * @param MarketplaceWebServiceProducts_Model_NumberOfOfferListingsList numberOfOfferListings
     * @return this instance
     */
    public function setNumberOfOfferListings($value)
	{
	    $this->_fields['NumberOfOfferListings']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if NumberOfOfferListings is set.
     *
     * @return true if NumberOfOfferListings is set.
     */
    public function isSetNumberOfOfferListings()
	{
	            return !is_null($this->_fields['NumberOfOfferListings']['FieldValue']);
		    }

    /**
     * Set the value of NumberOfOfferListings, return this.
     *
     * @param numberOfOfferListings
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withNumberOfOfferListings($value)
	{
        $this->setNumberOfOfferListings($value);
        return $this;
    }

    /**
     * Get the value of the TradeInValue property.
     *
     * @return MoneyType TradeInValue.
     */
    public function getTradeInValue()
	{
	    return $this->_fields['TradeInValue']['FieldValue'];
    }

    /**
     * Set the value of the TradeInValue property.
     *
     * @param MarketplaceWebServiceProducts_Model_MoneyType tradeInValue
     * @return this instance
     */
    public function setTradeInValue($value)
	{
	    $this->_fields['TradeInValue']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if TradeInValue is set.
     *
     * @return true if TradeInValue is set.
     */
    public function isSetTradeInValue()
	{
	            return !is_null($this->_fields['TradeInValue']['FieldValue']);
		    }

    /**
     * Set the value of TradeInValue, return this.
     *
     * @param tradeInValue
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withTradeInValue($value)
	{
        $this->setTradeInValue($value);
        return $this;
    }

}
