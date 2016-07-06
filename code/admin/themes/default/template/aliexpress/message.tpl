<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/normalgrid.js"></script>
<script type="text/javascript">
Ext.onReady(function() {
	Ext.QuickTips.init();	
	var MessageGrid = Ext.create('Ext.ux.NormalGrid',{
		id:'BrandGrid',
        title: '客户回复Message模板列表',
		headers:['序号','模板名','内容','排序值'],
        fields: ['rec_id','temp_name','temp_content','temp_sn'],
		width:850,
		frame:true,
		saveURL:'index.php?model=template&action=update',
		delURL:'index.php?model=template&action=del',
		listURL:'index.php?model=template&action=messageList',
		formitems:[{
				xtype:'hidden',
                name: 'rec_id'
				},{
				xtype:'hidden',
                name: 'cat_id',
				value:1
				},{
				xtype:'textfield',
				name:'temp_name',
				fieldLabel:'模板名',
				allowBlank:false,
				blankText:'此项必填'
				},{
				name:'temp_sn',
				fieldLabel:'排序值',
				xtype:'numberfield',
				decimalPrecision:4,
				allowDecimals:true,
				allowBlank:false,
				blankText:'此项必填'
				},{
				xtype:'textarea',
				width:470,
				height:300,
				name:'temp_content',
				fieldLabel:'内容',
				allowBlank:false
				}],
		windowTitle:'模板编辑',
		windowWidth:600,
        windowHeight:480,
		pagesize:10,
        renderTo: document.body
	});
    var panel = new Ext.Panel({
        title:'参数设置',
        shadow:true,
        collapsible:true,
        html:"<table style='font-size:14px;width:100%'><tr><td>公共(所有订单留言或者站内信的变量)</td><td>订单留言的变量</td><td>产品留言的变量</td></tr><tr><td><table style='font-size:12px;'><tr><td>买家名:</td><td>{BuyerName}</td></tr><tr><td>买家ID:</td><td>{BUYERID}</td></tr><tr><td>订单号:</td><td>{ItemNO}</td></tr><tr><td>账号ID:</td><td>{SELLERID}</td></tr></table></td><td><table style='font-size:12px;'><tr><td>订单总价:</td><td>{Amount}</td></tr><tr><td>发货地址:</td><td>{Shippingaddress}</td></tr><tr><td>发货时间:</td><td>{ShipDate}</td></tr><tr><td>付款时间:</td><td>{PaidDate}</td></tr><tr><td>追踪单号:</td><td>{Track_no}</td></tr><tr><td>追踪信息:</td><td>{track_info}</td></tr></table></td><td><table style='font-size:12px;'><tr><td>产品名:</td><td>{ProductName}</td></tr><tr><td>产品链接:</td><td>{ProductLink}</td></tr><tr><td>产品售价:</td><td>{ProductPrice}</td></tr></table></td></tr>",
        width:850,
        height:650,
        renderTo: document.body
    });
	MessageGrid.getStore().load();
	loadend();
});
    </script>
<!--{include file="footer.tpl"}-->
