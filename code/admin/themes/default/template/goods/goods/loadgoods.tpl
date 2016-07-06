<!--{include file="header.tpl"}-->
<link rel="stylesheet" type="text/css" href="js/statusbar/css/statusbar.css" />
<script type="text/javascript" src="js/statusbar/StatusBar.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	var account = [<!--{$account}-->];
    Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget = 'side';
	
    var top = new Ext.FormPanel({
		id:'loadform',
        buttonAlign:'center',
        align:'center',
		labelWidth:70,
        frame:true,
        title: 'EbayListing加载',
        bodyStyle:'padding:5px 5px 0',
		style:'margin:10px',
		width:300,
		renderTo:document.body,
        items: [{
	        xtype:'combo',
	        store: new Ext.data.SimpleStore({
	             fields: ["id", "account_name"],
	             data: account
	        }),
	        valueField :"id",
	        displayField: "account_name",
	        mode: 'local',
	        editable: false,
	        forceSelection: true,
	        triggerAction: 'all',
	        hiddenName:'id',
	        fieldLabel: 'Ebay账号',
	        emptyText:'选择Ebay账号',
	        name: 'id',
			allowBlank:false,
			blankText:'请选择'
	        }
        ],

        buttons: [{
            text: '加载账号产品',
			handler:function(){
				if(top.form.isValid()){
						var id = top.getForm().getFieldValues().id;
						parent.newTab('goodsload','加载Ebay产品','index.php?model=goods&action=Loadgoods&id='+id);
				}
			}
        },{
        	text: '重置',
			handler:function(){top.form.reset();}
        }]
    });
	
    var bestmatch = new Ext.FormPanel({
		id:'loadform',
        buttonAlign:'center',
        align:'center',
		labelWidth:70,
        frame:true,
        title: 'EbayBestmatch加载',
        bodyStyle:'padding:5px 5px 0',
		style:'margin:10px',
		width:300,
		renderTo:document.body,
        items: [{
	        xtype:'combo',
	        store: new Ext.data.SimpleStore({
	             fields: ["id", "account_name"],
	             data: account
	        }),
	        valueField :"id",
	        displayField: "account_name",
	        mode: 'local',
	        editable: false,
	        forceSelection: true,
	        triggerAction: 'all',
	        hiddenName:'id',
	        fieldLabel: 'Ebay账号',
	        emptyText:'选择Ebay账号',
	        name: 'id',
			allowBlank:false,
			blankText:'请选择'
	        }
        ],

        buttons: [{
            text: 'BestMatch数据',
			handler:function(){
				if(bestmatch.form.isValid()){
						var id = bestmatch.getForm().getFieldValues().id;
						parent.newTab('goodsload','加载Ebay Bestmatch','index.php?model=goods&action=Loadbestmatch&id='+id);
				}
			}
        },{
        	text: '重置',
			handler:function(){bestmatch.form.reset();}
        }]
    });	
	/*$trees['400078'][]=array('id' =>'400088','text' =>'模块管理','leaf' =>true,'cls' =>'file','model' =>'menu','action' =>'','root' =>'400078');
$trees['400078'][]=array('id' =>'400090','text' =>'权限管理','leaf' =>true,'cls' =>'file','model' =>'privilege','action' =>'','root' =>'400078');
$trees['400078'][]=array('id' =>'400190','text' =>'ERP客户管理','leaf' =>true,'cls' =>'file','model' =>'system','action' =>'client','root' =>'400078')*/;
    var category = new Ext.FormPanel({
		id:'loadform',
        buttonAlign:'center',
        align:'center',
		labelWidth:70,
        frame:true,
        title: 'Ebay店铺分类加载',
        bodyStyle:'padding:5px 5px 0',
		style:'margin:10px',
		width:300,
		renderTo:document.body,
        items: [{
	        xtype:'combo',
	        store: new Ext.data.SimpleStore({
	             fields: ["id", "account_name"],
	             data: account
	        }),
	        valueField :"id",
	        displayField: "account_name",
	        mode: 'local',
	        editable: false,
	        forceSelection: true,
	        triggerAction: 'all',
	        hiddenName:'id',
	        fieldLabel: 'Ebay账号',
	        emptyText:'选择Ebay账号',
	        name: 'id',
			allowBlank:false,
			blankText:'请选择'
	        }
        ],

        buttons: [{
            text: 'Ebay 店铺分类',
			handler:function(){
				if(category.form.isValid()){
						var id = category.getForm().getFieldValues().id;
						parent.newTab('goodsload','加载Ebay 店铺分类','index.php?model=goods&action=Loadcategory&id='+id);
				}
			}
        },{
        	text: '重置',
			handler:function(){category.form.reset();}
        }]
    });		
    loadend();
});
</script>
<!--{include file="footer.tpl"}-->
