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
 * MarketplaceWebServiceProducts_Model_ListMatchingProductsRequest
 * 
 * Properties:
 * <ul>
 * 
 * <li>SellerId: string</li>
 * <li>MarketplaceId: string</li>
 * <li>Query: string</li>
 * <li>QueryContextId: string</li>
 *
 * </ul>
 */

 class MarketplaceWebServiceProducts_Model_ListMatchingProductsRequest extends MarketplaceWebServiceProducts_Model {

    public function __construct($data = null)
    {
        $this->_fields = array (
            'SellerId' => array('FieldValue' => null, 'FieldType' => 'string'),
            'MarketplaceId' => array('FieldValue' => null, 'FieldType' => 'string'),
            'Query' => array('FieldValue' => null, 'FieldType' => 'string'),
            'QueryContextId' => array('FieldValue' => null, 'FieldType' => 'string'),
        );
	    parent::__construct($data);
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
     * Get the value of the MarketplaceId property.
     *
     * @return String MarketplaceId.
     */
    public function getMarketplaceId()
	{
	    return $this->_fields['MarketplaceId']['FieldValue'];
    }

    /**
     * Set the value of the MarketplaceId property.
     *
     * @param string marketplaceId
     * @return this instance
     */
    public function setMarketplaceId($value)
	{
	    $this->_fields['MarketplaceId']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if MarketplaceId is set.
     *
     * @return true if MarketplaceId is set.
     */
    public function isSetMarketplaceId()
	{
	            return !is_null($this->_fields['MarketplaceId']['FieldValue']);
		    }

    /**
     * Set the value of MarketplaceId, return this.
     *
     * @param marketplaceId
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withMarketplaceId($value)
	{
        $this->setMarketplaceId($value);
        return $this;
    }

    /**
     * Get the value of the Query property.
     *
     * @return String Query.
     */
    public function getQuery()
	{
	    return $this->_fields['Query']['FieldValue'];
    }

    /**
     * Set the value of the Query property.
     *
     * @param string query
     * @return this instance
     */
    public function setQuery($value)
	{
	    $this->_fields['Query']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if Query is set.
     *
     * @return true if Query is set.
     */
    public function isSetQuery()
	{
	            return !is_null($this->_fields['Query']['FieldValue']);
		    }

    /**
     * Set the value of Query, return this.
     *
     * @param query
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withQuery($value)
	{
        $this->setQuery($value);
        return $this;
    }

    /**
     * Get the value of the QueryContextId property.
     *
     * @return String QueryContextId.
     */
    public function getQueryContextId()
	{
	    return $this->_fields['QueryContextId']['FieldValue'];
    }

    /**
     * Set the value of the QueryContextId property.
     *
     * @param string queryContextId
     * @return this instance
     */
    public function setQueryContextId($value)
	{
	    $this->_fields['QueryContextId']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if QueryContextId is set.
     *
     * @return true if QueryContextId is set.
     */
    public function isSetQueryContextId()
	{
	            return !is_null($this->_fields['QueryContextId']['FieldValue']);
		    }

    /**
     * Set the value of QueryContextId, return this.
     *
     * @param queryContextId
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withQueryContextId($value)
	{
        $this->setQueryContextId($value);
        return $this;
    }

}
