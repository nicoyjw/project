<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function() {
Ext.QuickTips.init(); //初始化信息提示功能 
	var sfrom =new  Ext.FormPanel({
			labelWidth: 30,
			url:'index.php?model=news&action=saveRevert&id=<!--{$info.id}-->',
			frame:false,
			id:'sfrom',
			border:false,
			applyTo: 'sfrom', 
			items: [
				{
					fieldLabel: '回复信息',
					xtype:'htmleditor',
					height:120,
					id:'content',
					name: 'content'
				},{
					border:false,
					layout:'column',
					items: [{
								xtype:'checkbox',
								id:'showType',
								name: 'showType',
								width:20,
								style:'margin-top:3px'
							},{
								text: '回复只作者可见',
								xtype:'label'
							},{
								xtype:'button',
								width:30,
								style:'margin-left:20px',
								text: '回复',
								handler: function() {
									if(sfrom.getForm().findField('content').getValue()!=''){
										if(sfrom.getForm().isValid()){
											sfrom.getForm().submit({
												success:function(form,action){
													if(action.result.success==true){
														  alert(action.result.msg);
													 }
													 sfrom.getForm().reset();
												}
											});						
										}
									}else
									alert('请输入回复的内容！');
								}
						}]
				}
			]})//end_form
		});
</script>
<center>
    <!--网站正文开始-->
    <div id="center" style="width:95%; height:100%;">
    <br /><br /><br />
        <h1><span style="font-size:20px"><!--标题--><!--{$info.news_title}--></span></h1><br />
        <div class="article_info" style="width:100%" align="right" >
                作者：<!--{$info.create_user_id}-->&nbsp;&nbsp;&nbsp;&nbsp;发布时间：<!--{$info.create_time|date_format:'%Y-%m-%d %H:%M:%S'}-->
        </div>
        <!--网站内容开始--><br />
        <div id="articleContnet"  style="width:100%;" align="left">
            <p><strong>&nbsp;&nbsp;&nbsp;&nbsp;<!--{$info.content}--></strong></p>
        </div>
        <!--网站内容结束-->
        <br />
        <br />
        <br />
    	<div id="sfrom" style="width:100%;"  align="left"><!--回复编辑器-->	</div>
        <br />
        <div style="width:80%;"  align="left">
         	<!--回复列表-->
            <!--{foreach item=revert from=$revertList}-->
            <!--{$revert.user_name}-->于<!--{$revert.time|date_format:'%Y-%m-%d %H:%M:%S'}-->发表:<br />
            <!--{$revert.content}--><hr />
			<!--{/foreach}-->
   		</div>
    </div>
</center>