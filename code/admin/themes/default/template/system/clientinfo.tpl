<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	loadend();
});
function CheckForm(){
		Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
		Ext.Ajax.request({
			url:'index.php?model=user&action=saveclentinfo',
            method: 'post',
			success:function(response){
				var res = Ext.decode(response.responseText);
				Ext.example.msg('提示',res.msg);
				Ext.getBody().unmask();
				},
			failure:function(response){
				Ext.example.msg('警告','失败');
				Ext.getBody().unmask();
				},
			params:{
				cn_name:Ext.get('cn_name').getValue(),
				frist_name_en:Ext.get('frist_name_en').getValue(),
				last_name_en:Ext.get('last_name_en').getValue(),
				sex:Ext.get('sex').getValue(),
				address:Ext.get('address').getValue(),
				address2:Ext.get('address2').getValue(),
				cart_no:Ext.get('cart_no').getValue(),
				sent_email:Ext.getDom('sent_email').innerHTML,
				m_phone_no:Ext.get('m_phone_no').getValue(),
				phone:Ext.get('phone').getValue(),
				zipcode:Ext.get('zipcode').getValue(),
				blog_address:Ext.get('blog_address').getValue(),
				qq_no:Ext.get('qq_no').getValue(),
				msn_no:Ext.get('msn_no').getValue(),
				info_note:Ext.get('info_note').getValue(),
			}		 
		});
}

