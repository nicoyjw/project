<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){

    Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget = 'side';
    var top = new Ext.FormPanel({
        buttonAlign:'right',
		labelWidth:70,
        frame:true,
        title: '职员管理',
        bodyStyle:'padding:5px 5px 0',
		style:'margin:10px',
        items: [{
        	xtype:'fieldset',
            title: '基本信息',
            autoHeight:true,
        	items:[{
	            layout:'column',
	            items:[{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'textfield',
	                    fieldLabel: '用户名',
	                    allowBlank:false,
	                    name: 'username',
						value: '<!--{$info.username}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'textfield',
	                    fieldLabel: '姓名',
	                    allowBlank:false,
	                    name: 'real_name',
						value: '<!--{$info.real_name}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'combo',
	                    store: new Ext.data.SimpleStore({
	                    	fields: ["retrunValue", "displayText"],
	                    	data: [<!--{$sex}-->]
	                    }),
	                    valueField :"retrunValue",
	                    displayField: "displayText",
	                    mode: 'local',
	                    editable: false,
	                    forceSelection: true,
	                    triggerAction: 'all',
	                    hiddenName:'sex',
	                    fieldLabel: '性　别',
	                    emptyText:'选择',
	                    name: 'sex',
						value: '<!--{$info.sex}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'textfield',
	                    fieldLabel: '籍　贯',
	                    name: 'native_place',
						value: '<!--{$info.native_place}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'datefield',
	                    format:'Y-m-d',
	                    fieldLabel: '生日',
	                    name: 'birthday',
						value: '<!--{$info.birthday}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'textfield',
	                    fieldLabel: '身份证',
	                    name: 'id_card',
						value: '<!--{$info.id_card}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'combo',
	                    store: new Ext.data.SimpleStore({
	                    	fields: ["retrunValue", "displayText"],
	                    	data: [<!--{$nation}-->]
	                    }),
	                    valueField :"retrunValue",
	                    displayField: "displayText",
	                    mode: 'local',
	                    editable: false,
	                    forceSelection: true,
	                    triggerAction: 'all',
	                    hiddenName:'nation',
	                    fieldLabel: '民　族',
	                    emptyText:'选择',
	                    name: 'nation',
						value: '<!--{$info.nation}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'combo',
	                    store: new Ext.data.SimpleStore({
	                    	fields: ["retrunValue", "displayText"],
	                    	data: [<!--{$is_married}-->]
	                    }),
	                    valueField :"retrunValue",
	                    displayField: "displayText",
	                    mode: 'local',
	                    editable: false,
	                    forceSelection: true,
	                    triggerAction: 'all',
	                    hiddenName:'is_married',
	                    fieldLabel: '婚姻状况',
	                    emptyText:'选择',
	                    name: 'is_married',
						value: '<!--{$info.is_married}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'combo',
	                    store: new Ext.data.SimpleStore({
	                    	fields: ["retrunValue", "displayText"],
	                    	data: [<!--{$polity}-->]
	                    }),
	                    valueField :"retrunValue",
	                    displayField: "displayText",
	                    mode: 'local',
	                    editable: false,
	                    forceSelection: true,
	                    triggerAction: 'all',
	                    hiddenName:'polity',
	                    fieldLabel: '政治面貌',
	                    emptyText:'选择',
	                    name: 'polity',
						value: '<!--{$info.polity}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'combo',
	                    store: new Ext.data.SimpleStore({
	                    	fields: ["retrunValue", "displayText"],
	                    	data: [<!--{$education}-->]
	                    }),
	                    valueField :"retrunValue",
	                    displayField: "displayText",
	                    mode: 'local',
	                    editable: false,
	                    forceSelection: true,
	                    triggerAction: 'all',
	                    hiddenName:'education',
	                    fieldLabel: '学历',
	                    emptyText:'选择',
	                    name: 'education',
						value: '<!--{$info.education}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'textfield',
	                    fieldLabel: '专业',
	                    name: 'specialty',
						value: '<!--{$info.specialty}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'textfield',
	                    fieldLabel: '毕业院校',
	                    name: 'school',
						value: '<!--{$info.school}-->',
	                    anchor:'90%'
	                }]
	            },{
					xtype:'hidden',
					name: 'user_id',
					value: '<!--{$info.user_id}-->'
				}]
	        }]
        },{
        	xtype:'fieldset',
            title: '联系信息',
            autoHeight:true,
        	items:[{
	            layout:'column',
	            items:[{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'textfield',
	                    fieldLabel: '电话',
	                    name: 'telephone',
						value: '<!--{$info.telephone}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'textfield',
	                    fieldLabel: '手机',
	                    name: 'mobile',
						value: '<!--{$info.mobile}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'textfield',
	                    fieldLabel: 'Email',
	                    name: 'email',
	                    vtype:'email',
						value: '<!--{$info.email}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.66,
	                layout: 'form',
	                items: [{
	                    xtype:'textfield',
	                    fieldLabel: '地址',
	                    name: 'address',
						value: '<!--{$info.address}-->',
	                    anchor:'90%'
	                }]
	            }]
        	}]
        },{
        	xtype:'fieldset',
            title: '工作信息',
            autoHeight:true,
        	items:[{
	            layout:'column',
	            items:[{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'combo',
	                    store: new Ext.data.SimpleStore({
	                    	fields: ["retrunValue", "displayText"],
	                    	data: [<!--{$station_status}-->]
	                    }),
	                    valueField :"retrunValue",
	                    displayField: "displayText",
	                    mode: 'local',
	                    editable: false,
	                    forceSelection: true,
	                    triggerAction: 'all',
	                    hiddenName:'station_status',
	                    fieldLabel: '岗位状态',
	                    emptyText:'选择',
	                    name: 'station_status',
						value: '<!--{$info.station_status}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'combo',
	                    store: new Ext.data.SimpleStore({
	                    	fields: ["retrunValue", "displayText"],
	                    	data: [<!--{$headship}-->]
	                    }),
	                    valueField :"retrunValue",
	                    displayField: "displayText",
	                    mode: 'local',
	                    editable: false,
	                    forceSelection: true,
	                    triggerAction: 'all',
	                    hiddenName:'headship',
	                    fieldLabel: '职务',
	                    emptyText:'选择',
	                    name: 'headship',
						value: '<!--{$info.headship}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'datefield',
	                    format:'Y-m-d',
	                    fieldLabel: '入职时间',
	                    name: 'join_time',
						value: '<!--{$info.join_time}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'datefield',
	                    format:'Y-m-d',
	                    fieldLabel: '离职时间',
	                    name: 'leave_time',
						value: '<!--{$info.leave_time}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'datefield',
	                    format:'Y-m-d',
	                    fieldLabel: '复职时间',
	                    name: 'rehab_time',
						value: '<!--{$info.rehab_time}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'combo',
	                    store: new Ext.data.SimpleStore({
	                    	fields: ["retrunValue", "displayText"],
	                    	data: [<!--{$depts}-->]
	                    }),
	                    valueField :"retrunValue",
	                    displayField: "displayText",
	                    mode: 'local',
	                    editable: false,
	                    forceSelection: true,
	                    triggerAction: 'all',
	                    hiddenName:'dept_id',
	                    fieldLabel: '部门',
	                    emptyText:'选择',
	                    name: 'dept_id',
						value: '<!--{$info.dept_id}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.66,
	                layout: 'form',
	                items: [{
	                    xtype:'textfield',
	                    fieldLabel: '说明',
	                    name: 'note',
						value: '<!--{$info.note}-->',
	                    anchor:'90%'
	                }]
	            }]
        	}]
        },{
        	xtype:'fieldset',
            title: '系统信息',
            autoHeight:true,
        	items:[{
	            layout:'column',
	            items:[{
	                columnWidth:.25,
	                layout: 'form',
	                items: [{
	                    xtype:'textfield',
	                    fieldLabel: '添加时间',
						value: '2007-11-10',
						disabled :true,
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.25,
	                layout: 'form',
	                items: [{
	                    xtype:'textfield',
	                    fieldLabel: '添加人',
						value: '2007-11-10',
						disabled :true,
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.25,
	                layout: 'form',
	                items: [{
	                    xtype:'textfield',
	                    fieldLabel: '修改时间',
						value: '2007-11-10',
						disabled :true,
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.25,
	                layout: 'form',
	                items: [{
	                    xtype:'textfield',
	                    fieldLabel: '修改人',
						value: '2007-11-10',
						disabled :true,
	                    anchor:'90%'
	                }]
	            }]
        	}]
        }],

        buttons: [{
            text: '保存',
			handler:function(){
				if(top.form.isValid()){
					top.form.doAction('submit',{
						url:'index.php?model=user&action=save',
						method:'post',
						params:'',
						success:function(form,action){
							Ext.example.msg('操作','保存成功!');
							if (Ext.fly('user_id').dom.value=='') {
								top.form.reset();
							}
						},
						failure:function(){
							Ext.example.msg('操作','服务器出现错误请稍后再试！');
									
						}
                    });
				}
			}
        },{
        	text: '重置',
			handler:function(){top.form.reset();}
        }]
    });
    top.render(document.body);
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
