<?php
	/********************************************************************************
	* AUTHOR:  Nicolas Ng at 06/15/2013 For details,please visit www.cpowersoft.com*
	*******************************************************************************/


function RequestAli($url)
{
	set_time_limit(50000);
	$ch = curl_init($url);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true) ; 
	curl_setopt($ch, CURLOPT_BINARYTRANSFER, true) ;
	$re=curl_exec($ch);
	curl_close($ch);
	return json_decode($re,true);
}
/**
 * Send Post Request
 *
 * @param array $remote_server
 * @param array $content
 * @return string
 */
function request_post($remote_server,$content)
{ 
	set_time_limit(50000);
   $http_entity_type = 'application/x-www-from-urlencoded'; //Post type images
	$context = array( 
		'http'=>array( 
			'method'=>'POST', 
		 //add other header..
			'header'=>"Content-type: " .$http_entity_type ."\r\n". 
					  'Content-length: '.strlen($content), 
			'content'=>$content) 
		 ); 
	$stream_context = stream_context_create($context); 
	$data = file_get_contents($remote_server,FALSE,$stream_context); 
	return json_decode($data,true);
}

/* * * * * * * * * * * * * * * *
 * Get Aliexpress all categorys  *
 * * * * * * * * * * * * * * * */
function getcategory(){
	set_time_limit(50000);
	$result=$this->getChildrenPostCategoryById(/**CateId**/); //Request getChildrenPostCategoryById
	foreach($result['aeopPostCategoryList'] as $key => $value){	
		 /**
		  * insert database 
		  *
		  * cat_id' => $value['id']
		  * parent_id' => $cateId
		  *	cat_name' => $value['names']['zh']
		  * name_en' => $value['names']['en']
		  */
		$son_result=$this->getChildrenPostCategoryById($value['id']);
		if($son_result['aeopPostCategoryList']){
			foreach($son_result['aeopPostCategoryList'] as $key1 => $value1){
		/**
		  * insert database 
		  *
		  * cat_id' => $value['id']
		  * parent_id' => $cateId
		  *	cat_name' => $value['names']['zh']
		  * name_en' => $value['names']['en']
		  */
		$son1_result=$this->getChildrenPostCategoryById($value1['id']);
		if($son1_result['aeopPostCategoryList']){
		foreach($son1_result['aeopPostCategoryList'] as $key2 => $value2){
		/**
		  * insert database 
		  *
		  * cat_id' => $value['id']
		  * parent_id' => $cateId
		  *	cat_name' => $value['names']['zh']
		  * name_en' => $value['names']['en']
		  */
		$son2_result=$this->getChildrenPostCategoryById($value2['id']);
		if($son2_result['aeopPostCategoryList']){
		foreach($son2_result['aeopPostCategoryList'] as $key3 => $value3){
		 /**
		  * insert database 
		  *
		  * cat_id' => $value['id']
		  * parent_id' => $cateId
		  *	cat_name' => $value['names']['zh']
		  * name_en' => $value['names']['en']
		  */
		$son3_result=$this->getChildrenPostCategoryById($value3['id']);
		if($son3_result['aeopPostCategoryList']){
		foreach($son3_result['aeopPostCategoryList'] as $key4 => $value4){
		/**
		  * insert database 
		  *
		  * cat_id' => $value['id']
		  * parent_id' => $cateId
		  *	cat_name' => $value['names']['zh']
		  * name_en' => $value['names']['en']
		  */
		}	
		}
		}
		}
		}	
		}
		}
		}
	}
	echo '导入成功';
}


?>