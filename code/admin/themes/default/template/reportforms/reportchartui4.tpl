<!--{include file="header.tpl"}-->
<script type="text/javascript" src="common/lib/flashchart-php5-ofc-library/swfobject.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
var Nowdate=new Date();
Ext.form.Field.prototype.msgTarget = 'side';
var arr=[
	 {
		xtype:'label',
		text: '销售帐户：',
		style:'font-size:12px;font-family:Arial, Helvetica, sans-serif'
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
	name: 'Sales_account',
	id:'Sales_account'
	},
	 {
		xtype:'label',
		text: '开始时间：',
		style:'font-size:12px;font-family:Arial, Helvetica, sans-serif'
	},
	{
		xtype:'datefield',
		name: 'starttime',
		format:'Y-m-d',
		editable: false,
		allowBlank:false,
		value:new Date(Nowdate.getYear()+1900,Nowdate.getMonth(),1),
		blankText:'不能为空',
		invalidText:'格式错误！'
	},
	{
		xtype:'label',
		text: '截止时间：',
		style:'font-size:12px;font-family:Arial, Helvetica, sans-serif'
	},
	{
		xtype:'datefield',
		name: 'endtime',
		format:'Y-m-d',
		editable: false,
		value:Nowdate,
		allowBlank:false,
		blankText:'不能为空',
		invalidText:'格式错误！'
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
					"1300", "400", "9.0.0", "expressInstall.swf",
					{"data-file":escape("index.php?model=reportforms&action=GetDaySales"+'&starttime='+form.findField('starttime').getValue().format('Y-m-d')+'&endtime='+form.findField('endtime').getValue().format('Y-m-d')+'&Sales_account='+form.findField('Sales_account').getValue())}
				);
			}
			console.log("index.php?model=reportforms&action=GetDaySales"+'&starttime='+form.findField('starttime').getValue().format('Y-m-d')+'&endtime='+form.findField('endtime').getValue().format('Y-m-d')+'&Sales_account='+form.findField('Sales_account').getValue());
		}
	 }
 ];
var form = new Ext.FormPanel({
							 id:'queryform',
							 title:'日销售报表',
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