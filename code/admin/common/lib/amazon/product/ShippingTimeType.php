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
 * MarketplaceWebServiceProducts_Model_ShippingTimeType
 * 
 * Properties:
 * <ul>
 * 
 * <li>Max: string</li>
 *
 * </ul>
 */

 class MarketplaceWebServiceProducts_Model_ShippingTimeType extends MarketplaceWebServiceProducts_Model {

    public function __construct($data = null)
    {
        $this->_fields = array (
            'Max' => array('FieldValue' => null, 'FieldType' => 'string'),
        );
	    parent::__construct($data);
    }

    /**
     * Get the value of the Max property.
     *
     * @return String Max.
     */
    public function getMax()
	{
	    return $this->_fields['Max']['FieldValue'];
    }

    /**
     * Set the value of the Max property.
     *
     * @param string max
     * @return this instance
     */
    public function setMax($value)
	{
	    $this->_fields['Max']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if Max is set.
     *
     * @return true if Max is set.
     */
    public function isSetMax()
	{
	            return !is_null($this->_fields['Max']['FieldValue']);
		    }

    /**
     * Set the value of Max, return this.
     *
     * @param max
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withMax($value)
	{
        $this->setMax($value);
        return $this;
    }

}
