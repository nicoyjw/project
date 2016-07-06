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
 * MarketplaceWebServiceProducts_Model_MoneyType
 * 
 * Properties:
 * <ul>
 * 
 * <li>CurrencyCode: string</li>
 * <li>Amount: float</li>
 *
 * </ul>
 */

 class MarketplaceWebServiceProducts_Model_MoneyType extends MarketplaceWebServiceProducts_Model {

    public function __construct($data = null)
    {
        $this->_fields = array (
            'CurrencyCode' => array('FieldValue' => null, 'FieldType' => 'string'),
            'Amount' => array('FieldValue' => null, 'FieldType' => 'float'),
        );
	    parent::__construct($data);
    }

    /**
     * Get the value of the CurrencyCode property.
     *
     * @return String CurrencyCode.
     */
    public function getCurrencyCode()
	{
	    return $this->_fields['CurrencyCode']['FieldValue'];
    }

    /**
     * Set the value of the CurrencyCode property.
     *
     * @param string currencyCode
     * @return this instance
     */
    public function setCurrencyCode($value)
	{
	    $this->_fields['CurrencyCode']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if CurrencyCode is set.
     *
     * @return true if CurrencyCode is set.
     */
    public function isSetCurrencyCode()
	{
	            return !is_null($this->_fields['CurrencyCode']['FieldValue']);
		    }

    /**
     * Set the value of CurrencyCode, return this.
     *
     * @param currencyCode
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withCurrencyCode($value)
	{
        $this->setCurrencyCode($value);
        return $this;
    }

    /**
     * Get the value of the Amount property.
     *
     * @return BigDecimal Amount.
     */
    public function getAmount()
	{
	    return $this->_fields['Amount']['FieldValue'];
    }

    /**
     * Set the value of the Amount property.
     *
     * @param float amount
     * @return this instance
     */
    public function setAmount($value)
	{
	    $this->_fields['Amount']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if Amount is set.
     *
     * @return true if Amount is set.
     */
    public function isSetAmount()
	{
	            return !is_null($this->_fields['Amount']['FieldValue']);
		    }

    /**
     * Set the value of Amount, return this.
     *
     * @param amount
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withAmount($value)
	{
        $this->setAmount($value);
        return $this;
    }

}
