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

require_once ('Model.php');


/**
 * MarketplaceWebServiceProducts_Model_GetMatchingProductForIdResponse
 * 
 * Properties:
 * <ul>
 * 
 * <li>GetMatchingProductForIdResult: array</li>
 * <li>ResponseMetadata: MarketplaceWebServiceProducts_Model_ResponseMetadata</li>
 * <li>ResponseHeaderMetadata: MarketplaceWebServiceProducts_Model_ResponseHeaderMetadata</li>
 *
 * </ul>
 */

 class MarketplaceWebServiceProducts_Model_GetMatchingProductForIdResponse extends MarketplaceWebServiceProducts_Model {

    public function __construct($data = null)
    {
        $this->_fields = array (
            'GetMatchingProductForIdResult' => array('FieldValue' => array(), 'FieldType' => array('MarketplaceWebServiceProducts_Model_GetMatchingProductForIdResult')),
            'ResponseMetadata' => array('FieldValue' => null, 'FieldType' => 'MarketplaceWebServiceProducts_Model_ResponseMetadata'),
            'ResponseHeaderMetadata' => array('FieldValue' => null, 'FieldType' => 'MarketplaceWebServiceProducts_Model_ResponseHeaderMetadata'),
        );
	    parent::__construct($data);
    }

    /**
     * Get the value of the GetMatchingProductForIdResult property.
     *
     * @return List<GetMatchingProductForIdResult> GetMatchingProductForIdResult.
     */
    public function getGetMatchingProductForIdResult()
	{
        if ($this->_fields['GetMatchingProductForIdResult']['FieldValue'] == null)
		{
            $this->_fields['GetMatchingProductForIdResult']['FieldValue'] = array();
        }
	    return $this->_fields['GetMatchingProductForIdResult']['FieldValue'];
    }

    /**
     * Set the value of the GetMatchingProductForIdResult property.
     *
     * @param array getMatchingProductForIdResult
     * @return this instance
     */
    public function setGetMatchingProductForIdResult($value)
	{
        if (!$this->_isNumericArray($value)) {
            $value = array ($value);
        }
	    $this->_fields['GetMatchingProductForIdResult']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Clear GetMatchingProductForIdResult.
     */
    public function unsetGetMatchingProductForIdResult()
	{
        $this->_fields['GetMatchingProductForIdResult']['FieldValue'] = array();
    }

    /**
     * Check to see if GetMatchingProductForIdResult is set.
     *
     * @return true if GetMatchingProductForIdResult is set.
     */
    public function isSetGetMatchingProductForIdResult()
	{
	            return !empty($this->_fields['GetMatchingProductForIdResult']['FieldValue']);
		    }

    /**
     * Add values for GetMatchingProductForIdResult, return this.
     *
     * @param getMatchingProductForIdResult
     *             New values to add.
     *
     * @return This instance.
     */
    public function withGetMatchingProductForIdResult()
	{
        foreach (func_get_args() as $GetMatchingProductForIdResult)
		{
            $this->_fields['GetMatchingProductForIdResult']['FieldValue'][] = $GetMatchingProductForIdResult;
        }
        return $this;
    }

    /**
     * Get the value of the ResponseMetadata property.
     *
     * @return ResponseMetadata ResponseMetadata.
     */
    public function getResponseMetadata()
	{
	    return $this->_fields['ResponseMetadata']['FieldValue'];
    }

    /**
     * Set the value of the ResponseMetadata property.
     *
     * @param MarketplaceWebServiceProducts_Model_ResponseMetadata responseMetadata
     * @return this instance
     */
    public function setResponseMetadata($value)
	{
	    $this->_fields['ResponseMetadata']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if ResponseMetadata is set.
     *
     * @return true if ResponseMetadata is set.
     */
    public function isSetResponseMetadata()
	{
	            return !is_null($this->_fields['ResponseMetadata']['FieldValue']);
		    }

    /**
     * Set the value of ResponseMetadata, return this.
     *
     * @param responseMetadata
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withResponseMetadata($value)
	{
        $this->setResponseMetadata($value);
        return $this;
    }

    /**
     * Get the value of the ResponseHeaderMetadata property.
     *
     * @return ResponseHeaderMetadata ResponseHeaderMetadata.
     */
    public function getResponseHeaderMetadata()
	{
	    return $this->_fields['ResponseHeaderMetadata']['FieldValue'];
    }

    /**
     * Set the value of the ResponseHeaderMetadata property.
     *
     * @param MarketplaceWebServiceProducts_Model_ResponseHeaderMetadata responseHeaderMetadata
     * @return this instance
     */
    public function setResponseHeaderMetadata($value)
	{
	    $this->_fields['ResponseHeaderMetadata']['FieldValue'] = $value;
        return $this;
    }

    /**
     * Check to see if ResponseHeaderMetadata is set.
     *
     * @return true if ResponseHeaderMetadata is set.
     */
    public function isSetResponseHeaderMetadata()
	{
	            return !is_null($this->_fields['ResponseHeaderMetadata']['FieldValue']);
		    }

    /**
     * Set the value of ResponseHeaderMetadata, return this.
     *
     * @param responseHeaderMetadata
     *             The new value to set.
     *
     * @return This instance.
     */
    public function withResponseHeaderMetadata($value)
	{
        $this->setResponseHeaderMetadata($value);
        return $this;
    }
    /**
     * Construct MarketplaceWebServiceProducts_Model_GetMatchingProductForIdResponse from XML string
     * 
     * @param $xml
     *        XML string to construct from
     *
     * @return MarketplaceWebServiceProducts_Model_GetMatchingProductForIdResponse 
     */
    public static function fromXML($xml)
    {
        $dom = new DOMDocument();
        $dom->loadXML($xml);
        $xpath = new DOMXPath($dom);
        $response = $xpath->query("//*[local-name()='GetMatchingProductForIdResponse']");
        if ($response->length == 1) {
            return new MarketplaceWebServiceProducts_Model_GetMatchingProductForIdResponse(($response->item(0))); 
        } else {
            throw new Exception ("Unable to construct MarketplaceWebServiceProducts_Model_GetMatchingProductForIdResponse from provided XML. 
                                  Make sure that GetMatchingProductForIdResponse is a root element");
        }
    }
    /**
     * XML Representation for this object
     * 
     * @return string XML for this object
     */
    public function toXML() 
    {
        $xml = "";
        $xml .= "<GetMatchingProductForIdResponse xmlns=\"http://mws.amazonservices.com/schema/Products/2011-10-01\">";
        $xml .= $this->_toXMLFragment();
        $xml .= "</GetMatchingProductForIdResponse>";
        return $xml;
    }

}
