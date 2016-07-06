<!--{include file="header.tpl"}--> 
<link rel="stylesheet" type="text/css" href="js/feed-viewer/Feed-Viewer.css">
<style type="text/css">
.x-menu-item div.preview-right, .preview-right {
    background-image: url(js/feed-viewer/images/preview-right.gif);
}
.x-menu-item div.preview-bottom, .preview-bottom {
    background-image: url(js/feed-viewer/images/preview-bottom.gif);
}
.x-menu-item div.preview-hide, .preview-hide {
    background-image: url(js/feed-viewer/images/preview-hide.gif);
}

#reading-menu .x-menu-item-checked {
    border: 1px dotted #a3bae9 !important;
    background: #DFE8F6;
    padding: 0;
    margin: 0;
}
.tips-box {
    background: none repeat scroll 0 0 #fff;
    border: 1px solid #dae3f1;
    clear: both;
    padding: 6px;
    z-index: 1;
    margin-top:3px;     
}

.content-ele .message .tips-box .content {
    padding-right: 140px;
}
.tips-box .content {
    max-height: 75px;
    overflow: hidden;
}
.clearfix{
    clear: both;
    content: " ";
    display: block;
    height: 0;
}

.tips-box .content .product-img {
    float: left;
    height: 75px;
    width: 60px;
}  
a img {
    border: medium none;
}
.tips-box .inquiry-reply {
    float: right;
    right: 10px;
    top: 5px;
}
.tips-box .content {
    max-height: 75px;
    overflow: hidden;
}
.tips-box .content p.strong {
    color: #666;
    font-weight: 700;
    line-height: 18px;
}
.tips-box .content p {
    line-height: 16px;
} 
.tips-box p {
    line-height: 16px;
} 
.content .inquiry-about a {
    font-family: Tahoma;
    font-size: 11px;
}
.inquiry-about a {
    font-family: Tahoma;
    font-size: 11px;
}
</style>
<link rel="stylesheet" type="text/css" href="js/statusbar/css/statusbar.css" />
<script type="text/javascript" src="js/statusbar/StatusBar.js"></script>  
<script type="text/javascript">
/**
 * The Preview enables you to show a configurable preview of a record.
 *
 * This plugin assumes that it has control over the features used for this
 * particular grid section and may conflict with other plugins.
 */
 
var order_readmsgqty = '';
var order_allmsgqty = '';
var message_readqty = '';
var message_allqty = '';
var account = [<!--{$account}-->];
var menu_store = [<!--{$menu_store}-->];
var template = [<!--{$template}-->];
var msg_type = [<!--{$msg_type}-->];
var message_sel = '';
var aid = 0;

 
Ext.define('Ext.ux.PreviewPlugin', {
    extend: 'Ext.AbstractPlugin',
    alias: 'plugin.preview',
    requires: ['Ext.grid.feature.RowBody', 'Ext.grid.feature.RowWrap'],
    
    // private, css class to use to hide the body
    hideBodyCls: 'x-grid-row-body-hidden',
    
    /**
     * @cfg {String} bodyField
     * Field to display in the preview. Must be a field within the Model definition
     * that the store is using.
     */
    bodyField: '',
    
    /**
     * @cfg {Boolean} previewExpanded
     */
    previewExpanded: true,
    
    setCmp: function(grid) {
        this.callParent(arguments);
        
        var bodyField   = this.bodyField,
            hideBodyCls = this.hideBodyCls,
            features    = [{
                ftype: 'rowbody',
                getAdditionalData: function(data, idx, record, orig, view) {
                    var getAdditionalData = Ext.grid.feature.RowBody.prototype.getAdditionalData,
                        additionalData = {
                            rowBody: data[bodyField],
                            rowBodyCls: grid.previewExpanded ? '' : hideBodyCls
                        };
                        
                    if (getAdditionalData) {
                        Ext.apply(additionalData, getAdditionalData.apply(this, arguments));
                    }
                    return additionalData;
                }
            }, {
                ftype: 'rowwrap'
            }];
        
        grid.previewExpanded = this.previewExpanded;
        if (!grid.features) {
            grid.features = [];
        }
        grid.features = features.concat(grid.features);
    },
    
    /**
     * Toggle between the preview being expanded/hidden
     * @param {Boolean} expanded Pass true to expand the record and false to not show the preview.
     */
    toggleExpanded: function(expanded) {
        var view = this.getCmp();
        this.previewExpanded = view.previewExpanded = expanded;
        view.refresh();
    }
});   
/**
 * @class FeedViewer.FeedPost
 * @extends Ext.panel.Panel
 *
 * Shows the detail of a feed post
 *
 * @constructor
 * Create a new Feed Post
 * @param {Object} config The config object
 */
