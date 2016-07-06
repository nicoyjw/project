<!--{include file="header.tpl"}-->
<link rel="stylesheet" type="text/css" href="themes/default/css/uploadgoods.css"/>
<style type="text/css">
body {
	font:normal 12px verdana;
	margin:0;
	padding:0;
	border:0 none;
	height:100%;
	background-color:#FFF;
}
</style>
 <script type="text/javascript">
function afterselect(k,v){
	document.getElementById('cat_name').setAttribute('value',v);
	document.getElementById('cat_id').setAttribute('value',k);
}
</script> 
<div class="module box">
    <div class="module-hd"><h2>发布产品</h2></div>
    <div class="box-content">
        <p class="pc-selected-category-banner">
            &nbsp;&nbsp;<input type="text" placeholder="请选择分类" id="cat_name" /><input type="hidden" value="请选择分类" id="cat_id" />
            <button onclick="getCategoryFormTree('index.php?model=aliexpress&action=getcattree&com=0',0,afterselect);"
            type="button">选择类目</button>&nbsp;&nbsp;</p>
    </div>
</div>
<div class="module">
    <div class="module-hd"><h2>1.产品基本信息</h2></div>
    <div class="module-content clearfix">
        <label class="module-name"><a name="product-property">&nbsp;</a>产品属性：</label>
        <div class="module-body">
            <div id="post-property" class="post-property">
            <table class="sys-attr">
                <tbody>
                    <tr>
                        <td class="attr-name-field" style="font-size:12px" >
                            <label>
                                   <span id="attribute_frame">您还没有选择分类</span>
                            </label>
                        </td>
                        <td class="attr-value-field" style="font-size:12px" >
                            
                        </td>
                    </tr>
                </tbody>
            </table>
                <div id="more-post-property-content-box" style="display: none;">
                </div>
                <div id="more-post-property-button-box" style="display: none;">
                </div>
                <div id="custom-attr" class="custom-attr">
                    <input type="hidden" id="pp-product-property">
                    <div id="add-attr-line" class="add-attr-line">
                        <a href="javascript:void(0);" class="btn-add-attr" id="btn-add-attr">添加自定义属性</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="module-content" id="pt">
        <label class="module-name"><a name="product-title">&nbsp;</a><span class="required">产品标题：</span></label>
        <input type="text" size="128" value="<!--{$goodinfo.goods_name}-->" id="pt-title" name="">
    </div>
    <div class="module-content  module-content-hastip" id="pk">
        <label class="module-name"><a name="product-keyword">&nbsp;</a><span class="required">产品关键词：</span></label>
        <input type="text" size="30" placeholder="关键词" name="_fmw.w._0.k" id="pk-primary-keyword">
        <input type="text" size="30" placeholder="更多关键词1" name="_fmw.w._0.k" id="pk-primary-keyword">
        <input type="text" size="30" placeholder="更多关键词2" name="_fmw.w._0.k" id="pk-primary-keyword">
    </div>
    <div id="sku" class="module">
        <div class="module-content m-unit-select clearfix">
            <label class="module-name"><span class="required">最小计量单位：</span></label>
            <select name="_fmw.w._0.prod" id="unit-select">
                <option value="100000000">袋(bag/bags)</option><option value="100000001">桶(barrel/barrels)</option><option value="100000002">蒲式耳(bushel/bushels)</option><option value="100078580">箱(carton)</option><option value="100078581">厘米(centimeter)</option><option value="100000003">立方米(cubic meter)</option><option value="100000004">打(dozen)</option><option value="100078584">英尺(feet)</option><option value="100000005">加仑(gallon)</option><option value="100000006">克(gram)</option><option value="100078587">英寸(inch)</option><option value="100000007">千克(kilogram)</option><option value="100078589">千升(kiloliter)</option><option value="100000008">千米(kilometer)</option><option value="100078559">升(liter/liters)</option><option value="100000009">英吨(long ton)</option><option value="100000010">米(meter)</option><option value="100000011">公吨(metric ton)</option><option value="100078560">毫克(milligram)</option><option value="100078596">毫升(milliliter)</option><option value="100078597">毫米(millimeter)</option><option value="100000012">盎司(ounce)</option><option value="100000014">包(pack/packs)</option><option value="100000013">双(pair)</option><option value="100000015"selected="">件/个(piece/pieces)</option><option value="100000016">磅(pound)</option><option value="100078603">夸脱(quart)</option><option value="100000017">套(set/sets)</option><option value="100000018">美吨(short ton)</option><option value="100078606">平方英尺(square feet)</option><option value="100078607">平方英寸(square inch)</option><option value="100000019">平方米(square meter)</option><option value="100078609">平方码(square yard)</option><option value="100000020">吨(ton)</option><option value="100078558">码(yard/yards)</option>
            </select>
        </div>
        <div class="module-content m-sell-type">
		<label class="module-name">
			<span class="required">销售方式：</span>
		</label>
        <div class="module-body">
            <input name="_fmw.w._0.pa" id="sell-by-unit" value="sell_by_piece" checked="checked" type="radio">
            <label for="sell-by-unit">按<span id="single-unit">磅 (pound)</span>出售</label>
            <input name="_fmw.w._0.pa" id="sell-by-pack" value="sell_by_lot" type="radio">
            <label for="sell-by-pack">打包出售</label>
            <span class="hidden" id="pack-info">
                <label class="prt0">每包</label>
                <input id="pack-num" name="_fmw.w._0.l" maxlength="6" size="6" value="" type="text">
                <label id="pp-unit">磅</label>
            </span>
        </div>
        <div class="module-error">
            <p id="pack-num-tip" class="err-tip"></p>
        </div>
	</div>
        <div class="module-content">
            <label class="module-name">
                <span class="required">
                    零售价：
                </span>
            </label>
            <span>
                US $
                <input id="spu-price" name="_fmw.w._0.sp" value="" maxlength="8" size="8"
                type="text">
                /
                <span id="spu-unit">
                    件
                </span>
                <span id="spu-price-hint" class="module-tip">根据您当前的佣金费率，您的实际收入约为US$
                    <span id="spu-price-income">
                        0
                    </span>
                </span>
            </span>
            <div class="module-error">
                <p id="spu-price-tip" class="err-tip">
                </p>
            </div>
        </div>
        <div class="module-content m-ws">
            <label class="module-name">
                <span>
                    批发价：
                </span>
            </label>
            <input id="ws-support" name="supportBulk" value="Y" type="checkbox" disabled="disabled" >
            <label class="ws-support-label" for="ws-support">
                支持
            </label>
            
        </div>
        <div class="module-content">
            <label class="module-name">
                <span class="required">
                    发货期：
                </span>
            </label>
            <a name="product-time">
                &nbsp;
            </a>
            <span>
                <input id="delivery-days" name="_fmw.w._0.spu" size="2" maxlength="2"
                value="" type="text">
                天
            </span>
            <span class="module-tip">
                买家付款成功到您完成发货，并填写完发货通知的时间。
            </span>
            <a href="#product-time" class="help-tip" tabindex="-1" title="发货期" rel="time">
            </a>
            <div class="module-error">
                <p id="delivery-days-tip" class="err-tip">
                </p>
            </div>
        </div>
        <div class="module-content">
            <label class="module-name">
                <span>
                    商品编码：
                </span>
            </label>
            <input id="spu-code" name="_fmw.w._0.spus" maxlength="20" value="" type="text">
            <span class="module-tip">
                用于您对商品的管理，不会对买家展示。
            </span>
            <div class="module-error">
                <p id="spu-code-tip" class="err-tip">
                </p>
            </div>
        </div>
    </div>
    <div class="module-content">
        <label class="module-name">
            <a name="product-breif-intro">
                &nbsp;
            </a>
            产品简要描述：
        </label>
        <div class="module-body">
            <textarea id="product-description" name="_fmw.w._0.sum" rows="20" cols="500">
            </textarea>
        </div>
    </div>
    <div class="module-content" id="pd">
        <label class="module-name">
            <span class="required">
                产品详细描述：
            </span>
        </label>
    </div>
    <div class="module" id="pp">
        <div class="module-hd">
            <h3 class="logistics-title">
                2.包装信息
            </h3>
            <p class="logistics-tip">
                合理填写包装信息，降低物流运费成本
            </p>
        </div>
        <div class="module-content">
            <label for="package-weight" class="module-name">
                <span class="required">
                    产品包装后的重量：
                </span>
            </label>
            <div class="module-body">
                <input type="text" value="" id="package-weight" name="_fmw.w._0.gro" class="ipt-item">
                <label>
                    公斤/
                    <span id="pp-unit-other">
                        件<span class="module-tip">
                暂不支持自定义计重
            </span>
                    </span>
                    <span class="err-tip" id="ppk-tips">
                    </span>
                </label>
            </div>
            <div id="module-weight-error" class="module-error">
                <p id="ps-weight-tips" class="err-tip msg-err">
                </p>
            </div>
            <div class="module-body pt10 clear" id="custom-pp-option">
                <!--<input type="checkbox" disalbed="disabled"  id="pp-chk-toggle-custom-weight" name="pp_ch">
                <label for="pp-chk-toggle-custom-weight" style="display: inline-block;height: 22px;line-height: 22px;vertical-align: top;">
                    自定义计重
                </label>-->
                <div id="custom-weight-area" class="custom-weight">
                    <div class="custom-weight-info">
                        <p>
                            <label>
                                买家购买
                            </label>
                            <input type="text" class="ipt-item" value="" name="_fmw.wh._0.p" tabindex="34"
                            id="pp-base-unit">
                            <label>
                                <span class="p-unit">
                                    件/个
                                </span>
                                以内，按单件产品重量计算运费。
                            </label>
                        </p>
                        <p>
                            <label>
                                在此基础上，买家每多买
                            </label>
                            <input type="text" class="ipt-item" value="" name="_fmw.wh._0.pa" tabindex="34"
                            id="pp-add-unit">
                            <label>
                                <span class="p-unit">
                                    件/个
                                </span>
                                ，重量增加
                            </label>
                            <input type="text" class="ipt-item" value="" name="_fmw.wh._0.pac" tabindex="34"
                            id="pp-add-weight">
                            kg。
                        </p>
                    </div>
                </div>
            </div>
            <div id="pp-err-module" class="module-error">
                <p class="err-tip" id="pp-tips-weight-base">
                </p>
                <p class="err-tip" id="pp-tips-weight-add">
                </p>
                <p class="err-tip" id="pp-tips-weight">
                </p>
            </div>
        </div>
        <div class="module-content">
            <label for="package-weight" class="module-name">
                <span class="required">
                    产品包装后的尺寸：
                </span>
            </label>
            <input type="text" placeholder="长" value="<!--{$goodinfo.l}-->" id="package-length" name="_fmw.w._0.pac"
            class="ipt-item">
            <label>
                x
            </label>
            <input type="text" placeholder="宽" value="<!--{$goodinfo.w}-->" id="package-width" name="_fmw.w._0.pack"
            class="ipt-item">
            <label>
                x
            </label>
            <input type="text" placeholder="高" value="<!--{$goodinfo.h}-->" id="package-height" name="_fmw.w._0.packa"
            class="ipt-item">
            <label>
                (单位：厘米,每
                <span class="p-unit">
                    件/个
                </span>
                <span id="ps-volume">
                    0
                </span>
                cm
                <sup>
                    3
                </sup>
                )
                <span class="module-tip" id="ps-tips">
                </span>
            </label>
        </div>
        <div class="module-content freight-count">
            <div style="display:none" class="board-notice" id="freight-display">
                <div id="freight-display-tip" style="">
                    物流公司会根据产品包装毛重和产品包装体积重两者的较高值来计算运费。根据您填写的产品包装尺寸，系统估算出您产品的体积重介于
                    <span id="freight_1">
                        0
                    </span>
                    公斤和
                    <span id="freight_2">
                        0
                    </span>
                    公斤之间，超过了产品包装毛重，因此，系统会根据您产品的体积重来计算运费。
                    <a rel="unit" href="#package-size" tabindex="-1" class="help-tip" title="包装信息">
                        包装信息
                    </a>
                </div>
                <input type="hidden" id="freight-price-demo-country" value="US">
                <input type="hidden" id="freight-price-demo-count" value="1">
                <input type="hidden" id="freight-price-demo-company" value="DHL">
                <input type="hidden" id="freight-price-demo-decount" value="0">
            </div>
        </div>
        <div id="pp-size-err-module" class="module-error">
            <p id="pp-tips" class="err-tip msg-err">
            </p>
            <p id="pp-tips-width" class="err-tip msg-err">
            </p>
            <p id="pp-tips-height" class="err-tip msg-err">
            </p>
        </div>
    </div>
    <div id="ps" class="module">
    <div class="module-hd">
        <h3>
            3. 物流设置
            <a name="product-freight">
                &nbsp;
            </a>
        </h3>
    </div>
    <div class="module-content">
        <a href="#" name="freightTemplateNewTip">
        </a>
        <label class="module-name">
            产品运费模板：
        </label>
        <div class="module-body logistics-body">
            <div>
                <input name="_fmw.w._0.fr" id="mf-new-template" rel="1000" value="new"
                type="radio">
                <label for="mf-new-template">
                    新手运费模版
                </label>
                <span class="freight-template-new-tip" style="color:#999999">
                    不熟悉国际物流可选择此模版。该模版已设置运费折扣信息，买家支付后您可直接发货。
                </span>
                
            </div>
            <div>
                <input name="_fmw.w._0.fr" id="mf-my-template" rel="1000" value="custom"
                style="float:left" type="radio">
                <label style="float:left" for="mf-my-template">
                    自定义运费模板
                </label>
                
                <!--<a target="#" id="ps-btn-manage-template" href="/wsproduct/freight/freightTemplateList.htm">管理运费模板</a><a href="#freightTemplateID" class="help-tip" rel="ship" title='运费模板'>运费模板帮助</a>-->
                <a id="mf-new-template-url" href="/wsproduct/freight/create_freight_template.htm"
                style="display:none">
                </a>
            </div>
            <p id="mf-pack-tips" class="board-alert mf-pack-tips" style="margin-top: 30px; display: none;">
                请先设置产品包装信息
                <a class="richinfoclass" href="#package-weight">
                    立即设置
                </a>
            </p>
            <div class="mf-freight-main" id="mf-freight-main" style="width: 100%; float: left; display: block;">
                <table style="display: none;" class="mf-freight-info" id="mf-freight-info">
                    <thead>
                        <tr>
                            <td>
                                <strong>
                                    发货运费参考:
                                </strong>
                                以
                                <strong>
                                    1
                                </strong>
                                <span class="unit-letter unit-letter-bag">
                                    件
                                </span>
                                为例，发往国家/地区
                                <label class="mf-country">
                                    <select name="country" id="mf-country">
                                        <optgroup>
                                            <option value="AL">
                                                Albania
                                            </option>
                                            <option value="AR">
                                                Argentina
                                            </option>
                                            <option value="AU">
                                                Australia
                                            </option>
                                            <option value="AT">
                                                Austria
                                            </option>
                                            <option value="BY">
                                                Belarus
                                            </option>
                                            <option value="BE">
                                                Belgium
                                            </option>
                                            <option value="BR">
                                                Brazil
                                            </option>
                                            <option value="BG">
                                                Bulgaria
                                            </option>
                                            <option value="CM">
                                                Cameroon
                                            </option>
                                            <option value="CA">
                                                Canada
                                            </option>
                                            <option value="CL">
                                                Chile
                                            </option>
                                            <option value="CO">
                                                Colombia
                                            </option>
                                            <option value="CY">
                                                Cyprus
                                            </option>
                                            <option value="CZ">
                                                Czech Republic
                                            </option>
                                            <option value="DK">
                                                Denmark
                                            </option>
                                            <option value="EG">
                                                Egypt
                                            </option>
                                            <option value="EE">
                                                Estonia
                                            </option>
                                            <option value="FI">
                                                Finland
                                            </option>
                                            <option value="FR">
                                                France
                                            </option>
                                            <option value="GE">
                                                Georgia
                                            </option>
                                            <option value="DE">
                                                Germany
                                            </option>
                                            <option value="GR">
                                                Greece
                                            </option>
                                            <option value="HK">
                                                Hong Kong
                                            </option>
                                            <option value="HU">
                                                Hungary
                                            </option>
                                            <option value="IN">
                                                India
                                            </option>
                                            <option value="ID">
                                                Indonesia
                                            </option>
                                            <option value="IE">
                                                Ireland
                                            </option>
                                            <option value="IL">
                                                Israel
                                            </option>
                                            <option value="IT">
                                                Italy
                                            </option>
                                            <option value="JP">
                                                Japan
                                            </option>
                                            <option value="KZ">
                                                Kazakhstan
                                            </option>
                                            <option value="LV">
                                                Latvia
                                            </option>
                                            <option value="LT">
                                                Lithuania
                                            </option>
                                            <option value="MY">
                                                Malaysia
                                            </option>
                                            <option value="MX">
                                                Mexico
                                            </option>
                                            <option value="NL">
                                                Netherlands
                                            </option>
                                            <option value="NZ">
                                                New Zealand
                                            </option>
                                            <option value="NG">
                                                Nigeria
                                            </option>
                                            <option value="NO">
                                                Norway
                                            </option>
                                            <option value="PE">
                                                Peru
                                            </option>
                                            <option value="PH">
                                                Philippines
                                            </option>
                                            <option value="PL">
                                                Poland
                                            </option>
                                            <option value="PT">
                                                Portugal
                                            </option>
                                            <option value="RO">
                                                Romania
                                            </option>
                                            <option value="RU">
                                                Russian Federation
                                            </option>
                                            <option value="SA">
                                                Saudi Arabia
                                            </option>
                                            <option value="SG">
                                                Singapore
                                            </option>
                                            <option value="SI">
                                                Slovenia
                                            </option>
                                            <option value="ZA">
                                                South Africa
                                            </option>
                                            <option value="KR">
                                                South Korea
                                            </option>
                                            <option value="ES">
                                                Spain
                                            </option>
                                            <option value="SE">
                                                Sweden
                                            </option>
                                            <option value="CH">
                                                Switzerland
                                            </option>
                                            <option value="TH">
                                                Thailand
                                            </option>
                                            <option value="TR">
                                                Turkey
                                            </option>
                                            <option value="UA">
                                                Ukraine
                                            </option>
                                            <option value="AE">
                                                United Arab Emirates
                                            </option>
                                            <option value="UK">
                                                United Kingdom
                                            </option>
                                            <option value="US" selected="selected">
                                                United States
                                            </option>
                                        </optgroup>
                                        <optgroup label="All Countries &amp; Territories (A to Z)">
                                            <option value="AF">
                                                Afghanistan
                                            </option>
                                            <option value="ALA">
                                                Aland Islands
                                            </option>
                                            <option value="AL">
                                                Albania
                                            </option>
                                            <option value="GBA">
                                                Alderney
                                            </option>
                                            <option value="DZ">
                                                Algeria
                                            </option>
                                            <option value="AS">
                                                American Samoa
                                            </option>
                                            <option value="AD">
                                                Andorra
                                            </option>
                                            <option value="AO">
                                                Angola
                                            </option>
                                            <option value="AI">
                                                Anguilla
                                            </option>
                                            <option value="AQ">
                                                Antarctica
                                            </option>
                                            <option value="AG">
                                                Antigua and Barbuda
                                            </option>
                                            <option value="AR">
                                                Argentina
                                            </option>
                                            <option value="AM">
                                                Armenia
                                            </option>
                                            <option value="AW">
                                                Aruba
                                            </option>
                                            <option value="ASC">
                                                Ascension Island
                                            </option>
                                            <option value="AU">
                                                Australia
                                            </option>
                                            <option value="AT">
                                                Austria
                                            </option>
                                            <option value="AZ">
                                                Azerbaijan
                                            </option>
                                            <option value="BS">
                                                Bahamas
                                            </option>
                                            <option value="BH">
                                                Bahrain
                                            </option>
                                            <option value="BD">
                                                Bangladesh
                                            </option>
                                            <option value="BB">
                                                Barbados
                                            </option>
                                            <option value="BY">
                                                Belarus
                                            </option>
                                            <option value="BE">
                                                Belgium
                                            </option>
                                            <option value="BZ">
                                                Belize
                                            </option>
                                            <option value="BJ">
                                                Benin
                                            </option>
                                            <option value="BM">
                                                Bermuda
                                            </option>
                                            <option value="BT">
                                                Bhutan
                                            </option>
                                            <option value="BO">
                                                Bolivia
                                            </option>
                                            <option value="BA">
                                                Bosnia and Herzegovina
                                            </option>
                                            <option value="BW">
                                                Botswana
                                            </option>
                                            <option value="BV">
                                                Bouvet Island
                                            </option>
                                            <option value="BR">
                                                Brazil
                                            </option>
                                            <option value="IO">
                                                British Indian Ocean Territory
                                            </option>
                                            <option value="BN">
                                                Brunei Darussalam
                                            </option>
                                            <option value="BG">
                                                Bulgaria
                                            </option>
                                            <option value="BF">
                                                Burkina Faso
                                            </option>
                                            <option value="BI">
                                                Burundi
                                            </option>
                                            <option value="KH">
                                                Cambodia
                                            </option>
                                            <option value="CM">
                                                Cameroon
                                            </option>
                                            <option value="CA">
                                                Canada
                                            </option>
                                            <option value="CV">
                                                Cape Verde
                                            </option>
                                            <option value="KY">
                                                Cayman Islands
                                            </option>
                                            <option value="CF">
                                                Central African Republic
                                            </option>
                                            <option value="TD">
                                                Chad
                                            </option>
                                            <option value="CL">
                                                Chile
                                            </option>
                                            <option value="CN">
                                                China (Mainland)
                                            </option>
                                            <option value="CX">
                                                Christmas Island
                                            </option>
                                            <option value="CC">
                                                Cocos (Keeling) Islands
                                            </option>
                                            <option value="CO">
                                                Colombia
                                            </option>
                                            <option value="KM">
                                                Comoros
                                            </option>
                                            <option value="ZR">
                                                Congo, The Democratic Republic Of The
                                            </option>
                                            <option value="CG">
                                                Congo, The Republic of Congo
                                            </option>
                                            <option value="CK">
                                                Cook Islands
                                            </option>
                                            <option value="CR">
                                                Costa Rica
                                            </option>
                                            <option value="CI">
                                                Cote D'Ivoire
                                            </option>
                                            <option value="HR">
                                                Croatia (local name: Hrvatska)
                                            </option>
                                            <option value="CU">
                                                Cuba
                                            </option>
                                            <option value="CY">
                                                Cyprus
                                            </option>
                                            <option value="CZ">
                                                Czech Republic
                                            </option>
                                            <option value="DK">
                                                Denmark
                                            </option>
                                            <option value="DJ">
                                                Djibouti
                                            </option>
                                            <option value="DM">
                                                Dominica
                                            </option>
                                            <option value="DO">
                                                Dominican Republic
                                            </option>
                                            <option value="TP">
                                                East Timor
                                            </option>
                                            <option value="EC">
                                                Ecuador
                                            </option>
                                            <option value="EG">
                                                Egypt
                                            </option>
                                            <option value="SV">
                                                El Salvador
                                            </option>
                                            <option value="GQ">
                                                Equatorial Guinea
                                            </option>
                                            <option value="ER">
                                                Eritrea
                                            </option>
                                            <option value="EE">
                                                Estonia
                                            </option>
                                            <option value="ET">
                                                Ethiopia
                                            </option>
                                            <option value="FK">
                                                Falkland Islands (Malvinas)
                                            </option>
                                            <option value="FO">
                                                Faroe Islands
                                            </option>
                                            <option value="FJ">
                                                Fiji
                                            </option>
                                            <option value="FI">
                                                Finland
                                            </option>
                                            <option value="FR">
                                                France
                                            </option>
                                            <option value="FX">
                                                France Metropolitan
                                            </option>
                                            <option value="GF">
                                                French Guiana
                                            </option>
                                            <option value="PF">
                                                French Polynesia
                                            </option>
                                            <option value="TF">
                                                French Southern Territories
                                            </option>
                                            <option value="GA">
                                                Gabon
                                            </option>
                                            <option value="GM">
                                                Gambia
                                            </option>
                                            <option value="GE">
                                                Georgia
                                            </option>
                                            <option value="DE">
                                                Germany
                                            </option>
                                            <option value="GH">
                                                Ghana
                                            </option>
                                            <option value="GI">
                                                Gibraltar
                                            </option>
                                            <option value="GR">
                                                Greece
                                            </option>
                                            <option value="GL">
                                                Greenland
                                            </option>
                                            <option value="GD">
                                                Grenada
                                            </option>
                                            <option value="GP">
                                                Guadeloupe
                                            </option>
                                            <option value="GU">
                                                Guam
                                            </option>
                                            <option value="GT">
                                                Guatemala
                                            </option>
                                            <option value="GGY">
                                                Guernsey
                                            </option>
                                            <option value="GN">
                                                Guinea
                                            </option>
                                            <option value="GW">
                                                Guinea-Bissau
                                            </option>
                                            <option value="GY">
                                                Guyana
                                            </option>
                                            <option value="HT">
                                                Haiti
                                            </option>
                                            <option value="HM">
                                                Heard and Mc Donald Islands
                                            </option>
                                            <option value="HN">
                                                Honduras
                                            </option>
                                            <option value="HK">
                                                Hong Kong
                                            </option>
                                            <option value="HU">
                                                Hungary
                                            </option>
                                            <option value="IS">
                                                Iceland
                                            </option>
                                            <option value="IN">
                                                India
                                            </option>
                                            <option value="ID">
                                                Indonesia
                                            </option>
                                            <option value="IR">
                                                Iran (Islamic Republic of)
                                            </option>
                                            <option value="IQ">
                                                Iraq
                                            </option>
                                            <option value="IE">
                                                Ireland
                                            </option>
                                            <option value="IM">
                                                Isle of Man
                                            </option>
                                            <option value="IL">
                                                Israel
                                            </option>
                                            <option value="IT">
                                                Italy
                                            </option>
                                            <option value="JM">
                                                Jamaica
                                            </option>
                                            <option value="JP">
                                                Japan
                                            </option>
                                            <option value="JEY">
                                                Jersey
                                            </option>
                                            <option value="JO">
                                                Jordan
                                            </option>
                                            <option value="KZ">
                                                Kazakhstan
                                            </option>
                                            <option value="KE">
                                                Kenya
                                            </option>
                                            <option value="KI">
                                                Kiribati
                                            </option>
                                            <option value="KS">
                                                Kosovo
                                            </option>
                                            <option value="KW">
                                                Kuwait
                                            </option>
                                            <option value="KG">
                                                Kyrgyzstan
                                            </option>
                                            <option value="LA">
                                                Lao People's Democratic Republic
                                            </option>
                                            <option value="LV">
                                                Latvia
                                            </option>
                                            <option value="LB">
                                                Lebanon
                                            </option>
                                            <option value="LS">
                                                Lesotho
                                            </option>
                                            <option value="LR">
                                                Liberia
                                            </option>
                                            <option value="LY">
                                                Libya
                                            </option>
                                            <option value="LI">
                                                Liechtenstein
                                            </option>
                                            <option value="LT">
                                                Lithuania
                                            </option>
                                            <option value="LU">
                                                Luxembourg
                                            </option>
                                            <option value="MO">
                                                Macau
                                            </option>
                                            <option value="MK">
                                                Macedonia
                                            </option>
                                            <option value="MG">
                                                Madagascar
                                            </option>
                                            <option value="MW">
                                                Malawi
                                            </option>
                                            <option value="MY">
                                                Malaysia
                                            </option>
                                            <option value="MV">
                                                Maldives
                                            </option>
                                            <option value="ML">
                                                Mali
                                            </option>
                                            <option value="MT">
                                                Malta
                                            </option>
                                            <option value="MH">
                                                Marshall Islands
                                            </option>
                                            <option value="MQ">
                                                Martinique
                                            </option>
                                            <option value="MR">
                                                Mauritania
                                            </option>
                                            <option value="MU">
                                                Mauritius
                                            </option>
                                            <option value="YT">
                                                Mayotte
                                            </option>
                                            <option value="MX">
                                                Mexico
                                            </option>
                                            <option value="FM">
                                                Micronesia
                                            </option>
                                            <option value="MD">
                                                Moldova
                                            </option>
                                            <option value="MC">
                                                Monaco
                                            </option>
                                            <option value="MN">
                                                Mongolia
                                            </option>
                                            <option value="MNE">
                                                Montenegro
                                            </option>
                                            <option value="MS">
                                                Montserrat
                                            </option>
                                            <option value="MA">
                                                Morocco
                                            </option>
                                            <option value="MZ">
                                                Mozambique
                                            </option>
                                            <option value="MM">
                                                Myanmar
                                            </option>
                                            <option value="NA">
                                                Namibia
                                            </option>
                                            <option value="NR">
                                                Nauru
                                            </option>
                                            <option value="NP">
                                                Nepal
                                            </option>
                                            <option value="NL">
                                                Netherlands
                                            </option>
                                            <option value="AN">
                                                Netherlands Antilles
                                            </option>
                                            <option value="NC">
                                                New Caledonia
                                            </option>
                                            <option value="NZ">
                                                New Zealand
                                            </option>
                                            <option value="NI">
                                                Nicaragua
                                            </option>
                                            <option value="NE">
                                                Niger
                                            </option>
                                            <option value="NG">
                                                Nigeria
                                            </option>
                                            <option value="NU">
                                                Niue
                                            </option>
                                            <option value="NF">
                                                Norfolk Island
                                            </option>
                                            <option value="KP">
                                                North Korea
                                            </option>
                                            <option value="MP">
                                                Northern Mariana Islands
                                            </option>
                                            <option value="NO">
                                                Norway
                                            </option>
                                            <option value="OM">
                                                Oman
                                            </option>
                                            <option value="Other">
                                                Other Country
                                            </option>
                                            <option value="PK">
                                                Pakistan
                                            </option>
                                            <option value="PW">
                                                Palau
                                            </option>
                                            <option value="PS">
                                                Palestine
                                            </option>
                                            <option value="PA">
                                                Panama
                                            </option>
                                            <option value="PG">
                                                Papua New Guinea
                                            </option>
                                            <option value="PY">
                                                Paraguay
                                            </option>
                                            <option value="PE">
                                                Peru
                                            </option>
                                            <option value="PH">
                                                Philippines
                                            </option>
                                            <option value="PN">
                                                Pitcairn
                                            </option>
                                            <option value="PL">
                                                Poland
                                            </option>
                                            <option value="PT">
                                                Portugal
                                            </option>
                                            <option value="PR">
                                                Puerto Rico
                                            </option>
                                            <option value="QA">
                                                Qatar
                                            </option>
                                            <option value="RE">
                                                Reunion
                                            </option>
                                            <option value="RO">
                                                Romania
                                            </option>
                                            <option value="RU">
                                                Russian Federation
                                            </option>
                                            <option value="RW">
                                                Rwanda
                                            </option>
                                            <option value="BLM">
                                                Saint Barthelemy
                                            </option>
                                            <option value="KN">
                                                Saint Kitts and Nevis
                                            </option>
                                            <option value="LC">
                                                Saint Lucia
                                            </option>
                                            <option value="MAF">
                                                Saint Martin
                                            </option>
                                            <option value="VC">
                                                Saint Vincent and the Grenadines
                                            </option>
                                            <option value="WS">
                                                Samoa
                                            </option>
                                            <option value="SM">
                                                San Marino
                                            </option>
                                            <option value="ST">
                                                Sao Tome and Principe
                                            </option>
                                            <option value="SA">
                                                Saudi Arabia
                                            </option>
                                            <option value="SCT">
                                                Scotland
                                            </option>
                                            <option value="SN">
                                                Senegal
                                            </option>
                                            <option value="SRB">
                                                Serbia
                                            </option>
                                            <option value="SC">
                                                Seychelles
                                            </option>
                                            <option value="SL">
                                                Sierra Leone
                                            </option>
                                            <option value="SG">
                                                Singapore
                                            </option>
                                            <option value="SK">
                                                Slovakia (Slovak Republic)
                                            </option>
                                            <option value="SI">
                                                Slovenia
                                            </option>
                                            <option value="SB">
                                                Solomon Islands
                                            </option>
                                            <option value="SO">
                                                Somalia
                                            </option>
                                            <option value="ZA">
                                                South Africa
                                            </option>
                                            <option value="SGS">
                                                South Georgia and the South Sandwich Islands
                                            </option>
                                            <option value="KR">
                                                South Korea
                                            </option>
                                            <option value="SS">
                                                South Sudan
                                            </option>
                                            <option value="ES">
                                                Spain
                                            </option>
                                            <option value="LK">
                                                Sri Lanka
                                            </option>
                                            <option value="SH">
                                                St. Helena
                                            </option>
                                            <option value="PM">
                                                St. Pierre and Miquelon
                                            </option>
                                            <option value="SD">
                                                Sudan
                                            </option>
                                            <option value="SR">
                                                Suriname
                                            </option>
                                            <option value="SJ">
                                                Svalbard and Jan Mayen Islands
                                            </option>
                                            <option value="SZ">
                                                Swaziland
                                            </option>
                                            <option value="SE">
                                                Sweden
                                            </option>
                                            <option value="CH">
                                                Switzerland
                                            </option>
                                            <option value="SY">
                                                Syrian Arab Republic
                                            </option>
                                            <option value="TW">
                                                Taiwan
                                            </option>
                                            <option value="TJ">
                                                Tajikistan
                                            </option>
                                            <option value="TZ">
                                                Tanzania
                                            </option>
                                            <option value="TH">
                                                Thailand
                                            </option>
                                            <option value="TLS">
                                                Timor-Leste
                                            </option>
                                            <option value="TG">
                                                Togo
                                            </option>
                                            <option value="TK">
                                                Tokelau
                                            </option>
                                            <option value="TO">
                                                Tonga
                                            </option>
                                            <option value="TT">
                                                Trinidad and Tobago
                                            </option>
                                            <option value="TN">
                                                Tunisia
                                            </option>
                                            <option value="TR">
                                                Turkey
                                            </option>
                                            <option value="TM">
                                                Turkmenistan
                                            </option>
                                            <option value="TC">
                                                Turks and Caicos Islands
                                            </option>
                                            <option value="TV">
                                                Tuvalu
                                            </option>
                                            <option value="UG">
                                                Uganda
                                            </option>
                                            <option value="UA">
                                                Ukraine
                                            </option>
                                            <option value="AE">
                                                United Arab Emirates
                                            </option>
                                            <option value="UK">
                                                United Kingdom
                                            </option>
                                            <option value="US">
                                                United States
                                            </option>
                                            <option value="UM">
                                                United States Minor Outlying Islands
                                            </option>
                                            <option value="UY">
                                                Uruguay
                                            </option>
                                            <option value="UZ">
                                                Uzbekistan
                                            </option>
                                            <option value="VU">
                                                Vanuatu
                                            </option>
                                            <option value="VA">
                                                Vatican City State (Holy See)
                                            </option>
                                            <option value="VE">
                                                Venezuela
                                            </option>
                                            <option value="VN">
                                                Vietnam
                                            </option>
                                            <option value="VG">
                                                Virgin Islands (British)
                                            </option>
                                            <option value="VI">
                                                Virgin Islands (U.S.)
                                            </option>
                                            <option value="WF">
                                                Wallis And Futuna Islands
                                            </option>
                                            <option value="EH">
                                                Western Sahara
                                            </option>
                                            <option value="YE">
                                                Yemen
                                            </option>
                                            <option value="YU">
                                                Yugoslavia
                                            </option>
                                            <option value="ZM">
                                                Zambia
                                            </option>
                                            <option value="EAZ">
                                                Zanzibar
                                            </option>
                                            <option value="ZW">
                                                Zimbabwe
                                            </option>
                                        </optgroup>
                                    </select>
                                </label>
                            </td>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="mf-logistics-fob" id="mf-logistics-fob" style="display: none;">
                            <th>
                                仓储集货运费参考：
                            </th>
                            <td>
                                国内运费：
                                <strong class="cost">
                                </strong>
                                国际运费最低：
                                <strong class="cost">
                                </strong>
                            </td>
                        </tr>
                        <tr class="mf-logistics-personal" id="mf-logistics-personal">
                            <td>
                                <table class="mf-reference">
                                    <thead>
                                        <tr>
                                            <td>
                                                物流公司
                                            </td>
                                            <td>
                                                设置
                                            </td>
                                            <td>
                                                价格
                                            </td>
                                            <td>
                                                运达时间
                                            </td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                ePacket
                                                <span style="color:#999999">
                                                    (e邮宝)
                                                </span>
                                            </td>
                                            <td>
                                                <strong class="cost">
                                                    不支持向该国家发货
                                                </strong>
                                            </td>
                                            <td>
                                                -
                                            </td>
                                            <td>
                                                -
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                DHL Global Mail
                                            </td>
                                            <td>
                                                <strong class="cost">
                                                    不支持向该国家发货
                                                </strong>
                                            </td>
                                            <td>
                                                -
                                            </td>
                                            <td>
                                                -
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                EMS
                                                <span style="color:#999999">
                                                    (中国邮政特快专递)
                                                </span>
                                            </td>
                                            <td>
                                                自定义
                                            </td>
                                            <td>
                                                <b class="cost">
                                                    $21.08
                                                </b>
                                            </td>
                                            <td>
                                                27天
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                China Post Air Mail
                                                <span style="color:#999999">
                                                    (中国邮政小包)
                                                </span>
                                            </td>
                                            <td>
                                                自定义
                                            </td>
                                            <td>
                                                <b class="cost">
                                                    $22.09
                                                </b>
                                            </td>
                                            <td>
                                                39天
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td>
                                <a data-spm-anchor-id="0.0.0.0" target="_blank" class="mf-edittemplate"
                                href="#" id="mf-view-freight">
                                    查看该运费模板详细设置
                                </a>
                            </td>
                        </tr>
                    </tfoot>
                </table>
                <div class="mf-freight-bar mf-fold" id="mf-freight-bar">
                    <a data-spm-anchor-id="0.0.0.0" class="mf-bar-fold" href="javascript:;">
                        收起运费信息
                    </a>
                    <a data-spm-anchor-id="0.0.0.0" class="mf-bar-unfold" href="javascript:;">
                        展示运费信息
                    </a>
                </div>
            </div>
            <div style="display: none;" id="mf-no-template">
            </div>
        </div>
    </div>
    <div class="module-error">
        <p id="ship-tips" class="err-tip msg-err">
        </p>
    </div>
