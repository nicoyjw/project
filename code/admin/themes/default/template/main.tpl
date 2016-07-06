<!--{include file="header.tpl"}-->
<link rel="stylesheet" type="text/css" href="themes/default/css/main.css"/>
<script type="text/javascript" src="common/js/cookie.js"></script>
<script type="text/javascript" src="js/time.js"></script>
<style type="text/css">
.x-column-header-inner{
	border-top:none;
}
</style>
<script type="text/javascript">


/* 

*/


  Ext.define('ImageModel', {
        extend: 'Ext.data.Model',
        fields: ['news_title', 'news_url',{name:'create_time', type:'date', dateFormat:'timestamp'},'is_new']
    });
    var store = Ext.create('Ext.data.JsonStore', {
        model: 'ImageModel',
        proxy: {
            type: 'ajax',
            url: 'index.php?model=system&action=systemupdate',
            reader: {
                type: 'json',
                root: 'news'
            }
        }
    });
    store.load();

var listView = Ext.create('Ext.grid.Panel', {
        height:162,
        store: store,
        viewConfig: {
            emptyText: 'No news to display'
        },
        columns: [{
			text:'公告',
            flex: 1,
            dataIndex: 'news_title',
			renderer: function(value,rowindex,record){
				
				var newcom = record.data.is_new > 0 ? '&nbsp;&nbsp;<img src="themes/default/images/newico.gif" />' : '';
				return '<a href="'+record.data.news_url+'" target="_blank">'+value+'</a>'+newcom;
			}
        }/*,{
            text: '更新时间',
            xtype: 'datecolumn',
            format: 'Y-m-d h:i a',
            flex: 1,
            dataIndex: 'create_time'
        }*/]
    });
 Ext.define('HelpsModel', {
        extend: 'Ext.data.Model',
        fields: ['title', 'url']
    });
    var helpsstore = Ext.create('Ext.data.JsonStore', {
        model: 'HelpsModel',
        proxy: {
            type: 'ajax',
            url: 'index.php?model=system&action=systemurl',
            reader: {
                type: 'json',
                root: 'news'
            }
        }
    });
    helpsstore.load();
var listHelp = Ext.create('Ext.grid.Panel', {
        height:150,
        store: helpsstore,
        viewConfig: {
            emptyText: 'No news to display'
        },
        columns: [{
            text: '帮助',
            flex: 1,
            dataIndex: 'title',
			renderer: function(value,rowindex,record){
				return '<a href="'+record.data.url+'" target="_blank">'+value+'</a>';
			}
        }/*,{
            text: '更新时间',
            xtype: 'datecolumn',
            format: 'Y-m-d h:i a',
            flex: 35,
            dataIndex: 'add_time'
        }*/]
    });	
