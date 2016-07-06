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

require_once ('Model.php');

/**
 * MarketplaceWebServiceProducts_Model_GetMatchingProductForIdRequest
 * 
 * Properties:
 * <ul>
 * 
 * <li>SellerId: string</li>
 * <li>MarketplaceId: string</li>
 * <li>IdType: string</li>
 * <li>IdList: MarketplaceWebServiceProducts_Model_IdListType</li>
 *
 * </ul>
 */

 class MarketplaceWebServiceProducts_Model_GetMatchingProductForIdRequest extends MarketplaceWebServiceProducts_Model {

    public function __construct($data = null)
    {
        $this->_fields = array (
            'SellerId' => array('FieldValue' => null, 'FieldType' => 'string'),
            'MarketplaceId' => array('FieldValue' => null, 'FieldType' => 'string'),
            'IdType' => array('FieldValue' => null, 'FieldType' => 'string'),
            'IdList' => array('FieldValue' => null, 'FieldType' => 'MarketplaceWebServiceProducts_Model_IdListType'),
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
     * Get the value of the IdType property.
     *
     * @return String IdType.
     */
    public function getIdType()
	{
	    return $this->_fields['IdType']['FieldValue'];
    }

    /**
     * Set the value of the IdType property.
     *
     * @param string idType
     * @return this instance
     */
    public function setIdType($value)
	{
	    $this->_fields['IdType']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if IdType is set.
     *
     * @return true if IdType is set.
     */
    public function isSetIdType()
	{
	            return !is_null($this->_fields['IdType']['FieldValue']);
		    }

    /**
     * Set the value of IdType, return this.
     *
     * @param idType
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withIdType($value)
	{
        $this->setIdType($value);
        return $this;
    }

    /**
     * Get the value of the IdList property.
     *
     * @return IdListType IdList.
     */
    public function getIdList()
	{
	    return $this->_fields['IdList']['FieldValue'];
    }

    /**
     * Set the value of the IdList property.
     *
     * @param MarketplaceWebServiceProducts_Model_IdListType idList
     * @return this instance
     */
    public function setIdList($value)
	{
	    $this->_fields['IdList']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if IdList is set.
     *
     * @return true if IdList is set.
     */
    public function isSetIdList()
	{
	            return !is_null($this->_fields['IdList']['FieldValue']);
		    }

    /**
     * Set the value of IdList, return this.
     *
     * @param idList
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withIdList($value)
	{
        $this->setIdList($value);
        return $this;
    }

}
