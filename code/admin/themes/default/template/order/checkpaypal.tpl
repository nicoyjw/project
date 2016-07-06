<!--{include file="header.tpl"}-->
<link rel="stylesheet" type="text/css" href="js/grouping.css" />
<link rel="stylesheet" type="text/css" href="js/statusbar/css/statusbar.css" />
<script type="text/javascript" src="js/statusbar/StatusBar.js"></script>
    <script type="text/javascript">
Ext.onReady(function() {
var account = [<!--{$account}-->];
var msgWindow = showWindow('开始自动核对');
var arr = object_Array(account);
var t = Ext.create('Ext.grid.feature.Grouping',{
        groupHeaderTpl: '{group}账号待审核订单数量: ({[values.rs.length]}个订单)',
        hideGroupedHeader: true
    });
	
function showaccount(val){
	return arr[val];
}

var account_combo = Ext.create('Ext.form.field.ComboBox',{
	            store: Ext.create('Ext.data.ArrayStore',{
	                    fields: ["retrunValue", "displayText"],
	                    data: account
	                    }),
	             valueField :"retrunValue",
	              displayField: "displayText",
	              mode: 'local',
				  width:250,
				  labelWidth:65,
				  allowBlank:false,
				  blankText:'不能为空',
	              editable: false,
	              forceSelection: true,
	              triggerAction: 'all',
	              hiddenName:'account',
	              fieldLabel: '选择账户',
	              emptyText:'选择',
	              name: 'account',
				  id:'account_combo'
	});

var sb = Ext.getCmp('basic-statusbar');
		var store = Ext.create('Ext.data.JsonStore', {
			fields:['order_id','Sales_account_id','order_sn','userid','paypalid','PayPalEmailAddress'],
			groupField:'Sales_account_id',
			autoLoad:true,
			sorters:{property: 'order_id', direction: "ASC"},
			proxy: {
				type: 'ajax',
				url:'index.php?model=order&action=waitcheck',
				reader: {
					type: 'json',
					idProperty:'order_id',
					root: 'topics'
				}
			}
		});
    var grid = Ext.create('Ext.grid.Panel',{
        store: store,
        columns: [
            {header: "id", flex:1,hidden:true, sortable: true, dataIndex: 'order_id'},
			{header: "账号",flex:1,hidden:true, dataIndex: 'Sales_account_id',renderer:showaccount},
            {header: "订单号", flex:1, sortable: true, dataIndex: 'order_sn'},
            {header: "Buyer", flex:1, sortable: true, dataIndex: 'userid'},
            {header: "交易ID", flex:1, sortable: true, dataIndex: 'paypalid'},
			{header: "收款账号", flex:1, sortable: true, dataIndex: 'PayPalEmailAddress'}
        ],
        features: [t],
		tbar:[account_combo,{
				xtype:'button',
				text:'开始核对',
				handler:function(){
						startcheck();
						}
				}],
        frame:true,
		loadMask:true,
        height: 450,
        collapsible: true,
        animCollapse: false,
        title: '待审核列表',
        renderTo: document.body
    });
	
function startcheck(){
	var account_id = Ext.getCmp('account_combo').getValue();
	if(!account_id == ''){
		msgWindow.show();
		sb.showBusy();
		addText('开始校对'+arr[account_id]+'账号订单<br>');
		midStart(0);
	}
}

function midStart(num){
	var account_id = Ext.getCmp('account_combo').getValue();
		var records=store.queryBy(function(record,id){
			return record.get("Sales_account_id") == account_id;
		}).getRange();
		if(num<records.length){
			var paypalid = records[num].data.paypalid;
			var orderid = records[num].data.order_id;
			var PayPalEmailAddress = records[num].data.PayPalEmailAddress;
			ajaxHading(account_id,paypalid,orderid,num,PayPalEmailAddress);
		}else{
		sb.clearStatus();
		sb.setText('核对完成');
		store.load();
		}
}
function ajaxHading(account_id,paypalid,orderid,num,PayPalEmailAddress){
			Ext.Ajax.request({
					url:'index.php?model=order&action=ajaxpaypal',
					timeout:600000,
					success:function(response){
							addText(response.responseText);
							midStart(num+1);
							},
					failure:function(response){
							addText(response.responseText);
							sb.setStatus({
							text: 'Oops!',
							iconCls: 'x-status-error',
							clear: true 
							});
							},
					params:{account_id:account_id,paypalid:paypalid,orderid:orderid,PayPalEmailAddress:PayPalEmailAddress}
					});
}
function addText(str){
	msgWindow.body.dom.innerHTML = msgWindow.body.dom.innerHTML+str;
}
	loadend();
});
    </script>
<!--{include file="footer.tpl"}-->
