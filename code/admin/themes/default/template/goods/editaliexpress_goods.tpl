<!--{include file="header.tpl"}-->
<link rel="stylesheet" type="text/css" href="themes/default/template/aliexpress/image_bank/chooser.css" />
<script type="text/javascript" src="themes/default/template/aliexpress/image_bank/IconBrowser.js"></script>
<script type="text/javascript" src="themes/default/template/aliexpress/image_bank/InfoPanel.js"></script>
<script type="text/javascript" src="js/goods/edit_aliexpressgoodsform.js"></script>
<script type="text/javascript" src="js/celltooltip.js"></script>
<script type="text/javascript" src="common/lib/ckeditor/ckeditor.js"></script>
<script src="common/lib/ckeditor/_samples/sample.js" type="text/javascript"></script>
<script type="text/javascript">
var account = [<!--{$account}-->];
var aligoodsunit = [<!--{$aligoodsunit}-->];
account.push(['0','请选择']);   
Ext.define('Ext.chooser.Window', {
    extend: 'Ext.window.Window',
    height: 450,
    width : 950,
    title : '图片银行',
    layout: 'border',
	closeAction : 'destory',
    border: false,
    bodyBorder: false,
    initComponent: function() {
		var account = this.account;
		var tree = Ext.create('Ext.tree.Panel', {
            border: true,
            store: account,
            region: 'west',
            id: 'west-panel',
            width: 200,
            minSize: 175,
            maxSize: 400,
            margins: '0 0 0 0',
            layoutConfig: {
                animate: true
            },
            rootVisible: false,
            autoScroll: true
        });
        tree.on('itemclick', treeClick);
        function treeClick(view, node, item, index, e) {
			 Ext.getCmp('img-chooser-view').getStore().load({
				params: {
					group: node.data.id
				}
			})
        };
        this.items = [
            {
                xtype: 'panel',
                region: 'center',
                layout: 'fit',
                items: {
                    xtype: 'iconbrowser',
                    autoScroll: true,
                    id: 'img-chooser-view',
                    listeners: {
                        scope: this,
                        selectionchange: this.onIconSelect,
                        itemdblclick: this.fireImageSelected
                    }
                },
                
                tbar: [
                    {
                        xtype: 'textfield',
                        name : 'filter',
                        fieldLabel: '搜索',
                        labelWidth: 35,
						width:145,
                        listeners: {
                            scope : this,
                            buffer: 50,
                            change: this.filter
                        }
                    },
                    {
                        xtype: 'combo',
                        fieldLabel: '排序',
                        labelWidth:35,
						width:145,
                        valueField: 'field',
                        displayField: 'label',
                        value: 'Type',
                        editable: false,
                        store: Ext.create('Ext.data.Store', {
                            fields: ['field', 'label'],
                            sorters: 'type',
                            proxy : {
                                type: 'memory',
                                data  : [{label: 'Name', field: 'name'}, {label: 'Type', field: 'type'}]
                            }
                        }),
                        listeners: {
                            scope : this,
                            select: this.sort
                        }
                    },
					Ext.create('Ext.form.Panel',{
					id:'imgform',
					items:[
						{   
						xtype: 'fieldcontainer',
						layout: {
							type: 'hbox',   
							align: 'middle'
						},   
						combineErrors : true,
						style:'margin:0 0 0 15px',
						defaultType: 'textfield',
						items: [
						{
						   xtype: 'fileuploadfield',
						   hideLabel: true,
							name:'photo_path',
							id:'photo_path',
						   buttonText : '选择文件',
						   width:140,
							   
						},{
							xtype:'button',
							text:'上传',
							style:'margin-left:15px',
							handler:function(){
								var form = this.up("form").getForm();
								//alert(form);return;
								if (form.isValid()) {
									form.submit({
										url: "index.php?model=aliexpress&action=UploadImageBank",
										waitMsg: "Uploading your Image...",
										params:{'id':Ext.getCmp('account_id').getValue()},
										method:'post',
										success: function (form,action) {
											if (action.result.success) {
												Ext.example.msg('MSG',action.result.msg);
												Ext.getCmp('img-chooser-view').getStore().load({
													params: {}
												})
											} else {
												Ext.Msg.alert('ERROR',action.result.msg);
											}
										},
										failure:function(form,action){
												Ext.Msg.alert('ERROR',action.result.msg);
										}
									});
								}
							}
						}
						]}]
					})
				]
            },
            {
                xtype: 'infopanel',
                region: 'east',
                split: true
            },tree
        ];
        
        this.buttons = [
            {
                text: 'OK',
                scope: this,
                handler: this.fireImageSelected
            },
            {
                text: 'Cancel',
                scope: this,
                handler: function() {
                    this.hide();
                }
            }
        ];
        
        this.callParent(arguments);
        this.addEvents(
            'selected'
        );
    },
    filter: function(field, newValue) {
        var store = this.down('iconbrowser').store,
            view = this.down('dataview'),
            selModel = view.getSelectionModel(),
            selection = selModel.getSelection()[0];
        
        store.suspendEvents();
        store.clearFilter();
        store.filter({
            property: 'name',
            anyMatch: true,
            value   : newValue
        });
        store.resumeEvents();
        if (selection && store.indexOf(selection) === -1) {
            selModel.clearSelections();
            this.down('infopanel').clear();
        }
        view.refresh();
        
    },
    sort: function() {
        var field = this.down('combobox').getValue();
        
        this.down('dataview').store.sort(field);
    },
    onIconSelect: function(dataview, selections) {
        var selected = selections[0];
        
        if (selected) {
            this.down('infopanel').loadRecord(selected);
        }
    },
    fireImageSelected: function() {
        var selectedImage = this.down('iconbrowser').selModel.getSelection()[0];
		//alert(selectedImage.get('thumb'));return;
        if (selectedImage) {
            this.fireEvent('selected', selectedImage);
            this.hide();
        }
    }
});