var tree = Ext.create('Ext.panel.Panel', {
    region:'west',
    style:'background-color:#666;margin:0;padding:0;border-left:1px solid #CCC;border-right:1px solid #CCC;border-bottom:1px solid #CCC;border-radius:8px 0 0 0;',
    id:'west-panel',
    width: 198,
    title:'菜单',
    autoScroll:true,
    collapsible: false,
    layout: {
        // layout-specific configs go here
        type: 'accordion',
        fill:false,
        //multi:true,
        animate: true,
        collapseFirst:false,
        //activeOnTop: true,
        //reserveScrollbar: false // There will be a gap even when there's no scrollbar

    },
    items: [
    ]
});
var tab = Ext.widget('tabpanel', {
	region:'center',
	style:'background-color:#666;margin:0;padding:0;border-radius:0 8px 0 0;border-right:1px solid #CCC',
	deferredRender:false,
	activeTab:0,
	items:[{
		contentEl:'center2',
		title: '首页',
		style:'margin:0 auto;',
		autoScroll:true,
		items:[{
				style:'margin:5px 0 0 0',
				border:false,
				layout:'column',
				items:[
				{	
					border:false,
					columnWidth:.97,
					xtype:'panel',
					style:'margin-left:25px',
					collapsible : false,
					startCollapsed: true,
					html:'<div class="memberIndexInfo radius"><div class="memberIndexAvatar"><p><span id="ctl00_ContentPlaceHolder1_lblUserHeaderIcon"><img src="themes/default/images/touxiang.png"width="100"height="106"alt=""/></span></p><p align="center"><a href="javascript:void(0)">晒头像</a></p></div><div class="memberIndexInfoRight"><table width="96%"border="0"cellspacing="3"cellpadding="0" style="font-size:12px;color:#3E3A39"><tr><td colspan="2"><p class="memberIndexInfoRightZhanghao">用户信息</p></td><td colspan="3"><p class="memberIndexInfoRightHuiyuan">账户信息(公测中...)</p></td></tr><tr><th width="80px;">用&nbsp;&nbsp;户&nbsp;&nbsp;名：</th><td width="220px;"><span id="ctl00_ContentPlaceHolder1_lblrunickname"><!--{$smarty.session.admin_name}--></span></td><th width="110px;">账户状态：</th><td width="60px;"> <span id="ctl00_ContentPlaceHolder1_lblsuaccount">  <!--{if $eff_time eq "success"}--><a style="color:#ec870e;font-size:15px;font-weight:bold;" href="javascript:void(0)"> 正常使用 </a><!--{else}--> <a style="color:#ec870e;font-size:15px;font-weight:bold;" href="javascript:void(0)">已过期  </a><!--{/if}--><!--{$cash}--></span></td><td width="80px"><p><img src="themes/default/images/newico.gif" /></p></td></tr><tr><th>客户编号：</th><td><p><span id="ctl00_ContentPlaceHolder1_lblrushipcode">CNG74149</span>&nbsp;&nbsp;</p></td><th>  </th><td></td>  <td><p>  </p></td></tr><tr><th>发货标识：</th><td><p><span id="ctl00_ContentPlaceHolder1_lblsupin"><!--{$user.frist_name_en}--></span>&nbsp;&nbsp;(&nbsp;<a>First Name</a>&nbsp;)<!--{if $user.frist_name_en eq ""}-->&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)"onclick="newTab(\'clientinfo\',\'修改个人信息\',\'index.php?model=system&action=clientinfo\')">完善个人信息</a><!--{/if}--></td><td><strong></strong>&nbsp;<span id="ctl00_ContentPlaceHolder1_lblsuusaccount"></span></td><td><p></p></td></tr><tr><th>上次登录：</th><td><p><span><a href="javascript:void(0)"><span id="ctl00_ContentPlaceHolder1_lblsupoints"><!--{$last_login}--></span></a></span></p></td><td><strong></strong>&nbsp;<span id="ctl00_ContentPlaceHolder1_lblusdcard"></span></td><td><p></p></td></tr></table></div></div>'
				},{	
					border:false,
					columnWidth:.99,
					xtype:'panel',
					style:'margin-left:25px',
					collapsible : false,
					startCollapsed: true,
					html:'<div class="memberIndexStatistics radius"><div class="memberIndexStatisticsTitle topleftandrightradius"><ul><li style="color:#626262">我的订单</li></ul></div><div class="memberIndexStatisticsContent"><ul><li><span class="fr">(<a  onclick="newTab(\'stock\',\'当前库存\',\'index.php?model=inventory\')" href="javascript:void(0)"><span><!--{$kucun}--></span></a>)</span>我的库存</li><li><span class="fr">(<a href="javascript:void(0)"onclick="newTab(\'tishi7\',\'待审核订单\',\'index.php?model=order&action=servicecheck\')"><span><!--{$num2}--></span></a>)</span>等待审核</li><li><span class="fr">(<a href="javascript:void(0)"onclick="newTab(\'tishi8\',\'待处理订单\',\'index.php?model=order&action=orderhandle\')"><span><!--{$num4}--></span></a>)</span>等待处理</li><li><span class="fr">(<a href="javascript:void(0)"onclick="newTab(\'tishi9\',\'捡货订单\',\'index.php?model=order&action=shippinghandle\')"><span><!--{$num6}--></span></a>)</span>捡货订单</li><li><span class="fr">(<a href="javascript:void(0)"onclick="newTab(\'tishi9\',\'已发货订单\',\'index.php?model=order&action=shippinghandle\')"><span><!--{$num7}--></span></a>)</span>已经发货</li><li><span class="fr">(<a href="javascript:void(0)"><span>0</span></a>)</span>缺货订单</li></ul><span class="clearfix"></span></div></div><div class="memberIndexStatistics radius"style="margin-left:10px;"><div class="memberIndexStatisticsTitle topleftandrightradius"><ul><li style="color:#626262">当天订单</li></ul></div><div class="memberIndexStatisticsContent"><ul><!--{foreach from=$shippingnum item=shipping name=shippingitem}--><!--{if $shipping.num>0}--><li><span class="fr">(<a href="javascript:void(0)"><span><!--{$shipping.num}--></span></a>)</span><!--{$shipping.name}-->:</li><!--{else}--><li><span class="fr">(<a href="javascript:void(0)"><span>0</span></a>)</span>当天发货:</li><!--{/if}--><!--{/foreach}--></ul><span class="clearfix"></span></div></div><div class="memberIndexFAQ radius"><div class="memberIndexTitle2"> 常见问题</div><div class="memberIndexFAQInfo memberIndexIconInfo" ><div style="float:left;"><ul><li><a href="javascript:void(0)"onclick="newTab(\'ask2\',\'常见问题\',\'index.php?model=helps&page=0\')">物流发货</a></li><li><a href="javascript:void(0)"onclick="newTab(\'ask2\',\'常见问题\',\'index.php?model=helps&page=2\')">Amazon相关</a></li><li><a href="javascript:void(0)"onclick="newTab(\'ask2\',\'常见问题\',\'index.php?model=helps&page=4\')">Aliexpress相关</a></li><li><a href="javascript:void(0)"onclick="newTab(\'ask2\',\'常见问题\',\'index.php?model=helps&page=6\')">EBay相关</a></li></ul></div><div style="float:right;"><ul ><li><a href="javascript:void(0)"onclick="newTab(\'ask2\',\'常见问题\',\'index.php?model=helps&page=1\')">产品业务</a></li><li><a href="javascript:void(0)"onclick="newTab(\'ask2\',\'常见问题\',\'index.php?model=helps&page=3\')">客户服务</a></li><li><a  href="javascript:void(0)"onclick="newTab(\'ask2\',\'常见问题\',\'index.php?model=helps&page=5\')">投诉建议</a></li><li><a href="javascript:void(0)"onclick="newTab(\'ask2\',\'常见问题\',\'index.php?model=helps&page=7\')">系统知识</a></li></ul></div></div></div>'
				}]
				  },{
					style:'margin:2 0',
					layout:'column',
					items:[
				{
					columnWidth:.33,
					items:[{
						xtype:'panel',
						style:'margin-left:25px;border-radius:5px 5px 5px 5px;border:1px solid #CCC',
						collapsible : false,
						border:false,
						bodyStyle: 'border-width:0px',
						startCollapsed: true,
						items:[listView]
					}]
				},{
					columnWidth:.32,
					items:[{
						xtype:'panel',
						style:'margin-left:14px;border-radius:5px 5px 5px 5px;',
						collapsible : false,
						border:false,
						startCollapsed: true,
						html:'<div class="memberIndexShare radius"><div class="memberIndexTitle topleftandrightradius"  style="position:relative;">物流信息</div><div class="memberIndexStatisticsContent"><div style="padding:3px;border-bottom: 1px solid #D7D7D7;"><!--{$track.date}-->系统查询发货订单情况<font style="color: #FF6300;float:right;font-weight:bold;margin-right:20px;cursor:pointer;" onclick="newTab(\'tishi19\',\'物流详情\',\'index.php?model=main&action=TrackDetail\')">查看详情</font></div><ul style="margin-top:10px"><li><span class="fr">(<a href="javascript:void(0)"><span><!--{$track.Shipment}--></span></a>)</span>查询不到</li><li><span class="fr">(<a href="javascript:void(0)"><span><!--{$track.Shipment}--></span></a>)</span>运输途中</li><li><span class="fr">(<a href="javascript:void(0)"><span><!--{$track.Arrived}--></span></a>)</span>到达待取</li><li><span class="fr">(<a href="javascript:void(0)"><span><!--{$track.Delivered}--></span></a>)</span>成功签收</li><li><span class="fr">(<a href="javascript:void(0)"><span><!--{$track.Returned}--></span></a>)</span>物件退回</li><li><span class="fr">(<a href="javascript:void(0)"><span><!--{$track.Overseas}--></span></a>)</span>运往当地</li></ul> <div style="clear:both;font-size:11px;padding:3px;color:#CCC">提示：状态为签收完成的订单将自动变为已完成订单。</div></div></div>'
						//items:[listView2]
					}]
				},{
                    columnWidth:.32,
                    items:[{
                        xtype:'panel',
                        style:'margin-left:14px;border-radius:5px 5px 5px 5px;',
                        collapsible : false,
                        border:false,
                        startCollapsed: true,
                        html:'<div class="memberIndexShare radius"><div class="memberIndexTitle topleftandrightradius"  style="position:relative;">应用中心(<font style="color: #FF6300;">完善中...</font>)<img src="themes/default/images/newico.gif" /></div><div class="memberIndexShareInfo memberIndexIconInfo"><span" id="ctl00_ContentPlaceHolder1_lblUserHeart"><a style="padding:15px; target="_blank" href="../app/custom/index.php"> <img alt="全球速卖通批量线上发货" title="全球速卖通批量线上发货" style="height:80px;" src="http://www.cpowersoft.com/app/custom/img/removabl_150.png" /></a><a style="padding:15px; target="_blank" href="../app/custom/index.php"><img alt="全球速卖通定时自动上架商品" title="全球速卖通定时自动上架商品" style="height:80px;" src="http://www.cpowersoft.com/app/custom/img/ali_upsale.jpg" /></a></span></div></div>'
                        //items:[listView2]
                    }]
                }/*,{
				columnWidth:.65,
				style:'margin-left:25px;',
				border:false,
				height:180,
				items:[                                                             
					{
				style:'margin:5px 0 0 0',
				border:false,
				layout:'column',
				items:[
						{
							columnWidth:.2,
							xtype:'panel',
							style:'border-radius:5px 5px 5px 5px;',
							border:false,
							items:[catetree]
						},{
							columnWidth:.8,
							border:false,
							items:[dataview,{
							xtype: 'pagingtoolbar',
							pageSize: 10,
							displayInfo: true,
							displayMsg: '',
							emptyMsg: "没有数据",
							store: imagesstore
						}]
						}
				]}
					]}*/]
		  }
		]
	}]
});
function newTab(id,text,url) {
	  var n = tab.getComponent(id);
      
      if('<!--{$eff_time}-->' == 'error')url = 'http://www.cpowersoft.com/blog/contact_us';
      
		if (!n) {
			var n = tab.add({
				'id' : id,
				'title' : text,
				
				closable:true,
				html : '<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="'+url+'"></iframe>'
				});
		}
		tab.setActiveTab(n);
}
Ext.onReady(function(){
	
   
   var viewport = new Ext.Viewport({
		layout:'border', 
		style:'padding:0 45px 0 45px;background-color:#FFF;',
		items:[
			{
			region:'north',
			height:90,
			html:'<div id="north"><a href="?model=main"><img <!--{$logo_img}--> ></a><ul style="float:right;margin:0;padding:0;list-style:none; background-image:url(themes/default/images/topbg.jpg); background-repeat:no-repeat;background-position:85% 50%;margin-top:-9px"><li style="line-height:40px;text-align:right">欢迎您:&nbsp;&nbsp;<b style="color:#F15628;"><!--{$smarty.session.admin_name}--></b>&nbsp;&nbsp;&nbsp;<a style="margin-right:20px" href="/index.html" target="_blank">官方首页</a><a style="background-color: rgb(255, 127, 0);color:#fff" href="">我的ERP</a>&nbsp;&nbsp;&nbsp;&nbsp;<a target="_blank" href="/app/custom/index.php">我的应用</a>&nbsp;&nbsp;&nbsp;<a target="_blank" href="/blog/">客户服务</a>&nbsp;&nbsp;&nbsp;<a href="/blog/category/worldec">外贸咨询</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:relogin()">强制重登</a>&nbsp;&nbsp;&nbsp;<a target="_blank" href="http://www.cpowersoft.com/login/signOut/">退出系统</a>&nbsp;&nbsp;&nbsp;&nbsp;</li><li style="font-size:14px"><div id="memberHeaderTime"><ul><li onmouseover="overtime(1)"onmouseout="outtime(1)"><p><img src="themes/default/images/china.png"width="20px"alt=""/></p><p class="memberHeaderTimeInfo"><span id="Clock1"></span></p><p id="timeinfo1"class="memberHeaderTimeName">中国<br/>北京</p></li><li onmouseover="overtime(2)"onmouseout="outtime(2)"><p><img src="themes/default/images/ireland.png"width="20px"alt=""/></p><p class="memberHeaderTimeInfo"><span id="Clock2"></span></p><p id="timeinfo2"class="memberHeaderTimeName">爱尔兰<br/>都柏林</p></li><li onmouseover="overtime(3)"onmouseout="outtime(3)"><p><img src="themes/default/images/united_states_of_america_usa.png"width="20px"alt=""/></p><p class="memberHeaderTimeInfo"><span id="Clock3"></span></p><p id="timeinfo3"class="memberHeaderTimeName">美国<br/>纽约</p></li><li onmouseover="overtime(4)"onmouseout="outtime(4)"><p><img src="themes/default/images/australia.png"width="20px"alt=""/></p><p class="memberHeaderTimeInfo"><span id="Clock4"></span></p><p id="timeinfo4"class="memberHeaderTimeName">澳大利亚<br/>悉尼</p></li><li onmouseover="overtime(5)"onmouseout="outtime(5)"><p><img src="themes/default/images/united_kingdom_great_britain.png"width="20px"alt=""/></p><p class="memberHeaderTimeInfo"><span id="Clock7"></span></p><p id="timeinfo5"class="memberHeaderTimeName">英国<br/>伦敦</p></li><li onmouseover="overtime(6)"onmouseout="outtime(6)"><p><img src="themes/default/images/germany.png"width="20px"alt=""/></p><p class="memberHeaderTimeInfo"><span id="Clock8"></span></p><p id="timeinfo6"class="memberHeaderTimeName">德国<br/>柏林</p></li></ul></div></li></ul></div><div style="border:0"id="center2"></div>'
			},
			tab,tree/*,{
				region:'south',
				height:25,
				html:'<div style="padding:5px 0 0 5px;background-color:#157FCC;color:#FFF;height:100%"><span style="margin-right:25px;float:left">上门收件|发货请联系业务&nbsp;&nbsp;<b>业务(华强北):</b> <a style="color:#FFF" href="tencent://message/?uin=976017741&Site=&Menu=yes">976017741</a></span><span style="margin-right:25px;float:left"><b>业务(南山):</b> <a style="color:#FFF" href="tencent://message/?uin=799417121&Site=&Menu=yes">799417121</a></span><span style="margin-right:25px;float:left"><b>业务(广州):</b> <a style="color:#FFF" href="tencent://message/?uin=799417121&Site=&Menu=yes">799417121</a></span><span style="margin-right:15px;float:right">系统问题请联系技术&nbsp;&nbsp;<b>技术(1):</b> <a style="color:#FFF" href="tencent://message/?uin=545315118&Site=&Menu=yes">545315118</a>&nbsp;&nbsp;<b>技术(2):</b><a style="color:#FFF" href="tencent://message/?uin=2020712305&Site=&Menu=yes">2020712305</a></span></div>'
			}*/
		 ]
	});
	  <!--{foreach from =$trees item = tree name=treeitem}}-->
        tree.add(Ext.create('Ext.tree.Panel', {
            title: '<!--{$tree.text}-->',
            lines:true,
            autoLoad:false, 
            autoScroll:true,
            tools:[{
                type: 'refresh',
                handler: function(c, t) {
                    tree.setLoading(true, tree.body);
                    
                    Ext.Function.defer(function() {
                        tree.setLoading(false);
                        root.expand(true, true);
                    }, 1000);
                }
            }],
            rootVisible: false,
            store: Ext.create('Ext.data.TreeStore', {
                fields:['id','text','leaf','action','model'],
                proxy: {
                    type: 'ajax',
                    url: 'index.php?model=main&action=Treeson&node=<!--{$tree.id}-->',
                },root: {
                text: 'Root',
                id: '<!--{$tree.id}-->',
                draggable:false
                 }
            }),
            listeners: {
                itemclick: function(view,n ) {
                    if (n.get("leaf")) {  
                                 
                        newTab(n.get("id"),n.get("text"),'index.php?model='+n.get("model")+'&action='+n.get("action"))
                    }  
                }
            }
        }));
    <!--{/foreach}-->
	loadend();
	worldClockZone();
});
function overtime(num){
	//document.getElementById("timeinfo"+num).style.display == 'block';return;
	if(document.getElementById("timeinfo"+num).style.display == 'block') return false;
	Ext.get("timeinfo"+num).fadeIn({
         opacity: 1,
         easing: 'easeOut',
         duration: 600
     });
	 document.getElementById("timeinfo"+num).style.display = 'block';
}
function outtime(num){
	//document.getElementById("timeinfo"+num).style.display == 'none';return;
	if(document.getElementById("timeinfo"+num).style.display == 'none') return false;
	Ext.get("timeinfo"+num).fadeOut({
         opacity: 0,
         easing: 'easeOut',
         duration: 100,
         remove: false,
         useDisplay: false
     });
	document.getElementById("timeinfo"+num).style.display = 'none';
}
function setopacity(ev, v){
	ev.filters ? ev.style.filter = 'alpha(opacity=' + v + ')' : ev.style.opacity = v / 100;
}
//淡入效果(含淡入到指定透明度)
function fadeIn(elem, speed, opacity){
	/*
	 * 参数说明
	 * elem==>需要淡入的元素
	 * speed==>淡入速度,正整数(可选)
	 * opacity==>淡入到指定的透明度,0~100(可选)
	 */
	speed = speed || 1000;
	opacity = opacity || 1;
	//显示元素,并将元素值为0透明度(不可见)
	elem.style.display = 'block';
	setopacity(elem, 100);
	//初始化透明度变化值为0
	var val = -1;
	//循环将透明值以5递增,即淡入效果
	(function(){
		setopacity(elem, val);
		val += 0.00005;
		if (val <= opacity) {
			setTimeout(arguments.callee, speed)
		}
	})();
}

