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
 * MarketplaceWebServiceProducts_Model_IdentifierType
 * 
 * Properties:
 * <ul>
 * 
 * <li>MarketplaceASIN: MarketplaceWebServiceProducts_Model_ASINIdentifier</li>
 * <li>SKUIdentifier: MarketplaceWebServiceProducts_Model_SellerSKUIdentifier</li>
 *
 * </ul>
 */

 class MarketplaceWebServiceProducts_Model_IdentifierType extends MarketplaceWebServiceProducts_Model {

    public function __construct($data = null)
    {
        $this->_fields = array (
            'MarketplaceASIN' => array('FieldValue' => null, 'FieldType' => 'MarketplaceWebServiceProducts_Model_ASINIdentifier'),
            'SKUIdentifier' => array('FieldValue' => null, 'FieldType' => 'MarketplaceWebServiceProducts_Model_SellerSKUIdentifier'),
        );
	    parent::__construct($data);
    }

    /**
     * Get the value of the MarketplaceASIN property.
     *
     * @return ASINIdentifier MarketplaceASIN.
     */
    public function getMarketplaceASIN()
	{
	    return $this->_fields['MarketplaceASIN']['FieldValue'];
    }

    /**
     * Set the value of the MarketplaceASIN property.
     *
     * @param MarketplaceWebServiceProducts_Model_ASINIdentifier marketplaceASIN
     * @return this instance
     */
    public function setMarketplaceASIN($value)
	{
	    $this->_fields['MarketplaceASIN']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if MarketplaceASIN is set.
     *
     * @return true if MarketplaceASIN is set.
     */
    public function isSetMarketplaceASIN()
	{
	            return !is_null($this->_fields['MarketplaceASIN']['FieldValue']);
		    }

    /**
     * Set the value of MarketplaceASIN, return this.
     *
     * @param marketplaceASIN
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withMarketplaceASIN($value)
	{
        $this->setMarketplaceASIN($value);
        return $this;
    }

    /**
     * Get the value of the SKUIdentifier property.
     *
     * @return SellerSKUIdentifier SKUIdentifier.
     */
    public function getSKUIdentifier()
	{
	    return $this->_fields['SKUIdentifier']['FieldValue'];
    }

    /**
     * Set the value of the SKUIdentifier property.
     *
     * @param MarketplaceWebServiceProducts_Model_SellerSKUIdentifier skuIdentifier
     * @return this instance
     */
    public function setSKUIdentifier($value)
	{
	    $this->_fields['SKUIdentifier']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if SKUIdentifier is set.
     *
     * @return true if SKUIdentifier is set.
     */
    public function isSetSKUIdentifier()
	{
	            return !is_null($this->_fields['SKUIdentifier']['FieldValue']);
		    }

    /**
     * Set the value of SKUIdentifier, return this.
     *
     * @param skuIdentifier
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withSKUIdentifier($value)
	{
        $this->setSKUIdentifier($value);
        return $this;
    }

}