</script>
<style type="text/css">
html, body, div, dl, dt, dd, ul, ol, li, pre, code, form, fieldset, legend, input, button, textarea, p, blockquote, th, td{font-family:arial,宋体,sans-serif;font-size:13px;margin:0;padding:0;font-weight:normal}
.memberMyInfo{height:230px; padding-top:10px}
.memberMyInfo table{ padding:5px;}
.memberMyInfo table tr td{ height:30px; vertical-align:middle}
.memberMyInfoAdd tr th,.memberMyInfoAdd tr td{padding:3px 0 3px 20px; color:#5b5c5c}
.memberMyInfoAdd tr th{text-align:right}
.memberMyInfoAdd tr th span{color:#ff6300}
.memberMyInfoAdd tr td span{color:#ff6300}
.memberMyInfoAdd tr td img{ vertical-align:middle;}
.memberMyInfoAdd textarea{width:305px; height:40px;}
.font_title{color:#5b5c5c;}
.font_content{color:#5b5c5c;}

.memberMyInfoAdd tr td span.memberAddressCountry{height:18px;line-height:18px;border:1px solid #DAE1E9;display:inline-block;width:185px;background:url(../images/member/address/rr.gif) 185px 1px no-repeat;padding-right:20px;cursor:pointer;color:#666}
.memberCommonInput{background: url("themes/default/images/inputBg.jpg") repeat-x scroll 0 0 transparent;border: 1px solid #DAE1E9;
    height: 20px;line-height: 20px;  vertical-align:middle; padding:1px 5px;}
.memberCommonBtnLeft{background: url("themes/default/images/linkBtnLeft.jpg") left center no-repeat;padding-left:2px;cursor:pointer;display: inline-block;height: 21px;}
.memberCommonBtnRight{background: url("themes/default/images/linkBtnRight.jpg") right center no-repeat;padding-right:2px;cursor:pointer;display: inline-block;height: 21px;}
.memberCommonBtn{background: url("themes/default/images/linkBtn.jpg") repeat-x;color: #522201;display: inline-block;
	font-weight: bold;height: 21px;line-height: 21px;text-align: center; padding:0 10px;cursor:pointer}
</style>
    <div class="memberMyInfo" style="height:auto;">
        <table id="table_cn" width="100%" border="0" cellspacing="0" cellpadding="0" class="memberMyInfoAdd" style="padding-bottom:10px;">
        <tr>
            <th style="width:190px;" >您的用户名：</th>
            <td><label id="ruNickname"/><!--{$smarty.session.admin_name}--></td>
        </tr>         
         <tr>
            <th style="width:190px;" >您的中文姓名：</th>
            <td><input type="text" id="cn_name" class="memberCommonInput" value="<!--{$user.cn_name}-->" /><span style=" color:#ff0000">*</span></td>
        </tr>
        <tr>
            <th style="width:190px;" >您的英文姓名：</th>
            <td><input type="text" id="frist_name_en" class="memberCommonInput" value="<!--{$user.frist_name_en}-->" /><input type="text" id="last_name_en" class="memberCommonInput" value="<!--{$user.last_name_en}-->" />&nbsp;<span style=" color:#ff0000">*</span></td>
        </tr>
         <tr>
            <th style="width:190px;" >您的性别：</th>
            <td><select id="sex" class="memberCommonInput" >
            		<option value="1" <!--{if $user.sex eq 1}--> selected="selected" <!--{/if}--> >男</option>
                    <option value="2" <!--{if $user.sex eq 2}--> selected="selected" <!--{/if}--> >女</option>
                </select>
            </td>
        </tr>
        	
        </tr>
         <tr>
            <th style="width:190px;" >联系地址：</th>
            <td><input type="text" id="address" maxlength="200" style=" width:305px;" class="memberCommonInput" value="<!--{$user.address}-->"  /><span style=" color:#ff0000">*</span><br />
            </td>
        </tr>
        <tr>
            <th style="width:190px;" ></th>
            <td><input type="text" id="address2"  maxlength="200" style=" width:305px;" class="memberCommonInput" value="<!--{$user.address2}-->"/></td>
        </tr>
         <tr>
            <th style="width:190px;" >身份证号：</th>
            <td><input type="text" id="cart_no" maxlength="18" class="memberCommonInput" value="<!--{$user.cart_no}-->"  /><a href="#">输入后不可修改！</a></td>
        </tr>
        <tr>
            <th style="width:190px;" >接收通知邮箱：</th>
            <td><label id="sent_email" style="color:Blue;"><!--{$user.sent_email}--></label>
            <a id="linkEmail" style="margin-left:20px;margin-right:20px;color:Blue;cursor:pointer;" onclick="openemailwin()">修改</a>
            <!--{if $user.email_is_checking eq 0}-->
                <label id="isValid" style="margin-right:20px;color:Red;">未验证</label>
                <span id="validButton"><span class="memberCommonBtnLeft"><span class="memberCommonBtnRight">
                <a id="a1" style="cursor:pointer;" onclick="validemail();" class="memberCommonBtn">立即验证</a></span></span></span><input type="hidden" id="random" value="" />
            <!--{else}-->
            	<label id="isValid" style="margin-right:20px;color:Red;">已验证</label>
            
            <!--{/if}-->
<script type="text/javascript">
function validemail(){
	Ext.Msg.confirm('提示', '确定要验证此邮箱吗?', function(btn) {
		if (btn == 'yes') {
			Ext.getBody().mask("正在发送验证邮件..请稍作等候...","x-mask-loading");
			var email = Ext.getDom('sent_email').innerHTML;
			Ext.Ajax.request({
			   url: 'index.php?model=user&action=validemail&email='+email,
				success:function(response,opts){
					Ext.getBody().unmask();
					var res = Ext.decode(response.responseText);
						if(res.success){
							Ext.Msg.alert('INFO',res.msg);
						}else{
							Ext.Msg.alert('ERROR',res.msg);
						}						
				},
				failure:function(response){
					Ext.getBody().unmask();
					Ext.example.msg('警告','验证失败');
				}
			});
		}
	},this)
}
function openemailwin(){
	var win = Ext.getCmp('modeemail');
	if(!win){
		var oldmail = Ext.getDom('sent_email').innerHTML;
		var emailform = Ext.create('Ext.form.Panel',{
			id:'modeemailform',
			buttonAlign:'center',
			align:'center',
			padding:5,
			modal:false,
			frame:false,
			border:false,
			items: [
				{	xtype:'textfield',
					width:250,
					id:'newemail',
					labelWidth:45,
					fieldLabel: '邮箱',
					value:oldmail
				}
			],
	
			buttons: [{
				text: '确认',
				handler:function(){
					var emailstr = Ext.getCmp('newemail').getValue();
					Ext.getDom('sent_email').innerHTML = emailstr;
					Ext.getCmp('newemail').setValue('');
					win.hide();
				}
			}]
		})
		win = Ext.create('Ext.window.Window',{
			id:'modeemail',
			title:'修改接收邮箱',
			layout:'fit',
			width:300,
			height:150,
			bodyStyle:'padding:5px 5px 0',
			closeAction:'destroy',
			collapsible:true,
			constrainHeader:true,
			modal:false,
			plain: false,
			items:[emailform]
		});
	}
	win.show();
}

</script>
            </td>
        </tr>
         <tr>
            <th style="width:190px;" >手机号码：</th>
            <td><input type="text" id="m_phone_no" maxlength="15" class="memberCommonInput" value="<!--{$user.m_phone_no}-->"  /><span style=" color:#ff0000">*</span></td>
        </tr>
        <tr>
            <th style="width:190px;" >固定电话：</th>
            <td><input type="text" id="phone" maxlength="22" class="memberCommonInput" value="<!--{$user.phone}-->"  /></td>
        </tr>
        <tr>
            <th style="width:190px;" >邮政编码：</th>
            <td><input type="text" id="zipcode" maxlength="6" class="memberCommonInput" value="<!--{$user.zipcode}-->"  /><span style=" color:#ff0000">*</span></td>
        </tr>
        <tr>
            <th style="width:190px;" >个人博客：</th>
            <td><input type="text" id="blog_address" maxlength="60" class="memberCommonInput" value="<!--{$user.blog_address}-->"  /></td>
        </tr>
        <tr>
            <th style="width:190px;" >腾讯QQ：</th>
            <td><input type="text" id="qq_no" maxlength="20" class="memberCommonInput" value="<!--{$user.qq_no}-->"  /></td>
        </tr>
        <tr>
            <th style="width:190px;" >M&nbsp;S&nbsp;&nbsp;N：</th>
            <td><input type="text" id="msn_no" maxlength="60" class="memberCommonInput" value="<!--{$user.msn_no}-->" /></td>
        </tr>
        <tr>
            <th style="width:190px;" >备注信息：</th>
            <td><textarea id="info_note"  rows="6" cols="60" class="memberCommonInput" value="<!--{$user.info_note}-->" ></textarea></td>
        </tr>
        <tr>
            <th>&nbsp;</th>
            <td height="40">
            <span class="memberCommonBtnLeft"><span class="memberCommonBtnRight"><a id="a_submitinfo" style="cursor:pointer;" onclick="CheckForm();" class="memberCommonBtn">确 定</a></span></span>
            </td>
        </tr>
        </table>
    </div>


<!--{include file="footer.tpl"}-->