Ext.onReady(function(){
	Ext.QuickTips.init();
	var DispatchTimeMax = [<!--{$DispatchTimeMax}-->];
	var ListingDuration = [<!--{$ListingDuration}-->];
	var ListingType = [<!--{$ListingType}-->];
	var condition = [<!--{$condition}-->];
	
	var goodsinfo = eval(<!--{$good}-->);
	var win;
	var insertButton = new Ext.button.Button({
        text: "打开图片银行",
		id:'btnbank',
		margin:10,
        handler : function() {
			if(!Ext.getCmp('account_id').getValue()){
				Ext.Msg.alert('ERROR', '请选择帐号!');
				return false;
			} 
			var treestore = new Ext.data.TreeStore({
				proxy: {
						type: 'ajax',
						url: 'index.php?model=aliexpress&action=get_image_group&account_id='+Ext.getCmp('account_id').getValue()
					},
					root: {
						text: '总类',
						draggable: false,
						id: 'root'
					}
			});
			if(!win){
				win = Ext.create('Ext.chooser.Window', {
					id: 'img-chooser-dlg',
					animateTarget: insertButton.getEl(),
					account:treestore,
					listeners: {
						selected: insertSelectedImage
					}
				});
			}
			win.show();
		}
	});
	var insertSelectedImage = function (image) {
		
		document.getElementById("img_"+Ext.getCmp('changeImg').getValue()).src = image.get('thumb'); 
		
       /* var image = Ext.fly('images').createChild({
            tag: 'img',
			height:75,
			id:'',
            src: image.get('thumb')
        });
        image.hide().show({duration: 500}).frame();
        win.animateTarget = image;*/
    }
	var orderform = Ext.create('Ext.ux.goodsForm',{
		border:true,
		id:'ebaygoodform',
		region:'center',
		labelAlign: 'right',
		style:'margin-top:-5px',
		labelWidth: 75,
		status:status,
		delchildURL:'index.php?model=goods&action=delChildgoods',
		catURL:'index.php?model=goods&action=catList',
		brandURL:'index.php?model=goods&action=brandList',
		childlistURL:'index.php?model=goods&action=getchildgoods',
		goodsURL:'index.php?model=goods&action=getgoodslist',
		savechildURL:'index.php?model=goods&action=savechild',
		updatesurl:'index.php?model=goods&action=Uploadgoodsimg',
		goods_data:[aligoodsunit,ListingDuration,ListingType,condition,account],
		good:goodsinfo,
		selectFn:insertSelectedImage,
		bbtn:insertButton,
		autoWidth: true,
		renderTo:document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
