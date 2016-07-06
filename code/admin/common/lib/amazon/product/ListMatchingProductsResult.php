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
 * MarketplaceWebServiceProducts_Model_ListMatchingProductsResult
 * 
 * Properties:
 * <ul>
 * 
 * <li>Products: MarketplaceWebServiceProducts_Model_ProductList</li>
 *
 * </ul>
 */

 class MarketplaceWebServiceProducts_Model_ListMatchingProductsResult extends MarketplaceWebServiceProducts_Model {

    public function __construct($data = null)
    {
        $this->_fields = array (
            'Products' => array('FieldValue' => null, 'FieldType' => 'MarketplaceWebServiceProducts_Model_ProductList'),
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

}
