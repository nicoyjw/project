<!--{include file="header.tpl"}-->
<script type="text/javascript" src="common/lib/ext-4/ux/RowEditor.js"></script>
<link rel="stylesheet" type="text/css" href="common/lib/ext-4/ux/css/RowEditor.css" />
<script type="text/javascript" src="js/normaleditor.js"></script>
<script type="text/javascript" src="js/order/orderstatus.js"></script>
    <script type="text/javascript">
Ext.onReady(function() {

var istruedata = [<!--{$is_true}-->];
var orderstatusdata = [<!--{$order_status}-->];
var start_end = [<!--{$start_end}-->];
function newcombo(sdata){
	return Ext.create('Ext.form.field.ComboBox',{
                    typeAhead: true,
                    triggerAction: 'all',
                        mode: 'local',
					store: Ext.create('Ext.data.ArrayStore',{
						id: 0,
						fields: [
							'myId',
							'displayText'
						],
						data: sdata
					}),
					valueField: 'myId',
					width:250,
					displayField: 'displayText',
                    lazyRender: true,
                    listClass: 'x-combo-list-small'
                });
}
var statuscombo1 = newcombo(orderstatusdata);
var statuscombo2 = newcombo(orderstatusdata);
var statuscombo3 = newcombo(orderstatusdata);
var statuscombo4 = newcombo(orderstatusdata);
var istruecombo = newcombo(istruedata);
var istruecombo1 = newcombo(istruedata);
var istruecombo2 = newcombo(istruedata);
var istruecombo3 = newcombo(istruedata);
var s_e_locationcombo = newcombo(start_end);
var sdata=object_Array(istruedata);
var statusdata=object_Array(orderstatusdata);
var s_e = object_Array(start_end);
    function istrue(v) {
		return sdata[v];
    }
	function sstatus(v) {
		return statusdata[v];
    }
	function s_e_location(v){
		return s_e[v];
	}
    var editor = Ext.create('Ext.grid.plugin.RowEditing', {
		clicksToEdit: 1
	});
			var Menu = Ext.data.Record.create({
				name: 'id',
				type: 'string'
			},{
				name: 'status',
				type: 'string'
			},{
				name: 'next_id',
				type: 'string'
			},{
				name: 'hold_id',
				type: 'string'
			},{
				name: 'refund_id',
				type: 'string'
			},{
				name: 'fail_id',
				type: 'string'
			},{
				name: 'pay_status',
				type: 'string'
			},{
				name: 'shipping_status',
				type: 'string'
			},{
				name: 'start_end',
				type: 'string'
			},{
				name: 'is_show',
				type: 'string'
			},{
				name: 'description',
				type: 'string'
			}); 
	
	
    var OrderstatusGrid = Ext.create('Ext.ux.OrderstatusEditor',{
        title: '订单状态管理',
		border:false,
		region:'center',
		loadMask: true,
		headers:['序号','状态','通过状态','暂停状态','退款状态','未通过','是否支付','是否发货','所处位置','是否显示','描述'],
        fields: ['id','status','next_id','hold_id','refund_id','fail_id','pay_status','shipping_status','start_end','is_show','description'],
		values:['','','','','','','0','0','0','0',''],
		editors:['',{
                xtype: 'textfield',
                allowBlank: false,
				blankText:'此项必填'
		},statuscombo1,statuscombo2,statuscombo3,statuscombo4,istruecombo,istruecombo1,s_e_locationcombo,istruecombo3,{
                xtype: 'textfield'
		}],
		renderers:['','',sstatus,sstatus,sstatus,sstatus,istrue,istrue,s_e_location,istrue,''],
		width:600,
		pagesize:20,
		frame:false,
		record:Menu,
		plugins: [editor],
		saveURL:'index.php?model=order&action=savestatus',
		delURL:'index.php?model=order&action=delstatus',
		listURL:'index.php?model=order&action=liststatus',
        renderTo: document.body
    });
	var viewport =Ext.create('Ext.Viewport',{
        layout:'border',
        items:[
			OrderstatusGrid,Ext.create('Ext.panel.Panel',{
				region:'south',
				height:50,
				html:'状态说明:<br>1.所处位置---该状态是订单流程中的起始或者终止或者流程中的状态，如被删除的订单应为结束而手工录单则为开始<br>2.是否显示---起始流程中的订单是否显示在客服审核位置，默认为否，直接显示在库管审核中'			
			})
		]}
	);
	loadend();
});
    </script>
  <div id="north-div"></div>
  <div id="center"></div>
<!--{include file="footer.tpl"}-->
