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
 * MarketplaceWebServiceProducts_Model_LowestOfferListingList
 * 
 * Properties:
 * <ul>
 * 
 * <li>LowestOfferListing: array</li>
 *
 * </ul>
 */

 class MarketplaceWebServiceProducts_Model_LowestOfferListingList extends MarketplaceWebServiceProducts_Model {

    public function __construct($data = null)
    {
        $this->_fields = array (
            'LowestOfferListing' => array('FieldValue' => array(), 'FieldType' => array('MarketplaceWebServiceProducts_Model_LowestOfferListingType')),
        );
	    parent::__construct($data);
    }

    /**
     * Get the value of the LowestOfferListing property.
     *
     * @return List<LowestOfferListingType> LowestOfferListing.
     */
    public function getLowestOfferListing()
	{
        if ($this->_fields['LowestOfferListing']['FieldValue'] == null)
		{
            $this->_fields['LowestOfferListing']['FieldValue'] = array();
        }
	    return $this->_fields['LowestOfferListing']['FieldValue'];
    }

    /**
     * Set the value of the LowestOfferListing property.
     *
     * @param array lowestOfferListing
     * @return this instance
     */
    public function setLowestOfferListing($value)
	{
        if (!$this->_isNumericArray($value)) {
            $value = array ($value);
        }
	    $this->_fields['LowestOfferListing']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Clear LowestOfferListing.
     */
    public function unsetLowestOfferListing()
	{
        $this->_fields['LowestOfferListing']['FieldValue'] = array();
    }

    /**
     * Check to see if LowestOfferListing is set.
     *
     * @return true if LowestOfferListing is set.
     */
    public function isSetLowestOfferListing()
	{
	            return !empty($this->_fields['LowestOfferListing']['FieldValue']);
		    }

    /**
     * Add values for LowestOfferListing, return this.
     *
     * @param lowestOfferListing
     *             New values to add.
     *
     * @return This instance.
     */
    public function withLowestOfferListing()
	{
        foreach (func_get_args() as $LowestOfferListing)
		{
            $this->_fields['LowestOfferListing']['FieldValue'][] = $LowestOfferListing;
        }
        return $this;
    }

}
