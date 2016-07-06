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
 * MarketplaceWebServiceProducts_Model_ErrorDetail
 * 
 * Properties:
 * <ul>
 * 
 * <li>Any: array</li>
 *
 * </ul>
 */

 class MarketplaceWebServiceProducts_Model_ErrorDetail extends MarketplaceWebServiceProducts_Model {

    public function __construct($data = null)
    {
        $this->_fields = array (
            'Any' => array('FieldValue' => array(), 'FieldType' => array('object')),
        );
	    parent::__construct($data);
    }

    /**
     * Get the value of the Any property.
     *
     * @return List<Object> Any.
     */
    public function getAny()
	{
        if ($this->_fields['Any']['FieldValue'] == null)
		{
            $this->_fields['Any']['FieldValue'] = array();
        }
	    return $this->_fields['Any']['FieldValue'];
    }

    /**
     * Set the value of the Any property.
     *
     * @param array any
     * @return this instance
     */
    public function setAny($value)
	{
        if (!$this->_isNumericArray($value)) {
            $value = array ($value);
        }
	    $this->_fields['Any']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Clear Any.
     */
    public function unsetAny()
	{
        $this->_fields['Any']['FieldValue'] = array();
    }

    /**
     * Check to see if Any is set.
     *
     * @return true if Any is set.
     */
    public function isSetAny()
	{
	            return !empty($this->_fields['Any']['FieldValue']);
		    }

    /**
     * Add values for Any, return this.
     *
     * @param any
     *             New values to add.
     *
     * @return This instance.
     */
    public function withAny()
	{
        foreach (func_get_args() as $Any)
		{
            $this->_fields['Any']['FieldValue'][] = $Any;
        }
        return $this;
    }

}