Ext.define('FeedViewer.FeedPost', {

    extend: 'Ext.panel.Panel',
    alias: 'widget.feedpost',
    cls: 'preview',
    autoScroll: true,
    border: true,
    
    initComponent: function(){
       
        Ext.apply(this, {
            dockedItems: [this.createToolbar()],
            tpl: Ext.create('Ext.XTemplate',
                '<div style="width:68%;float:left;margin:2px;border-radius:5px 5px 5px 5px;border:1px solid #CCC;position: relative;overflow:hidden" class="post-data">',
                    '<div><span class="post-date">{pubDate} &nbsp; &nbsp; &nbsp; &nbsp; by {author:this.defaultValue}</span>',
                    '<h3 class="post-title">{title}</h3></div>',
                '</div><div id="replymessage" class="post-data" style="width:22%;border-radius:5px 5px 0 0;border:1px solid #CCC;padding:3px;float:right; position: fixed;right:30px;">',
                '<span style="margin-left:5px;line-height:30px;">快速回复</span><span style="margin-left:15px;line-height:30px;">  <a style="color:blue" href=\'javascript:parent.newTab("alimsgg","Aliexpress回复模版","index.php?model=template&action=Alimessage")\'> 设置模版  </a></span>',
                '<button style="float:right;margin-right:5px;" onclick="replymsgsend({account_id},{message_id})">回复</button><input type="hidden" id="message_cache_text"/>',
                '<textarea style="font-size:12px;width:100%;border: 1px solid #15428b;" id="answer" rows = "8">{re_content}</textarea></div>',
                '<div style="width:68%;float:left;margin:0 0 0 5px;" class="post-body">{content:this.getBody}</div><div style="width:28%;float:right;">   </div>',
                {
                    getBody: function(value, all){
                        return Ext.util.Format.stripScripts(value);
                    },

                    defaultValue: function(v){
                        return v ? v : 'Unknown';
                    },

                    formatDate: function(value){
                        if (!value) {
                            return '';
                        }
                        return Ext.Date.format(value, 'M j, Y, g:i a');
                    }
                }
             )
        });
        this.callParent(arguments);
    },

    /**
     * Set the active post
     * @param {Ext.data.Model} rec The record
     */
    setActive: function(rec) {
        var me = this,
        gotoButton = me.down('button[text=前往Aliexpress]');

        me.active = rec;
        me.update(rec.data);
        gotoButton.setHref(rec.get('link'));
    },

    /**
     * Create the top toolbar
     * @private
     * @return {Ext.toolbar.Toolbar} toolbar
     */
       createToolbar: function(rec){
        var items = [],
            config = {};
        if (!this.inTab) {
            items.push({
                scope: this,
                handler: this.openTab,
                text: '新窗口打开',
                iconCls: 'tab-new'
            }, '-');                    
        }
        else {
            config.cls = 'x-docked-noborder-top';
        }
        items.push({
            href: this.inTab ? this.data.url : '#',
            target: '_blank',
            hidden:true,
            text: '前往Aliexpress',
            iconCls: 'post-go'
        },{
            text: '标记已读',
            hidden:true,
            icon:'js/feed-viewer/images/msg_readed.png',
            handler:function(){
              //markAliMsg(read,orderid,account_id,index)  
            }
        },{
            xtype:'button',  
            text: '同步历史记录',
            handler:function(field,e){
                Ext.getBody().mask("正在同步历史数据.请稍等...","x-mask-loading");  
                var s = Ext.getCmp('grd').getSelectionModel().getSelection()[0];                                    
                var type = s.get('messageType');
                if(type=='order' || type=='product')var value = s.get('orderId');
                Ext.Ajax.request({
                    url:'index.php?model=aliexpress&action=loadmsgByOrder&type='+type+'&orderId='+value+'&id='+s.get('account_id'),     
                    params:'',
                    loadMask:true,
                    timeout: 45000,
                    success:function(response,opts){
                        Ext.getBody().unmask();
                        var res = Ext.decode(response.responseText);
                        if(res.success){
                            Ext.example.msg('提示',res.msg);
                            Ext.getCmp('grd').getStore().load({params:{start:0, limit:25/*, keyword:s.get('orderId')*/}});
                        }else{
                        }
                    },
                    failure:function(response){
                        Ext.getBody().unmask();
                        Ext.example.msg('提示','可能因为网络繁忙,您的请求已超时...请稍后重试.');
                    }
                })
            }
        });
        if (!this.inTab) {
            items.push('->',{
                xtype:'combo',
                fieldLabel: '回复模版',
                store: Ext.create('Ext.data.ArrayStore',{
                     fields: ["id", "key_type"],
                     data: template
                }),
                valueField :"id",
                displayField: "key_type",
                mode: 'local',
                style:'margin-right:25px;',
                editable: false,
                forceSelection: true,
                labelWidth:65,
                width:240,
                triggerAction: 'all',
                hiddenName:'template',
                id: 'template',
                listeners: {
                    change:function(field,e){     
                        var paypalid = 0;
                        var s = Ext.getCmp('grd').getSelectionModel().getSelection()[0];                                    
                        paypalid = s.get('orderId');
                        Ext.getBody().mask("正在获取模板数据.请稍等...","x-mask-loading");
                        Ext.Ajax.request({
                           url: 'index.php?model=template&action=getcontent&rec_id='+field.getValue()+'&paypalid='+paypalid,
                           loadMask:true,
                            success:function(response,opts){
                                    Ext.getBody().unmask();
                                    document.getElementById("answer").value = response.responseText;
                                    message_sel = document.getElementById("answer").value;
                                }
                            });                                    
                    }
                }
            });
        }
        config.items = items;
        return Ext.create('widget.toolbar', config);
    },

    /**
     * Navigate to the active post in a new window
     * @private
     */
    goToPost: function(){
        window.open(this.active.get('link'));
    },

    /**
     * Open the post in a new tab
     * @private
     */
    openTab: function(){   
        this.fireEvent('opentab', this, this.active);
    }

});

 

