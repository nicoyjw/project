Ext.example = function(){
    var msgCt;
    function createBox(t, s){
       // return ['<div class="msg">',
       //         '<div class="x-box-tl"><div class="x-box-tr"><div class="x-box-tc"></div></div></div>',
       //         '<div class="x-box-ml"><div class="x-box-mr"><div class="x-box-mc"><h3>', t, '</h3>', s, '</div></div></div>',
       //         '<div class="x-box-bl"><div class="x-box-br"><div class="x-box-bc"></div></div></div>',
       //         '</div>'].join('');
       return '<div class="msg"><h3>' + t + '</h3><p>' + s + '</p></div>';
    }
    return {
        msg : function(title, format){
            if(!msgCt){
                msgCt = Ext.DomHelper.insertFirst(document.body, {id:'msg-div'}, true);
            }
            var s = Ext.String.format.apply(String, Array.prototype.slice.call(arguments, 1));
            var m = Ext.DomHelper.append(msgCt, createBox(title, s), true);
            m.hide();
            m.slideIn('t').ghost("t", { delay: 1000, remove: true});
        },

        init : function(){
            if(!msgCt){
                // It's better to create the msg-div here in order to avoid re-layouts 
                // later that could interfere with the HtmlEditor and reset its iFrame.
                msgCt = Ext.DomHelper.insertFirst(document.body, {id:'msg-div'}, true);
            }
//            var t = Ext.get('exttheme');
//            if(!t){ // run locally?
//                return;
//            }
//            var theme = Cookies.get('exttheme') || 'aero';
//            if(theme){
//                t.dom.value = theme;
//                Ext.getBody().addClass('x-'+theme);
//            }
//            t.on('change', function(){
//                Cookies.set('exttheme', t.getValue());
//                setTimeout(function(){
//                    window.location.reload();
//                }, 250);
//            });
//
//            var lb = Ext.get('lib-bar');
//            if(lb){
//                lb.show();
//            }
        }
    };
}();


Ext.onReady(Ext.example.init, Ext.example);
function openWindowWithPost(url, data, name) {   
    var newWindow = window.open('about:blank', name);   
    if (!newWindow) return false;   
    var html = "";   
	html += "<html><head></head><body><form id='formid' method='post' action='" + url + "'>";   
	html += "<input type='hidden' name='ids' value='" + data + "'/>";   
	html += "</form><script type='text/javascript'>document.getElementById(\"formid\").submit()</script></body></html>";   
	newWindow.document.write(html); 
    return newWindow;   
}  
function comrender(v,arr){
	var arr = object_Array(arr);
	return arr[v];
}

function loadend() {
	setTimeout(function(){
        Ext.get('loading').remove();
        Ext.get('loading-mask').fadeOut({remove:true});
    }, 250);
}
function getIds(grid2) {
	//var s = grid2.getSelectionModel().getSelections();
	var s = grid2.getSelectionModel().getSelection();
	if (s.length==0) {
		return null;
	}
	var ids = [];
	for (i=0;i<s.length;i++) {
		ids.push(s[i].data.id);
	}
	ids = ids.join(',');
	return ids;
}
//制保留2位小数，如：2，会在2后面补上00.即2.00  
function toDecimal2(x) {  
	var f = parseFloat(x);  
	if (isNaN(f)) {  
		return false;  
	}  
	var f = Math.round(x*100)/100;  
	var s = f.toString();  
	var rs = s.indexOf('.');  
	if (rs < 0) {  
		rs = s.length;  
		s += '.';  
	}  
	while (s.length <= rs + 2) {  
		s += '0';  
	}  
	return s;  
}  
function getId(grid2) {
	var s = grid2.getSelectionModel().getSelection();
	if(s.length > 0){
		return s[0].data.id;
	}
	return 0;
}
function showWindow(title,width,height){
    
    var h = (!height)?300:height;
    var w = (!width)?300:width;
	var msgWindow = Ext.create('Ext.window.Window',{
			id:'msgWindow',
			title:title,
			modal:true,
			closeAction:'hide',
			height:h,
			width:w,
			autoScroll:true,
			html:'',
			constrainHeader:true,
			bbar: Ext.create('Ext.ux.StatusBar', {
				id: 'basic-statusbar',
				defaultText: 'Default status text',
				text: 'Ready',
				iconCls: 'x-status-valid'
			})
		});
	return 	msgWindow;
	}
