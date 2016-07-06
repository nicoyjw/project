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
 * MarketplaceWebServiceProducts_Model_SalesRankList
 * 
 * Properties:
 * <ul>
 * 
 * <li>SalesRank: array</li>
 *
 * </ul>
 */

 class MarketplaceWebServiceProducts_Model_SalesRankList extends MarketplaceWebServiceProducts_Model {

    public function __construct($data = null)
    {
        $this->_fields = array (
            'SalesRank' => array('FieldValue' => array(), 'FieldType' => array('MarketplaceWebServiceProducts_Model_SalesRankType')),
        );
	    parent::__construct($data);
    }

    /**
     * Get the value of the SalesRank property.
     *
     * @return List<SalesRankType> SalesRank.
     */
    public function getSalesRank()
	{
        if ($this->_fields['SalesRank']['FieldValue'] == null)
		{
            $this->_fields['SalesRank']['FieldValue'] = array();
        }
	    return $this->_fields['SalesRank']['FieldValue'];
    }

    /**
     * Set the value of the SalesRank property.
     *
     * @param array salesRank
     * @return this instance
     */
    public function setSalesRank($value)
	{
        if (!$this->_isNumericArray($value)) {
            $value = array ($value);
        }
	    $this->_fields['SalesRank']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Clear SalesRank.
     */
    public function unsetSalesRank()
	{
        $this->_fields['SalesRank']['FieldValue'] = array();
    }

    /**
     * Check to see if SalesRank is set.
     *
     * @return true if SalesRank is set.
     */
    public function isSetSalesRank()
	{
	            return !empty($this->_fields['SalesRank']['FieldValue']);
		    }

    /**
     * Add values for SalesRank, return this.
     *
     * @param salesRank
     *             New values to add.
     *
     * @return This instance.
     */
    public function withSalesRank()
	{
        foreach (func_get_args() as $SalesRank)
		{
            $this->_fields['SalesRank']['FieldValue'][] = $SalesRank;
        }
        return $this;
    }

}