function markAliMsg(read,orderid,account_id,index){
    if(read=='1')return false;
    var store = Ext.getCmp('grd').getStore();                         
    Ext.Ajax.request({
        url:'index.php?model=aliexpress&action=MarkMsgali',
        success:function(response){       
        var res = Ext.decode(response.responseText);
            if(res.success){
                Ext.example.msg('提示',res.msg); 
                store.load();
            }
        },
        params:{id:account_id,orderId:orderid}             
    });    
}
function replymsgsend(id,message_id){
    if(document.getElementById("answer").value == '' || !document.getElementById("answer").value || document.getElementById("answer").value == null){document.getElementById("answer").focus();return false;}
    Ext.getBody().mask("正在提交数据.请稍等...", "x-mask-loading");
    var store = Ext.getCmp('grd').getStore();                         
    Ext.Ajax.request({
        url:'index.php?model=aliexpress&action=SendorderMsg',
        method:'POST',
        timeout:30000,
        loadMask:true,
        success:function(response){ 
            Ext.getBody().unmask();        
            var res = Ext.decode(response.responseText);
                if(res.success){
                    Ext.example.msg('提示',res.msg);
                    store.load();
                }
            },
            params:{id:id,message_id:message_id,content:document.getElementById("answer").value}             
    });
      
}
function getCount(type){
    
}


Ext.define('FeedViewer.FeedGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.feedgrid',
    initComponent: function(){
        this.addEvents(  
            'rowdblclick',   
            'select'
        );
        var stroe = Ext.create('Ext.data.Store', {
            model: 'FeedItem',
            sortInfo: {
                property: 'pubDate',
                direction: 'DESC'
            },
            proxy: {
                type: 'ajax',
                url: 'index.php?model=aliexpress&action=getMessageList',
                reader: {
                        type: 'json',
                        totalProperty: 'totalCount',
                        idProperty: 'message_id',
                        root: 'topics'
                },
                listeners: {
                    exception: this.onProxyException,
                    scope: this
                }
            },
            listeners: {
                load: this.onLoad,
                scope: this
            }
        }); 
        var sm = Ext.create('Ext.selection.CheckboxModel', {
            listeners:{
                select:function(e,record,rowindex){
                    var orderdata = record.data;
                    //document.getElementById('OrderInfo').innerHTML = orderdata.track_info;
                }
            }    
            
        });
        Ext.apply(this, {
            cls: 'feed-grid',
            id:'grd',
            store: stroe,
            viewConfig: {
                itemId: 'view',
                plugins: [{
                    pluginId: 'preview',
                    ptype: 'preview',
                    bodyField: 'description',
                    expanded: true
                }],
                listeners: {
                    scope: this,
                    itemdblclick: this.onRowDblClick
                }
            },
            columns: [{
                text: '内容',
                dataIndex: 'title',
                flex: 1,
                renderer: this.formatTitle
            }, {
                text: '所属帐号',
                dataIndex: 'account_name',
                width: 160

            }, {
                text: '最后回复时间',
                dataIndex: 'pubDate',
                sortable:true,        
                width: 230
            }],
            bbar:Ext.create('Ext.toolbar.Paging', {
                plugins: new Ext.ui.plugins.ComboPageSize(),
                pageSize: 25,
                displayInfo: true,
                displayMsg: '第{0} 到 {1} 条数据 共{2}条',
                emptyMsg: "没有数据",
                store: stroe,
                items:[
                    {
                        scope: this,
                        handler: function(){
                            alert('即将开放');
                        },
                        text: '批量回复',
                        icon:'js/feed-viewer/images/msg_read.png',  
                    }/*, '-',{
                        scope: this,
                        handler: this.openTab,
                        text: '批量标记已读',
                        iconCls: 'tab-new'
                    }*/
                ]   
            }),
            selModel: sm,
        }
        );
        this.callParent(arguments);
        this.on('selectionchange', this.onSelect, this);
    },

        /**
     * Reacts to a double click
     * @private
     * @param {Object} view The view
     * @param {Object} index The row index
     */
    onRowDblClick: function(view, record, item, index, e) {
        //this.store.getAt(index).get('message_id');
        this.fireEvent('rowdblclick', this, this.store.getAt(index));
    },


    /**
     * React to a grid item being selected
     * @private
     * @param {Ext.model.Selection} model The selection model
     * @param {Array} selections An array of selections
     */
    onSelect: function(model, selections){
        var selected = selections[0];
        if (selected) {
            this.fireEvent('select', this, selected);
        }
    },

    /**
     * Listens for the store loading
     * @private
     */
    onLoad: function(store, records, success) {
        if (this.getStore().getCount()) {
            this.getSelectionModel().select(0);
        }
    },

    /**
     * Listen for proxy eerrors.
     */
    onProxyException: function(proxy, response, operation) {
        Ext.Msg.alert("Error with data from server", operation.error);
        this.view.el.update('');
        
        // Update the detail view with a dummy empty record
        this.fireEvent('select', this, {data:{}});
    },

    /**
     * Instructs the grid to load a new feed
     * @param {String} url The url to load
     */
    loadFeed: function(url){
        var store = this.store;
        store.getProxy().extraParams.feed = url;
        store.load();
    },

    /**
     * Title renderer
     * @private
     */
    formatTitle: function(value, p, record,index){ 
        var check_read = record.get('is_re');
        var img = 'flag_red.gif';
        var me = this;
        var evenclick = '';
        var store = this.store;
        if(check_read == '1')img = 'flag_green.gif';
        var mid = record.get('message_id'); 
        var str = Ext.String.format('<div class="topic"><span id="'+mid+'"  class="TipDiv" data-qtip="双击快速回复" data-qtitle="提示" style="cursor:pointer;float:left;margin-right:10px"><img id="img'+record.get('orderId')+'" src="themes/default/images/'+img+'" /></span> <b>{0}</b></div>', value, record.get('author') || "Unknown");
        
        return str;
    },

    /**
     * Date renderer
     * @private
     */
    formatDate: function(date){
        if (!date) {
            return '';
        }

        var now = new Date(), d = Ext.Date.clearTime(now, true), notime = Ext.Date.clearTime(date, true).getTime();

        if (notime === d.getTime()) {
            return 'Today ' + Ext.Date.format(date, 'g:i a');
        }

        d = Ext.Date.add(d, 'd', -6);
        if (d.getTime() <= notime) {
            return Ext.Date.format(date, 'D g:i a');
        }
        return Ext.Date.format(date, 'Y/m/d g:i a');
    },
    test:function(i){
        alert(i);
    }
});

 /**
 * @class FeedViewer.FeedInfo
 * @extends Ext.tab.Panel
 *
 * A container class for showing a series of feed details
 * 
 * @constructor
 * Create a new Feed Info
 * @param {Object} config The config object
 */
