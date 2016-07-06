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
 * MarketplaceWebServiceProducts_Model_NumberOfOfferListingsList
 * 
 * Properties:
 * <ul>
 * 
 * <li>OfferListingCount: array</li>
 *
 * </ul>
 */

 class MarketplaceWebServiceProducts_Model_NumberOfOfferListingsList extends MarketplaceWebServiceProducts_Model {

    public function __construct($data = null)
    {
        $this->_fields = array (
            'OfferListingCount' => array('FieldValue' => array(), 'FieldType' => array('MarketplaceWebServiceProducts_Model_OfferListingCountType')),
        );
	    parent::__construct($data);
    }

    /**
     * Get the value of the OfferListingCount property.
     *
     * @return List<OfferListingCountType> OfferListingCount.
     */
    public function getOfferListingCount()
	{
        if ($this->_fields['OfferListingCount']['FieldValue'] == null)
		{
            $this->_fields['OfferListingCount']['FieldValue'] = array();
        }
	    return $this->_fields['OfferListingCount']['FieldValue'];
    }

    /**
     * Set the value of the OfferListingCount property.
     *
     * @param array offerListingCount
     * @return this instance
     */
    public function setOfferListingCount($value)
	{
        if (!$this->_isNumericArray($value)) {
            $value = array ($value);
        }
	    $this->_fields['OfferListingCount']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Clear OfferListingCount.
     */
    public function unsetOfferListingCount()
	{
        $this->_fields['OfferListingCount']['FieldValue'] = array();
    }

    /**
     * Check to see if OfferListingCount is set.
     *
     * @return true if OfferListingCount is set.
     */
    public function isSetOfferListingCount()
	{
	            return !empty($this->_fields['OfferListingCount']['FieldValue']);
		    }

    /**
     * Add values for OfferListingCount, return this.
     *
     * @param offerListingCount
     *             New values to add.
     *
     * @return This instance.
     */
    public function withOfferListingCount()
	{
        foreach (func_get_args() as $OfferListingCount)
		{
            $this->_fields['OfferListingCount']['FieldValue'][] = $OfferListingCount;
        }
        return $this;
    }

}
