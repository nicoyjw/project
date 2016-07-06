Ext.ux.CaseGrid = Ext.extend(Ext.ux.NormalGrid, {
    initComponent: function() {
        Ext.ux.CaseGrid.superclass.initComponent.call(this);
    },
	

	createFormtiems:function(){
        var items = [{
				xtype:'hidden',
                name: 'cat_id'
					},{
                fieldLabel: '分类代码',
                name: 'code',
				id:'code'
					},{
                fieldLabel: '分类名',
                name: 'cat_name'
					},{
	                    xtype:'combo',
	                    store: this.typestore,
	                    valueField :"cat_id",
	                    displayField: "cat_name",
	                    mode: 'local',
	                    editable: false,
	                    forceSelection: true,
	                    triggerAction: 'all',
	                    hiddenName:'parent_id',
	                    fieldLabel: '所属分类',
	                    emptyText:'root',
						value:0,
						id:'parent_id'
	                }];
		this.formitem = items;
	},
    createForm: function() {
		var thiz = this.store;
        var form = new Ext.form.FormPanel({
            frame: true,
            defaultType: 'textfield',
            buttonAlign: 'center',
            labelAlign: 'right',
            labelWidth: 70,
            trackResetOnLoad: true,
            reader: new Ext.data.ArrayReader({
                fields: this.fields
            }),
            items: this.formitem,
            buttons: [{
                text: 'submit',
                handler: this.submitRecord.createDelegate(this)
            }, {
                text: 'reset',
                handler: function() {
                    form.getForm().reset();
                }
            }]
        });
        return form;
    }
});

