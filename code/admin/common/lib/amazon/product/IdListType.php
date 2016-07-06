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
 * MarketplaceWebServiceProducts_Model_IdListType
 * 
 * Properties:
 * <ul>
 * 
 * <li>Id: array</li>
 *
 * </ul>
 */

 class MarketplaceWebServiceProducts_Model_IdListType extends MarketplaceWebServiceProducts_Model {

    public function __construct($data = null)
    {
        $this->_fields = array (
            'Id' => array('FieldValue' => array(), 'FieldType' => array('string')),
        );
	    parent::__construct($data);
    }

    /**
     * Get the value of the Id property.
     *
     * @return List<String> Id.
     */
    public function getId()
	{
        if ($this->_fields['Id']['FieldValue'] == null)
		{
            $this->_fields['Id']['FieldValue'] = array();
        }
	    return $this->_fields['Id']['FieldValue'];
    }

    /**
     * Set the value of the Id property.
     *
     * @param array id
     * @return this instance
     */
    public function setId($value)
	{
        if (!$this->_isNumericArray($value)) {
            $value = array ($value);
        }
	    $this->_fields['Id']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Clear Id.
     */
    public function unsetId()
	{
        $this->_fields['Id']['FieldValue'] = array();
    }

    /**
     * Check to see if Id is set.
     *
     * @return true if Id is set.
     */
    public function isSetId()
	{
	            return !empty($this->_fields['Id']['FieldValue']);
		    }

    /**
     * Add values for Id, return this.
     *
     * @param id
     *             New values to add.
     *
     * @return This instance.
     */
    public function withId()
	{
        foreach (func_get_args() as $Id)
		{
            $this->_fields['Id']['FieldValue'][] = $Id;
        }
        return $this;
    }

}
