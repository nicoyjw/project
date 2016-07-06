/**
 * The Preview enables you to show a configurable preview of a record.
 *
 * This plugin assumes that it has control over the features used for this
 * particular grid section and may conflict with other plugins.
 */
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
                '<div class="post-data">',
                    '<span class="post-date">{gmtCreate}</span>',
                    '<h3 class="post-title">{title}</h3>',
                    '<h4 class="post-author">by {author:this.defaultValue}</h4>',
                '</div>',
                '<div class="post-body">{content:this.getBody}</div>',
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
            gotoButton = me.down('button[text=打开订单页面]');

        me.active = rec;
        me.update(rec.data);
       // gotoButton.setHref(rec.get('link'));
    },

    /**
     * Create the top toolbar
     * @private
     * @return {Ext.toolbar.Toolbar} toolbar
     */
    createToolbar: function(){
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
            text: '打开订单页面',
            iconCls: 'post-go'
        });
        config.items = items;
        return Ext.create('widget.toolbar', config);
    },

    /**
     * Navigate to the active post in a new window
     * @private
     */
    goToPost: function(){
        window.open(this.active.get('url'));
    },

    /**
     * Open the post in a new tab
     * @private
     */
    openTab: function(){
        this.fireEvent('opentab', this, this.active);
    }

});
/**
 * @class FeedViewer.FeedDetail
 * @extends Ext.panel.Panel
 *
 * Shows the details of a particular feed
 * 
 * @constructor
 * Create a new Feed Detail
 * @param {Object} config The config object
 */
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

    /**
     * Creates top controller toolbar.
     * @private
     * @return {Ext.toolbar.Toolbar} toolbar
     */
    createTopToolbar: function(){
        this.toolbar = Ext.create('widget.toolbar', {
            cls: 'x-docked-noborder-top',
            items: [{
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
            }, {
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
            layout: 'fit',
            region: 'east',
            flex: 1,
            split: true,
            hidden: true,
            minWidth: 150,
            border: false
        });
        return this.east;
    }
});

