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
 * MarketplaceWebServiceProducts_Model_GetMatchingProductForIdResult
 * 
 * Properties:
 * <ul>
 * 
 * <li>Products: MarketplaceWebServiceProducts_Model_ProductList</li>
 * <li>Error: MarketplaceWebServiceProducts_Model_Error</li>
 * <li>Id: string</li>
 * <li>IdType: string</li>
 * <li>status: string</li>
 *
 * </ul>
 */

 class MarketplaceWebServiceProducts_Model_GetMatchingProductForIdResult extends MarketplaceWebServiceProducts_Model {

    public function __construct($data = null)
    {
        $this->_fields = array (
            'Products' => array('FieldValue' => null, 'FieldType' => 'MarketplaceWebServiceProducts_Model_ProductList'),
            'Error' => array('FieldValue' => null, 'FieldType' => 'MarketplaceWebServiceProducts_Model_Error'),
            'Id' => array('FieldValue' => null, 'FieldType' => '@string'),
            'IdType' => array('FieldValue' => null, 'FieldType' => '@string'),
            'status' => array('FieldValue' => null, 'FieldType' => '@string'),
        );
	    parent::__construct($data);
    }

    /**
     * Get the value of the Products property.
     *
     * @return ProductList Products.
     */
    public function getProducts()
	{
	    return $this->_fields['Products']['FieldValue'];
    }

    /**
     * Set the value of the Products property.
     *
     * @param MarketplaceWebServiceProducts_Model_ProductList products
     * @return this instance
     */
    public function setProducts($value)
	{
	    $this->_fields['Products']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if Products is set.
     *
     * @return true if Products is set.
     */
    public function isSetProducts()
	{
	            return !is_null($this->_fields['Products']['FieldValue']);
		    }

    /**
     * Set the value of Products, return this.
     *
     * @param products
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withProducts($value)
	{
        $this->setProducts($value);
        return $this;
    }

    /**
     * Get the value of the Error property.
     *
     * @return Error Error.
     */
    public function getError()
	{
	    return $this->_fields['Error']['FieldValue'];
    }

    /**
     * Set the value of the Error property.
     *
     * @param MarketplaceWebServiceProducts_Model_Error error
     * @return this instance
     */
    public function setError($value)
	{
	    $this->_fields['Error']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if Error is set.
     *
     * @return true if Error is set.
     */
    public function isSetError()
	{
	            return !is_null($this->_fields['Error']['FieldValue']);
		    }

    /**
     * Set the value of Error, return this.
     *
     * @param error
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withError($value)
	{
        $this->setError($value);
        return $this;
    }

    /**
     * Get the value of the Id property.
     *
     * @return String Id.
     */
    public function getId()
	{
	    return $this->_fields['Id']['FieldValue'];
    }

    /**
     * Set the value of the Id property.
     *
     * @param string id
     * @return this instance
     */
    public function setId($value)
	{
	    $this->_fields['Id']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if Id is set.
     *
     * @return true if Id is set.
     */
    public function isSetId()
	{
	            return !is_null($this->_fields['Id']['FieldValue']);
		    }

    /**
     * Set the value of Id, return this.
     *
     * @param id
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withId($value)
	{
        $this->setId($value);
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
     * Get the value of the status property.
     *
     * @return String status.
     */
    public function getstatus()
	{
	    return $this->_fields['status']['FieldValue'];
    }

    /**
     * Set the value of the status property.
     *
     * @param string status
     * @return this instance
     */
    public function setstatus($value)
	{
	    $this->_fields['status']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if status is set.
     *
     * @return true if status is set.
     */
    public function isSetstatus()
	{
	            return !is_null($this->_fields['status']['FieldValue']);
		    }

    /**
     * Set the value of status, return this.
     *
     * @param status
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withstatus($value)
	{
        $this->setstatus($value);
        return $this;
    }

}
