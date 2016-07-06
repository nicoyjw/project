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
 * MarketplaceWebServiceProducts_Model_CompetitivePriceList
 * 
 * Properties:
 * <ul>
 * 
 * <li>CompetitivePrice: array</li>
 *
 * </ul>
 */

 class MarketplaceWebServiceProducts_Model_CompetitivePriceList extends MarketplaceWebServiceProducts_Model {

    public function __construct($data = null)
    {
        $this->_fields = array (
            'CompetitivePrice' => array('FieldValue' => array(), 'FieldType' => array('MarketplaceWebServiceProducts_Model_CompetitivePriceType')),
        );
	    parent::__construct($data);
    }

    /**
     * Get the value of the CompetitivePrice property.
     *
     * @return List<CompetitivePriceType> CompetitivePrice.
     */
    public function getCompetitivePrice()
	{
        if ($this->_fields['CompetitivePrice']['FieldValue'] == null)
		{
            $this->_fields['CompetitivePrice']['FieldValue'] = array();
        }
	    return $this->_fields['CompetitivePrice']['FieldValue'];
    }

    /**
     * Set the value of the CompetitivePrice property.
     *
     * @param array competitivePrice
     * @return this instance
     */
    public function setCompetitivePrice($value)
	{
        if (!$this->_isNumericArray($value)) {
            $value = array ($value);
        }
	    $this->_fields['CompetitivePrice']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Clear CompetitivePrice.
     */
    public function unsetCompetitivePrice()
	{
        $this->_fields['CompetitivePrice']['FieldValue'] = array();
    }

    /**
     * Check to see if CompetitivePrice is set.
     *
     * @return true if CompetitivePrice is set.
     */
    public function isSetCompetitivePrice()
	{
	            return !empty($this->_fields['CompetitivePrice']['FieldValue']);
		    }

    /**
     * Add values for CompetitivePrice, return this.
     *
     * @param competitivePrice
     *             New values to add.
     *
     * @return This instance.
     */
    public function withCompetitivePrice()
	{
        foreach (func_get_args() as $CompetitivePrice)
		{
            $this->_fields['CompetitivePrice']['FieldValue'][] = $CompetitivePrice;
        }
        return $this;
    }

}
