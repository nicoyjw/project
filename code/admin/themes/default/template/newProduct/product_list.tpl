<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/newProduct/productList.js"></script>
<script type="text/javascript" src="js/celltooltip.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var tasks=[<!--{$tasks}-->];
	var users=[<!--{$users}-->];
	var goods_status = [<!--{$goods_audit_status}-->];
	var goods_cat = [<!--{$goods_cat}-->];
	var goods_brand = [<!--{$goods_brand}-->];
	var action_type = '<!--{$action_type}-->';
	goods_status.push(['-1','All Status']);
	goods_cat.push(['0','所有分类']);
	goods_brand.push(['0','所有品牌']);
	var viewport = new Ext.ux.GoodsView({
		headers:['goods_id','sku','名称','品牌','所属分类','产品状态','产品图片状态','产品描述状态','录入人','录入时间'],
        fields: ['goods_id','sku','goods_name','brand_id','cat_id','status','img_status','des_status','add_user','add_time','type','assign_status','user_id','times'],
		action_type:parseInt(action_type),
		tasks:tasks,
		users:users,
		arrdata:[goods_status,goods_cat,goods_brand],
		listURL:'index.php?model=newProduct&action=list',
		catTreeURL:'index.php?model=goods&action=getcattree&com=1',
		windowTitle:'高级搜索',
		windowWidth:320,
		windowHeight:200,
		pagesize:15
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->