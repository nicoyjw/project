<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/normalgrid.js"></script>
<script type="text/javascript" src="js/system/user.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
Ext.QuickTips.init();
Ext.form.Field.prototype.msgTarget = 'side';
var role = [<!--{$role}-->];
var arr = object_Array(role);
function showrole(val){
	return arr[val];
}
var rolearr = object_Array(role);
var UserGrid = Ext.create('Ext.ux.UserGrid',{
        title: '用户列表',
		headers:['序号','用户名','Email','角色'],
        fields: ['user_id','user_name','email','role_id'],
		formitems:[{
				xtype:'hidden',
                name: 'user_id'
				},{
				name:'user_name',
				id:'user_name',
				xtype:'textfield',
				fieldLabel:'用户名',
				width:250,
				labelWidth:85,
				allowBlank:false,
				blankText:'此项必填',
				listeners: {
					blur:function(field,e){
						Ext.getBody().mask("Checking Username.waiting...","x-mask-loading");
						//if(Ext.getCmp('goodform').getForm().findField('user_name').getValue() == thiz.good.goods_sn){ return;}
						Ext.Ajax.request({
						   url: 'index.php?model=user&action=checkname',
						   loadMask:true,
						   params: { value:field.getValue() },
							success:function(response,opts){
								var res = Ext.decode(response.responseText);
								Ext.getBody().unmask();
									if(res.success){
									Ext.example.msg('MSG',res.msg);
									}else{
									Ext.Msg.alert('ERROR',res.msg);
									}						
								}
							});
						//Ext.example.msg('test',field.getValue());
					}
				}
				},{
				name:'email',
				fieldLabel:'Email',
				xtype:'textfield',
				labelWidth:85,
				width:250,
				vtype:'email'
				},{
				name:'pwd',
				xtype:'textfield',
				labelWidth:85,
				fieldLabel:'重设密码',
				inputType:'password',
				width:250
				},{
				xtype:'combo',
	            store: Ext.create('Ext.data.ArrayStore',{
	                    fields: ["retrunValue", "displayText"],
	                    data: role
	                    }),
	             valueField :"retrunValue",
	              displayField: "displayText",
	              mode: 'local',
				  allowBlank:false,
				  blankText:'不能为空',
	              editable: false,
	              forceSelection: true,
	              triggerAction: 'all',
				  labelWidth:85,
				  width:250,
	              hiddenName:'role_id',
	              fieldLabel: '角色',
	              emptyText:'选择',
	              name: 'role_id'
			}],
		frame:true,
		autoWidth:true,
		renderers:showrole,
		saveURL:'index.php?model=User&action=save',
		delURL:'index.php?model=User&action=delete',
		listURL:'index.php?model=User&action=list',
		windowTitle:'编辑用户信息',
		windowWidth:380,
		windowHeight:230,
        renderTo: document.body
    });
    var store = Ext.create('Ext.data.ArrayStore',{
        fields: [
           {name: 'id'},
           {name: 'role'}
        ]
    });
    store.loadData(role);
var RightGrid = new Ext.grid.GridPanel({
        title: '角色权限列表',
        columns: [
            {
                header   : '角色', 
                width    : 160, 
                sortable : true, 
                dataIndex: 'role'
            },
            {
                header   : 'id',
				id:'id', 
                width    : 75, 
                sortable : true, 
                dataIndex: 'id'
            },{
				  header:'操作',
				  width:75,
				  xtype: 'actioncolumn',
				  items:[{
						icon   : 'themes/default/images/update.gif',	 
						tooltip: '编辑权限',
						handler: function(grid, rowIndex, colIndex) {
							var id = store.getAt(rowIndex).get('id');
							parent.openWindow(id,'编辑权限','index.php?model=privilege&action=eidtpriv&roleid='+id,700,380);
						}
						 }]
				  }],
		store: store,
		autoHeight:true,
		frame:true,
		width:500,
        renderTo: document.body
    });
	
	UserGrid.getStore().load({
			params:{start:0,limit:UserGrid.pagesize}
			});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->