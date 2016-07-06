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
 * MarketplaceWebServiceProducts_Model_CompetitivePriceType
 * 
 * Properties:
 * <ul>
 * 
 * <li>CompetitivePriceId: string</li>
 * <li>Price: MarketplaceWebServiceProducts_Model_PriceType</li>
 * <li>condition: string</li>
 * <li>subcondition: string</li>
 * <li>belongsToRequester: bool</li>
 *
 * </ul>
 */

 class MarketplaceWebServiceProducts_Model_CompetitivePriceType extends MarketplaceWebServiceProducts_Model {

    public function __construct($data = null)
    {
        $this->_fields = array (
            'CompetitivePriceId' => array('FieldValue' => null, 'FieldType' => 'string'),
            'Price' => array('FieldValue' => null, 'FieldType' => 'MarketplaceWebServiceProducts_Model_PriceType'),
            'condition' => array('FieldValue' => null, 'FieldType' => '@string'),
            'subcondition' => array('FieldValue' => null, 'FieldType' => '@string'),
            'belongsToRequester' => array('FieldValue' => null, 'FieldType' => '@bool'),
        );
	    parent::__construct($data);
    }

    /**
     * Get the value of the CompetitivePriceId property.
     *
     * @return String CompetitivePriceId.
     */
    public function getCompetitivePriceId()
	{
	    return $this->_fields['CompetitivePriceId']['FieldValue'];
    }

    /**
     * Set the value of the CompetitivePriceId property.
     *
     * @param string competitivePriceId
     * @return this instance
     */
    public function setCompetitivePriceId($value)
	{
	    $this->_fields['CompetitivePriceId']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if CompetitivePriceId is set.
     *
     * @return true if CompetitivePriceId is set.
     */
    public function isSetCompetitivePriceId()
	{
	            return !is_null($this->_fields['CompetitivePriceId']['FieldValue']);
		    }

    /**
     * Set the value of CompetitivePriceId, return this.
     *
     * @param competitivePriceId
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withCompetitivePriceId($value)
	{
        $this->setCompetitivePriceId($value);
        return $this;
    }

    /**
     * Get the value of the Price property.
     *
     * @return PriceType Price.
     */
    public function getPrice()
	{
	    return $this->_fields['Price']['FieldValue'];
    }

    /**
     * Set the value of the Price property.
     *
     * @param MarketplaceWebServiceProducts_Model_PriceType price
     * @return this instance
     */
    public function setPrice($value)
	{
	    $this->_fields['Price']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if Price is set.
     *
     * @return true if Price is set.
     */
    public function isSetPrice()
	{
	            return !is_null($this->_fields['Price']['FieldValue']);
		    }

    /**
     * Set the value of Price, return this.
     *
     * @param price
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withPrice($value)
	{
        $this->setPrice($value);
        return $this;
    }

    /**
     * Get the value of the condition property.
     *
     * @return String condition.
     */
    public function getcondition()
	{
	    return $this->_fields['condition']['FieldValue'];
    }

    /**
     * Set the value of the condition property.
     *
     * @param string condition
     * @return this instance
     */
    public function setcondition($value)
	{
	    $this->_fields['condition']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if condition is set.
     *
     * @return true if condition is set.
     */
    public function isSetcondition()
	{
	            return !is_null($this->_fields['condition']['FieldValue']);
		    }

    /**
     * Set the value of condition, return this.
     *
     * @param condition
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withcondition($value)
	{
        $this->setcondition($value);
        return $this;
    }

    /**
     * Get the value of the subcondition property.
     *
     * @return String subcondition.
     */
    public function getsubcondition()
	{
	    return $this->_fields['subcondition']['FieldValue'];
    }

    /**
     * Set the value of the subcondition property.
     *
     * @param string subcondition
     * @return this instance
     */
    public function setsubcondition($value)
	{
	    $this->_fields['subcondition']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if subcondition is set.
     *
     * @return true if subcondition is set.
     */
    public function isSetsubcondition()
	{
	            return !is_null($this->_fields['subcondition']['FieldValue']);
		    }

    /**
     * Set the value of subcondition, return this.
     *
     * @param subcondition
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withsubcondition($value)
	{
        $this->setsubcondition($value);
        return $this;
    }

    /**
     * Check the value of belongsToRequester.
     *
     * @return true if belongsToRequester is set to true.
     */
    public function isbelongsToRequester()
	{
        return !is_null($this->_fields['belongsToRequester']['FieldValue']) && $this->_fields['belongsToRequester']['FieldValue'];
    }

    /**
     * Get the value of the belongsToRequester property.
     *
     * @return Boolean belongsToRequester.
     */
    public function getbelongsToRequester()
	{
	    return $this->_fields['belongsToRequester']['FieldValue'];
    }

    /**
     * Set the value of the belongsToRequester property.
     *
     * @param bool belongsToRequester
     * @return this instance
     */
    public function setbelongsToRequester($value)
	{
	    $this->_fields['belongsToRequester']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if belongsToRequester is set.
     *
     * @return true if belongsToRequester is set.
     */
    public function isSetbelongsToRequester()
	{
	            return !is_null($this->_fields['belongsToRequester']['FieldValue']);
		    }

    /**
     * Set the value of belongsToRequester, return this.
     *
     * @param belongsToRequester
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withbelongsToRequester($value)
	{
        $this->setbelongsToRequester($value);
        return $this;
    }

}
