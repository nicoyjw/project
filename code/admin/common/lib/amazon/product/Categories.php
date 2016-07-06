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
 * MarketplaceWebServiceProducts_Model_Categories
 * 
 * Properties:
 * <ul>
 * 
 * <li>ProductCategoryId: string</li>
 * <li>ProductCategoryName: string</li>
 * <li>Parent: MarketplaceWebServiceProducts_Model_Categories</li>
 *
 * </ul>
 */

 class MarketplaceWebServiceProducts_Model_Categories extends MarketplaceWebServiceProducts_Model {

    public function __construct($data = null)
    {
        $this->_fields = array (
            'ProductCategoryId' => array('FieldValue' => null, 'FieldType' => 'string'),
            'ProductCategoryName' => array('FieldValue' => null, 'FieldType' => 'string'),
            'Parent' => array('FieldValue' => null, 'FieldType' => 'MarketplaceWebServiceProducts_Model_Categories'),
        );
	    parent::__construct($data);
    }

    /**
     * Get the value of the ProductCategoryId property.
     *
     * @return String ProductCategoryId.
     */
    public function getProductCategoryId()
	{
	    return $this->_fields['ProductCategoryId']['FieldValue'];
    }

    /**
     * Set the value of the ProductCategoryId property.
     *
     * @param string productCategoryId
     * @return this instance
     */
    public function setProductCategoryId($value)
	{
	    $this->_fields['ProductCategoryId']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if ProductCategoryId is set.
     *
     * @return true if ProductCategoryId is set.
     */
    public function isSetProductCategoryId()
	{
	            return !is_null($this->_fields['ProductCategoryId']['FieldValue']);
		    }

    /**
     * Set the value of ProductCategoryId, return this.
     *
     * @param productCategoryId
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withProductCategoryId($value)
	{
        $this->setProductCategoryId($value);
        return $this;
    }

    /**
     * Get the value of the ProductCategoryName property.
     *
     * @return String ProductCategoryName.
     */
    public function getProductCategoryName()
	{
	    return $this->_fields['ProductCategoryName']['FieldValue'];
    }

    /**
     * Set the value of the ProductCategoryName property.
     *
     * @param string productCategoryName
     * @return this instance
     */
    public function setProductCategoryName($value)
	{
	    $this->_fields['ProductCategoryName']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if ProductCategoryName is set.
     *
     * @return true if ProductCategoryName is set.
     */
    public function isSetProductCategoryName()
	{
	            return !is_null($this->_fields['ProductCategoryName']['FieldValue']);
		    }

    /**
     * Set the value of ProductCategoryName, return this.
     *
     * @param productCategoryName
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withProductCategoryName($value)
	{
        $this->setProductCategoryName($value);
        return $this;
    }

    /**
     * Get the value of the Parent property.
     *
     * @return Categories Parent.
     */
    public function getParent()
	{
	    return $this->_fields['Parent']['FieldValue'];
    }

    /**
     * Set the value of the Parent property.
     *
     * @param MarketplaceWebServiceProducts_Model_Categories parent
     * @return this instance
     */
    public function setParent($value)
	{
	    $this->_fields['Parent']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if Parent is set.
     *
     * @return true if Parent is set.
     */
    public function isSetParent()
	{
	            return !is_null($this->_fields['Parent']['FieldValue']);
		    }

    /**
     * Set the value of Parent, return this.
     *
     * @param parent
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withParent($value)
	{
        $this->setParent($value);
        return $this;
    }

}
