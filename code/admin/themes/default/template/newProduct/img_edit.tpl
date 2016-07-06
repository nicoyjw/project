<!--{include file="header.tpl"}-->
<script type="text/javascript" src="common/lib/ext/ux/RowEditor.js"></script>
<link rel="stylesheet" type="text/css" href="common/lib/ext/ux/css/RowEditor.css" />
<script type="text/javascript" src="js/normaleditor.js"></script>
<script type="text/javascript" src="js/normalgrid.js"></script>
<script type="text/javascript" src="js/newProduct/imgEditor.js"></script>
<script type="text/javascript">
Ext.onReady(function() {
	//Ext.QuickTips.init(); //初始化信息提示功能
	var action_type = '<!--{$action_type}-->';
	var ptypedata =[<!--{$typedata}-->
	];
	
	/**function newcombo(sdata){
		return new Ext.form.ComboBox({
						typeAhead: true,
						triggerAction: 'all',
							mode: 'local',
						store: new Ext.data.ArrayStore({
							id: 0,
							fields: [
								'myId',
								'displayText'
							],
							data: sdata
						}),
						valueField: 'myId',
						displayField: 'displayText',
						lazyRender: true,
						listClass: 'x-combo-list-small'
					});
	}
	var typecombo = newcombo(ptypedata);
	var typedata=object_Array(ptypedata);
	*/
	/**
	  var editor = new Ext.ux.grid.RowEditor({
        saveText: 'Update'
    	});
		var Menu = Ext.data.Record.create([{
			name: 'rec_id',
			type: 'string'
		},{
			name: 'img_assign',
			type: 'string'
		},{
			name: 'url',
			type: 'string'
		}]); 
	function stype(v) {
		return typedata[v];
    }
	
	 var imgGrid = new Ext.ux.imgEditor({
        title: 'fdafdsaf ',
		border:false,
		region:'center',
		loadMask: true,
		headers:['序号','图片类型','URL'],
        fields: ['rec_id','img_assign','url'],
		values:['','0',''],
		editors:['',typecombo,{
                xtype: 'textfield',
                allowBlank: false,
				width:300,
				blankText:'此项必填'
            	}],
		renderers:['',stype,''],
		pagesize:20,
		frame:true,
		height:300,
		editor:editor,
		record:Menu,
		plugins: [editor],
		saveURL:'index.php?model=newProduct&action=savestatus',
		delURL:'index.php?model=newProduct&action=delstatus',
		listURL:'index.php?model=newProduct&action=liststatus',
		renderTo:document.body
    });*/
	
	
	
	var goodsinfo = eval(<!--{$good}-->
	);
	 var imgGrid = {};
	if(goodsinfo){
		 imgGrid = new Ext.ux.imgGrid({
			id:'imgGrid',
			title: '图片集',
			frame:true,
			headers:['序号','图片类型','URL','操作员','更新时间'],
			fields: ['rec_id','img_assign','url','add_user','add_time'],
			formitems:[{
					xtype:'hidden',
					id: 'rec_id'
					},{xtype:'hidden',id:'goods_id',value:goodsinfo?goodsinfo.goods_id:''},{
					xtype:'combo',
					store: new Ext.data.SimpleStore({
						 fields: ["id", "key_type"],
						 data: ptypedata
					}),
					valueField :"id",
					displayField: "key_type",
					mode: 'local',
					editable: false,
					forceSelection: true,
					triggerAction: 'all',
					hiddenName:'img_assign',
					fieldLabel: '所属区域',
					name: 'img_assign',
					width:250,
					allowBlank:false,
					blankText:'此项必填'
					},{
					name:'url',
					fieldLabel:'URL',
					width:250,
					allowBlank:false,
					blankText:'此项必填'
					}],
			width:950,
			height:300,
			saveURL:'index.php?model=newProduct&action=saveImg&goods_id='+(goodsinfo?goodsinfo.goods_id:''),
			delURL:'index.php?model=newProduct&action=deleteImg&goods_id='+(goodsinfo?goodsinfo.goods_id:''),
			listURL:'index.php?model=newProduct&action=imglist&goods_id='+(goodsinfo?goodsinfo.goods_id:''),
			windowTitle:'图片管理',
			windowWidth:420,
			windowHeight:150,
			renderTo:document.body
		});
		imgGrid.getStore().reload();  
	}
	var addimgForm = new Ext.ux.addimgForm({
		title:'产品信息',
		border:true,
		region:'center',
		labelAlign: 'right',
        labelWidth: 75,
		good:goodsinfo?goodsinfo:{},
		action_type:parseInt(action_type),
		imgGrid:imgGrid,
        autoWidth: true,
		autoHeight:true,
		renderTo:document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->