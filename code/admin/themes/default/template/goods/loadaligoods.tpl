<!--{include file="header.tpl"}-->
<link rel="stylesheet" type="text/css" href="js/statusbar/css/statusbar.css" />
<script type="text/javascript" src="js/statusbar/StatusBar.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	var account = [<!--{$account}-->];
    Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget = 'side';
	
    var top = Ext.create('Ext.form.Panel',{
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
	        store: Ext.create('Ext.data.ArrayStore',{
	             fields: ["id", "account_name"],
	             data: account
	        }),
	        valueField :"id",
	        displayField: "account_name",
	        mode: 'local',
			width:250,
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
			handler:function(){top.getForm().reset();}
        }]
    });
	
    var bestmatch =Ext.create('Ext.form.Panel',{
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
	        store: Ext.create('Ext.data.ArrayStore',{
	             fields: ["id", "account_name"],
	             data: account
	        }),
	        valueField :"id",
			width:250,
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
				if(bestmatch.getForm(0).isValid()){
						var id = bestmatch.getForm().getFieldValues().id;
						parent.newTab('goodsload','加载Ebay Bestmatch','index.php?model=goods&action=Loadbestmatch&id='+id);
				}
			}
        },{
        	text: '重置',
			handler:function(){bestmatch.form.reset();}
        }]
    });	
	
    var category = Ext.create('Ext.form.Panel',{
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
	        store: Ext.create('Ext.data.ArrayStore',{
	             fields: ["id", "account_name"],
	             data: account
	        }),
			width:250,
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
				if(category.getForm().isValid()){
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
