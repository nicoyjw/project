<!--{include file="header.tpl"}-->
<script type="text/javascript" src="common/lib/flashchart-php5-ofc-library/swfobject.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
    Ext.QuickTips.init();
var Nowdate=new Date();
Ext.form.Field.prototype.msgTarget = 'side';
var arr=[
	 {
		xtype:'label',
		text: '销售帐户：'
	},
	{
	xtype:'combo',
	store: new Ext.data.SimpleStore({
		fields: ['id','name'],
		data: [<!--{$Sales_account}-->,['0','所有账户']]
	}),
	valueField :"id",
	displayField: "name",
	mode: 'local',
	editable: false,
	allowBlank: true,
	forceSelection: true,
	triggerAction: 'all',
	hiddenName:'Sales_account',
	fieldLabel: '销售帐户',
	emptyText:'选择',
	value:0,
	id:'Sales_account'
	},
	 {
		xtype:'label',
		text: '开始时间：'
	},
	{
		xtype:'datefield',
		name: 'starttime',
		format:'Y-m-d',
		editable: false,
		allowBlank:false,
		blankText:'不能为空',
		value:new Date(Nowdate.getYear()+1900,Nowdate.getMonth(),1),
		invalidText:'格式错误！'
	},
	{
		xtype:'label',
		text: '截止时间：'
	},
	{
		xtype:'datefield',
		name: 'endtime',
		format:'Y-m-d',
		editable: false,
		allowBlank:false,
		blankText:'不能为空',
		value:Nowdate,
		invalidText:'格式错误！'
	},{
		xtype:'label',
		text: '显示数量：'
	},
	{
		xtype:'numberfield',
		minValue:5,
		MaxValue:10,
		name: 'limit',
		width:40,
		value:5
	},
	 {
		text:'查询',
		xtype:'button',
		style:'margin-left:20px',
		pressed:true,
		handler:function(){
			var form = Ext.getCmp("queryform").getForm();
			if(form.isValid()) {
				swfobject.embedSWF(
					"common/lib/flashchart-php5-ofc-library/open-flash-chart.swf", "chart",
					"500", "400", "9.0.0", "expressInstall.swf",
					{"data-file":escape("index.php?model=reportforms&action=gethotgoodssales"+'&starttime='+form.findField('starttime').getValue().format('Y-m-d')+'&endtime='+form.findField('endtime').getValue().format('Y-m-d')+'&limit='+form.findField('limit').getValue()+'&Sales_account='+form.findField('Sales_account').getValue())}
				);
			}
		}
	 }
 ];
var form = new Ext.FormPanel({
							 id:'queryform',
							 title:'热销产品排名',
							 layout: 'column',
							 columns:3,
							 border:false,
							 frame:true,
							 items:arr,
							 renderTo: Ext.get('query_form')
							 });


	loadend();
});
</script>
<div id="query_form"></div>
<div id="chart"></div>
<!--{include file="footer.tpl"}-->