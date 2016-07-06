<!--{include file="header.tpl"}-->
<link rel="stylesheet" type="text/css" href="themes/default/template/aliexpress/image_bank/chooser.css" />
<script type="text/javascript" src="themes/default/template/aliexpress/image_bank/IconBrowser.js"></script>
<script type="text/javascript" src="themes/default/template/aliexpress/image_bank/InfoPanel.js"></script>
<script type="text/javascript">


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
			
			//Ext.getCmp('img-chooser-view').store.sort('name');
			 Ext.getCmp('img-chooser-view').getStore().load({
				params: {
					group: node.data.id
				}
			})
			
			
			//alert(Ext.getCmp('img-chooser-view'));return;
           /* if (!node.isLeaf()) {
                e.stopEvent();
                Ext.getCmp('img-chooser-view').setValue(node.data.id);
                store.load({
                    params: {
                        start: 0,
                        group: node.data.id,
                        limit: pagesize
                    },
                    scope: this.store
                })
            }*/
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
                            //buffer: 50,
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
        
        if (selectedImage) {
            this.fireEvent('selected', selectedImage);
            this.hide();
        }
    }
});

Ext.onReady(function() {
	var acc = [<!--{$account}-->];
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';
	var account = Ext.create('Ext.form.ComboBox',{
		typeAhead: true,
		triggerAction: 'all',
		mode: 'local',
		renderTo: 'account',
		store: Ext.create('Ext.data.ArrayStore',{
			id: 0,
			fields: [
				'Id',
				'Text'
			],
			data: acc
		}),
		width:250,
		editable:false,
		valueField: 'Id',
		displayField: 'Text',
		lazyRender: true,
		emptyText:'--请选择帐号--',
		listClass: 'x-combo-list-small',
		listeners: {
		 select: function(c, r, i) {
			Ext.getCmp('account_id').setValue(c.getValue());
		}
	 }
	});
	Ext.create('Ext.form.Hidden',{
		id:'account_id'
	});
	var treestore;
	var win;
    var insertButton = Ext.create('Ext.button.Button', {
        text: "打开图片银行",
        renderTo: 'buttons',
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
	
    function insertSelectedImage(image) {
        var image = Ext.fly('images').createChild({
            tag: 'img',
			height:75,
            src: image.get('thumb')
        });
        image.hide().show({duration: 500}).frame();
        win.animateTarget = image;
    }
	
});




</script>
 </head>
    <body>
    <div style="height:30px;"></div>
    <div id="account" style="margin:20px;float:left">
    	</div>
    	<div id="buttons" style="margin:20px;float:left">
    	</div>
        <div style="clear:both"></div>
    	<div id="images" style="margin:20px;width:600px;">
    	</div>
    </body>
</html>
