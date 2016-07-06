<?php
$trees['root'][] = array('id'=>'100000','text'=>'个人管理专区','leaf'=>false, 'cls'=>'folder');
	$trees['100000'][] = array('id'=>'100001','text'=>'修改我的资料','leaf'=>true, 'cls'=>'file','model'=>'user','action'=>'modself');
	$trees['100000'][] = array('id'=>'100002','text'=>'修改我的密码','leaf'=>true, 'cls'=>'file','model'=>'user','action'=>'modpass');
	$trees['100000'][] = array('id'=>'100003','text'=>'我的工作','leaf'=>true, 'cls'=>'file','model'=>'task','action'=>'my');
	$trees['100000'][] = array('id'=>'100004','text'=>'个人消息','leaf'=>true, 'cls'=>'file','model'=>'message','action'=>'');
	$trees['100000'][] = array('id'=>'100010','text'=>'我的信息','leaf'=>false, 'cls'=>'folder');
		$trees['100010'][] = array('id'=>'100011','text'=>'我的出售房源','leaf'=>true, 'cls'=>'file','model'=>'sale','action'=>'my');
		$trees['100010'][] = array('id'=>'100012','text'=>'我的求购房源','leaf'=>true, 'cls'=>'file','model'=>'buy','action'=>'my');
		$trees['100010'][] = array('id'=>'100013','text'=>'我的客户','leaf'=>true, 'cls'=>'file','model'=>'client','action'=>'my');
$trees['root'][] = array('id'=>'200000','text'=>'业务信息管理','leaf'=>false, 'cls'=>'folder');
	$trees['200000'][] = array('id'=>'200010','text'=>'出售管理','leaf'=>false, 'cls'=>'folder');
		$trees['200010'][] = array('id'=>'200011','text'=>'所有出售房源','leaf'=>true, 'cls'=>'file','model'=>'sale','action'=>'');
		$trees['200010'][] = array('id'=>'200012','text'=>'添加出售房源','leaf'=>true, 'cls'=>'file','model'=>'sale','action'=>'add');
		$trees['200010'][] = array('id'=>'200013','text'=>'房源回收站','leaf'=>true, 'cls'=>'file','model'=>'sale','action'=>'recycle');
	$trees['200000'][] = array('id'=>'200020','text'=>'求购管理','leaf'=>false, 'cls'=>'folder');
		$trees['200020'][] = array('id'=>'200021','text'=>'所有求购房源','leaf'=>true, 'cls'=>'file','model'=>'buy','action'=>'');
		$trees['200020'][] = array('id'=>'200022','text'=>'添加求购房源','leaf'=>true, 'cls'=>'file','model'=>'buy','action'=>'add');
		$trees['200020'][] = array('id'=>'200023','text'=>'求购回收站','leaf'=>true, 'cls'=>'file','model'=>'buy','action'=>'recycle');
	$trees['200000'][] = array('id'=>'200030','text'=>'小区库管理','leaf'=>false, 'cls'=>'folder');
		$trees['200030'][] = array('id'=>'200031','text'=>'小区库','leaf'=>true, 'cls'=>'file','model'=>'uptown','action'=>'');
		$trees['200030'][] = array('id'=>'200032','text'=>'添加小区','leaf'=>true, 'cls'=>'file','model'=>'uptown','action'=>'add');
	$trees['200000'][] = array('id'=>'200040','text'=>'客户管理','leaf'=>false, 'cls'=>'folder');
		$trees['200040'][] = array('id'=>'200041','text'=>'所有客户','leaf'=>true, 'cls'=>'file','model'=>'client','action'=>'');
		$trees['200040'][] = array('id'=>'200042','text'=>'添加客户','leaf'=>true, 'cls'=>'file','model'=>'client','action'=>'add');
$trees['root'][] = array('id'=>'300000','text'=>'后期业务管理','leaf'=>false, 'cls'=>'folder');
	$trees['300000'][] = array('id'=>'300001','text'=>'暂未开放','leaf'=>true, 'cls'=>'file','model'=>'','action'=>'');
$trees['root'][] = array('id'=>'400000','text'=>'系统管理','leaf'=>false, 'cls'=>'folder');
	$trees['400000'][] = array('id'=>'400010','text'=>'人员管理','leaf'=>false, 'cls'=>'folder');
		$trees['400010'][] = array('id'=>'400011','text'=>'所有人员','leaf'=>true, 'cls'=>'file','model'=>'user','action'=>'');
		//$trees['400010'][] = array('id'=>'400012','text'=>'添加人员','leaf'=>true, 'cls'=>'file','model'=>'user','action'=>'add');
		$trees['400010'][] = array('id'=>'400013','text'=>'部门管理','leaf'=>true, 'cls'=>'file','model'=>'dept','action'=>'');
		$trees['400010'][] = array('id'=>'400014','text'=>'权限管理','leaf'=>true, 'cls'=>'file','model'=>'user','action'=>'right');
	$trees['400000'][] = array('id'=>'400020','text'=>'公告管理','leaf'=>false, 'cls'=>'folder');
		$trees['400020'][] = array('id'=>'400021','text'=>'公告列表','leaf'=>true, 'cls'=>'file','model'=>'news','action'=>'');
		$trees['400020'][] = array('id'=>'400022','text'=>'添加公告','leaf'=>true, 'cls'=>'file','model'=>'news','action'=>'add');
		$trees['400020'][] = array('id'=>'400023','text'=>'公告分类','leaf'=>true, 'cls'=>'file','model'=>'category','action'=>'');
	$trees['400000'][] = array('id'=>'400031','text'=>'字典管理','leaf'=>true, 'cls'=>'file','model'=>'dd','action'=>'');
	$trees['400000'][] = array('id'=>'400041','text'=>'系统日志','leaf'=>true, 'cls'=>'file','model'=>'log','action'=>'');
	$trees['400000'][] = array('id'=>'400051','text'=>'电话黑名单','leaf'=>true, 'cls'=>'file','model'=>'telephone','action'=>'');
	$trees['400000'][] = array('id'=>'400061','text'=>'系统设置','leaf'=>true, 'cls'=>'file','model'=>'system','action'=>'');
	$trees['400000'][] = array('id'=>'400071','text'=>'快递方式','leaf'=>true, 'cls'=>'file','model'=>'express','action'=>'');
?>