</div>
    <div class="module" id="serve-post-main">
    <div class="module-hd">
        <h3>
            4. 服务模板
        </h3>
        <a name="product-serve">
        </a>
    </div>
    <div class="module-content clearfix">
        <label class="module-name">
            <span class="required">
                服务设置:
            </span>
        </label>
        <div class="module-body s-serve-set-main">
            <div class="serve-item clearfix">
                <input name="selectTemplateType" data-value="0" data-name="NewbieServiceTemplate"
                value="defaultServe" id="default-serve-radio" type="radio">
                <label for="default-serve-radio">
                    新手服务模板
                </label>
                <span class="serve-set-tips">
                    不了解服务设置可选择此模板。该模板根据平台规则设置了基础服务，为买家提供基本保障。
                </span>
            </div>
            <div class="serve-item clearfix">
                <input name="selectTemplateType" value="customServe" id="custom-serve-radio"
                type="radio">
                <label for="custom-serve-radio">
                    自定义服务模板
                </label>
                <div class="s-serve-select" id="serveTemSelect">
                    <span class="s-serve-txt" id="serveTemplateName">
                        请选择模板
                    </span>
                    <input value="0" name="_fmw.w._0.p" id="selectedServeId" type="hidden">
                    <input name="serveDatafrom" id="serveDatafrom" value="" type="hidden">
                    <input id="serveProductId" name="serveProductId" value="" type="hidden">
                    <span class="s-serve-icon">
                    </span>
                    <div class="serve-list-content" id="serveListContent">
                        <ul>
                        </ul>
                        <div id="addServeTemplate" class="add-serve-template">
                            <a data-spm-anchor-id="0.0.0.0" href="javascript:void(0)">
                                新增服务模板
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- serve-detail-show -->
            <div style="display: block;" class="serve-show-main" id="serveShowMain">
                <div style="display: none;" id="serveDetailShow">
                    <table id="serve-show-table">
                        <thead>
                            <tr>
                                <td class="row-1">
                                    <span class="t-serve">
                                        货不对版退货
                                    </span>
                                    <div class="b-serve">
                                        <span class="b-serve-1">
                                            是否需要退货
                                        </span>
                                        <span class="b-serve-2">
                                            运费承担方
                                        </span>
                                    </div>
                                </td>
                                <td class="row-2">
                                    <span class="t-serve">
                                        无理由退货
                                    </span>
                                    <div class="b-serve">
                                        <span class="b-serve-1">
                                            是否接受
                                        </span>
                                        <span class="b-serve-2">
                                            运费承担方
                                        </span>
                                    </div>
                                </td>
                                <td class="row-3">
                                    消保服务
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <input id="promiseTemplateErrorCode" value="0" type="hidden">
                            <input id="promiseTemplateErrorDesc" value="" type="hidden">
                            <tr id="0">
                                <td class="row-1">
                                    <span class="b-serve-1">
                                        是
                                    </span>
                                    <span class="b-serve-2">
                                        买家
                                    </span>
                                </td>
                                <td class="row-2">
                                    <span class="b-serve-1">
                                        否
                                    </span>
                                    <span class="b-serve-2">
                                        <span class="t-grey">
                                            -
                                        </span>
                                    </span>
                                </td>
                                <td class="row-3">
                                    -
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="s-serve-more">
                        <a href="javascript:void(0)" id="viewTemplatePage">
                            查看该服务模板详细设置
                        </a>
                    </div>
                </div>
                <div class="serve-template-btn show-fold" id="serveTemplateBtn">
                    <a data-spm-anchor-id="0.0.0.0" href="javascript:void(0);" class="less-template-info">
                        收起模板信息
                    </a>
                    <a data-spm-anchor-id="0.0.0.0" href="javascript:void(0);" class="display-template-info">
                        展开模板信息
                    </a>
                </div>
            </div>
            <!-- serve-detail-show -->
        </div>
    </div>
    <div class="module-error">
        <p id="serveErrorTips" class="err-tip msg-err">
        </p>
    </div>
