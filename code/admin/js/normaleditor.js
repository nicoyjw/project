Ext.define('Ext.ux.NormalEditor',{
	extend:'Ext.grid.Panel',
	initComponent: function() {
        this.stripeRows = true;
		this.autoScroll= true;
        this.createStore();
        this.createColumns();
        this.createTbar();
        this.createBbar();
		this.loaddata();
		this.getSelectionModel().on('selectionchange', function(sm){
			Ext.getCmp('removeBtn').setDisabled(sm.getCount() < 1);
		});
        this.callParent(this);
    },
    createStore: function() {
		var getparams= this.getparams;
		var saveURL = this.saveURL;
		this.store = Ext.create('Ext.data.JsonStore', {
			fields:this.fields,
			remoteSort:true,
			autoLoad:true,
			proxy: {
				type: 'ajax',
				url:this.listURL,  
				actionMethods: {  
					read: 'POST'  
				},
				reader:{
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:this.fields[0],
					root: 'topics'
				}
			},
			listeners:{
			'update':function(thiz,record,operation){
				var newmenu = record.data;
				var newparams = getparams(newmenu,this.fields);
				if(operation == Ext.data.Record.EDIT){
					Ext.Ajax.request({
						url:saveURL,
						params:newparams,
						method:'POST',
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
							if(res.success){
							Ext.example.msg('MSG',res.msg);
							thiz.load();
							}else{
							Ext.Msg.alert('MSG',res.msg);
							}
						},
						failure:function(){
							Ext.example.msg('MSG','更新失败'),
							thiz.rejectChanges();
						}
					})
				}
			}			
		}
    	});
    },

	getparams:function(newmenu,fields){
			var r = {};
			for (var i = 0; i < fields.length; i++) {
				var f = fields.items[i].name;
				//r = r +'' +f+':\''+ newmenu[f]+'\',';
				r[f] = newmenu[f];
			}
			return r;
		},
	loaddata:function(){
		this.store.load({
			params:{start:0,limit:this.pagesize},
			scope:this.store
			})
		},
	
		
	createColumns: function() {
        var cols = [];
		cols.push({xtype: 'rownumberer'});
        for (var i = 1; i < this.fields.length; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
			var e = this.editors[i];
            cols.push({
                header: h,
                dataIndex: f,
				editor:e
            });
        }
        this.columns = cols;
    },


    createTbar: function() {
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
			handler: this.createRecord.bind(this)
        },{
            text: '删除',
            iconCls: 'x-tbar-del',
			id:'removeBtn',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.bind(this)
        }];
    },

    createBbar: function() {
		var	pagesize = this.pagesize;
        this.bbar = Ext.create('Ext.toolbar.Paging',{
			pageSize: pagesize,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
            store: this.store
        });
    },

    createRecord: function() {
		var record =this.getEmptyRecord();
		this.editor.stopEditing();
		this.store.insert(0, record);
		this.getView().refresh();
		this.getSelectionModel().select(0);
		this.editor.startEditing(0);
    },

    removeRecord: function() {
		var ids = getIds(this);
		var r = this.getSelectedRecord();
		var thiz = this.store;
            Ext.Msg.confirm('Delete Alert!', 'Are you sure?', function(btn) {
                if (btn == 'yes') {
					Ext.Ajax.request({
					   url: this.delURL+'&ids='+ids,
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
								if(res.success){
								thiz.remove(r);
								Ext.example.msg('MSG',res.msg);
								}else{
								Ext.Msg.alert('ERROR',res.msg);
								}						
							}
						});
                }
            }, this);
    },
	
	
    getSelectedRecord: function() {
        var sm = this.getSelectionModel();
        if (sm.getCount() == 0) {
            Ext.example.msg('Info', 'Please select one row.');
            return false;
        } else {
            return sm.getSelection()[0];
        }
    },

    getEmptyRecord: function() {
			var  record =this.record;
			var str ={};
			for (var i = 0; i < this.fields.length; i++) {
				var f = this.fields[i];
				var v = this.values[i];
				str[f] = v;
			}
			return new record(str);
    }
});

