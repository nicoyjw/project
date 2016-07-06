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
 * MarketplaceWebServiceProducts_Model_SalesRankType
 * 
 * Properties:
 * <ul>
 * 
 * <li>ProductCategoryId: string</li>
 * <li>Rank: int</li>
 *
 * </ul>
 */

 class MarketplaceWebServiceProducts_Model_SalesRankType extends MarketplaceWebServiceProducts_Model {

    public function __construct($data = null)
    {
        $this->_fields = array (
            'ProductCategoryId' => array('FieldValue' => null, 'FieldType' => 'string'),
            'Rank' => array('FieldValue' => null, 'FieldType' => 'int'),
        );
	    parent::__construct($data);
    }

    /**
     * Get the value of the ProductCategoryId property.
     *
     * @return String ProductCategoryId.
     */
    public function getProductCategoryId()
	{
	    return $this->_fields['ProductCategoryId']['FieldValue'];
    }

    /**
     * Set the value of the ProductCategoryId property.
     *
     * @param string productCategoryId
     * @return this instance
     */
    public function setProductCategoryId($value)
	{
	    $this->_fields['ProductCategoryId']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if ProductCategoryId is set.
     *
     * @return true if ProductCategoryId is set.
     */
    public function isSetProductCategoryId()
	{
	            return !is_null($this->_fields['ProductCategoryId']['FieldValue']);
		    }

    /**
     * Set the value of ProductCategoryId, return this.
     *
     * @param productCategoryId
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withProductCategoryId($value)
	{
        $this->setProductCategoryId($value);
        return $this;
    }

    /**
     * Get the value of the Rank property.
     *
     * @return int Rank.
     */
    public function getRank()
	{
	    return $this->_fields['Rank']['FieldValue'];
    }

    /**
     * Set the value of the Rank property.
     *
     * @param int rank
     * @return this instance
     */
    public function setRank($value)
	{
	    $this->_fields['Rank']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if Rank is set.
     *
     * @return true if Rank is set.
     */
    public function isSetRank()
	{
	            return !is_null($this->_fields['Rank']['FieldValue']);
		    }

    /**
     * Set the value of Rank, return this.
     *
     * @param rank
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withRank($value)
	{
        $this->setRank($value);
        return $this;
    }

}