Ext.define('FeedViewer.FeedGrid', {
    extend: 'Ext.grid.Panel',

    alias: 'widget.feedgrid',

    initComponent: function(){
        this.addEvents(
            /**
             * @event rowdblclick
             * Fires when a row is double clicked
             * @param {FeedViewer.FeedGrid} this
             * @param {Ext.data.Model} model
             */
            'rowdblclick',
            /**
             * @event select
             * Fires when a grid row is selected
             * @param {FeedViewer.FeedGrid} this
             * @param {Ext.data.Model} model
             */
            'select'
        );

        Ext.apply(this, {
            cls: 'feed-grid',
            
            
            /*
             * 
             * this.store = Ext.create('Ext.data.JsonStore', {
                    fields:this.fields,
                    remoteSort: true,
                    autoLoad: true,
                    pageSize: this.pagesize,
                    proxy: {
                        type: 'ajax',
                        url: this.listURL,
                        actionMethods: {
                            read: 'POST'
                        },
                        reader: {
                            type: 'json',
                            totalProperty: 'totalCount',
                            idProperty: this.fields[0],
                            root: 'topics'
                        }
                    }
                })
             * 
             */
            
            
            
            store: Ext.create('Ext.data.Store', {
                model: 'FeedItem',
                sortInfo: {
                    property: 'gmtCreate',
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
            }),
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
                text: 'Title',
                dataIndex: 'title',
                flex: 1,
                renderer: this.formatTitle
            }, {
                text: '发件人',
                dataIndex: 'author',
                hidden: true,
                width: 200

            }, {
                text: '最后回复时间',
                dataIndex: 'gmtCreate',
                //renderer: this.formatDate,
                width: 200
            }]
        });
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
    formatTitle: function(value, p, record){
        return Ext.String.format('<div class="topic"><b>{0}</b><span class="author">{1}</span></div>', value, record.get('author') || "Unknown");
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
    title: 'Feeds',

    initComponent: function(){
        Ext.apply(this, {
            items: this.createView(),
            dockedItems: this.createToolbar()
        });
        this.createMenu();
        this.addEvents(
            /**
             * @event feedremove Fired when a feed is removed
             * @param {FeedPanel} this
             * @param {String} title The title of the feed
             * @param {String} url The url of the feed
             */
            'feedremove',

            /**
             * @event feedselect Fired when a feed is selected
             * @param {FeedPanel} this
             * @param {String} title The title of the feed
             * @param {String} url The url of the feed
             */
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
            trackOver: true,
            cls: 'feed-list',
            itemSelector: '.feed-list-item',
            overItemCls: 'feed-list-item-hover',
            tpl: '<tpl for="."><div class="feed-list-item">{content}</div></tpl>'
        });
        return this.view;
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
        this.toolbar = Ext.create('widget.toolbar', {
            items: [this.addAction, this.removeAction]
        });
        return this.toolbar;
    },

    /**
     * Create actions to share between toolbar and menu
     * @private
     */
    createActions: function(){
        this.addAction = Ext.create('Ext.Action', {
            scope: this,
            handler: this.onAddFeedClick,
            text: 'Add feed',
            iconCls: 'feed-add'
        });

        this.removeAction = Ext.create('Ext.Action', {
            itemId: 'remove',
            scope: this,
            handler: this.onRemoveFeedClick,
            text: 'Remove feed',
            iconCls: 'feed-remove'
        });
    },

    /**
     * Create the context menu
     * @private
     */
    createMenu: function(){
        this.menu = Ext.create('widget.menu', {
            items: [{
                scope: this,
                handler: this.onLoadClick,
                text: 'Load feed',
                iconCls: 'feed-load'
            }, this.removeAction, '-', this.addAction],
            listeners: {
                hide: function(c){
                    c.activeFeed = null;
                }
            }
        });
    },

    /**
     * Used when view selection changes so we can disable toolbar buttons.
     * @private
     */
    onSelectionChange: function(){
        var selected = this.getSelectedItem();
        this.toolbar.getComponent('remove').setDisabled(!selected);
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
            this.fireEvent('feedselect', this, rec.get('title'), rec.get('url'));
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
            this.animateNode(this.view.getNode(active), 1, 0, {
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
    onFeedValid: function(win, title, url){
        var view = this.view,
            store = view.store,
            rec;

        rec = store.add({
            url: url,
            title: title
        })[0];
        this.animateNode(view.getNode(rec), 0, 1);
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


/**
 * @class FeedViewer.FeedViewer
 * @extends Ext.container.Viewport
 *
 * The main FeedViewer application
 * 
 * @constructor
 * Create a new Feed Viewer app
 * @param {Object} config The config object
 */ 
/**
 * @class FeedViewer.FeedWindow
 * @extends Ext.window.Window
 *
 * Shows a dialog for creating and validating a new feed.
 * 
 * @constructor
 * Create a new Feed Window
 * @param {Object} config The config object
 */

Ext.define('FeedViewer.FeedWindow', {
    extend: 'Ext.window.Window',
    
    alias: 'widget.feedwindow',

    plain: true,
    resizable: false,
    modal: true,
    closeAction: 'hide',
    defaultFocus: '#feed',

    defaultFeeds: [
        ['http://rss.cnn.com/rss/edition.rss', 'CNN Top Stories'],
        ['http://sports.espn.go.com/espn/rss/news', 'ESPN Top News'],
        ['http://news.google.com/news?ned=us&topic=t&output=rss', 'Sci/Tech - Google News'],
        ['http://rss.news.yahoo.com/rss/software', 'Yahoo Software News']
    ],
    
    initComponent: function(){
        var me = this;
        me.addEvents(
            /**
             * @event feedvalid
             * @param {FeedViewer.FeedWindow} this
             * @param {String} title
             * @param {String} url
             * @param {String} description
             */
            'feedvalid'
        );
        
        me.form = Ext.create('widget.form', {
            bodyPadding: '12 10 10',
            border: false,
            unstyled: true,
            items: [{
                anchor: '100%',
                itemId: 'feed',
                fieldLabel: 'Enter the URL of the feed to add',
                labelAlign: 'top',
                msgTarget: 'under',
                xtype: 'combo',
                store: this.defaultFeeds,
                getInnerTpl: function(){
                    return '<div class="feed-picker-url">{field1}</div><div class="feed-picker-title">{field2}</div>'; 
                }
            }]
        });
        Ext.apply(me, {
            width: 500,
            title: 'Add Feed',
            iconCls: 'feed',
            layout: 'fit',
            items: me.form,
            buttons: [{
                xtype: 'button',
                text: 'Add Feed',
                scope: me,
                handler: me.onAddClick
            }, {
                xtype: 'button',
                text: 'Cancel',
                scope: me,
                handler: me.doHide
            }]
        });
        me.callParent(arguments);
    },
    
    doHide: function(){
        this.hide();
    },
    
    /**
     * React to the add button being clicked.
     * @private
     */
    onAddClick: function(addBtn) {
        addBtn.disable();
        var url = this.form.getComponent('feed').getValue();
        this.form.setLoading({
            msg: 'Validating feed...'
        });
        Ext.Ajax.request({
            url: 'js/feed-viewer/feed-proxy.php',
            params: {
                feed: url
            },
            success: this.validateFeed,
            failure: this.markInvalid,
            scope: this
        });
    },
    
    /**
     * React to the feed validation passing
     * @private
     * @param {Object} response The response object
     */
    validateFeed: function(response) {
        this.form.setLoading(false);
        this.down('button[text=Add Feed]').enable();
        
        var dq = Ext.DomQuery,
            url = this.form.getComponent('feed').getValue(),
            xml,
            channel,
            title;

        try {
            xml = response.responseXML;
            channel = xml.getElementsByTagName('channel')[0];
            if (channel) {
                title = dq.selectValue('title', channel, url);
                this.fireEvent('feedvalid', this, title, url);
                this.hide();
                return;
            }
        } catch(e) {
        }
        this.markInvalid();
        
    },
    
    /**
     * React to the feed validation failing
     * @private
     */
    markInvalid: function(){
        this.down('button[text=Add Feed]').enable();
        this.form.setLoading(false);
        this.form.getComponent('feed').markInvalid('The URL specified is not a valid RSS2 feed.');
    }
});