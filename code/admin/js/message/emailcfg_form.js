Ext.ns('EmailCfg');
/**
 * @class EmailCfg.FormPanel
 * A typical FormPanel extension
 */
EmailCfg.Form = Ext.extend(Ext.form.FormPanel, {
    frame: true,
    labelAlign: 'right',
    title: '邮箱(修改/添加)',
    frame: true,
    width: 500,
	height:300,
    defaultType: 'textfield',
    defaults: {
        anchor: '50%'
    },

    // private A pointer to the currently loaded record
    record : null,

    /**
     * initComponent
     * @protected
     */
    initComponent : function() {
        // build the form-fields.  Always a good idea to defer form-building to a method so that this class can
        // be over-ridden to provide different form-fields
        this.items = this.buildForm();

        // build form-buttons
        this.buttons = this.buildUI();

        // add a create event for convenience in our EmailCfglication-code.
        this.addEvents({
            /**
             * @event create
             * Fires when user clicks [create] button
             * @param {FormPanel} this
             * @param {Object} values, the Form's values object
             */
            create : true
        });

        // super
        EmailCfg.Form.superclass.initComponent.call(this);
    },

    /**
     * buildform
     * @private
     */
    buildForm : function() {
        return [
            {fieldLabel: '邮箱', name: 'email', allowBlank: false, vtype: 'email'},
            {fieldLabel: '密码', name: 'password', allowBlank: false},
            {fieldLabel: 'Last', name: 'last', allowBlank: false}
        ];
    },

    /**
     * buildUI
     * @private
     */
    buildUI: function(){
        return [{
            text: '修改',
            handler: this.onUpdate,
            scope: this
        }, {
            text: '添加',
            handler: this.onCreate,
            scope: this
        }];
    },

    /**
     * loadRecord
     * @param {Record} rec
     */
    loadRecord : function(rec) {
        this.record = rec;
        this.getForm().loadRecord(rec);
    },

    /**
     * onUpdate
     */
    onUpdate : function(btn, ev) {
        if (this.record == null) {
            return;
        }
        if (!this.getForm().isValid()) {
            EmailCfg.setAlert(false, "Form is invalid.");
            return false;
        }
        this.getForm().updateRecord(this.record);
    },

    /**
     * onCreate
     */
    onCreate : function(btn, ev) {
        if (!this.getForm().isValid()) {
            EmailCfg.setAlert(false, "Form is invalid");
            return false;
        }
        this.fireEvent('create', this, this.getForm().getValues());
        this.getForm().reset();
    }

});