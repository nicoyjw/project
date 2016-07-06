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
 * MarketplaceWebServiceProducts_Model_MessageList
 * 
 * Properties:
 * <ul>
 * 
 * <li>Message: array</li>
 *
 * </ul>
 */

 class MarketplaceWebServiceProducts_Model_MessageList extends MarketplaceWebServiceProducts_Model {

    public function __construct($data = null)
    {
        $this->_fields = array (
            'Message' => array('FieldValue' => array(), 'FieldType' => array('MarketplaceWebServiceProducts_Model_Message')),
        );
	    parent::__construct($data);
    }

    /**
     * Get the value of the Message property.
     *
     * @return List<Message> Message.
     */
    public function getMessage()
	{
        if ($this->_fields['Message']['FieldValue'] == null)
		{
            $this->_fields['Message']['FieldValue'] = array();
        }
	    return $this->_fields['Message']['FieldValue'];
    }

    /**
     * Set the value of the Message property.
     *
     * @param array message
     * @return this instance
     */
    public function setMessage($value)
	{
        if (!$this->_isNumericArray($value)) {
            $value = array ($value);
        }
	    $this->_fields['Message']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Clear Message.
     */
    public function unsetMessage()
	{
        $this->_fields['Message']['FieldValue'] = array();
    }

    /**
     * Check to see if Message is set.
     *
     * @return true if Message is set.
     */
    public function isSetMessage()
	{
	            return !empty($this->_fields['Message']['FieldValue']);
		    }

    /**
     * Add values for Message, return this.
     *
     * @param message
     *             New values to add.
     *
     * @return This instance.
     */
    public function withMessage()
	{
        foreach (func_get_args() as $Message)
		{
            $this->_fields['Message']['FieldValue'][] = $Message;
        }
        return $this;
    }

}
