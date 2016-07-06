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
 * MarketplaceWebServiceProducts_Model_Error
 * 
 * Properties:
 * <ul>
 * 
 * <li>Type: string</li>
 * <li>Code: string</li>
 * <li>Message: string</li>
 * <li>Detail: MarketplaceWebServiceProducts_Model_ErrorDetail</li>
 *
 * </ul>
 */

 class MarketplaceWebServiceProducts_Model_Error extends MarketplaceWebServiceProducts_Model {

    public function __construct($data = null)
    {
        $this->_fields = array (
            'Type' => array('FieldValue' => null, 'FieldType' => 'string'),
            'Code' => array('FieldValue' => null, 'FieldType' => 'string'),
            'Message' => array('FieldValue' => null, 'FieldType' => 'string'),
            'Detail' => array('FieldValue' => null, 'FieldType' => 'MarketplaceWebServiceProducts_Model_ErrorDetail'),
        );
	    parent::__construct($data);
    }

    /**
     * Get the value of the Type property.
     *
     * @return String Type.
     */
    public function getType()
	{
	    return $this->_fields['Type']['FieldValue'];
    }

    /**
     * Set the value of the Type property.
     *
     * @param string type
     * @return this instance
     */
    public function setType($value)
	{
	    $this->_fields['Type']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if Type is set.
     *
     * @return true if Type is set.
     */
    public function isSetType()
	{
	            return !is_null($this->_fields['Type']['FieldValue']);
		    }

    /**
     * Set the value of Type, return this.
     *
     * @param type
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withType($value)
	{
        $this->setType($value);
        return $this;
    }

    /**
     * Get the value of the Code property.
     *
     * @return String Code.
     */
    public function getCode()
	{
	    return $this->_fields['Code']['FieldValue'];
    }

    /**
     * Set the value of the Code property.
     *
     * @param string code
     * @return this instance
     */
    public function setCode($value)
	{
	    $this->_fields['Code']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if Code is set.
     *
     * @return true if Code is set.
     */
    public function isSetCode()
	{
	            return !is_null($this->_fields['Code']['FieldValue']);
		    }

    /**
     * Set the value of Code, return this.
     *
     * @param code
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withCode($value)
	{
        $this->setCode($value);
        return $this;
    }

    /**
     * Get the value of the Message property.
     *
     * @return String Message.
     */
    public function getMessage()
	{
	    return $this->_fields['Message']['FieldValue'];
    }

    /**
     * Set the value of the Message property.
     *
     * @param string message
     * @return this instance
     */
    public function setMessage($value)
	{
	    $this->_fields['Message']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if Message is set.
     *
     * @return true if Message is set.
     */
    public function isSetMessage()
	{
	            return !is_null($this->_fields['Message']['FieldValue']);
		    }

    /**
     * Set the value of Message, return this.
     *
     * @param message
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withMessage($value)
	{
        $this->setMessage($value);
        return $this;
    }

    /**
     * Get the value of the Detail property.
     *
     * @return ErrorDetail Detail.
     */
    public function getDetail()
	{
	    return $this->_fields['Detail']['FieldValue'];
    }

    /**
     * Set the value of the Detail property.
     *
     * @param MarketplaceWebServiceProducts_Model_ErrorDetail detail
     * @return this instance
     */
    public function setDetail($value)
	{
	    $this->_fields['Detail']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if Detail is set.
     *
     * @return true if Detail is set.
     */
    public function isSetDetail()
	{
	            return !is_null($this->_fields['Detail']['FieldValue']);
		    }

    /**
     * Set the value of Detail, return this.
     *
     * @param detail
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withDetail($value)
	{
        $this->setDetail($value);
        return $this;
    }

}
