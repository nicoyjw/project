<!--{include file="header.tpl"}-->
    <style type="text/css">
        body .x-panel {
            margin:0 0 20px 0;
        }
    </style>
<script type="text/javascript" src="js/normalgrid.js"></script>
<script type="text/javascript" src="js/system/ebayaccount.js"></script>
    <script type="text/javascript">
Ext.onReady(function() {
	Ext.QuickTips.init();
	var amazon_site = [<!--{$amazon_site}-->];
    var PaypalRootGrid = Ext.create('Ext.ux.PaypalRootGrid',{
        title: 'Paypal主账号列表',
		id:'PaypalRootGrid',
		columnWidth:.99,
		headers:['序号','主账号','username','password','signature'],
        fields: ['p_root_id','paypal_account', 'username','password','signature'],
		width:600,
		frame:true,
		saveURL:'index.php?model=ebayaccount&action=paypalrootupdate',
		delURL:'index.php?model=ebayaccount&action=Paypalrootdel',
		listURL:'index.php?model=ebayaccount&action=paypalrootList',
		windowTitle:'Paypal Root Account',
		windowWidth:320,
		windowHeight:300
    });	
    var EbayGrid = Ext.create('Ext.ux.EbayGrid',{
		id:'EbayGrid',
        title: '账号列表',
		headers:['序号','Ebay账号','devID','appID/MCID','certID/MKID','userToken','DevUserID','APIPassword','SellerUserID','Ebay分类ID'],
        fields: ['id','account_name','devID','appID','certID','userToken','APIDevUserID','APIPassword','APISellerUserID','cat_id'],
		width:600,
		style:'margin-right:50px;',
		columnWidth:.99,
		frame:true,
		saveURL:'index.php?model=ebayaccount&action=Update',
		delURL:'index.php?model=ebayaccount&action=delete',
		listURL:'index.php?model=ebayaccount&action=List&type=1',
		windowTitle:'Ebay Account',
		windowWidth:350,
		windowHeight:650
    });
    var AmzGrid = Ext.create('Ext.ux.AmzGrid',{
		id:'AmzGrid',
        title: '账号列表',
		headers:['序号','站点','Amazon账号','MCID','MKID','DevUserID','APIPassword','SellerUserID'],
	    fields: ['id','site','account_name','appID','certID','APIDevUserID','APIPassword','APISellerUserID'],
		width:600,
		frame:true,
		sitelist:amazon_site,
		saveURL:'index.php?model=ebayaccount&action=Update',
		delURL:'index.php?model=ebayaccount&action=delete',
		listURL:'index.php?model=ebayaccount&action=List&type=2',
		windowTitle:'Amazon Account',
		windowWidth:350,
		windowHeight:280
    });
    var EzGrid = Ext.create('Ext.ux.EzGrid',{
		id:'ezGrid',
        title: '账号列表',
		headers:['序号','普通账号','DevUserID','APIPassword','SellerUserID'],
	 	fields: ['id','account_name','APIDevUserID','APIPassword','APISellerUserID'],
		width:600,
		frame:true,
		pagesize:15,
		saveURL:'index.php?model=ebayaccount&action=Update',
		delURL:'index.php?model=ebayaccount&action=delete',
		listURL:'index.php?model=ebayaccount&action=List&type=0',
		windowTitle:'Account',
		windowWidth:350,
		windowHeight:150
    });
    var TbGrid = Ext.create('Ext.ux.TbGrid',{
		id:'TbGrid',
        title: '淘宝账号列表',
		headers:['序号','淘宝账号','devID','appID/MCID','certID/MKID'],
        fields: ['id','account_name','devID','appID','certID'],
		width:600,
		frame:true,
		saveURL:'index.php?model=ebayaccount&action=Update',
		delURL:'index.php?model=ebayaccount&action=delete',
		listURL:'index.php?model=ebayaccount&action=List&type=3',
		windowTitle:'Taobao Account',
		windowWidth:350,
		windowHeight:150
    });
    var ZcGrid = Ext.create('Ext.ux.ZcGrid',{
        id:'ZcGrid',
        title: 'Zencart账号列表',
        headers:['序号','Zencart账号','网址','devID','appID/MCID','certID/MKID'],
        fields: ['id','account_name','url','devID','appID','certID'],
        width:600,
        frame:true,
        saveURL:'index.php?model=ebayaccount&action=Update',
        delURL:'index.php?model=ebayaccount&action=delete',
        listURL:'index.php?model=ebayaccount&action=List&type=4',
        windowTitle:'Zencart Account',
        windowWidth:350,
        windowHeight:200
    });
    var mgGrid = Ext.create('Ext.ux.MgGrid',{
		id:'MgGrid',
        title: 'Magento账号列表',
		headers:['序号','Magento账号','网址','apiAccount','apiPassword'],
        fields: ['id','account_name','url','APIDevUserID','APIPassword'],
		width:600,
		frame:true,
		saveURL:'index.php?model=ebayaccount&action=Update',
		delURL:'index.php?model=ebayaccount&action=delete',
		listURL:'index.php?model=ebayaccount&action=List&type=5',
		windowTitle:'Magento Account',
		windowWidth:350,
		windowHeight:300
    });
    var AliGrid = Ext.create('Ext.ux.AliGrid',{
        id:'AliGrid',
        title: '速卖通账号列表',
        headers:['序号','速卖通账号','access_token','refresh_token','APIDevUserID','APIPassword'],
        fields: ['id','account_name','ac_token','re_token','APIDevUserID','APIPassword'],
        width:600,
        frame:true,
        saveURL:'index.php?model=ebayaccount&action=Update',
        delURL:'index.php?model=ebayaccount&action=delete',
        listURL:'index.php?model=ebayaccount&action=List&type=6',
        windowTitle:'Ali Account',
        windowWidth:350,
        windowHeight:180
    });
	var DHGrid = Ext.create('Ext.ux.DHGrid',{
		id:'DHGrid',
        title: '账号列表',
		headers:['序号','速卖通账号','access_token','refresh_token'],
        fields: ['id','account_name','ac_token','re_token'],
		width:600,
		frame:true,
		saveURL:'index.php?model=ebayaccount&action=Update',
		delURL:'index.php?model=ebayaccount&action=delete',
		listURL:'index.php?model=ebayaccount&action=List&type=7',
		windowTitle:'DHgate Account',
		windowWidth:350,
		windowHeight:220
    });
	var tab = new Ext.TabPanel({
        activeTab: 0,
		deferredRender:false,
        defaults:{autoScroll: true,autoHeight:true},
        items:[{
			    id:'tab1',
                title: 'Ebay账号',
				defaultType: 'textfield',
				autoScroll:true,
				padding:10,
				layout:'column',
                items:[EbayGrid,PaypalRootGrid]
				},
				{
			    id:'tab2',
                title: 'Amazon账号',
				defaultType: 'textfield',
				autoScroll:true,
                items:[AmzGrid]
				},
                {
                id:'tab7',
                title: 'Aliexpress账号',
                defaultType: 'textfield',
                autoScroll:true,
                items:[AliGrid]
                },
                {
                id:'tab9',
                title: 'DHgate账号',
                defaultType: 'textfield',
                autoScroll:true,
                items:[DHGrid]
                },
				{
			    id:'tab3',
                title: 'Taobao账号',
				defaultType: 'textfield',
				autoScroll:true,
                items:[TbGrid]
				},
				{
			    id:'tab4',
                title: '普通账号',
				defaultType: 'textfield',
				autoScroll:true,
                items:[EzGrid]
				},
				{
			    id:'tab5',
                title: 'zencart账号',
				defaultType: 'textfield',
				autoScroll:true,
                items:[ZcGrid]
				},
				{
			    id:'tab6',
                title: 'magento账号',
				defaultType: 'textfield',
				autoScroll:true,
				disabled:false,
                items:[mgGrid]
				},
				{
			    id:'tab8',
                title: 'OpenCart账号',
				defaultType: 'textfield',
				autoScroll:true,
				disabled:true,
                items:[]
				}
				]
	});
	tab.render(document.body);
	loadend();
});
    </script>
<!--{include file="footer.tpl"}-->