Ext.define('FeedViewer.FeedInfo', {
    
    extend: 'Ext.tab.Panel',
    alias: 'widget.feedinfo',
    
    maxTabWidth: 230,
    border: false,

    initComponent: function() {
        this.tabBar = {
            border: true
        };
        
        this.callParent();
    },
    
    /**
     * Add a new feed
     * @param {String} title The title of the feed
     * @param {String} url The url of the feed
     */
    addFeed: function(title, url){
        var active = this.items.first();
        if (!active) {
            active = this.add({
                xtype: 'feeddetail',
                title: title,
                url: url,
                closable: false,
                listeners: {
                    scope: this,
                    opentab: this.onTabOpen,
                    openall: this.onOpenAll,
                    rowdblclick: this.onRowDblClick
                }
            });
        } else {
            active.loadFeed(url);
            active.tab.setText(title);
        }
        this.setActiveTab(active);
    },
    
    /**
     * Listens for a new tab request
     * @private
     * @param {FeedViewer.FeedPost} The post
     * @param {Ext.data.Model} model The model
     */
    onTabOpen: function(post, rec) {
        var items = [],
            item,
            title;
            
        if (Ext.isArray(rec)) {
            Ext.each(rec, function(rec) {
                title = rec.get('title');
                if (!this.getTabByTitle(title)) {
                    items.push({
                        inTab: true,
                        xtype: 'feedpost',
                        title: title,
                        closable: true,
                        data: rec.data,
                        active: rec
                    });
                }
            }, this);
            this.add(items);
        }
        else {
            title = rec.get('title');
            item = this.getTabByTitle(title);
            if (!item) {
                item = this.add({
                    inTab: true,
                    xtype: 'feedpost',
                    title: title,
                    closable: true,
                    data: rec.data,
                    active: rec
                });
            }
            this.setActiveTab(item);
            
        }
    },

    /**
     * Find a tab by title
     * @param {String} title The title of the tab
     * @return {Ext.Component} The panel matching the title. null if not found.
     */
    getTabByTitle: function(title) {
        var index = this.items.findIndex('title', title);
        return (index < 0) ? null : this.items.getAt(index);
    },
    
    /**
     * Listens for a row dblclick
     * @private
     * @param {FeedViewer.Detail} detail The detail
     * @param {Ext.data.Model} model The model
     */
    onRowDblClick: function(info, rec){
        this.onTabOpen(null, rec);
    },
    
    /**
     * Listens for the open all click
     * @private
     * @param {FeedViewer.FeedDetail}
     */
    onOpenAll: function(detail) {
        this.onTabOpen(null, detail.getFeedData());
    }
});
Ext.onReady(function(){
Ext.QuickTips.init(); 
var menu_account = [];

<!--{foreach from = $menu_store item = menu name=mstore}-->
    menu_account.push({
       title:'<!--{$menu.title}-->',
       url: '<!--{$menu.url}-->',
       id:'<!--{$menu.id}-->',
       type:'<!--{$menu.type}-->'
    });
<!--{/foreach}--> 

 /**
 * @class FeedViewer.FeedPanel
 * @extends Ext.panel.Panel
 *
 * Shows a list of available feeds. Also has the ability to add/remove and load feeds.
 *
 * @constructor
 * Create a new Feed Panel
 * @param {Object} config The config object
 */

Ext.define('FeedViewer.FeedPanel', {
    extend: 'Ext.panel.Panel',

    alias: 'widget.feedpanel',

    animCollapse: true,
    layout: 'fit',
    title: 'Messages',   

    initComponent: function(){
        this.view = Ext.create('widget.dataview', {
            autoScroll: true,
            store: Ext.create('Ext.data.Store', {
                model: 'Feed',
                data: this.feeds
            }),
            selModel: {
                mode: 'SINGLE',
                listeners: {
                    scope: this,
                    selectionchange: this.onSelectionChange
                }
            },
            listeners: {
                scope: this,
                contextmenu: this.onContextMenu,
                viewready: this.onViewReady
            },              
            cls: 'feed-list',
            itemSelector: '.feed-list-item', 
            overItemCls: 'feed-list-item-hover',
            autoScroll: true,
            tpl: '<tpl for="."><div class="feed-list-item">{title}</div></tpl>',
            
        });
        //return this.view;
        Ext.apply(this, {
            items: this.view,
            dockedItems: this.createToolbar()
        });
        this.createMenu();
        
        this.addEvents(
            'feedremove',
            'feedselect'
        );

        this.callParent(arguments);
    },

    /**
     * Create the DataView to be used for the feed list.
     * @private
     * @return {Ext.view.View}
     */
    createView: function(){
        
    },

    onViewReady: function(){
        this.view.getSelectionModel().select(this.view.store.first());
    },

    /**
     * Creates the toolbar to be used for controlling feeds.
     * @private
     * @return {Ext.toolbar.Toolbar}
     */
    createToolbar: function(){
        this.createActions();     
        var menu = Ext.create('Ext.menu.Menu', {
            id: 'mainMenu',
            style: {
                overflow: 'visible' 
            },
            items: [     
                '<b>按条件同步数据</b>',{
                    xtype:'datefield',
                    fieldLabel: '开始时间',
                    name: 'start',
                    id: 'start',
                    allowBlank:false,
                    format:'Y-m-d',
                    value:'<!--{$yesterday}-->',//'<!--{$yesterday}-->',
                    maxValue:'<!--{$today}-->',         
                    anchor:'90%'
                    },{
                    xtype:'datefield',
                    fieldLabel: '结束时间',
                    name: 'end',
                    id: 'end',
                    format:'Y-m-d',
                    value:'<!--{$today}-->',
                    maxValue:'<!--{$today}-->',
                    allowBlank:false,         
                    anchor:'90%'
                    },{
                    xtype:'combo',
                    store: new Ext.data.SimpleStore({
                         fields: ["id", "account_name"],
                         data: [<!--{$account}-->]
                    }),
                    valueField :"id",
                    displayField: "account_name",
                    mode: 'local',
                    editable: false,
                    forceSelection: true,
                    triggerAction: 'all',
                    hiddenName:'id',
                    fieldLabel: 'Aliexpress账号',
                    emptyText:'选择Aliexpress账号',
                    name: 'account_id',
                    id:'account_id',
                    allowBlank:false,
                    blankText:'请选择'
                    },{                        
                    text: '同步订单留言',
                    icon:'themes/default/images/downmsg.png',     
                    handler:function(){     
                        var starttime=Ext.util.Format.date(Ext.getCmp('start').getValue(),'Y-m-d');
                        var endtime = Ext.util.Format.date(Ext.getCmp('end').getValue(),'Y-m-d');
                        if(Ext.getCmp('msgWindow')){
                           var msgWindow = Ext.getCmp('msgWindow');
                        }else{
                           var msgWindow = showWindow('同步aliexpress站内信',520,120);  
                        }
                        msgWindow.show();
                        msgWindow.body.dom.innerHTML = '';
                        var sb = Ext.getCmp('basic-statusbar');
                        sb.showBusy();
                        sb.setText('正在同步订单留言,可能需要花费数分钟时间,请耐心等候..');
                       
                        var id = Ext.getCmp('account_id').getValue();
                        Ext.Ajax.request({
                            url:'index.php?model=aliexpress&action=loadmsg&type=order&id='+id+'&start='+starttime+'&end='+endtime,     
                            params:'',
                            timeout: 45000,
                            success:function(response,opts){
                                var res = Ext.decode(response.responseText);
                                if(res.success){
                                    window.location="javascript:location.reload()";
                                    sb.setStatus({
                                        text: res.msg,
                                        iconCls: 'x-status-valid',
                                        clear: false
                                    });
                                }else{
                                    
                                    sb.setStatus({
                                        text: res.msg,
                                        iconCls: 'x-status-error',
                                        clear: true
                                    });
                                }
                            },
                            failure:function(response){
                                    sb.setStatus({
                                        text: '可能因为网络繁忙,您的请求已超时...请稍后重试.',
                                        iconCls: 'x-status-error',
                                        clear: false
                                    });
                                }
                        }) 
                    }
               },{                              
                    text: '同步站内信',                                                                  
                    icon:'themes/default/images/downmsg.png',                     
                    handler:function(){ 
                        var starttime=Ext.util.Format.date(Ext.getCmp('start').getValue(),'Y-m-d');
                        var endtime = Ext.util.Format.date(Ext.getCmp('end').getValue(),'Y-m-d');
                        if(Ext.getCmp('msgWindow')){
                           var msgWindow = Ext.getCmp('msgWindow');
                        }else{
                           var msgWindow = showWindow('同步aliexpress站内信',520,120);  
                        }
                        msgWindow.show();
                        msgWindow.body.dom.innerHTML = '';
                        var sb = Ext.getCmp('basic-statusbar');
                        sb.showBusy();
                        sb.setText('正在同步站内信,可能需要花费数分钟时间,请耐心等候..');
                       
                        var id = Ext.getCmp('account_id').getValue();
                        Ext.Ajax.request({
                            url:'index.php?model=aliexpress&action=loadmsg&type=msg&id='+id+'&start='+starttime+'&end='+endtime,     
                            params:'',
                            timeout: 45000,
                            success:function(response,opts){
                                var res = Ext.decode(response.responseText);
                                if(res.success){
                                    window.location="javascript:location.reload()";
                                    sb.setStatus({
                                        text: res.msg,
                                        iconCls: 'x-status-valid',
                                        clear: false
                                    });
                                }else{
                                    
                                    sb.setStatus({
                                        text: res.msg,
                                        iconCls: 'x-status-error',
                                        clear: true
                                    });
                                }
                            },
                            failure:function(response){
                                    sb.setStatus({
                                        text: '可能因为网络繁忙,您的请求已超时...请稍后重试.',
                                        iconCls: 'x-status-error',
                                        clear: false
                                    });
                                }
                        })        
                    }
               }, '-','<b>初始化数据</b>',{                              
                    text: '清空所有站内信与留言',                                                                  
                    icon:'themes/default/images/del.gif',                     
                    handler:function(){ 
                        
                        if(Ext.getCmp('msgWindow')){
                           var msgWindow = Ext.getCmp('msgWindow');
                        }else{
                           var msgWindow = showWindow('初始化数据站内信与留言',520,120);  
                        }
                        msgWindow.show();
                        msgWindow.body.dom.innerHTML = '';
                        var sb = Ext.getCmp('basic-statusbar');
                        sb.showBusy();
                        sb.setText('正在初始化数据,可能需要花费数分钟时间,请耐心等候..');
                        Ext.Ajax.request({
                            url:'index.php?model=aliexpress&action=del_allmsg',     
                            params:'',
                            timeout: 45000,
                            success:function(response,opts){
                                var res = Ext.decode(response.responseText);
                                if(res.success){                                                    
                                    sb.setStatus({
                                        text: res.msg,
                                        iconCls: 'x-status-valid',
                                        clear: false
                                    });
                                    window.location="javascript:location.reload()";
                                }else{
                                    
                                    sb.setStatus({
                                        text: res.msg,
                                        iconCls: 'x-status-error',
                                        clear: true
                                    });
                                }
                            },
                            failure:function(response){
                                    sb.setStatus({
                                        text: '可能因为网络繁忙,您的请求已超时...请稍后重试.',
                                        iconCls: 'x-status-error',
                                        clear: false
                                    });
                                }
                        })        
                    }
               } 
            ]
        });
        this.toolbar = Ext.create('widget.toolbar', {
            items: [  
            {
                text:'一键同步',
                icon:'themes/default/images/downmsg.png',
                tooltip: {text:'默认同步所有帐号一个月内的所有站内信与订单留言', title:'提示'},
                handler:function(){ 
                        
                        if(Ext.getCmp('msgWindow')){
                           var msgWindow = Ext.getCmp('msgWindow');
                        }else{
                           var msgWindow = showWindow('一键同步订单留言，站内信',520,450);  
                        }
                        msgWindow.show();
                        msgWindow.body.dom.innerHTML = '';
                        var sb = Ext.getCmp('basic-statusbar');
                        sb.showBusy();
                        sb.setText('正在同步数据,可能需要花费数分钟时间,请耐心等候..');
                       
                        var id = Ext.getCmp('account_id').getValue();
                        Ext.Ajax.request({
                            url:'index.php?model=aliexpress&action=fastloadmsg',     
                            params:'',
                            timeout: 120000,
                            success:function(response,opts){
                                var res = Ext.decode(response.responseText);
                                if(res.success){
                                    
                                    sb.setStatus({
                                        text: res.msg,
                                        iconCls: 'x-status-valid',
                                        clear: false
                                    });
                                }else{
                                    
                                    sb.setStatus({
                                        text: res.msg,
                                        iconCls: 'x-status-error',
                                        clear: true
                                    });
                                }
                                window.location="javascript:location.reload()";
                            },
                            failure:function(response){
                                    sb.setStatus({
                                        text: '可能因为网络繁忙,您的请求已超时...请稍后重试.',
                                        iconCls: 'x-status-error',
                                        clear: false
                                    });
                                }
                        })        
                    }
            },{
                text:'数据管理',
                icon:'themes/default/images/downmsg.png',
                tooltip: {text:'同步或初始化您的站内信和留言', title:'提示'},
                menu: menu
            }]
        });
        return this.toolbar;
    },

    /**
     * Create actions to share between toolbar and menu
     * @private
     */
      createActions: function(){
        
    },

    /**
     * Create the context menu
     * @private
     */
    createMenu: function(){
        this.menu = Ext.create('widget.menu', {
            items: [
            {
                scope: this,
                handler: this.onLoadClick,
                text: 'Load feed',
                iconCls: 'feed-load'
            }
            ]/*,
            listeners: {
                hide: function(c){
                    c.activeFeed = null;
                }
            } */
        });
    },

    /**
     * Used when view selection changes so we can disable toolbar buttons.
     * @private
     */
    onSelectionChange: function(){
        var selected = this.getSelectedItem();             
        //this.toolbar.getComponent('remove').setDisabled(!selected);
        if (selected) {
            this.loadFeed(selected);
        }
    },

    /**
     * React to the load feed menu click.
     * @private
     */
    onLoadClick: function(){
        this.loadFeed(this.menu.activeFeed);
    },

    /**
     * Loads a feed.
     * @private
     * @param {Ext.data.Model} rec The feed
     */
    loadFeed: function(rec){
        if (rec) {  
            this.fireEvent('feedselect', this, rec.get('title'), rec.get('url'), rec.get('id'), rec.get('type'));
        }
    },

    /**
     * Gets the currently selected record in the view.
     * @private
     * @return {Ext.data.Model} Returns the selected model. false if nothing is selected.
     */
    getSelectedItem: function(){
        return this.view.getSelectionModel().getSelection()[0] || false;
    },

    /**
     * Listens for the context menu event on the view
     * @private
     */
    onContextMenu: function(view, index, el, event){
        var menu = this.menu;

        event.stopEvent();
        menu.activeFeed = view.store.getAt(index);
        menu.showAt(event.getXY());
    },

    /**
     * React to a feed being removed
     * @private
     */
    onRemoveFeedClick: function() {
        var active = this.menu.activeFeed || this.getSelectedItem();


        if (active) {
            this.view.getSelectionModel().deselectAll();
            this.animateNode(this.view.getNode(active), 1, 0,{
                scope: this,
                afteranimate: function() {
                    this.view.store.remove(active);
                    
                }
            });
            this.fireEvent('feedremove', this, active.get('title'), active.get('url'));
        }
    },

    /**
     * React to a feed attempting to be added
     * @private
     */
    onAddFeedClick: function(){
        var win = this.addFeedWindow || (this.addFeedWindow = Ext.create('widget.feedwindow', {
            listeners: {
                scope: this,
                feedvalid: this.onFeedValid
            }
        }));
        win.form.getForm().reset();
        win.show();
    },

    /**
     * React to a validation on a feed passing
     * @private
     * @param {FeedViewer.FeedWindow} win
     * @param {String} title The title of the feed
     * @param {String} url The url of the feed
     */
    onFeedValid: function(win, title, url,id,type){
        var view = this.view,
            store = view.store,
            rec;

        rec = store.add({
            url: url,
            title: title,
            id: id,
            type: type
        })[0];
        this.animateNode(view.getNode(rec), 0, 1,2,3);
    },

    /**
     * Animate a node in the view when it is added/removed
     * @private
     * @param {Mixed} el The element to animate
     * @param {Number} start The start opacity
     * @param {Number} end The end opacity
     * @param {Object} listeners (optional) Any listeners
     */
    animateNode: function(el, start, end, listeners){
        Ext.create('Ext.fx.Anim', {
            target: Ext.get(el),
            duration: 500,
            from: {
                opacity: start
            },
            to: {
                opacity: end
            },
            listeners: listeners
         });
    },

    // Inherit docs
    onDestroy: function(){
        this.callParent(arguments);
        this.menu.destroy();
    }
});


Ext.define('FeedViewer.FeedDetail', { 
    extend: 'Ext.panel.Panel',
    alias: 'widget.feeddetail', 
    border: false, 
    initComponent: function(){
        this.display = Ext.create('widget.feedpost', {});
        Ext.apply(this, {
            layout: 'border',
            items: [this.createGrid(), this.createSouth(), this.createEast()]
        });
        this.relayEvents(this.display, ['opentab']);
        this.relayEvents(this.grid, ['rowdblclick']);
        this.callParent(arguments);
    },

    /**
     * Loads a feed.
     * @param {String} url
     */
    loadFeed: function(url){
        this.grid.loadFeed(url);
    },

    /**
     * Creates the feed grid
     * @private
     * @return {FeedViewer.FeedGrid} feedGrid
     */
    createGrid: function(){
        this.grid = Ext.create('widget.feedgrid', {
            region: 'center',
            dockedItems: [this.createTopToolbar()],
            flex: 2,
            minHeight: 200,
            minWidth: 150,
            listeners: {
                scope: this,
                select: this.onSelect
            }
        });
        this.loadFeed(this.url);
        return this.grid;
    },

    /**
     * Fires when a grid row is selected
     * @private
     * @param {FeedViewer.FeedGrid} grid
     * @param {Ext.data.Model} rec
     */
    onSelect: function(grid, rec) {
        
        this.display.setActive(rec);
    },

    createTopToolbar: function(){
         
        var store = this.store;
        this.toolbar = Ext.create('widget.toolbar', {
            cls: 'x-docked-noborder-top',
            items: [
            {
                xtype:'datefield',
                emptyText:'起始日期', 
                hideLabel:true,
                name: 'starttime',
                id: 'starttime',
                allowBlank:true,
                format:'Y-m-d',                                    
                maxValue:'<!--{$today}-->',         
                width:95
                },{
                xtype:'datefield',
                emptyText:'截止日期',
                hideLabel:true,
                name: 'endtime',
                id: 'endtime',
                format:'Y-m-d',        
                maxValue:'<!--{$today}-->',
                allowBlank:true,         
                width:95 
                },'-','-','类型',{
                xtype:'combo',
                store: Ext.create('Ext.data.ArrayStore',{
                     fields: ["id", "key_type"],
                     data: [['0','所有类型'],['order','订单留言'],['product','产品留言'],['member','买家留言'],['store','店铺留言']]
                }),
                valueField :"id",
                displayField: "key_type",
                mode: 'local',
                style:'margin-right:25px;',
                editable: false,
                forceSelection: true,
                width:90,
                triggerAction: 'all',
                hiddenName:'msgtype',
                id: 'msgtype',
                value:'0',
                listeners: {
                    change:function(field,e){
                        Ext.getCmp('grd').getStore().on('beforeload', function (store, options) {
                        var new_params = {      
                            type:Ext.getCmp('msgtype').getValue(),
                            account:aid
                        };
                        Ext.apply(Ext.getCmp('grd').getStore().proxy.extraParams, new_params);
                        });
                        Ext.getCmp('grd').getStore().load({params:{start:0, limit:25}});                                    
                    }
                }
            },{
                xtype:'textfield', 
                width:105 ,
                id:'keyword',
                name:'keyword',
                emptyText: '回车',
                hideLabel:true,
                enableKeyEvents:true,
                listeners:{
                scope:this,
                keypress:function(field,e){
                    if(e.getKey()==13){                       
                        Ext.getCmp('grd').getStore().load({params:{start:0, limit:25,keyword:Ext.getCmp('keyword').getValue()}});
                    }
                }
                } 
            },'-', {                              
        text: '搜索',                                                                  
        iconCls: 'post-go',
        handler:function(){
            Ext.getCmp('grd').getStore().load({params:{start:0, limit:25,keyword:Ext.getCmp('keyword').getValue()}});
            }
        },'->',/*{
                xtype: 'cycle',
                text: 'Reading Pane',
                prependText: 'Message视图: ',
                showText: true,
                scope: this,
                changeHandler: this.readingPaneChange,
                menu: {
                    id: 'reading-menu',
                    items: [{
                        text: '底部',
                        checked: true,
                        iconCls:'preview-bottom'
                    }, {
                        text: '右边',
                        iconCls:'preview-right'
                    }, {
                        text: '隐藏',
                        iconCls:'preview-hide'
                    }]
                }
            }, */{
                iconCls: 'summary',
                text: '精简模式',
                enableToggle: true,
                pressed: true,
                scope: this,
                toggleHandler: this.onSummaryToggle
            }]
        });
        return this.toolbar;
    },

    /**
     * Reacts to the open all being clicked
     * @private
     */
    onOpenAllClick: function(){
        this.fireEvent('openall', this);
    },

    /**
     * Gets a list of titles/urls for each feed.
     * @return {Array} The feed details
     */
    getFeedData: function(){
        return this.grid.store.getRange();
    },

    /**
     * @private
     * @param {Ext.button.Button} button The button
     * @param {Boolean} pressed Whether the button is pressed
     */
    onSummaryToggle: function(btn, pressed) {
        this.grid.getComponent('view').getPlugin('preview').toggleExpanded(pressed);
    },

    /**
     * Handle the checked item being changed
     * @private
     * @param {Ext.menu.CheckItem} item The checked item
     */
     readingPaneChange: function(cycle, activeItem){
        switch (activeItem.text) {
            case '底部':
                this.east.hide();
                this.south.show();
                this.south.add(this.display);
                break;
            case '右边':
                this.south.hide();
                this.east.show();
                this.east.add(this.display);
                break;
            default:
                this.south.hide();
                this.east.hide();
                break;
        }
    },

    /**
     * Create the south region container
     * @private
     * @return {Ext.panel.Panel} south
     */
    createSouth: function(){
        this.south =  Ext.create('Ext.panel.Panel', { 
            layout: 'fit',
            region: 'south',
            border: false,
            split: true,
            flex: 2,
            minHeight: 150,
            items: this.display
        });
        return this.south;
    },

    /**
     * Create the east region container
     * @private
     * @return {Ext.panel.Panel} east
     */
    createEast: function(){
        this.east =  Ext.create('Ext.panel.Panel', {
            region: 'east',
            bodyStyle:'background-color:#FFFFFF;',
            autoScroll: true,
            height:500,
            autoWidth:true,
            flex: 0.6,
            padding:0,         
            split: true,          
            hidden:true, 
            minWidth: 100,
            border: false,
            html:'<style type="text/css">ul{list-style:none;padding:0;margin:0;}</style><div style="padding:0;margin:0;font-size:11px;" id="OrderInfo"></div>'
        });
        return this.east;
    }
});



Ext.define('FeedViewer.App', {
    extend: 'Ext.container.Viewport',
    
    initComponent: function(){
        
        Ext.define('Feed', {
            extend: 'Ext.data.Model',
            fields: ['title', 'url','type','id']
        });

        Ext.define('Account', {
            extend: 'Ext.data.Model',
            fields: ['title', 'url']
        });
        
        Ext.define('FeedItem', {
            extend: 'Ext.data.Model',
            fields: ['message_id', 'title','author', 'pubDate','link','track_info','msg_type','messageType','order_sn', 'description','account_name','account_id','orderId','content','readed','is_re','re_content']
        });
        
        Ext.apply(this, {
            layout: {
                type: 'border',
                padding: 5
            },
            items: [this.createFeedPanel(), this.createFeedInfo()]
        });
        this.callParent(arguments);
    },
    
    /**
     * Create the list of fields to be shown on the left
     * @private
     * @return {FeedViewer.FeedPanel} feedPanel
     */
    createFeedPanel: function(){
        
        this.feedPanel = Ext.create('widget.feedpanel',{
            region: 'west',
            id:'left_pan',
            collapsible: true,
            width: 220,
            floatable: false,
            split: true,
            minWidth: 175,
            feeds: menu_account,
            listeners: {
                scope: this,
                feedselect: this.onFeedSelect
            }
        });
        
        return this.feedPanel;
    },
    
    /**
     * Create the feed info container
     * @private
     * @return {FeedViewer.FeedInfo} feedInfo
     */
    createFeedInfo: function(){
        this.feedInfo = Ext.create('widget.feedinfo', {
            region: 'center',
            minWidth: 300
        });
        return this.feedInfo;
    },
    
    /**
     * Reacts to a feed being selected
     * @private
     */
    onFeedSelect: function(feed, title, url,id,type){
        if(type=='account'){
            aid = id; 
        }
        this.feedInfo.addFeed(title, url,id,type);
    }
});

 
    var app = new FeedViewer.App({});
    
});
</script>   
</body>
</html>