</div>
<div id="poi" class="module">
    <h3 class="module-hd">
        5. 其他信息
    </h3>
    <div class="module-content">
        <label class="module-name">
            <a name="product-group">
                &nbsp;
            </a>
            产品组：
        </label>
        <select name="_fmw.w._0.g" id="product-group-list">
            <option value="0">
                ---请选择产品组---
            </option>
            <option value="251157283">
                Outdoor Sports
            </option>
            <option value="251158305">
                Tablet PC
            </option>
            <option value="251160325">
                LED Flashlights
            </option>
            <option value="251160324">
                Home &amp; Garden
            </option>
            <option value="251152316">
                Batteries &amp; Charging
            </option>
            <option value="251158304">
                Tablet PC Accessories
            </option>
        </select>
        <input id="groupName" name="_fmw.w._0.gr" type="hidden">
        <a href="#product-group" class="help-tip" rel="group" tabindex="-1" title="产品组">
            产品组帮助
        </a>
    </div>
    <div class="module-content">
        <label class="module-name" for="ftn-days">
            <a name="yxq">
                &nbsp;
            </a>
            产品有效期：
        </label>
        <input name="_fmw.w._0.v" id="ftn-days" value="14" type="radio">
        <label for="ftn-days">
            14天
        </label>
        <input name="_fmw.w._0.v" id="tty-days" value="30" checked="checked" type="radio">
        <label for="tty-days">
            30天
        </label>
    </div>
    <div class="module-content">
        <label class="module-name" for="payway">
            支付宝：
        </label>
        <div class="module-body">
            <input name="_fmw.w._0.is" id="alipay" value="Y" checked="checked" type="radio">
            <label>
                支持&nbsp;&nbsp;
                <a href="http://seller.aliexpress.com/escrow/index.html" target="_blank">
                    <img src="http://img.alibaba.com/images/eng/wholesale/icon/escrow_logo_s.gif"
                    alt="escrow">
                </a>
            </label>
        </div>
    </div>
</div>

</body>
</html>