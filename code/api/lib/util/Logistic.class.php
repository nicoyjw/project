<?php

define('ICE_TOKEN','5d43d152af5247daba05cc54f80c1c24');


class Logistic{
    

    
    
    /***
    * 计算运费
    * 
    */
    function calculateCharge($countryCode,$weight,$channels=null){
       
        $request['countryCode'] = $countryCode;
        $request['weight'] = $weight;
        $request['cargoCode'] = 'W';                         
        $request['postcode'] = 10000;
        if(!empty($channels) && count($channels)) $request['transportWayCode'] = $channels;
        $client = new SoapClient ("http://kd.szice.net:8086/xms/services/order?wsdl", array ('encoding' => 'UTF-8' ));
        $calculateChargeResponse= $client->calculateCharge(ICE_TOKEN,$request);  
        return $calculateChargeResponse;
    }
    
   
    
    
    /**
    * 获取互联易所有渠道
    * 
    */
    function getTransportWayList(){
        
        $client = new SoapClient ("http://kd.szice.net:8086/xms/services/order?wsdl", array ('encoding' => 'UTF-8' ));
        $calculateChargeResponse= $client->getTransportWayList(ICE_TOKEN);  
        
        $result = array();
        foreach($calculateChargeResponse->transportWays as $list){
            $result[] = $list;
           
        }
        return $result;
    }
    




}


    
?>