function object_Array(arrayobject){
	var result=new Array();
	for(var i = 0, len = arrayobject.length; i < len; i++){
		result[arrayobject[i][0]] = arrayobject[i][1];
	}
	return result;
}
function openWindow(id,title,url,width,height){
	var win = Ext.getCmp(id);
	if(!win){
		win = Ext.create('Ext.window.Window',{
			id:id,
			title:title,
			layout:'fit',
			width:width,
			height:height,
			closeAction:'destroy',
			collapsible:true,
			constrainHeader:true,
			modal:true,
			plain: true,
			html : '<iframe frameborder="0" width="100%" height="100%" src="'+url+'"></iframe>'
		});
	}
	win.show();
}
function getCategoryFormTree(url,show,fn){
	var panel = Ext.getCmp('cattreepanel');
	if(!panel){
		panel = Ext.create('Ext.window.Window',{
	title:'SELECT Category',
	id:'cattreepanel',
	width:240,
	height:500,
	autoScroll:true,
	modal: true,
	closable:false,
	constrainHeader:true,
	items:[{
		xtype: 'treepanel',
		width: 200,
		autoScroll: true,
		split: true,
		id:'cattree',
		store:Ext.create('Ext.data.TreeStore', {
			fields:['id','text'],
			proxy: {
				type: 'ajax',
				url: url
			},
			root: {
				text: 'Root',
				id: 'root',
				expanded:true,
				draggable:false
			},
			folderSort: true
		}),
		rootVisible: show?true:false,
		listeners: {
			itemclick: function(view,n) {
				if(n.hasChildNodes()&& !show) {
						Ext.example.msg('Error','Can not be choosed');
						return false;
				}
				Ext.getCmp('cattreepanel').hide();
				fn(n.raw.id,n.raw.text);
			}
		}}]
	});
	}

	panel.show();
}
function getAliCategoryFormTree(url,show,fn){
	var panel = Ext.getCmp('cattreepanel');
	if(!panel){
		panel = Ext.create('Ext.window.Window',{
	title:'SELECT Category',
	id:'cattreepanel',
	width:420,
	height:500,
	autoScroll:true,
	modal: true,
	closable:false,
	constrainHeader:true,
	items:[{
		xtype: 'treepanel',
		width: 400,
		autoScroll: true,
		split: true,
		id:'cattree',
		store:Ext.create('Ext.data.TreeStore', {
			fields:['id','text'],
			proxy: {
				type: 'ajax',
				url: url
			},
			root: {
				text: 'Root',
				id: 'root',
				expanded:true,
				draggable:false
			},
			folderSort: true
		}),
		rootVisible: show?true:false,
		listeners: {
			itemclick: function(view,n) {
				if(n.hasChildNodes()&& !show) {
						Ext.example.msg('Error','Can not be choosed');
						return false;
				}
				Ext.getCmp('cattreepanel').hide();
				fn(n.raw.id,n.raw.text);
			}
		}}]
	});
	}

	panel.show();
}
function modifymodel(id,field,value,model){
	Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
	Ext.Ajax.request({
	    url: 'index.php?model='+model+'&action=modify',
	    loadMask:true,
	    params: { field: field,value:value,id:id },
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
}
function getValueModel(id,field,model,com){
	Ext.Ajax.request({
		url: 'index.php?model='+model+'&action=getvalue',
		loadMask:true,
		params: { field: field,id:id },
		success:function(response,opts){
			var res = Ext.decode(response.responseText);
			if(res.success){
				Ext.getCmp(com).setValue(res.msg);
			}else{
				Ext.example.msg('ERROR',res.msg);
			return false;
			}						
		}
	});
}




Ext.define("Ext.ux.form.field.CKEditor", {
    extend: 'Ext.form.field.TextArea',
    alias: 'widget.ckeditor',
    constructor : function() {
        this.callParent(arguments);//必须先构造父类对象
        this.addEvents("instanceReady");//注册一个instanceReady事件
    },
    
    initComponent: function () {
        this.callParent(arguments);
        this.on("afterrender", function(){
            Ext.apply(this.CKConfig, {
               height : this.getHeight(),
               width : this.getWidth()
            });
            this.editor = CKEDITOR.replace(this.inputEl.id, this.CKConfig);
            this.editor.name = this.name;//把配置中的name属性赋值给CKEditor的name属性
            this.editor.on("instanceReady", function(){
                this.fireEvent("instanceReady", this, this.editor);//触发instanceReady事件
            }, this);
        }, this);
    },
    onRender: function (ct, position) {
        if (!this.el) {
            this.defaultAutoCreate = {
                tag: 'textarea',
                autocomplete: 'off'
            };
        }
        this.callParent(arguments)
    },
    setValue: function (value) {
        this.callParent(arguments);
        if (this.editor) {
            this.editor.setData(value);
        }
    },
    getRawValue: function () {//要覆盖getRawValue方法，否则会取不到值
        if (this.editor) {
            return this.editor.getData();
        } else {
            return ''
        }
    },
    getValue: function () {
        return this.getRawValue();
    }
});




Ext.apply(Ext.form.field.VTypes, {

	numberValid: function (val, field) {

		return /^\d{1,5}\.\d{2}$/.test(val);

	},

	numberValidText: '最多7位，保留2位小数！'

});
 Ext.namespace('Ext.ui.plugins');
 Ext.ui.plugins.ComboPageSize = function(config) {
     Ext.apply(this, config);
 };
 Ext.extend(Ext.ui.plugins.ComboPageSize, Ext.util.Observable, {
     pageSizes: [ 50, 100, 300, 500],
     prefixText: '',
     postfixText: '',
     addToItem: true,    //true添加到items中去，配合index；false则直接添加到最后
     index: 8,           //在items中的位置
     init: function(pagingToolbar) {
         var ps = this.pageSizes;
         var combo = Ext.create('Ext.form.field.ComboBox',{
             typeAhead: true,
             triggerAction: 'all',
             lazyRender: true,
             mode: 'local',
             width: 55,
             store: ps,
             enableKeyEvents: true,
             editable: true,
             loadPages: function() {
                 var rowIndex = 0;
                 var gp = pagingToolbar.findParentBy(
                                 function(ct, cmp) { return (ct instanceof Ext.grid.GridPanel) ? true : false; }
                               );
                 var sm = gp.getSelectionModel();
                 if (undefined != sm && sm.hasSelection()) {
                     if (sm instanceof Ext.selection.RowModel) {
                         rowIndex = gp.store.indexOf(sm.getSelection()[0]);
                     } else if (sm instanceof Ext.selection.CellModel) {
                         rowIndex = sm.getCurrentPosition().row;
                     }
                 }
                // rowIndex += pagingToolbar.cursor;
				gp.getStore().pageSize =  pagingToolbar.pageSize;
				 gp.getStore().load({
					start: Math.floor(rowIndex / pagingToolbar.pageSize) * pagingToolbar.pageSize,
					limit:pagingToolbar.pageSize
				});
             },
             listeners: {
                 select: function(c, r, i) {
                     pagingToolbar.pageSize = c.getValue();
                     this.loadPages();
                 },
                 blur: function() {
                     var pagesizeTemp = Number(this.getValue());
                     if (isNaN(pagesizeTemp)) {
                         this.setValue(pagingToolbar.pageSize);
                         return;
                     }
                     pagingToolbar.pageSize = Number(this.getValue());
                     this.loadPages();
                 }
             }
         });
         if (this.addToItem) {
             var inputIndex = this.index;
             if (inputIndex > pagingToolbar.items.length) inputIndex = pagingToolbar.items.length;
             pagingToolbar.insert(++inputIndex, '-');
             pagingToolbar.insert(++inputIndex, this.prefixText);
             pagingToolbar.insert(++inputIndex, combo);
             pagingToolbar.insert(++inputIndex, this.postfixText);
         }
         else {
             pagingToolbar.add('-');
             pagingToolbar.add(this.prefixText);
             pagingToolbar.add(combo);
             pagingToolbar.add(this.postfixText);
         }
         pagingToolbar.on({
             beforedestroy: function() {
                 combo.destroy();
             },
             change: function() {
                 combo.setValue(pagingToolbar.pageSize);
 
             }
         });
 
     }
 })
