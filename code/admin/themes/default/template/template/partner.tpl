<!--{include file="header.tpl"}-->
    <style type="text/css">
        body .x-panel {
            margin:0 0 20px 10px;
        }
    </style>
<script type="text/javascript" src="js/normalgrid.js"></script>
    <script type="text/javascript">
Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';	
	var MessageGrid = new Ext.ux.NormalGrid({
		id:'BrandGrid',
        title: '客户联系message模板列表',
		headers:['序号','模板名','内容'],
        fields: ['rec_id','temp_name','temp_content'],
		width:850,
		frame:true,
		saveURL:'index.php?model=template&action=update',
		delURL:'index.php?model=template&action=del',
		listURL:'index.php?model=template&action=partnerList',
		formitems:[{
				xtype:'hidden',
                name: 'rec_id'
				},{
				xtype:'hidden',
                name: 'cat_id',
				value:2
				},{
				name:'temp_name',
				xtype:'textfield',
				fieldLabel:'模板名',
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
        renderTo: document.body
	})
	var panel = new Ext.Panel({
		title:'参数设置',
		shadow:true,
		collapsible:true,
		html:"可调用参数<br />买家名:{BuyerName}<br />买家ID:{BUYERID}<br />账号ID:{SELLERID}<br />ItemNO:{ITEMNOLIST}<br />付款时间:{PaidDate}<br>发货时间:{ShipDate}<br>订单总价:{Amount}<br>追踪单号:{Track_no}<br>回复ID:{admin_user}<br>发货地址:{Shippingaddress}",
		width:350,
		height:250,
		renderTo: document.body
	});
	MessageGrid.getStore().load();
	loadend();
});
    </script>
<!--{include file="footer.tpl"}-->