//淡出效果(含淡出到指定透明度)
function fadeOut(elem, speed, opacity){
	/*
	 * 参数说明
	 * elem==>需要淡入的元素
	 * speed==>淡入速度,正整数(可选)
	 * opacity==>淡入到指定的透明度,0~100(可选)
	 */
	speed = speed || 1000;
	opacity = opacity || 0;
	//初始化透明度变化值为0
	var val = 1;
	//循环将透明值以5递减,即淡出效果
	(function(){
	   setopacity(elem, val);
		val -= 0.0005;
		if (val >= opacity) {
			setTimeout(arguments.callee, speed);
		}else if (val < 0) {
			//元素透明度为0后隐藏元素
			elem.style.display = 'none';
		}
	})();
}
function afterselect(k){
	var cid = document.getElementById('cat_id');
	cid.setAttribute('value',k);
	imagesstore.load({params:{start:0, limit:10,
		cat_id:document.getElementById('cat_id').value
	}});
}
function tdchange(num,obj){
	if(num == 1) obj.bgColor = '#FF6634';
	else obj.bgColor = '#157fcc';
}
function relogin(){
	var win = Ext.getCmp('modeemail');
	if(!win){
		var reloginform = Ext.create('Ext.form.Panel',{
			id:'modeemailform',
			buttonAlign:'center',
			align:'center',
			padding:5,
			modal:false,
			frame:false,
			border:false,
			items: [
				{	xtype:'textfield',
					width:250,
					id:'username',
					name:'username',
					labelWidth:45,
					fieldLabel: '用户名',
					value:'<!--{$smarty.session.admin_name}-->'
				},{	xtype:'textfield',
            		inputType:'password',
					width:250,
					id:'passwd',
					name:'passwd',
					labelWidth:45,
					fieldLabel: '密码'
				},{	xtype:'textfield',
					width:250,
					id:'company',
					name:'company',
					hidden:true,
					labelWidth:45,
					value:'<!--{$smarty.session.admin_name}-->',
					fieldLabel: '公司名',
				}
			],
			buttons: [{
				text: '强制重登',
				handler:function(){
				if(reloginform.form.isValid()){
					var date = new Date();
					date.setTime(date.getTime() - 10000);
					document.cookie = 'PHPSESSID' + "=a; expires=" + date.toGMTString()+"; path=/";
					document.cookie = 'MYBUSERLOGIN' + "=a; expires=" + date.toGMTString()+"; path=/erp/";
					document.cookie = 'MYOIS_AUTH_CHECKTIME' + "=a; expires=" + date.toGMTString()+"; path=/erp/";
					Ext.getBody().mask("正在注销.请稍等...","x-mask-loading");
					reloginform.form.doAction('submit',{
						 url:'index.php?action=login',
						 method:'post',
						 params:'',
						 success:function(form,action){
							 
								if (action.result.msg=='OK') {
									document.location='index.php?model=main';
								} else {
									Ext.example.msg('登录出错',action.result.msg);
								}
						 },
						 failure:function(){
								Ext.example.msg('操作','服务器出现错误请稍后再试！');
						 }
				   });
				   win.hide();
				}
				}
			}]
		})
		win = Ext.create('Ext.window.Window',{
			id:'modeemail',
			title:'请输入您的密码',
			layout:'fit',
			width:300,
			height:180,
			bodyStyle:'padding:5px 5px 0',
			closeAction:'destroy',
			collapsible:true,
			constrainHeader:true,
			modal:false,
			plain: false,
			items:[reloginform]
		});
	}
	win.show();
		
}



</script>



<!--{include file="footer.tpl"}-->    
