Ext.define('Ext.ux.test.inventory.shelf',{
	extend:'Ext.ux.NormalGrid',
    initComponent: function() {
        this.callParent();
    },
    createTbar: function() {
        this.tbar = [
        {
            text: '创建',
            iconCls: 'x-tbar-add',   
            handler: this.createRecord.bind(this)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
            id:'ShelfGrid_editBtn',
            ref: '../editBtn',
            disabled: true,
            handler: this.updateRecord.bind(this)
        },
        {
            text: '删除',
            iconCls: 'x-tbar-del',
            ref: '../removeBtn',
            id:'ShelfGrid_removeBtn',
            disabled: true,
            handler: this.removeRecord.bind(this)
        }];
    },
	createColumns: function() {
        var cols = [{xtype: 'rownumberer'}];
        for (var i = 1; i < this.fields.length-1; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
            cols.push({
				flex:1,
                header: h,
                dataIndex: f
            });
        }
        this.columns = cols;
    },
	createFormtiems:function(){
        var items = [{
				xtype:'hidden',
                name: this.fields[0]
            },{
                fieldLabel: '货架名',
				xtype:'textfield',
				labelWidth:70,
				width:250,
                name: 'name',
				allowBlank:false,
				blankText:'此项必填'
			},{
	                    xtype:'combo',
						store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: this.depot
							}),
	                    valueField :"id",
	                    displayField: "key_type",
	                    mode: 'local',
						labelWidth:70,
						width:250,
	                    editable: false,
	                    forceSelection: true,
	                    triggerAction: 'all',
	                    hiddenName:'depot_id',
	                    fieldLabel: '所属仓库',
	                    emptyText:'选择',
	                    name: 'depot_id',
						allowBlank:false,
						blankText:'请选择'
	                }];
		this.formitem = items;
	},
    removeRecord: function() {
        var r = this.getSelectionModel().getSelection()[0];
        if(r.get('shelf_id') == 0){Ext.Msg.alert('ERROR','默认货架不能删除！');return false;}
        var ids = getIds(this);
        var thiz = this.store;
        afterRemove = this.afterRemove;
        if (r != false) {
            Ext.Msg.confirm('Delete Alert!', 'Are you sure?',
            function(btn) {
                if (btn == 'yes') {
                    Ext.Ajax.request({
                        url: this.delURL + '&ids=' + ids,
                        success: function(response, opts) {
                            var res = Ext.decode(response.responseText);
                            if (res.success) {
                                thiz.remove(r);
                                afterRemove()
                            } else {
                                Ext.Msg.alert('ERROR', res.msg)
                            }
                        }
                    })
                }
            },
            this)
        }
    },
    submitRecord: function() {
        var form = this.getForm();         
        var values = form.getFieldValues();
        if(form.getFieldValues().shelf_id){Ext.Msg.alert('ERROR','默认货架不能修改！');return false;}
        afterEdit = this.afterEdit;
        var thiz = this.store;
        if (form.isValid()) {
            Ext.getBody().mask("waiting...", "x-mask-loading");
            form.submit({
                url: this.saveURL,
                method: 'post',
                params: '',
                success: function(form, action) {
                    if (action.result.success) {
                        Ext.getBody().unmask();
                        thiz.load();
                        Ext.Msg.alert('MSG', action.result.msg)
                    } else {
                        Ext.getBody().unmask();
                        Ext.Msg.alert('修改失败', action.result.msg)
                    }
                },
                failure: function(form, action) {
                    Ext.getBody().unmask();
                    Ext.Msg.alert('操作', action.result.msg)
                }
            })
        }
        this.hideWindow()
    }
});
﻿Ext.define('Ext.ux.test.inventory.depot',{
    extend:'Ext.ux.NormalGrid',
    initComponent: function() {
        this.callParent();
    },
    createColumns: function() { 
        var cols = [];
        for (var i = 1; i < this.fields.length; i++) {
            var f = this.fields[i];
            var h = this.headers[i];
            cols.push({
                flex:1,
                header: h,
                dataIndex: f
            });
        }
        this.columns = cols;
    },
    createTbar: function() {
        this.tbar = [
        {
            text: '创建',
            iconCls: 'x-tbar-add',   
            handler: this.createRecord.bind(this)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
            id:'DepotGrid_editBtn',
            ref: '../editBtn',
            disabled: true,
            handler: this.updateRecord.bind(this)
        },
        {
            text: '删除',
            iconCls: 'x-tbar-del',
            ref: '../removeBtn',
            id:'DepotGrid_removeBtn',
            disabled: true,
            handler: this.removeRecord.bind(this)
        }];
    },
    createFormtiems:function(){
        var items = [{
                xtype:'hidden',
                name: this.fields[0]
            },{
                fieldLabel: '仓库值',
                xtype:'textfield',
                labelWidth:70,
                width:250,
                name: 'di_value',
                allowBlank:false,
                blankText:'此项必填'
            },{
                fieldLabel: '仓库名',
                xtype:'textfield',
                labelWidth:70,
                width:250,
                name: 'di_caption',
                allowBlank:false,
                blankText:'此项必填'
            }];
        this.formitem = items;
    },
    removeRecord: function() {
        var r = this.getSelectionModel().getSelection()[0];
        if(r.get('di_value') == 0){Ext.Msg.alert('ERROR','默认仓库不能删除！');return false;}
        var ids = getIds(this);
        var thiz = this.store;
        afterRemove = this.afterRemove;
        if (r != false) {
            Ext.Msg.confirm('Delete Alert!', 'Are you sure?',
            function(btn) {
                if (btn == 'yes') {
                    Ext.Ajax.request({
                        url: this.delURL + '&ids=' + ids,
                        success: function(response, opts) {
                            var res = Ext.decode(response.responseText);
                            if (res.success) {
                                thiz.remove(r);
                                afterRemove()
                            } else {
                                Ext.Msg.alert('ERROR', res.msg)
                            }
                        }
                    })
                }
            },
            this)
        }
    },
    submitRecord: function() {
        var form = this.getForm();         
        var values = form.getFieldValues();
        if(form.getFieldValues().di_value){Ext.Msg.alert('ERROR','默认仓库不能修改！');return false;}
        afterEdit = this.afterEdit;
        var thiz = this.store;
        if (form.isValid()) {
            Ext.getBody().mask("waiting...", "x-mask-loading");
            form.submit({
                url: this.saveURL,
                method: 'post',
                params: '',
                success: function(form, action) {
                    if (action.result.success) {
                        Ext.getBody().unmask();
                        thiz.load();
                        Ext.Msg.alert('MSG', action.result.msg)
                    } else {
                        Ext.getBody().unmask();
                        Ext.Msg.alert('修改失败', action.result.msg)
                    }
                },
                failure: function(form, action) {
                    Ext.getBody().unmask();
                    Ext.Msg.alert('操作', action.result.msg)
                }
            })
        }
        this.hideWindow()
    }
});