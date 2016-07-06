Ext.example = function(){
    var msgCt;
    function createBox(t, s){
        return ['<div class="msg">',
                '<div class="x-box-tl"><div class="x-box-tr"><div class="x-box-tc"></div></div></div>',
                '<div class="x-box-ml"><div class="x-box-mr"><div class="x-box-mc"><h3>', t, '</h3>', s, '</div></div></div>',
                '<div class="x-box-bl"><div class="x-box-br"><div class="x-box-bc"></div></div></div>',
                '</div>'].join('');
    }
    return {
        msg : function(title, format){
            if(!msgCt){
                msgCt = Ext.DomHelper.insertFirst(document.body, {id:'msg-div'}, true);
            }
            msgCt.alignTo(document, 't-t');
            var s = String.format.apply(String, Array.prototype.slice.call(arguments, 1));
            var m = Ext.DomHelper.append(msgCt, {html:createBox(title, s)}, true);
            m.slideIn('t').pause(2).ghost("t", {remove:true});
        },
        init : function(){
        }
    };
}();
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
	var s = grid2.getSelectionModel().getSelections();
	if (s.length==0) {
		return null;
	}
	var ids = [];
	for (i=0;i<s.length;i++) {
		ids.push(s[i].id);
	}
	ids = ids.join(',');
	return ids;
}
function getId(grid2) {
	var s = grid2.getSelectionModel().getSelected();
	if (s) {
		return s.id;
	}
	return 0;
}
function showWindow(title){
	var msgWindow = new Ext.Window({
			id:'msgWindow',
			title:title,
			modal:true,
			closeAction:'hide',
			height:300,
			width:300,
			autoScroll:true,
			html:'',
			constrainHeader:true,
			bbar: new Ext.ux.StatusBar({
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
	var win = Ext.get(id);
	if (win) {
		win.show();
		return;
	}
	win = new Ext.Window({
		id:id,
		title:title,
		layout:'fit',
		width:width,
		height:height,
		closeAction:'close',
		collapsible:true,
		constrainHeader:true,
		modal:true,
		plain: true,
		html : '<iframe frameborder="0" width="100%" height="100%" src="'+url+'"></iframe>'
	});
	win.show();
}
function getCategoryFormTree(url,show,fn)
{
var panel = new Ext.Window({
	title:'SELECT Category',
	id:'cattreepanel',
	width:240,
	height:500,
	autoScroll:true,
	modal: true,
	closable:false,
	constrainHeader:true,
	items:[{
		title: 'Category List',
		xtype: 'treepanel',
		width: 200,
		autoScroll: true,
		split: true,
		id:'cattree',
		loader: new Ext.tree.TreeLoader(),
		root: new Ext.tree.AsyncTreeNode({
			text: 'Root',
			draggable:false,
			id:'root'
		}),
		rootVisible: show?true:false,
		loader: new Ext.tree.TreeLoader({
		dataUrl:url
		}),
		listeners: {
			click: function(n) {
				if(n.hasChildNodes()&& !show) {
						Ext.example.msg('Error','Can not be choosed');
						return false;
				}
				Ext.getCmp('cattreepanel').hide();
				fn(n.attributes.id,n.attributes.text);
			}
		}}]
	});
	panel.show();
}
function getAliCategoryFormTree(url,show,fn)
{
var panel = new Ext.Window({
	title:'SELECT Category',
	id:'cattreepanel',
	width:550,
	height:500,
	autoScroll:true,
	modal: true,
	closable:false,
	constrainHeader:true,
	items:[{
		title: 'Category List',
		xtype: 'treepanel',
		width: 520,
		autoScroll: true,
		split: true,
		id:'cattree',
		loader: new Ext.tree.TreeLoader(),
		root: new Ext.tree.AsyncTreeNode({
			text: 'Root',
			draggable:false,
			id:'root'
		}),
		rootVisible: show?true:false,
		loader: new Ext.tree.TreeLoader({
		dataUrl:url
		}),
		listeners: {
			click: function(n) {
				if(n.hasChildNodes()&& !show) {
						Ext.example.msg('Error','Can not be choosed');
						return false;
				}
				Ext.getCmp('cattreepanel').hide();
				fn(n.attributes.id,n.attributes.text);
			}
		}}]
	});
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
function getValueModel(id,field,model,com)
{
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
/*Ext.onReady(function(){//fix for IE to get the grid data selectable
	 Ext.override(Ext.grid.GridView, {
		templates: {
			cell: new Ext.Template(
						'<td class="x-grid3-col x-grid3-cell x-grid3-td-{id} {css}" style="{style}" tabIndex="0" {cellAttr}>',
						'<div class="x-grid3-cell-inner x-grid3-col-{id}" {attr}>{value}</div>',
						"</td>"
				)
		}
	});
});*/
Ext.override(Ext.form.RadioGroup, {   
    getValue: function(){  
        var v;  
        if (this.rendered) {  
            this.items.each(function(item){  
                if (!item.getValue())   
                    return true;  
                v = item.getRawValue();  
                return false;  
            });  
        }  
        else {  
            for (var k in this.items) {  
                if (this.items[k].checked) {  
                    v = this.items[k].inputValue;  
                    break;  
                }  
            }  
        }  
        return v;  
    },  
    setValue: function(v){  
        if (this.rendered)   
            this.items.each(function(item){  
                item.setValue(item.getRawValue() == v);  
            });  
        else {  
            for (var k in this.items) {  
                this.items[k].checked = this.items[k].inputValue == v;  
            }  
        }  
    }  
});

 Ext.namespace('Ext.ui.plugins');
 Ext.ui.plugins.ComboPageSize = function(config) {
     Ext.apply(this, config);
 };
 
 Ext.extend(Ext.ui.plugins.ComboPageSize, Ext.util.Observable, {
     pageSizes: [ 15, 20, 50, 100, 200, 500],
     prefixText: '',
     postfixText: '',
     addToItem: true,    //true添加到items中去，配合index；false则直接添加到最后
     index: 8,           //在items中的位置
     init: function(pagingToolbar) {
         var ps = this.pageSizes;
         var combo = new Ext.form.ComboBox({
             typeAhead: true,
             triggerAction: 'all',
             lazyRender: true,
             mode: 'local',
             width: 45,
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
                     if (sm instanceof Ext.grid.RowSelectionModel) {
                         rowIndex = gp.store.indexOf(sm.getSelected());
                     } else if (sm instanceof Ext.grid.CellSelectionModel) {
                         rowIndex = sm.getSelectedCell()[0];
                     }
                 }
                 rowIndex += pagingToolbar.cursor;
                 pagingToolbar.doLoad(Math.floor(rowIndex / pagingToolbar.pageSize) * pagingToolbar.pageSize);
             },
             listeners: {
                 select: function(c, r, i) {
                     pagingToolbar.pageSize = ps[i];
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
