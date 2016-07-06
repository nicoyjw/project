<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/normalgrid.js"></script>
<script type="text/javascript" src="js/system/sales.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	var salechannel = [<!--{$Sales_channels}-->];
	var cnl = object_Array(salechannel);
	function showCnl(val){
		return cnl[val];
	}
	Ext.QuickTips.init();
    var SalesGrid = new Ext.ux.SalesGrid({
        title: '销售员列表',
		headers:['序号','销售员','分成比例','销售代码','起始时间'],
        fields: ['id','name', 'rate','code','start_time'],
		formitems:[{
				xtype:'hidden',
                name: 'id'
				},{
				name:'name',
				fieldLabel:'销售员',
				width:180,
				allowBlank:false,
				blankText:'此项必填'
				},{
				name:'rate',
				xtype:'numberfield',
				maxValue:100,
				allowDecimals:false,
				allowNegative:false,
				fieldLabel:'分成比例',
				width:120,
				allowBlank:false
				},{
				name:'code',
				fieldLabel:'销售代码',
				width:120
				},{
				xtype:'datefield',
				name:'start_time',
				fieldLabel:'起始时间',
				format:'Y-m-d',
				width:120
				}],
		width:800,
		frame:true,
		saveURL:'index.php?model=sales&action=update',
		delURL:'index.php?model=sales&action=delete',
		listURL:'index.php?model=sales&action=list',
		windowTitle:'销售员信息',
		windowWidth:420,
		windowHeight:200,
        renderTo: document.body
    });
    var SalesGoodsGrid = new Ext.ux.SalesGoodsGrid({
		id:'SalesGoodsGrid',
        title: '销售员产品',
		headers:['序号','产品编码','成本(含运费)'],
        fields: ['rec_id','sku','cost'],
		frame:true,
		saveURL:'index.php?model=sales&action=goodsupdate',
		delURL:'index.php?model=sales&action=goodsdelete',
		listURL:'index.php?model=sales&action=goodslist',
		formitems:[{
				xtype:'hidden',
                name: 'rec_id'
				},{
				xtype:'hidden',
                name: 'id'
				},{
				name:'sku',
				fieldLabel:'SKU',
				width:180,
				allowBlank:false,
				blankText:'此项必填'
				},{
				name:'cost',
				fieldLabel:'cost',
				xtype:'numberfield',
				allowNegative:false,
				width:180,
				allowBlank:false,
				blankText:'此项必填'
				}],
		width:800,
		windowTitle:'销售员产品',
		windowWidth:320,
		windowHeight:130,
        renderTo: document.body
    });
    var SalesChannelGrid = new Ext.ux.SalesChannelGrid({
		id:'SalesChannelGrid',
        title: '销售渠道费率',
		headers:['序号','销售渠道','费率','固定费用'],
        fields: ['id','sales_channels','rate','fix'],
		frame:true,
		saveURL:'index.php?model=sales&action=channelupdate',
		delURL:'index.php?model=sales&action=channelete',
		listURL:'index.php?model=sales&action=channellist',
		channelreander:showCnl,
		formitems:[{
				xtype:'hidden',
                name: 'id'
				},{
					xtype:'combo',
					store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: salechannel
							}),
					valueField :"id",
					displayField: "key_type",
					mode: 'local',
					width:130,
					editable: false,
					forceSelection: true,
					triggerAction: 'all',
					hiddenName:'sales_channels',
					name: 'sales_channels',
					allowBlank:false,
					fieldLabel: '销售渠道'
            },{
				name:'rate',
				xtype:'numberfield',
				maxValue:100,
				allowDecimals:false,
				allowNegative:false,
				fieldLabel:'费率',
				width:120,
				allowBlank:false
				},{
				name:'fix',
				xtype:'numberfield',
				maxValue:100,
				allowNegative:false,
				fieldLabel:'固定费用',
				width:120,
				allowBlank:false
				}],
		width:800,
		windowTitle:'销售渠道费率',
		windowWidth:320,
		windowHeight:160,
        renderTo: document.body
    });
	SalesGrid.getStore().load({
			params:{start:0,limit:SalesGrid.pagesize}
			});
	SalesChannelGrid.getStore().load({
			params:{start:0,limit:SalesGrid.pagesize}
			});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
