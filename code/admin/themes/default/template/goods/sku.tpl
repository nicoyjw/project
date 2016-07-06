<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/normalgrid.js"></script>
<script type="text/javascript" src="js/goods/sku.js"></script>
    <script type="text/javascript">
Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';

	var SkuGrid = Ext.create('Ext.ux.SkuGrid',{
		id:'BrandGrid',
        title: '外部SKU列表',
		headers:['序号','SKU','外部SKU'],
        fields: ['rec_id','sku','out_sku'],
		width:600,
		frame:true,
		saveURL:'index.php?model=goods&action=skuupdate',
		delURL:'index.php?model=goods&action=skudel',
		listURL:'index.php?model=goods&action=skuList',
		formitems:[{
			xtype:'hidden',
			name: 'rec_id'
		},{
			name:'sku',
			xtype:'textfield',
			fieldLabel:'SKU',
			allowBlank:false,
			width:250,
			blankText:'此项必填'
		},{
			name:'out_sku',
			xtype:'textfield',
			fieldLabel:'外部SKU',
			allowBlank:false,
			width:250,
			blankText:'此项必填'
		}],
		windowTitle:'编辑外部SKU',
		windowWidth:300,
		windowHeight:160,
        renderTo: document.body
	})
	SkuGrid.getStore().load({
			params:{start:0,limit:SkuGrid.pagesize}
			});
			
    var simple = Ext.create('Ext.FormPanel',{
        labelWidth: 75,
        frame:true,
        title: '外部SKU批量导入',
		fileUpload:true,
        bodyStyle:'padding:5px 5px 0',
        width: 350,
        defaults: {width: 150},
        defaultType: 'textfield',
		renderTo:document.body,
        items: [{
				fieldLabel: 'xls文件',
				width:250,
				xtype: 'fileuploadfield',
				allowBlank:false,
				name:'file_path'
            }
        ],

        buttons: [{
				text: '导入',
				type: 'submit',
				handler:function(){formsubmit();}
			}]
    });
	var formsubmit = function(){
					  if(simple.getForm().isValid()){
						simple.submit({
							 url:'index.php?model=goods&action=importsku',
							 method:'post',
							 params:'',
							 success:function(form,action){
							 		if (action.result.success) {
										Ext.example.msg('导入成功',action.result.msg);
									} else {
										Ext.Msg.alert('导入错误',action.result.msg);
							 		}
							 },
							 failure:function(form,action){
									Ext.Msg.alert('操作',action.result.msg);
							 }
                      });
					}
				}			
	loadend();
});
    </script>
<!--{include file="footer.tpl"}-->
