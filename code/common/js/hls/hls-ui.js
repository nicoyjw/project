'use strict';

define(['moment', 'locale', 'datetimepicker'], function () {
    var hlsUiModule = angular.module('hls.ui', [
        'hls.core', 'hls.ui.area', 'hls.ui.datetimepicker', 'hls.ui.pagination', 'hls.ui.formvalid',
        'hls.ui.dialogs', 'hls.ui.include', 'hls.ui.grid', 'hls.ui.upload', 'hls.ui.list', 'ngMsgValidate']);

    angular.module('hls.ui.area', [])
        .run(['$templateCache', function ($templateCache) {
            $templateCache.put('/hls/hlsCity.html',
                '<div>'
                + '<div class="dropdown">                                                    '
                + '    <div style="padding: 0px">                                                              '
                + '        <input class="dropdown-toggle {{hlsClass}}" placeholder="{{hlsPlaceholder}}" data-toggle="dropdown" ng-model="hlsData.selectedData"/>         '
                + '                                                                                                             '
                + '        <div class="dropdown-menu  hlsAreaPanel" role="menu">                                                 '
                + '            <ul class="list-inline hlsAreaTab">                                                              '
                + '                <li ng-repeat="tab in hlsAreaTabOption" class="{{hlsAreaTabActiveClass(tab)}}">              '
                + '                    <span data-stopPropagation="true" ng-click="tabChange(tab)">{{getTabName(tab)}}</span>   '
                + '                </li>                                                                                        '
                + '            </ul>                                                                                            '
                + '            <div ng-show="isContentShow()">                                                                  '
                + '                <div class="col-sm-2"><b style="color:orange">热门</b></div>                                 '
                + '                <div class="col-sm-10 text-left">                                                            '
                + '                    <ul class="list-inline">                                                                 '
                + '                        <li ng-repeat="area in getAreaData()" class="{{hlsAreaActiveClass(area)}}">          '
                + '                            <span ng-click="AreaSelected(area)">{{area}}</span>                              '
                + '                        </li>                                                                                '
                + '                    </ul>                                                                                    '
                + '                </div>                                                                                       '
                + '            </div>                                                                                           '
                + '            <div ng-repeat="tab in hlsAreaDataOption" ng-show="isContentShow(tab)">                          '
                + '                <div ng-repeat="prefix in tab">                                                              '
                + '                    <div class="col-sm-2"><b style="color:orange">{{prefix}}</b></div>                       '
                + '                    <div class="col-sm-10 text-left">                                                        '
                + '                        <ul class="list-inline">                                                             '
                + '                            <li ng-if="getAreaData(prefix).length==0"></li>                                  '
                + '                            <li ng-repeat="area in getAreaData(prefix)" class="{{hlsAreaActiveClass(area)}}">'
                + '                                <span ng-click="AreaSelected(area)">{{area}}</span>                          '
                + '                            </li>                                                                            '
                + '                        </ul>                                                                                '
                + '                    </div>                                                                                   '
                + '                </div>                                                                                       '
                + '            </div>                                                                                           '
                + '        </div>                                                                                               '
                + '    </div>                                                                                                   '
                + '</div>     '
                + '</div>'
            );

            $templateCache.put('/hls/hlsCountry.html',
                '<div>'
                + '<div class="dropdown">                                                    '
                + '    <div style="padding: 0px">                                                              '
                + '        <input class="dropdown-toggle {{hlsClass}}" placeholder="{{hlsPlaceholder}}" data-toggle="dropdown" ng-model="hlsData.selectedData.Name"/>         '
                + '                                                                                                             '
                + '        <div class="dropdown-menu hlsAreaPanel" role="menu">                                                 '
                + '            <ul class="list-inline hlsAreaTab">                                                              '
                + '                <li ng-repeat="tab in hlsAreaTabOption" class="{{hlsAreaTabActiveClass(tab)}}">              '
                + '                    <span data-stopPropagation="true" ng-click="tabChange(tab)">{{getTabName(tab)}}</span>   '
                + '                </li>                                                                                        '
                + '            </ul>                                                                                            '
                + '            <div ng-show="isContentShow()">                                                                  '
                + '                <div class="col-sm-2"><b style="color:orange">热门</b></div>                                 '
                + '                <div class="col-sm-10 text-left">                                                            '
                + '                    <ul class="list-inline">                                                                 '
                + '                        <li ng-repeat="area in getAreaData()" class="{{hlsAreaActiveClass(area)}}">          '
                + '                            <span ng-click="AreaSelected(area)">{{area.Name}}</span>                              '
                + '                        </li>                                                                                '
                + '                    </ul>                                                                                    '
                + '                </div>                                                                                       '
                + '            </div>                                                                                           '
                + '            <div ng-repeat="tab in hlsAreaDataOption" ng-show="isContentShow(tab)">                          '
                + '                <div ng-repeat="prefix in tab">                                                              '
                + '                    <div class="col-sm-2"><b style="color:orange">{{prefix}}</b></div>                       '
                + '                    <div class="col-sm-10 text-left">                                                        '
                + '                        <ul class="list-inline">                                                             '
                + '                            <li ng-if="getAreaData(prefix).length==0"></li>                                  '
                + '                            <li ng-repeat="area in getAreaData(prefix)" class="{{hlsAreaActiveClass(area)}}">'
                + '                                <span ng-click="AreaSelected(area)">{{area.Name}}</span>                          '
                + '                            </li>                                                                            '
                + '                        </ul>                                                                                '
                + '                    </div>                                                                                   '
                + '                </div>                                                                                       '
                + '            </div>                                                                                           '
                + '        </div>                                                                       '
                + '    </div>                                                                                                   '
                + '</div> '
                + '</div>'
            );
        }])
        .constant('cnCityData', {
            'hot': ['深圳市', '广州市'],
            'A': [
                '安庆市',
                '澳门特别行政区',
                '安顺市',
                '安阳市',
                '鞍山市',
                '阿拉善盟',
                '安康市',
                '阿坝藏族羌族自治州',
                '阿里地区',
                '阿克苏地区',
                '阿勒泰地区',
            ],
            'B': [
                '蚌埠市',
                '北京市',
                '白银市',
                '百色市',
                '北海市',
                '毕节地区',
                '毕节市',
                '保定市',
                '白城市',
                '白山市',
                '本溪市',
                '巴彦淖尔',
                '巴彦淖尔市',
                '包头市',
                '滨州市',
                '宝鸡市',
                '巴中市',
                '巴音郭楞蒙古自治州',
                '博尔塔拉蒙古自治州',
                '保山市',
            ],
            'C': [
                '巢湖市',
                '池州市',
                '滁州市',
                '潮州市',
                '崇左市',
                '沧州市',
                '承德市',
                '长沙市',
                '常德市',
                '郴州市',
                '长春市',
                '常熟市',
                '常州市',
                '朝阳市',
                '赤峰市',
                '长治市',
                '成都市',
                '昌都地区',
                '昌吉回族自治州',
                '楚雄彝族自治州',
                '重庆市',
            ],
            'D': [
                '定西市',
                '敦煌市',
                '东莞市',
                '都匀市',
                '大庆市',
                '大兴安岭地区',
                '大连市',
                '丹东市',
                '德州市',
                '东营市',
                '大同市',
                '达州市',
                '德阳市',
                '大理白族自治州',
                '德宏傣族景颇族自治州',
                '迪庆藏族自治州',
            ],
            'E': [
                '鄂州市',
                '恩施土家族苗族自治州',
                '鄂尔多斯市',
            ],
            'F': [
                '阜阳市',
                '福州市',
                '佛山市',
                '防城港市',
                '抚州市',
                '抚顺市',
                '阜新市',
            ],
            'G': [
                '广州市',
                '甘南藏族自治州',
                '贵港市',
                '桂林市',
                '贵阳市',
                '巩义市',
                '赣州市',
                '固原市',
                '果洛藏族自治州',
                '甘孜藏族自治州',
                '广安市',
                '广元市',
            ],
            'H': [
                '毫州市',
                '合肥市',
                '淮北市',
                '淮南市',
                '黄山市',
                '河源市',
                '惠州市',
                '河池市',
                '贺州市',
                '海口市',
                '邯郸市',
                '衡水市',
                '鹤壁市',
                '哈尔滨市',
                '鹤岗市',
                '黑河市',
                '黄冈市',
                '黄石市',
                '衡阳市',
                '怀化市',
                '黄花',
                '淮安市',
                '葫芦岛市',
                '海拉尔区',
                '呼和浩特市',
                '呼伦贝尔市',
                '海北藏族自治州',
                '海东地区',
                '海南藏族自治州',
                '海西蒙古族藏族自治州',
                '黄南藏族自治州',
                '菏泽市',
                '汉中市',
                '香港岛',
                '哈密地区',
                '和田地区',
                '红河哈尼族彝族自治州',
                '杭州市',
                '湖州市',
                '黄岩市',
            ],
            'I': [],
            'J': [
                '晋江市',
                '嘉峪关市',
                '金昌市',
                '酒泉市',
                '江门市',
                '揭阳市',
                '济源市',
                '焦作市',
                '鸡西市',
                '佳木斯市',
                '荆门市',
                '荆州市',
                '吉林市',
                '江阴市',
                '吉安市',
                '景德镇市',
                '九江市',
                '锦州市',
                '济南市',
                '济宁市',
                '晋城市',
                '晋中市',
                '九龙',
                '嘉兴市',
                '金华市',
            ],
            'K': [
                '凯里市',
                '开封市',
                '昆山市',
                '喀什地区',
                '克拉玛依市',
                '克孜勒苏柯尔克孜自治州',
                '昆明市',
            ],
            'L': [
                '六安市',
                '龙岩市',
                '兰州市',
                '临夏回族自治州',
                '陇南市',
                '来宾市',
                '柳州市',
                '六盘水市',
                '廊坊市',
                '洛阳市',
                '漯河市',
                '娄底市',
                '辽源市',
                '连云港市',
                '辽阳市',
                '莱芜市',
                '聊城市',
                '临沂市',
                '临汾市',
                '吕梁市',
                '乐山市',
                '凉山彝族自治州',
                '泸州市',
                '拉萨市',
                '林芝地区',
                '丽江市',
                '临沧市',
                '丽水市',
            ],
            'M': [
                '马鞍山市',
                '茂名市',
                '梅州市',
                '牡丹江市',
                '眉山市',
                '绵阳市',
            ],
            'N': [
                '南平市',
                '宁德市',
                '南宁市',
                '南阳市',
                '南京市',
                '南通市',
                '南昌市',
                '内江市',
                '南充市',
                '那曲地区',
                '怒江傈僳族自治州',
                '宁波市',
            ],
            'O': [],
            'P': [
                '莆田市',
                '平凉市',
                '平顶山市',
                '濮阳市',
                '萍乡市',
                '盘锦市',
                '攀枝花市',
                '普洱市',
            ],
            'Q': [
                '泉州市',
                '庆阳市',
                '清远市',
                '钦州市',
                '黔东南苗族侗族自治州',
                '黔南布依族苗族自治州',
                '黔西南布依族苗族自治州',
                '秦皇岛市',
                '七台河市',
                '齐齐哈尔市',
                '青岛市',
                '曲靖市',
                '衢州市',
            ],
            'R': [
                '日照市',
                '日喀则地区',
            ],
            'S': [
                '深圳市',
                '宿州市',
                '三明市',
                '汕头市',
                '汕尾市',
                '韶关市',
                '三亚市',
                '石家庄市',
                '三门峡市',
                '商丘市',
                '双鸭山市',
                '绥化市',
                '十堰市',
                '随州市',
                '邵阳市',
                '四平市',
                '松原市',
                '苏州市',
                '宿迁市',
                '上饶市',
                '沈阳市',
                '石嘴山市',
                '朔州市',
                '商洛市',
                '上海市',
                '遂宁市',
                '山南地区',
                '邵通市',
                '绍兴市',
            ],
            'T': [
                '铜陵市',
                '天水市',
                '铜仁地区',
                '铜仁市',
                '唐山市',
                '通化市',
                '泰州市',
                '铁岭市',
                '通辽市',
                '泰安市',
                '太原市',
                '铜川市',
                '天津市',
                '塔城地区',
                '吐鲁番地区',
                '台州市',
            ],
            'U': [],
            'V': [],
            'W': [
                '芜湖市',
                '武威市',
                '梧州市',
                '武汉市',
                '无锡市',
                '乌海市',
                '乌兰察布市',
                '乌兰浩特市',
                '吴忠市',
                '威海市',
                '潍坊市',
                '渭南市',
                '乌鲁木齐市',
                '文山壮族苗族自治州',
                '温州市',
            ],
            'X': [
                '宣城市',
                '厦门市',
                '兴义市',
                '邢台市',
                '新乡市',
                '信阳市',
                '许昌市',
                '咸宁市',
                '襄樊市',
                '襄阳市',
                '孝感市',
                '湘潭市',
                '湘西土家族苗族自治州',
                '徐州市',
                '新余市',
                '锡林郭勒盟',
                '兴安盟',
                '西宁市',
                '忻州市',
                '西安市',
                '咸阳市',
                '香港特别行政区',
                '新界东',
                '新界西',
                '西双版纳傣族自治州',
            ],
            'Y': [
                '阳江市',
                '云浮市',
                '玉林市',
                '伊春市',
                '宜昌市',
                '益阳市',
                '永州市',
                '岳阳市',
                '延边朝鲜族自治州',
                '延边州',
                '盐城市',
                '扬州市',
                '宜兴市',
                '宜春市',
                '鹰潭市',
                '营口市',
                '伊克昭盟',
                '银川市',
                '玉树藏族自治州',
                '烟台市',
                '阳泉市',
                '运城市',
                '延安市',
                '榆林市',
                '雅安市',
                '宜宾市',
                '伊犁哈萨克自治州',
                '玉溪市',
                '义乌市',
            ],
            'Z': [
                '亳州市',
                '漳州市',
                '张掖市',
                '湛江市',
                '肇庆市',
                '中山市',
                '珠海市',
                '遵义市',
                '张家口市',
                '郑州市',
                '周口市',
                '驻马店市',
                '张家界市',
                '株洲市',
                '张家港市',
                '镇江市',
                '中卫市',
                '枣庄市',
                '淄博市',
                '资阳市',
                '自贡市',
                '昭通市',
                '舟山市',]
        })
        .constant('countryData', [
            {'Name': '安道尔', 'Code': 'AD', EnName: 'Andorra'},
            {'Name': '阿拉伯联合大公国', 'Code': 'AE', EnName: 'United Arab Emirates'},
            {'Name': '阿富汗', 'Code': 'AF', EnName: 'Afghanistan'},
            {'Name': '安提瓜和巴布达', 'Code': 'AG', EnName: 'Antigua And Barbuda'},
            {'Name': '安圭拉', 'Code': 'AI', EnName: 'Anguilla'},
            {'Name': '阿尔巴尼亚', 'Code': 'AL', EnName: 'Albania'},
            {'Name': '亚美尼亚', 'Code': 'AM', EnName: 'Armenia'},
            {'Name': '荷属安的列斯群岛', 'Code': 'AN', EnName: 'Netherlands Antilles'},
            {'Name': '安哥拉', 'Code': 'AO', EnName: 'Angola'},
            {'Name': '南极洲', 'Code': 'AQ', EnName: 'Antarctica'},
            {'Name': '阿根廷', 'Code': 'AR', EnName: 'Argentina'},
            {'Name': '萨摩亚(美国新界)', 'Code': 'AS', EnName: 'Samoa,Usa Territory'},
            {'Name': '奥地利', 'Code': 'AT', EnName: 'Austria'},
            {'Name': '澳大利亚', 'Code': 'AU', EnName: 'Australia'},
            {'Name': '雅卢巴', 'Code': 'AW', EnName: 'Aruba'},
            {'Name': '阿塞拜疆', 'Code': 'AZ', EnName: 'Azerbaijan'},
            {'Name': '波斯尼亚 - 黑塞哥维那', 'Code': 'BA', EnName: 'Bosnia And Herzegovina'},
            {'Name': '巴巴多斯', 'Code': 'BB', EnName: 'Barbados'},
            {'Name': '孟加拉', 'Code': 'BD', EnName: 'Bangladesh'},
            {'Name': '比利时', 'Code': 'BE', EnName: 'Belgium'},
            {'Name': '布基纳法索', 'Code': 'BF', EnName: 'Burkina Faso'},
            {'Name': '保加利亚', 'Code': 'BG', EnName: 'Bulgaria'},
            {'Name': '巴林', 'Code': 'BH', EnName: 'Bahrain'},
            {'Name': '布隆迪', 'Code': 'BI', EnName: 'Burundi'},
            {'Name': '贝宁', 'Code': 'BJ', EnName: 'Benin'},
            {'Name': '百慕大', 'Code': 'BM', EnName: 'Bermuda'},
            {'Name': '文莱', 'Code': 'BN', EnName: 'Brunei Darussalam'},
            {'Name': '玻利维亚', 'Code': 'BO', EnName: 'Bolivia'},
            {'Name': '巴西', 'Code': 'BR', EnName: 'Brazil'},
            {'Name': '巴哈马', 'Code': 'BS', EnName: 'Bahamas'},
            {'Name': '不丹', 'Code': 'BT', EnName: 'Bhutan'},
            {'Name': '布维岛', 'Code': 'BV', EnName: 'Bouvet Island'},
            {'Name': '博茨瓦纳', 'Code': 'BW', EnName: 'Botswana'},
            {'Name': '白俄罗斯', 'Code': 'BY', EnName: 'Belarus'},
            {'Name': '伯利兹', 'Code': 'BZ', EnName: 'Belize'},
            {'Name': '加拿大', 'Code': 'CA', EnName: 'Canada'},
            {'Name': '科科斯群岛', 'Code': 'CC', EnName: 'Cocos(keeling)islands'},
            {'Name': '刚果（民主共和国）', 'Code': 'CD', EnName: 'Congo (dem. Rep. Of)'},
            {'Name': '中非共和国', 'Code': 'CF', EnName: 'Central African Republic'},
            {'Name': '刚果', 'Code': 'CG', EnName: 'Congo (rep. Of)'},
            {'Name': '瑞士', 'Code': 'CH', EnName: 'Switzerland'},
            {'Name': '库克群岛', 'Code': 'CK', EnName: 'Cook Islands'},
            {'Name': '智利', 'Code': 'CL', EnName: 'Chile'},
            {'Name': '喀麦隆', 'Code': 'CM', EnName: 'Cameroon'},
            {'Name': '中国', 'Code': 'CN', EnName: 'China'},
            {'Name': '哥伦比亚', 'Code': 'CO', EnName: 'Colombia'},
            {'Name': '哥斯达黎加', 'Code': 'CR', EnName: 'Costa Rica'},
            {'Name': '古巴', 'Code': 'CU', EnName: 'Cuba'},
            {'Name': '佛得角群岛', 'Code': 'CV', EnName: 'Cape Verde'},
            {'Name': '圣诞岛', 'Code': 'CX', EnName: 'Christmas Island'},
            {'Name': '塞浦路斯', 'Code': 'CY', EnName: 'Cyprus'},
            {'Name': '捷克的', 'Code': 'CZ', EnName: 'Czech Republic'},
            {'Name': '德国', 'Code': 'DE', EnName: 'Germany'},
            {'Name': '吉布提', 'Code': 'DJ', EnName: 'Djibouti'},
            {'Name': '丹麦', 'Code': 'DK', EnName: 'Denmark'},
            {'Name': '多米尼加', 'Code': 'DM', EnName: 'Dominica'},
            {'Name': '多米尼加共和国', 'Code': 'DO', EnName: 'Dominican Republic'},
            {'Name': '阿尔及利亚', 'Code': 'DZ', EnName: 'Algeria'},
            {'Name': '厄瓜多尔', 'Code': 'EC', EnName: 'Ecuador'},
            {'Name': '爱沙尼亚', 'Code': 'EE', EnName: 'Estonia'},
            {'Name': '埃及', 'Code': 'EG', EnName: 'Egypt'},
            {'Name': '西撒哈拉', 'Code': 'EH', EnName: 'Western Sahara A)'},
            {'Name': '厄立特里亚', 'Code': 'ER', EnName: 'Eritrea'},
            {'Name': '西班牙', 'Code': 'ES', EnName: 'Spain'},
            {'Name': '埃塞俄比亚', 'Code': 'ET', EnName: 'Ethiopia'},
            {'Name': '芬兰', 'Code': 'FI', EnName: 'Finland'},
            {'Name': '斐济', 'Code': 'FJ', EnName: 'Fiji'},
            {'Name': '福克兰群岛', 'Code': 'FK', EnName: 'Falkland Island (malvinas)'},
            {'Name': '密克罗尼西亚', 'Code': 'FM', EnName: 'Micronesia (federated States Of)'},
            {'Name': '法罗群岛', 'Code': 'FO', EnName: 'Faroe Islands'},
            {'Name': '法国', 'Code': 'FR', EnName: 'France'},
            {'Name': '法国,大都会', 'Code': 'FX', EnName: 'FRANCE, METROPOLITAN'},
            {'Name': '另外薘', 'Code': 'GA', EnName: 'Gabon'},
            {'Name': '英国', 'Code': 'GB', EnName: 'United Kingdom'},
            {'Name': '格林纳达', 'Code': 'GD', EnName: 'Grenada'},
            {'Name': '格鲁吉亚', 'Code': 'GE', EnName: 'Georgia'},
            {'Name': '法属圭亚那', 'Code': 'GF', EnName: 'French Guiana'},
            {'Name': '加纳', 'Code': 'GH', EnName: 'Ghana'},
            {'Name': '直布罗陀', 'Code': 'GI', EnName: 'Gibraltar'},
            {'Name': '格陵兰', 'Code': 'GL', EnName: 'Greenland'},
            {'Name': '冈比亚', 'Code': 'GM', EnName: 'Gambia'},
            {'Name': '新几内亚', 'Code': 'GN', EnName: 'Guinea'},
            {'Name': '瓜德罗普岛', 'Code': 'GP', EnName: 'Guadeloupe'},
            {'Name': '赤道几内亚', 'Code': 'GQ', EnName: 'Equatorial Guinea'},
            {'Name': '希腊', 'Code': 'GR', EnName: 'Greece'},
            {'Name': '南乔治亚岛和南桑威奇群岛', 'Code': 'GS', EnName: 'South Georgia And The South Sandwich Isl'},
            {'Name': '危地马拉', 'Code': 'GT', EnName: 'Guatemala'},
            {'Name': '关岛', 'Code': 'GU', EnName: 'Guam'},
            {'Name': '几内亚比绍', 'Code': 'GW', EnName: 'Guinea-bissau'},
            {'Name': '圭亚那', 'Code': 'GY', EnName: 'Guyana'},
            {'Name': '香港', 'Code': 'HK', EnName: 'Hong Kong'},
            {'Name': '赫德岛和麦克唐纳岛', 'Code': 'HM', EnName: 'Heard Island And Mcdonald Islands'},
            {'Name': '洪都拉斯', 'Code': 'HN', EnName: 'Honduras'},
            {'Name': '克罗地亚', 'Code': 'HR', EnName: 'Croatia'},
            {'Name': '海地', 'Code': 'HT', EnName: 'Haiti'},
            {'Name': '匈牙利', 'Code': 'HU', EnName: 'Hungary'},
            {'Name': '印尼', 'Code': 'ID', EnName: 'Indonesia'},
            {'Name': '爱尔兰', 'Code': 'IE', EnName: 'Ireland'},
            {'Name': '以色列', 'Code': 'IL', EnName: 'Israel'},
            {'Name': '印度', 'Code': 'IN', EnName: 'India'},
            {'Name': '英属印度洋领地', 'Code': 'IO', EnName: 'British Indian Ocean Territory'},
            {'Name': '伊拉克', 'Code': 'IQ', EnName: 'Iraq'},
            {'Name': '伊朗', 'Code': 'IR', EnName: 'Iran (islamic Republic Of)'},
            {'Name': '冰岛', 'Code': 'IS', EnName: 'Iceland'},
            {'Name': '意大利', 'Code': 'IT', EnName: 'Italy'},
            {'Name': '牙买加', 'Code': 'JM', EnName: 'Jamaica'},
            {'Name': '约旦', 'Code': 'JO', EnName: 'Jordan'},
            {'Name': '日本', 'Code': 'JP', EnName: 'Japan'},
            {'Name': '肯尼亚', 'Code': 'KE', EnName: 'Kenya'},
            {'Name': '吉尔吉斯', 'Code': 'KG', EnName: 'Kyrgyzstan'},
            {'Name': '柬埔寨', 'Code': 'KH', EnName: 'Cambodia'},
            {'Name': '基里巴斯', 'Code': 'KI', EnName: 'Kiribati'},
            {'Name': '科摩罗', 'Code': 'KM', EnName: 'Comoros'},
            {'Name': '圣基茨和尼维斯', 'Code': 'KN', EnName: 'Saint Kitts And Nevis'},
            {'Name': '韩国', 'Code': 'KR', EnName: 'Korea'},
            {'Name': '科威特', 'Code': 'KW', EnName: 'Kuwait'},
            {'Name': '开曼群岛', 'Code': 'KY', EnName: 'Cayman Islands'},
            {'Name': '哈萨克斯坦', 'Code': 'KZ', EnName: 'Kazakhstan'},
            {'Name': '黎巴嫩', 'Code': 'LB', EnName: 'Lebanon'},
            {'Name': '圣卢西亚', 'Code': 'LC', EnName: 'Saint Lucia'},
            {'Name': '列支敦士登', 'Code': 'LI', EnName: 'Liechtenstein'},
            {'Name': '斯里兰卡', 'Code': 'LK', EnName: 'Sri Lanka'},
            {'Name': '利比里亚', 'Code': 'LR', EnName: 'Liberia'},
            {'Name': '莱索托', 'Code': 'LS', EnName: 'Lesotho'},
            {'Name': '立陶宛', 'Code': 'LT', EnName: 'Lithuania'},
            {'Name': '卢森堡', 'Code': 'LU', EnName: 'Luxembourg'},
            {'Name': '拉脱维亚', 'Code': 'LV', EnName: 'Latvia'},
            {'Name': '利比亚', 'Code': 'LY', EnName: 'Libyan Arab Jamahiriya'},
            {'Name': '摩洛哥', 'Code': 'MA', EnName: 'Morocco'},
            {'Name': '摩纳哥', 'Code': 'MC', EnName: 'Monaco'},
            {'Name': '摩尔多瓦', 'Code': 'MD', EnName: 'MOLDOVA, REPUBLIC OF'},
            {'Name': '黑山共和国', 'Code': 'ME', EnName: 'Montenegro'},
            {'Name': '马达加斯加', 'Code': 'MG', EnName: 'Madagascar'},
            {'Name': '马绍尔群岛', 'Code': 'MH', EnName: 'Marshall Islands'},
            {'Name': '马其顿', 'Code': 'MK', EnName: 'Macedonia (rep. Of) (former Yogoslavia)'},
            {'Name': '马里', 'Code': 'ML', EnName: 'Mali'},
            {'Name': '缅甸', 'Code': 'MM', EnName: 'Myanmar'},
            {'Name': '蒙古', 'Code': 'MN', EnName: 'Mongolia'},
            {'Name': '澳门', 'Code': 'MO', EnName: 'Macau'},
            {'Name': '马里亚纳群岛（北方）', 'Code': 'MP', EnName: 'Mariana Islands (northern)'},
            {'Name': '马提尼克岛', 'Code': 'MQ', EnName: 'Martinique'},
            {'Name': '毛里塔尼亚', 'Code': 'MR', EnName: 'Mauritania'},
            {'Name': '蒙特塞拉特', 'Code': 'MS', EnName: 'Montserrat'},
            {'Name': '马耳他', 'Code': 'MT', EnName: 'Malta'},
            {'Name': '毛里求斯', 'Code': 'MU', EnName: 'Mauritius'},
            {'Name': '马尔代夫', 'Code': 'MV', EnName: 'Maldives'},
            {'Name': '马拉维', 'Code': 'MW', EnName: 'Malawi'},
            {'Name': '墨西哥', 'Code': 'MX', EnName: 'Mexico'},
            {'Name': '马来西亚', 'Code': 'MY', EnName: 'Malaysia'},
            {'Name': '莫桑比克', 'Code': 'MZ', EnName: 'Mozambique'},
            {'Name': '纳米比亚', 'Code': 'NA', EnName: 'Namibia'},
            {'Name': '新喀里多尼亚', 'Code': 'NC', EnName: 'New Caledonia'},
            {'Name': '尼日尔', 'Code': 'NE', EnName: 'Niger'},
            {'Name': '无极褔克岛', 'Code': 'NF', EnName: 'Norfolk Island'},
            {'Name': '尼日利亚', 'Code': 'NG', EnName: 'Nigeria'},
            {'Name': '尼加拉瓜', 'Code': 'NI', EnName: 'Nicaragua'},
            {'Name': '荷兰', 'Code': 'NL', EnName: 'Netherlands'},
            {'Name': '挪威', 'Code': 'NO', EnName: 'Norway'},
            {'Name': '尼泊尔', 'Code': 'NP', EnName: 'Nepal'},
            {'Name': '瑙鲁', 'Code': 'NR', EnName: 'Nauru'},
            {'Name': '纽埃', 'Code': 'NU', EnName: 'Niue'},
            {'Name': '新西兰', 'Code': 'NZ', EnName: 'New Zealand'},
            {'Name': '阿曼', 'Code': 'OM', EnName: 'Oman'},
            {'Name': '巴拿马', 'Code': 'PA', EnName: 'Panama'},
            {'Name': '秘鲁', 'Code': 'PE', EnName: 'Peru'},
            {'Name': '法属波利尼西亚', 'Code': 'PF', EnName: 'French Polynesia'},
            {'Name': '巴布亚新几内亚', 'Code': 'PG', EnName: 'Papua New Guinea'},
            {'Name': '菲律宾', 'Code': 'PH', EnName: 'Philippines'},
            {'Name': '巴基斯坦', 'Code': 'PK', EnName: 'Pakistan'},
            {'Name': '波兰', 'Code': 'PL', EnName: 'Poland'},
            {'Name': '圣皮埃尔和密克隆', 'Code': 'PM', EnName: 'Saint Pierre And Miquelon'},
            {'Name': '皮特克恩岛', 'Code': 'PN', EnName: 'Pitcairn'},
            {'Name': '波多黎各', 'Code': 'PR', EnName: 'Puerto Rico'},
            {'Name': '葡萄牙', 'Code': 'PT', EnName: 'Portugal'},
            {'Name': '巴拉圭', 'Code': 'PY', EnName: 'Paraguay'},
            {'Name': '卡塔尔', 'Code': 'QA', EnName: 'Qatar'},
            {'Name': '留尼旺岛', 'Code': 'RE', EnName: 'Reunion'},
            {'Name': '罗马尼亚', 'Code': 'RO', EnName: 'Romania'},
            {'Name': '塞尔维亚', 'Code': 'RS', EnName: 'Serbia'},
            {'Name': '俄罗斯', 'Code': 'RU', EnName: 'Russian Federation'},
            {'Name': '卢旺达', 'Code': 'RW', EnName: 'Rwanda'},
            {'Name': '沙特阿拉伯', 'Code': 'SA', EnName: 'Saudi Arabia'},
            {'Name': '索罗门群岛', 'Code': 'SB', EnName: 'Solomon Islands'},
            {'Name': '塞舌尔', 'Code': 'SC', EnName: 'Seychelles'},
            {'Name': '苏丹', 'Code': 'SD', EnName: 'Sudan'},
            {'Name': '瑞典', 'Code': 'SE', EnName: 'Sweden'},
            {'Name': '新加坡', 'Code': 'SG', EnName: 'Singapore'},
            {'Name': '圣赫勒拿岛', 'Code': 'SH', EnName: 'Saint Helena'},
            {'Name': '斯洛文尼亚', 'Code': 'SI', EnName: 'Slovenia'},
            {'Name': '斯匹次卑尔根群岛', 'Code': 'SJ', EnName: 'Spitsbergen(svalbard)'},
            {'Name': '斯洛伐克', 'Code': 'SK', EnName: 'Slovak Republic'},
            {'Name': '塞拉利昂', 'Code': 'SL', EnName: 'Sierra Leone'},
            {'Name': '圣马力诺', 'Code': 'SM', EnName: 'San Marino'},
            {'Name': '塞内加尔', 'Code': 'SN', EnName: 'Senegal'},
            {'Name': '索马里', 'Code': 'SO', EnName: 'Somalia'},
            {'Name': '苏里南', 'Code': 'SR', EnName: 'Suriname'},
            {'Name': '圣多美和普林西比', 'Code': 'ST', EnName: 'Sao Tome And Principe'},
            {'Name': '萨尔瓦多', 'Code': 'SV', EnName: 'El Salvador'},
            {'Name': '阿拉伯叙利亚共和国（叙利亚）', 'Code': 'SY', EnName: 'Syrian Arab Republic'},
            {'Name': '斯威士兰', 'Code': 'SZ', EnName: 'Swaziland'},
            {'Name': '特克斯和凯科斯群岛', 'Code': 'TC', EnName: 'Turks And Caicos Islands'},
            {'Name': '乍得', 'Code': 'TD', EnName: 'Chad'},
            {'Name': '法国南部地区', 'Code': 'TF', EnName: 'French Southern Territories'},
            {'Name': '多哥', 'Code': 'TG', EnName: 'Togo'},
            {'Name': '泰国', 'Code': 'TH', EnName: 'Thailand'},
            {'Name': '塔吉克', 'Code': 'TJ', EnName: 'Tajikistan'},
            {'Name': '托克劳', 'Code': 'TK', EnName: 'Tokelau'},
            {'Name': '土库曼', 'Code': 'TM', EnName: 'Turkmenistan'},
            {'Name': '突尼斯', 'Code': 'TN', EnName: 'Tunisia'},
            {'Name': '汤加', 'Code': 'TO', EnName: 'Tonga'},
            {'Name': '东帝汶', 'Code': 'TP', EnName: 'East Timor A)'},
            {'Name': '土耳其', 'Code': 'TR', EnName: 'Turkey'},
            {'Name': '特里尼达和多巴哥', 'Code': 'TT', EnName: 'Trinidad And Tobago'},
            {'Name': '图瓦卢', 'Code': 'TV', EnName: 'Tuvalu'},
            {'Name': '台湾', 'Code': 'TW', EnName: 'Taiwan'},
            {'Name': '坦桑尼亚', 'Code': 'TZ', EnName: 'Tanzania'},
            {'Name': '乌克兰', 'Code': 'UA', EnName: 'Ukraine'},
            {'Name': '乌干达', 'Code': 'UG', EnName: 'Uganda'},
            {'Name': '美国本土外小岛屿', 'Code': 'UM', EnName: 'United States Minor Outlying Islands'},
            {'Name': '美国', 'Code': 'US', EnName: 'United States'},
            {'Name': '乌拉圭', 'Code': 'UY', EnName: 'Uruguay'},
            {'Name': '乌兹别克', 'Code': 'UZ', EnName: 'Uzbekistan'},
            {'Name': '教廷', 'Code': 'VA', EnName: 'Vatican City State (holy See)'},
            {'Name': '圣文森特和格林纳丁斯', 'Code': 'VC', EnName: 'Saint Vincent And The Grenadines'},
            {'Name': '委内瑞拉', 'Code': 'VE', EnName: 'Venezuela'},
            {'Name': '英属维尔京群岛（英属维尔京群岛）', 'Code': 'VG', EnName: 'Tortola (british Virgin Islands)'},
            {'Name': '美国美属维尔京群岛', 'Code': 'VI', EnName: 'Virgin Islands (u.s.)'},
            {'Name': '越南', 'Code': 'VN', EnName: 'Viet Nam'},
            {'Name': '瓦努阿图', 'Code': 'VU', EnName: 'Vanuatu'},
            {'Name': '瓦利斯群岛和富图纳群岛', 'Code': 'WF', EnName: 'Wallis And Futuna Islands'},
            {'Name': '西萨摩亚', 'Code': 'WS', EnName: 'SAMOA, WESTERN'},
            {'Name': '加那利群岛', 'Code': 'XA', EnName: 'Canary Islands'},
            {'Name': '特里斯坦 - 达库尼亚岛', 'Code': 'XB', EnName: 'Tristan Da Cunha'},
            {'Name': '海峡群岛', 'Code': 'XC', EnName: 'Channel Islands'},
            {'Name': '上升', 'Code': 'XD', EnName: 'Ascension'},
            {'Name': '加沙地带汗尤尼斯', 'Code': 'XE', EnName: 'Gaza And Khan Yunis'},
            {'Name': '科西嘉岛', 'Code': 'XF', EnName: 'Corsica'},
            {'Name': '北非，西班牙属土', 'Code': 'XG', EnName: 'Spanish Territories Of N. Africa'},
            {'Name': '亚速尔群岛', 'Code': 'XH', EnName: 'Azores'},
            {'Name': '马德拉', 'Code': 'XI', EnName: 'Madeira'},
            {'Name': '巴利阿里群岛', 'Code': 'XJ', EnName: 'Balearic Islands'},
            {'Name': '加罗林群岛', 'Code': 'XK', EnName: 'Caroline Islands'},
            {'Name': '属土群岛（库克群岛）在新西兰', 'Code': 'XL', EnName: 'New Zealand Islands Territories'},
            {'Name': '威克岛', 'Code': 'XM', EnName: 'Wake Island'},
            {'Name': '科索沃', 'Code': 'XO', EnName: 'Kosovo'},
            {'Name': '也门', 'Code': 'YE', EnName: 'Yemen (republic Of)'},
            {'Name': '马约特岛', 'Code': 'YT', EnName: 'Mayotte'},
            {'Name': '南非', 'Code': 'ZA', EnName: 'South Africa'},
            {'Name': '赞比亚', 'Code': 'ZM', EnName: 'Zambia'},
            {'Name': '津巴布韦', 'Code': 'ZW', EnName: 'Zimbabwe'}
        ])
        //====城市选择控件====//
        .controller('hlsCityCtrl', ['$scope', 'cnCityData', 'countryData', function ($scope, cnCityData, countryData) {

            $scope.activeTab = "hot";
            $scope.hlsAreaTabOption = ['hot', 'ABCD', 'EFGH', 'IJKL', 'MNOP', 'QRST', 'UVWX', 'YZ'];
            $scope.hlsAreaDataOption = ['ABCD', 'EFGH', 'IJKL', 'MNOP', 'QRST', 'UVWX', 'YZ'];

            $scope.tabChange = function (tab) {
                $scope.activeTab = tab;
            }
            $scope.getTabName = function (tab) {
                return tab == 'hot' ? '热门' : tab;
            }
            $scope.isContentShow = function (tab) {
                if (!tab)tab = 'hot';
                return $scope.activeTab == tab;
            }
            $scope.getAreaData = function (tab) {
                if (!tab) {
                    return $scope.Data.hot;
                } else {
                    return $scope.Data[tab];
                }
            }
            $scope.AreaSelected = function (area) {
                $scope.hlsData.selectedData = area;
            }
            $scope.hlsAreaTabActiveClass = function (tab) {
                return $scope.activeTab == tab ? 'hlsAreaTabActive' : '';
            }
            $scope.hlsAreaActiveClass = function (area) {
                return $scope.hlsData.selectedData == area ? 'hlsAreaAction' : '';
            }
            $scope.init = function () {
                $scope.Data = cnCityData;
                $("div.dropdown-menu").on("click", "[data-stopPropagation]", function (e) {
                    e.stopPropagation();
                });
            }

            $scope.init();
        }])
        .directive('hlsCity', function () {
            return {
                restrict: 'E',
                scope: {
                    hlsData: '=',
                    hlsClass: '@',
                    hlsPlaceholder: '@'
                },
                replace: true,
                controller: 'hlsCityCtrl',
                templateUrl: '/hls/hlsCity.html',
                link: function (scope, element, attrs, ctrls) {
                }
            };
        })
        //====国家选择控件====//
        .controller('hlsCountryCtrl', ['$scope', 'cnCityData', 'countryData', function ($scope, cnCityData, countryData) {

            $scope.activeTab = "hot";
            $scope.hlsAreaTabOption = ['hot', 'ABCD', 'EFGH', 'IJKL', 'MNOP', 'QRST', 'UVWX', 'YZ'];
            $scope.hlsAreaDataOption = ['ABCD', 'EFGH', 'IJKL', 'MNOP', 'QRST', 'UVWX', 'YZ'];

            $scope.tabChange = function (tab) {
                $scope.activeTab = tab;
            }
            $scope.getTabName = function (tab) {
                return tab == 'hot' ? '热门' : tab;
            }

            $scope.isContentShow = function (tab) {
                if (!tab)tab = 'hot';
                return $scope.activeTab == tab;
            }

            $scope.getAreaData = function (tab) {
                if (!tab) {
                    return $scope.Data.hot;
                } else {
                    return $scope.Data[tab];
                }
            }
            $scope.AreaSelected = function (area) {
                $scope.hlsData.selectedData = area;
            }
            $scope.hlsAreaTabActiveClass = function (tab) {
                return $scope.activeTab == tab ? 'hlsAreaTabActive' : '';
            }

            $scope.hlsAreaActiveClass = function (area) {
                return $scope.hlsData.selectedData == area ? 'hlsAreaAction' : '';
            }

            $scope.groupCountry = function (countrys) {
                var newArr = [];
                var sortKey = "EnName";
                var areaGroup = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
                angular.forEach(areaGroup, function (g) {
                    newArr[g] = [];
                    angular.forEach(countrys, function (area) {
                        if (area[sortKey].startWith(g)) {
                            newArr[g].push(area);
                        }
                    });
                })
                var n = newArr;
                return newArr;
            }

            $scope.init = function () {
                $scope.Data = $scope.groupCountry(countryData);
                $scope.Data.hot = [
                    {'Name': '澳大利亚', 'Code': 'AU', EnName: 'Australia'},
                    {'Name': '奥地利', 'Code': 'AT', EnName: 'Austria'},
                    {'Name': '加拿大', 'Code': 'CA', EnName: 'Canada'},
                    {'Name': '法国', 'Code': 'FR', EnName: 'France'},
                    {'Name': '德国', 'Code': 'DE', EnName: 'Germany'},
                    {'Name': '印度', 'Code': 'IN', EnName: 'India'},
                    {'Name': '以色列', 'Code': 'IL', EnName: 'Israel'},
                    {'Name': '意大利', 'Code': 'IT', EnName: 'Italy'},
                    {'Name': '马来西亚', 'Code': 'MY', EnName: 'Malaysia'},
                    {'Name': '墨西哥', 'Code': 'MX', EnName: 'Mexico'},
                    {'Name': '新西兰', 'Code': 'NZ', EnName: 'New Zealand'},
                    {'Name': '菲律宾', 'Code': 'PH', EnName: 'Philippines'},
                    {'Name': '新加坡', 'Code': 'SG', EnName: 'Singapore'},
                    {'Name': '韩国', 'Code': 'KR', EnName: 'Korea'},
                    {'Name': '西班牙', 'Code': 'ES', EnName: 'Spain'},
                    {'Name': '泰国', 'Code': 'TH', EnName: 'Thailand'},
                    {'Name': '英国', 'Code': 'GB', EnName: 'United Kingdom'},
                    {'Name': '美国', 'Code': 'US', EnName: 'United States'}
                ];
                $("div.dropdown-menu").on("click", "[data-stopPropagation]", function (e) {
                    e.stopPropagation();
                });
            }

            $scope.init();
        }])
        .directive('hlsCountry', function () {
            return {
                restrict: 'E',
                scope: {
                    hlsData: '=',
                    hlsClass: '@',
                    hlsPlaceholder: '@'
                },
                replace: true,
                controller: 'hlsCountryCtrl',
                templateUrl: '/hls/hlsCountry.html',
                link: function (scope, element, attrs, ctrls) {
                }
            };
        });

    //=====  日期时间控件=====/
    angular.module('hls.ui.datetimepicker', ['ui.bootstrap.datetimepicker'])
        .run(['$templateCache', function ($templateCache) {
            $templateCache.put('/hls/datetimepicker.html',
                '<div class="dropdown">' +
                '<a class="dropdown-toggle" id="{{ToggleID}}" role="button" data-toggle="dropdown" data-target="#" style="cursor:pointer;">' +
                '<div class="input-group">' +
                '<input type="text" class="form-control" data-ng-model="data.dateDropDownInputFormatting" disabled style="cursor:pointer;">' +
                '<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>' +
                '</div>' +
                '</a>' +
                '<ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">' +
                '<datetimepicker data-ng-model="data.dateDropDownInputNoFormatting" data-datetimepicker-config="config.datetimePicker" data-on-set-time="inputOnTimeSet(newDate)"></datetimepicker>' +
                '</ul>' +
                '</div>'
            );
        }])
        .controller('hlsDateTimePickerController', ['$scope', function ($scope) {

            $scope.data = {};
            $scope.config = {
                datetimePicker: {
                    minView: 'day'
                }
            };
            $scope.ToggleID = 'dropdown' + Math.floor(Math.random() * (100 + 1));

            $scope.inputOnTimeSet = function (newDate) {
                $('#' + $scope.ToggleID).dropdown('toggle');
                ChangeSelectModel(newDate);
            };

            $scope.$watch('selectModel', function (newValue, oldValue) {
                if (angular.isDefined(newValue) && newValue != null && newValue != '' && newValue != oldValue) {
                    var date = ChangeDataInput(newValue);
                    ChangeDataInputView(date);
                }
            });

            function Init() {
                if (angular.isDefined($scope.selectMode) && $scope.selectMode === 'time') {
                    $scope.config.datetimePicker.minView = 'minute';
                }

                if (angular.isUndefined($scope.selectModel) || $scope.selectModel == null || $scope.selectModel == '') {
                    ChangeSelectModel(new Date());
                }
                var date = ChangeDataInput($scope.selectModel);
                ChangeDataInputView(date);
            };

            function ChangeSelectModel(date) {
                if ($scope.config.datetimePicker.minView === 'day') {
                    $scope.selectModel = date.format("yyyy-MM-dd");
                }
                else {
                    $scope.selectModel = date.format("yyyy-MM-dd HH:mm:ss");
                }
            };

            function ChangeDataInput(value) {
                var date = undefined;
                if (angular.isDate(value)) {
                    date = value;
                } else {
                    date = new Date(value.replace(/-/ig, '/'));
                }
                $scope.data.dateDropDownInputNoFormatting = date;
                return date;
            };

            function ChangeDataInputView(date) {
                if ($scope.config.datetimePicker.minView === 'day') {
                    $scope.data.dateDropDownInputFormatting = date.format("yyyy-MM-dd");
                }
                else {
                    $scope.data.dateDropDownInputFormatting = date.format("yyyy-MM-dd HH:mm:ss");
                }
            };

            Init();
        }])
        .directive('hlsDatetimepicker', function () {
            return {
                restrict: 'E',
                scope: {
                    selectModel: '=',
                    selectMode: '@'
                },
                replace: true,
                controller: 'hlsDateTimePickerController',
                templateUrl: '/hls/datetimepicker.html',
                link: function (scope, element, attrs, ctrls) {
                }
            };
        });

    //====分页控件====//
    angular.module('hls.ui.pagination', [])

        .run(["$templateCache", function ($templateCache) {

            $templateCache.put("template/hls/pagination/hlspagination.html",
                "<div class=\"pagination-div\" ng-show=\"totalPages>1\">" +
                "<ul class=\"pagination\">\n" +
                "  <li ng-if=\"showInfo\"><span style=\"color:darkslategray\">共 <b ng-bind=\"totalItems\"></b>条<b  ng-bind=\"totalPages\" ></b>页 <span></li>\n" +
                "  <li ng-if=\"boundaryLinks\" ng-class=\"{disabled: noPrevious()}\"><a href ng-click=\"selectPage(1)\">{{getText('first')}}</a></li>\n" +
                "  <li ng-if=\"directionLinks\" ng-class=\"{disabled: noPrevious()}\"><a href ng-click=\"selectPage(page - 1)\">{{getText('previous')}}</a></li>\n" +
                "  <li ng-repeat=\"page in pages track by $index\" ng-class=\"{active: page.active}\"><a href ng-click=\"selectPage(page.number)\">{{page.text}}</a></li>\n" +
                "  <li ng-if=\"directionLinks\" ng-class=\"{disabled: noNext()}\"><a href ng-click=\"selectPage(page + 1)\">{{getText('next')}}</a></li>\n" +
                "  <li ng-if=\"boundaryLinks\" ng-class=\"{disabled: noNext()}\"><a href ng-click=\"selectPage(totalPages)\">{{getText('last')}}</a></li>\n" +
                //"  <li><a><input type=\"number\" ng-model=\"gopage\" ng-keypress=\"gokeypress($event)\" class=\"form-group\" min=\"1\" max={{totalPages}} style=\"float:left;margin:0px;width:50px;width:40px;\" /></a></li>\n" +
                //"  <li style=\"\"><a href ng-click=\"selectPage(gopage)\">{{getText('go')}}</a></li>\n" +
                "</ul>" +
                "</div>");
        }])
        .constant('paginationConfig', {
            itemsPerPage: 10,
            showInfo: true,
            boundaryLinks: true,
            directionLinks: true,
            firstText: '首页',
            previousText: ' 上一页 ',
            nextText: ' 下一页 ',
            lastText: '尾页',
            goText: '跳转',
            rotate: true,
            maxSize: 10,

        })
        .controller('hlsPaginationController', ['$scope', '$attrs', '$parse', 'paginationConfig', function ($scope, $attrs, $parse, paginationConfig) {
            var self = this,
                ngModelCtrl = {$setViewValue: angular.noop}, // nullModelCtrl
                setNumPages = $attrs.numPages ? $parse($attrs.numPages).assign : angular.noop;

            this.init = function (ngModelCtrl_, config) {
                ngModelCtrl = ngModelCtrl_;
                this.config = config;

                ngModelCtrl.$render = function () {
                    self.render();
                };

                if ($attrs.pageSize) {
                    $scope.$parent.$watch($parse($attrs.pageSize), function (value) {
                        self.itemsPerPage = parseInt(value, 10);
                        $scope.totalPages = self.calculateTotalPages();
                    });
                } else {
                    this.itemsPerPage = config.itemsPerPage;
                }
            };

            this.calculateTotalPages = function () {
                var totalPages = this.itemsPerPage < 1 ? 1 : Math.ceil($scope.totalItems / this.itemsPerPage);
                return Math.max(totalPages || 0, 1);
            };

            this.render = function () {
                $scope.page = parseInt(ngModelCtrl.$viewValue, 10) || 1;
                $scope.gopage = 0;
            };

            $scope.selectPage = function (page) {
                if ($scope.page !== page && page > 0 && page <= $scope.totalPages) {
                    ngModelCtrl.$setViewValue(page);
                    ngModelCtrl.$render();
                }
            };

            $scope.gokeypress = function (ev) {
                if (ev.keyCode !== 13) {
                    return;
                }
                $scope.selectPage($scope.gopage);
            }

            $scope.getText = function (key) {
                return $scope[key + 'Text'] || self.config[key + 'Text'];
            };
            $scope.getShow = function (key) {
                return $scope['show' + key] || self.config['show' + key];
            }
            $scope.noPrevious = function () {
                return $scope.page === 1;
            };
            $scope.noNext = function () {
                return $scope.page === $scope.totalPages;
            };

            $scope.getInfo = function () {
                return '共' + $scope.page + '页|' + $scope.totalItems + '条';
            }

            $scope.$watch('totalItems', function () {
                $scope.totalPages = self.calculateTotalPages();
            });

            $scope.$watch('totalPages', function (value) {
                setNumPages($scope.$parent, value); // Readonly variable

                if ($scope.page > value) {
                    $scope.selectPage(value);
                } else {
                    ngModelCtrl.$render();
                }
            });
        }])
        .directive('hlsPagination', [
            '$parse', 'paginationConfig', function ($parse, paginationConfig) {
                return {
                    restrict: 'EA',
                    scope: {
                        totalItems: '=',
                        pageSize: '=',
                        firstText: '@',
                        previousText: '@',
                        nextText: '@',
                        lastText: '@',
                        showFirst: '@',
                        showLast: '@',
                        showInfo: '@',
                        goText: '@',
                    },
                    require: ['hlsPagination', '?ngModel'],
                    controller: 'hlsPaginationController',
                    templateUrl: 'template/hls/pagination/hlspagination.html',
                    replace: true,
                    link: function (scope, element, attrs, ctrls) {
                        var paginationCtrl = ctrls[0], ngModelCtrl = ctrls[1];

                        if (!ngModelCtrl) {
                            return; // do nothing if no ng-model
                        }

                        // Setup configuration parameters
                        var maxSize = angular.isDefined(attrs.maxSize) ? scope.$parent.$eval(attrs.maxSize) : paginationConfig.maxSize,
                            rotate = angular.isDefined(attrs.rotate) ? scope.$parent.$eval(attrs.rotate) : paginationConfig.rotate;
                        scope.boundaryLinks = angular.isDefined(attrs.boundaryLinks) ? scope.$parent.$eval(attrs.boundaryLinks) : paginationConfig.boundaryLinks;
                        scope.directionLinks = angular.isDefined(attrs.directionLinks) ? scope.$parent.$eval(attrs.directionLinks) : paginationConfig.directionLinks;
                        scope.showInfo = angular.isDefined(attrs.showInfo) ? scope.$parent.$eval(attrs.showInfo) : paginationConfig.showInfo;

                        paginationCtrl.init(ngModelCtrl, paginationConfig);

                        if (attrs.maxSize) {
                            scope.$parent.$watch($parse(attrs.maxSize), function (value) {
                                maxSize = parseInt(value, 10);
                                paginationCtrl.render();
                            });
                        }

                        // Create page object used in template
                        function makePage(number, text, isActive) {
                            return {
                                number: number,
                                text: text,
                                active: isActive
                            };
                        }

                        function getPages(currentPage, totalPages) {
                            var pages = [];

                            // Default page limits
                            var startPage = 1, endPage = totalPages;
                            var isMaxSized = (angular.isDefined(maxSize) && maxSize < totalPages);

                            // recompute if maxSize
                            if (isMaxSized) {
                                if (rotate) {
                                    // Current page is displayed in the middle of the visible ones
                                    startPage = Math.max(currentPage - Math.floor(maxSize / 2), 1);
                                    endPage = startPage + maxSize - 1;

                                    // Adjust if limit is exceeded
                                    if (endPage > totalPages) {
                                        endPage = totalPages;
                                        startPage = endPage - maxSize + 1;
                                    }
                                } else {
                                    // Visible pages are paginated with maxSize
                                    startPage = ((Math.ceil(currentPage / maxSize) - 1) * maxSize) + 1;

                                    // Adjust last page if limit is exceeded
                                    endPage = Math.min(startPage + maxSize - 1, totalPages);
                                }
                            }

                            // Add page number links
                            for (var number = startPage; number <= endPage; number++) {
                                var page = makePage(number, number, number === currentPage);
                                pages.push(page);
                            }

                            // Add links to move between page sets
                            if (isMaxSized && !rotate) {
                                if (startPage > 1) {
                                    var previousPageSet = makePage(startPage - 1, '...', false);
                                    pages.unshift(previousPageSet);
                                }

                                if (endPage < totalPages) {
                                    var nextPageSet = makePage(endPage + 1, '...', false);
                                    pages.push(nextPageSet);
                                }
                            }

                            return pages;
                        }

                        var originalRender = paginationCtrl.render;
                        paginationCtrl.render = function () {
                            originalRender();
                            if (scope.page > 0 && scope.page <= scope.totalPages) {
                                scope.pages = getPages(scope.page, scope.totalPages);
                            }
                        };
                    }
                };
            }
        ])

    //===表单输入验证===//
    angular.module('hls.ui.formvalid', ['hls.core'])
        .directive('dirNum', ['validateService', 'validaeCtrlService', function (validateService, validaeCtrlService) {
            return validaeCtrlService.directiveValidFn('dirNum', validateService, validaeCtrlService);
        }])
        .directive('dirFloat', ['validateService', 'validaeCtrlService', function (validateService, validaeCtrlService) {
            return validaeCtrlService.directiveValidFn('dirFloat', validateService, validaeCtrlService);
        }])
        .directive('dirRange', ['validateService', 'validaeCtrlService', function (validateService, validaeCtrlService) {
            return validaeCtrlService.directiveValidFn('dirRange', validateService, validaeCtrlService);
        }])
        .directive('dirRangelength', ['validateService', 'validaeCtrlService', function (validateService, validaeCtrlService) {
            return validaeCtrlService.directiveValidFn('dirRangelength', validateService, validaeCtrlService);
        }])
        .directive('dirEqual', ['validateService', 'validaeCtrlService', function (validateService, validaeCtrlService) {
            return validaeCtrlService.directiveValidFn('dirEqual', validateService, validaeCtrlService);
        }])
        .directive('dirKeyValid', ['validateService', 'validaeCtrlService', function (validateService, validaeCtrlService) {
            return validaeCtrlService.directiveValidKeyValidFn('dirKeyValid', validateService, validaeCtrlService);
        }])
        .directive('dirDirectiveExt', ['validateService', 'validaeCtrlService', function (validateService, validaeCtrlService) {
            return validaeCtrlService.directiveValidExtFn('dirDirectiveExt', validateService, validaeCtrlService);
        }])
        .service('validaeCtrlService', function () {
            var service = {};

            var defaultErrorMsg = {
                'required': '值不能为空',
                'min': '最小值不正确',
                'max': '最大值不正确',
                'minlength': '最小长度不正确',
                'maxlength': '最大长度不正确',
                'pattern': '模式匹配不正确',
                'number': '值不是数值类型',
                'email': '邮件格式不正确',
                'url': 'URL地址格式不正确',
                'direqual': '两次输入的值不相等',
                'dirnum': '值不是正整数',
                'dirfloat': '值不是浮点数',
                'dirrange': '值不在限定的范围内',
                'dirrangelength': '长度不在限定范围内',
                'dirkeyvalid': '该值已经存在'
            };

            var messageName = "msg";

            service.directiveValidTypeFn = function (directiveName, scope, element, attrs, ctrl, input, validateService) {
                switch (directiveName) {
                    case 'dirNum':
                        return validateService.isNum(input);
                    case 'dirFloat':
                        return validateService.isFloat(input);
                    case 'dirRange':
                        var range = attrs[directiveName];
                        var rindex = range.indexOf(',');
                        var min = range.slice(0, rindex);
                        var max = range.slice(rindex + 1, range.length);
                        return validateService.range(input, min, max);
                    case 'dirRangelength':
                        var rangeLength = attrs[directiveName];
                        var rlindex = rangeLength.indexOf(',');
                        var minLength = rangeLength.slice(0, rlindex);
                        var maxLength = rangeLength.slice(rlindex + 1, rangeLength.length);
                        return validateService.rangeLength(input, minLength, maxLength);
                    case 'dirEqual':
                        var compareElementName = attrs[directiveName];
                        var compareElement = angular.element(document.getElementsByName(compareElementName));
                        return validateService.equal(input, compareElement.val());
                }
                return true;
            }

            service.directiveValidFn = function (directiveName, validateService, validaeCtrlService) {
                return {
                    restrict: 'A',
                    require: 'ngModel',
                    link: function (scope, element, attrs, ctrl) {
                        var verify = function (input) {
                            return validaeCtrlService.directiveValidTypeFn(directiveName, scope, element, attrs, ctrl, input, validateService);
                        }

                        ctrl.$parsers.push(function (input) {
                            var validity = verify(input);
                            ctrl.$setValidity(angular.lowercase(directiveName), validity);

                            return input;
                        });
                        ctrl.$formatters.push(function (input) {
                            var validity = verify(input);
                            ctrl.$setValidity(angular.lowercase(directiveName), validity);

                            return input;
                        });
                    }
                }
            }

            service.directiveValidKeyValidFn = function (directiveName, validateService, validaeCtrlService) {
                return {
                    restrict: 'A',
                    require: 'ngModel',
                    scope: {
                        keyValidFn: '&'
                    },
                    link: function (scope, element, attrs, ctrl) {
                        var verify = function (input) {
                            var v = scope.keyValidFn({input: input});

                            return v;
                        }
                        //check each input
                        /*ctrl.$parsers.push(function (input) {
                         var validity = verify(input);
                         ctrl.$setValidity(angular.lowercase(directiveName), validity);

                         return input;
                         });
                         ctrl.$formatters.push(function (input) {
                         var validity = verify(input);
                         ctrl.$setValidity(angular.lowercase(directiveName), validity);

                         return input;
                         });*/

                        //only check blur
                        element.bind('focus', function (evt) {
                            scope.$apply(function () {
                                if (ctrl.$pristine) {
                                    return;
                                }

                                validaeCtrlService.removeErrorMsg(element, attrs, ctrl);
                            });
                        }).bind('blur', function (evt) {
                            scope.$apply(function () {
                                if (ctrl.$pristine) {
                                    return;
                                }
                                /*var isValid = verify(element.val());
                                 if (!isValid) {
                                 var properName = angular.lowercase('dirkeyvalid' + messageName);
                                 var message = attrs[properName];
                                 message = validateService.isEmpty(message) ? '该值已经存在' : message;

                                 validaeCtrlService.addErrorMsg(element, attrs, ctrl, message);
                                 }*/
                                //promise mode
                                var promise = verify(element.val());
                                promise.then(function (result) {
                                    /*ctrl.$setValidity(angular.lowercase(directiveName), result);*/
                                    // ctrl.$setValidity('dirkeyvalid', result);
                                    if (!result) {
                                        var properName = angular.lowercase('dirkeyvalid' + messageName);
                                        var message = attrs[properName];
                                        message = validateService.isEmpty(message) ? '该值已经存在' : message;

                                        validaeCtrlService.addErrorMsg(element, attrs, ctrl, message);
                                    }
                                }, function (reason) {
                                });
                            });
                        });
                    }
                }
            }

            service.directiveValidExtFn = function (directiveName, validateService, validaeCtrlService) {
                return {
                    restrict: 'A',
                    require: 'ngModel',
                    link: function (scope, element, attrs, ctrl) {
                        element.bind('focus', function (evt) {
                            scope.$apply(function () {
                                if (ctrl.$pristine) {
                                    return;
                                }

                                validaeCtrlService.removeErrorMsg(element, attrs, ctrl);
                            });
                        }).bind('blur', function (evt) {
                            scope.$apply(function () {
                                if (ctrl.$pristine) {
                                    return;
                                }
                                for (var err in ctrl.$error) {
                                    var value = ctrl.$error[err];
                                    if (value) {
                                        var properName = angular.lowercase(err + messageName);
                                        var message = attrs[properName];
                                        message = validateService.isEmpty(message) ? validaeCtrlService.getErrorMsg(err) : message;
                                        validaeCtrlService.addErrorMsg(element, attrs, ctrl, message);
                                    }
                                }
                            });
                        });
                    }
                }
            }

            service.setValidateInfo = function (ctrl, isValid) {
                ctrl.$setValidity('validateError', isValid);
            }

            service.addErrorMsg = function (element, attrs, ctrl, message) {
                var parentElement = element.parent();

                parentElement.addClass('has-error');

                var showMsg = '<span class="help-block dir-error">' + message + '</span>';

                element.after(showMsg);
            }

            service.removeErrorMsg = function (element, attrs, ctrl) {
                var parentElement = element.parent();

                parentElement.removeClass('has-error');

                var spanInfos = parentElement.find('span');

                angular.forEach(spanInfos, function (value) {
                    var span = angular.element(value);
                    if (span.hasClass('dir-error')) {
                        span.remove();
                    }
                });
            }

            service.getErrorMsg = function (errType) {
                return defaultErrorMsg[errType];
            }

            return service;
        });

    //== hls.ui.dialogs 弹出窗控件=======================================================//
    angular.module('hls.ui.dialogs.controllers', ['ui.bootstrap.modal'])
        .run(['$templateCache', function ($templateCache) {
            $templateCache.put('/dialogs/error.html', '<div class="error_modal"><div class="modal-header dialog-header-error">    <h4><i class="glyphicon glyphicon-warning-sign" > </i> 错误</h4></div><div class="modal-body">{{msg}}</div> <div class="modal-footer"><button class="btn btn-hls" ng-click="close()"  focus-me="{{true}}">关闭</button></div></div>');
            $templateCache.put('/dialogs/notify.html', '<div class="notify_modal"><div class="modal-header dialog-header-notify">    <h4><i class="glyphicon glyphicon-info-sign" > </i> {{header}}</h4></div><div class="modal-body">{{msg}}</div> <div class="modal-footer"><button class="btn btn-hls" ng-click="close()"  focus-me="{{true}}">关闭</button></div></div>');
            $templateCache.put('/dialogs/confirm.html', '<div class="confirm_modal"><div class="modal-header dialog-header-confirm"><h4><i class="glyphicon glyphicon-check" > </i>{{header}}</h4></div><div class="modal-body"><p ng-bind-html="msg"></p></div>  <div class="modal-footer">   <button class="btn btn-info" ng-click="yes()">确定</button>   <button class="btn btn-default" ng-click="no()" focus-me="{{true}}">取消</button> </div></div>');
        }])
        .controller('errorDialogCtrl', ['$scope', '$uibModalInstance', 'msg', function ($scope, $uibModalInstance, msg) {
            $scope.msg = (angular.isDefined(msg)) ? msg : 'An unknown error has occurred.';

            $scope.close = function () {
                $uibModalInstance.close();
            };
        }])
        .controller('notifyDialogCtrl', ['$scope', '$uibModalInstance', 'header', 'msg', function ($scope, $uibModalInstance, header, msg) {
            $scope.header = (angular.isDefined(header)) ? header : '提示';
            $scope.msg = (angular.isDefined(msg)) ? msg : 'Unknown application notification.';

            $scope.close = function () {
                $uibModalInstance.close();
            };
        }])
        .controller('confirmDialogCtrl', ['$scope', '$uibModalInstance', 'header', 'msg', function ($scope, $uibModalInstance, header, msg) {
            $scope.header = (angular.isDefined(header)) ? header : '确认';
            $scope.msg = (angular.isDefined(msg)) ? msg : 'Confirmation required.';

            $scope.no = function () {
                $uibModalInstance.close('no');
            };
            $scope.yes = function () {
                $uibModalInstance.close('yes');
            };
        }]);
    angular.module('hls.ui.dialogs', ['ui.bootstrap.modal', 'hls.ui.dialogs.controllers'])
        .factory('$dialogs', ['$uibModal', function ($uibModal) {
            return {
                error: function (msg, callback_ok) {
                    var modalInstance = $uibModal.open({
                        templateUrl: '/dialogs/error.html',
                        controller: 'errorDialogCtrl',
                        backdrop: 'static',
                        resolve: {
                            msg: function () {
                                return angular.copy(msg);
                            }
                        }
                    });

                    modalInstance.result.then(function () {
                            if (angular.isFunction(callback_ok)) {
                                callback_ok();
                            }
                        },
                        function () {
                        });
                },
                notify: function (header, msg, callback_ok) {
                    var modalInstance = $uibModal.open({
                        templateUrl: '/dialogs/notify.html',
                        controller: 'notifyDialogCtrl',
                        backdrop: 'static',
                        resolve: {
                            header: function () {
                                return angular.copy(header);
                            },
                            msg: function () {
                                return angular.copy(msg);
                            }
                        }
                    });
                    modalInstance.result.then(function () {
                            if (angular.isFunction(callback_ok)) {
                                callback_ok();
                            }
                        },
                        function () {
                        });
                },
                confirm: function (header, msg, callback_ok, callback_cancel) {
                    var modalInstance = $uibModal.open({
                        templateUrl: '/dialogs/confirm.html',
                        controller: 'confirmDialogCtrl',
                        backdrop: 'static',
                        resolve: {
                            header: function () {
                                return angular.copy(header);
                            },
                            msg: function () {
                                return angular.copy(msg);
                            }
                        }
                    });
                    modalInstance.result.then(function (data) {
                            if (angular.isFunction(callback_ok) && data == 'yes') {
                                callback_ok();
                            }
                            if (angular.isFunction(callback_cancel) && data == 'no') {
                                callback_cancel();
                            }
                        },
                        function () {
                        });
                },
                create: function (url, ctrlr, data, callback_ok, callback_cancel) {
                    var modalInstance = $uibModal.open({
                        templateUrl: url,
                        controller: ctrlr,
                        backdrop: 'static',
                        resolve: {
                            data: function () {
                                return angular.copy(data);
                            }
                        }
                    });
                    modalInstance.result.then(function (result_data) {
                        if (angular.isDefined(callback_ok)) {
                            callback_ok(result_data);
                        }

                    }, function () {
                        if (angular.isDefined(callback_cancel)) {
                            callback_cancel();
                        }
                    });
                },
                openModal: function (templateUrl, controller, modalData, size, okcallbackFun, cancelcallbackFun) {
                    var modalInstance = $uibModal.open({
                        templateUrl: templateUrl,
                        controller: controller,
                        size: size,
                        backdrop: 'static',
                        resolve: {
                            modalData: function () {
                                return angular.copy(modalData);
                            }
                        }
                    });

                    modalInstance.result.then(function (data) {
                        if (angular.isFunction(okcallbackFun)) {
                            okcallbackFun(data);
                        }
                    }, function (data) {
                        if (angular.isFunction(cancelcallbackFun)) {
                            cancelcallbackFun(data);
                        }
                    });
                }
            }
        }]);

    //== hls.ui.include 局部页面控件==========================================================//
    angular.module('hls.ui.include', [])
        .run(['$templateCache', function ($templateCache) {
            $templateCache.put('/template/hls/include.html', '<div ng-include="IncludeUrl"></div>');
        }])
        .controller('hlsIncludeController', ['$q', '$rootScope', '$scope', function ($q, $rootScope, $scope) {

            $scope.$watch('url', function (newValue, oldValue) {
                if (angular.isDefined(newValue) && newValue != null && newValue != '' && newValue != oldValue) {
                    changeUrl(newValue);
                }
            });

            function Init() {
                changeUrl($scope.url);
            };

            function changeUrl(url) {
                if (angular.isDefined(url)) {
                    var js = '';
                    if (angular.isDefined($scope.action) && $scope.action != null) {
                        js = $scope.action;
                    }
                    else {
                        if (url.indexOf('.html') > 0) {
                            js = url.replace('html', 'js');
                        }
                        else {
                            var parsePath = url.split("/");
                            parsePath.remove("");
                            if (parsePath.length > 0) {
                                js = "..";
                                for (var i = 0; i < parsePath.length && i < 3; i++) {
                                    if (i == 1) {
                                        js += "/Views";
                                    }
                                    js += "/" + parsePath[i];
                                }
                            }
                        }
                    }

                    if (js.length > 0) {
                        loadJs(js, function () {
                            $scope.IncludeUrl = url.replace("//", "/");
                        });
                    }
                }
            };

            function loadJs(js, callback) {
                var dependencies = [js];
                var deferred = $q.defer();
                require(dependencies, function () {
                    $rootScope.$apply(function () {
                        deferred.resolve();

                        callback();
                    });
                });
                deferred.promise;
            };

            Init();
        }])
        .directive('hlsInclude', function () {
            return {
                restrict: 'E',
                scope: {
                    url: '='
                },
                replace: true,
                controller: 'hlsIncludeController',
                templateUrl: '/template/hls/include.html',
                link: function ($scope, element, attrs, ctrls) {
                }
            };
        });


    //=============================自定义 Grid========================================
    angular.module('hls.ui.grid', [])
        .run(["$templateCache", function ($templateCache) {
            $templateCache.put("template/hls/grid.html",
                "<div class=\"table-responsive\" style='margin-top:8px;'>\n" +
                "<table ng-if=\"showGrid\" ng-class=\"gridOptions.class\">\n" +
                "<thead>\n" +
                "<tr>\n" +
                "<th class=\"grid-checkbox\" ng-if=\"showFirstCheck\">" +
                "<input type=\"checkbox\" ng-model=\"gridCheck.checkAll\" ng-change=\"checkAllChange()\" />" +
                "</th>" +
                "<th ng-repeat=\"col in hlsGridViewInfo\" ng-class=\"col.ClassName\">\n" +
                "<span>{{col.DisplayName}}</span>\n" +
                "</th>\n" +
                "<th ng-if=\"showOperator\" class=\"grid-operation\" ng-class=\"gridOptions.colsOpr.headClass\">" + "{{gridOptions.colsOpr.headName}}" +
                "</th>" +
                "</tr>\n" +
                "</thread>" +
                "<tbody>\n" +
                "<tr ng-repeat=\"record in gridOptions.data\" ng-click=\"rowSelected(record,$event)\" >" +
                "<td class=\"grid-checkbox\" ng-if=\"showFirstCheck\">" +
                "<input type=\"checkbox\" ng-model=\"record[gridCheck.checkboxName]\" ng-change=\"rowCheckChange(record,$event)\" />" +
                "</td>" +
                "<td ng-repeat=\"viewCol in hlsGridViewInfo\">" +
                "<span><div ng-bind-html=\"getFieldValue(record,viewCol)\"></div></span>" +//{{record[viewCol.FieldName]}}
                "</td>" +
                "<td class=\"grid-operation\" ng-if=\"showOperator\">" +
                "<a style=\"cursor:pointer\"  ng-repeat=\"ainfo in gridOptions.colsOpr.colInfo\" ng-click=\"ainfo.clickFn(record,$event)\" class=\"btn-link btn-lg btn-lg-iconpadding\" title=\"{{ainfo.title}}\" >" +
                "<span ng-if=\"operatorShowIcon(ainfo)\" ng-class=\"ainfo.iconClass\"></span>" +
                "<span ng-if=\"!operatorShowIcon(ainfo)\" >{{ainfo.title}}</span>" +
                "</a>" +
                "<a style=\"cursor:pointer\" ng-if=\"showView(record)\" ng-click=\"viewFunction(record,$event)\" class=\"btn-link btn-lg btn-lg-iconpadding\" title=\"{{gridOptions.colsOpr.init.viewTitle}}\" >" +
                "<span ng-class=\"gridOptions.colsOpr.init.viewIcon\" ></span>" +
                "</a>" +
                "<a style=\"cursor:pointer\"  ng-if=\"showEdit(record)\" ng-click=\"editFunction(record,$event)\" class=\"btn-link btn-lg btn-lg-iconpadding\" title=\"{{gridOptions.colsOpr.init.editTitle}}\" >" +
                "<span ng-class=\"gridOptions.colsOpr.init.editIcon\" ></span>" +
                "</a>" +
                "<a style=\"cursor:pointer\"  ng-if=\"showDelete(record)\" ng-click=\"deleteFunction(record,$event)\" class=\"btn-link btn-lg btn-lg-iconpadding\" title=\"{{gridOptions.colsOpr.init.delTitle}}\" >" +
                "<span ng-class=\"gridOptions.colsOpr.init.delIcon\"  ></span>" +
                "</a>" +
                "</td>" +
                "</tr>" +
                "</tbody>\n" +
                "</table>\n" +
                "<div ng-if=\"!showGrid\" style=\"border:1px solid #ddd;text-align:center;font-weight:bold;padding:8px;\">该列表暂无数据</div>" +
                "</div>");
        }])
        .controller('hlsGridController', ['$scope', '$sce', function ($scope, $sce) {
            var self = this;

            $scope.hlsGridViewInfo = [];
            $scope.showGrid = false;
            $scope.showFirstCheck = false;
            $scope.showOperator = false;
            $scope.gridCheck = {
                checkAll: false,
                checkboxName: '$checked',
            };

            if (!$scope.gridOptions.class) {
                $scope.gridOptions.class = "table table-bordered table-striped table-hover";
            }
            if ($scope.gridOptions.colsOpr && $scope.gridOptions.colsOpr.init) {

                $scope.gridOptions.colsOpr.init.viewIcon = $scope.gridOptions.colsOpr.init.viewIcon ?
                    $scope.gridOptions.colsOpr.init.viewIcon : "glyphicon glyphicon-eye-open text-primary";
                $scope.gridOptions.colsOpr.init.editIcon = $scope.gridOptions.colsOpr.init.editIcon ?
                    $scope.gridOptions.colsOpr.init.editIcon : "glyphicon glyphicon-edit text-primary";
                $scope.gridOptions.colsOpr.init.delIcon = $scope.gridOptions.colsOpr.init.delIcon ?
                    $scope.gridOptions.colsOpr.init.delIcon : "glyphicon glyphicon-minus text-danger";


                $scope.gridOptions.colsOpr.init.viewTitle = $scope.gridOptions.colsOpr.init.viewTitle ?
                    $scope.gridOptions.colsOpr.init.viewTitle : "查看";
                $scope.gridOptions.colsOpr.init.editTitle = $scope.gridOptions.colsOpr.init.editTitle ?
                    $scope.gridOptions.colsOpr.init.editTitle : "修改";
                $scope.gridOptions.colsOpr.init.delTitle = $scope.gridOptions.colsOpr.init.delTitle ?
                    $scope.gridOptions.colsOpr.init.delTitle : "删除";
            }

            var columnInfo = {
                FieldName: undefined,
                DisplayName: undefined,
                ClassName: undefined,
                Formatter: undefined,
                IsObject: false,
                IsShow: true,
            };

            this.init = function (config) {
                this.config = config;
            }

            this.checkObjStyle = function (input) {
                var str = input.split('.');

                return str.length > 1;
            }
            //ignore case
            this.checkPropertyExist = function (data, proName) {
                var lowerProName = angular.lowercase(proName);

                var realName = undefined;
                angular.forEach(data, function (dValue, dKey) {
                    if (angular.lowercase(dKey) === lowerProName) {
                        realName = dKey;
                    }
                });
                return realName;
            }

            this.setColumnInfo = function (copyColumnInfo, colDefineInfo) {
                if (angular.isDefined(colDefineInfo.DisplayName)) {
                    copyColumnInfo.DisplayName = colDefineInfo.DisplayName;
                }
                if (angular.isDefined(colDefineInfo.ClassName)) {
                    copyColumnInfo.ClassName = colDefineInfo.ClassName;
                }
                if (angular.isDefined(colDefineInfo.Formatter)) {
                    copyColumnInfo.Formatter = colDefineInfo.Formatter;
                }
                if (angular.isDefined(colDefineInfo.IsShow)) {//true default
                    copyColumnInfo.IsShow = colDefineInfo.IsShow;
                }
            }

            this.gethlsGridInfo = function () {
                var columnDefExist = angular.isUndefined($scope.gridOptions.cols) ? false : true;

                var noListgridViewInfo = [];
                for (var i = 0; i < $scope.gridOptions.data.length; i++) {
                    angular.forEach($scope.gridOptions.data[i], function (gridValue, gridKey) {
                        var copyColumnInfo = angular.copy(columnInfo);

                        copyColumnInfo.FieldName = gridKey;//real field name
                        copyColumnInfo.DisplayName = gridKey;//default field name
                        //IsShow:True default

                        var colDefExist = false;
                        var lowerGridKey = angular.lowercase(gridKey);

                        var plexColumn = false;
                        if (columnDefExist) {
                            for (var k = 0; k < $scope.gridOptions.cols.length; k++) {
                                var colDefInfo = $scope.gridOptions.cols[k];
                                if (angular.isDefined(colDefInfo.FieldName)) {
                                    if (!self.checkObjStyle(colDefInfo.FieldName)) {//column name style,simple style
                                        var colDefLowerFieldName = angular.lowercase(colDefInfo.FieldName);
                                        if (lowerGridKey === colDefLowerFieldName) {
                                            self.setColumnInfo(copyColumnInfo, colDefInfo);
                                            colDefExist = true;
                                            break;
                                        }
                                    }
                                    else {//object style,if ensure object,check all columns,use continue
                                        var copyPlexColumnInfo = angular.copy(columnInfo);

                                        var names = colDefInfo.FieldName.split('.');
                                        var lowerFirstName = angular.lowercase(names[0]);
                                        if (lowerGridKey === lowerFirstName) {
                                            plexColumn = true;
                                            copyPlexColumnInfo.IsObject = true;
                                            var data = angular.copy(gridValue);
                                            var realFieldName = gridKey;
                                            for (var i = 1; i < names.length; i++) {
                                                var realName = self.checkPropertyExist(data, names[i]);
                                                if (angular.isUndefined(realName)) {//not exist
                                                    copyPlexColumnInfo.IsShow = false;
                                                    break;
                                                }
                                                data = data[realName];
                                                //realFieldName = i == 0 ? realName : realFieldName + "." + realName;
                                                realFieldName = realFieldName + "." + realName;
                                            } //end for names
                                            if (copyPlexColumnInfo.IsShow) {
                                                copyPlexColumnInfo.FieldName = realFieldName;
                                                copyPlexColumnInfo.DisplayName = realFieldName;
                                                self.setColumnInfo(copyPlexColumnInfo, colDefInfo);

                                                //set hlsGridViewInfo
                                                if (copyPlexColumnInfo.IsShow === true && !self.removeColumns(lowerGridKey)
                                                    && !self.hiddenColumns(lowerGridKey)) {
                                                    noListgridViewInfo.push(copyPlexColumnInfo);
                                                }
                                                continue;
                                            }// end add show plex column
                                        }//end do with equal name
                                    }//end else
                                }
                            }
                        }
                        if (!colDefExist && !plexColumn) {//only simple style
                            copyColumnInfo.IsShow = angular.isUndefined($scope.gridOptions.cols) ? true : false;//false default if columnDef exist and undefined
                        }
                        //set hlsGridViewInfo
                        if (copyColumnInfo.IsShow === true && !self.removeColumns(lowerGridKey)
                            && !self.hiddenColumns(lowerGridKey) && !plexColumn) {//only simple style
                            //$scope.hlsGridViewInfo.push(copyColumnInfo);
                            noListgridViewInfo.push(copyColumnInfo);
                        }
                    });
                    //list column info
                    angular.forEach($scope.gridOptions.cols, function (colDefInfo) {
                        var colLowerName = angular.lowercase(colDefInfo.FieldName);
                        angular.forEach(noListgridViewInfo, function (columnInfo) {
                            if (colLowerName === angular.lowercase(columnInfo.FieldName)) {
                                $scope.hlsGridViewInfo.push(columnInfo);
                            }
                        });
                    });

                    //only get one record to get real field information
                    break;
                }
            }

            this.removeColumns = function (colName) {
                if (colName === '$$hashkey') {
                    return true;
                }

                if (angular.isDefined($scope.gridOptions.colsChk)) {
                    if (angular.lowercase($scope.gridCheck.checkboxName) === colName) {
                        return true;
                    }
                }
                return false;
            }

            this.hiddenColumns = function (colName) {
                if (angular.isDefined($scope.gridOptions.colsHidden)) {
                    for (var i = 0; i < $scope.gridOptions.colsHidden.length; i++) {
                        if (colName === angular.lowercase($scope.gridOptions.colsHidden[i])) {
                            return true;
                        }
                    }
                }

                return false;
            }

            this.inithlsGrid = function () {
                self.gethlsGridInfo();

                self.render();
            }

            this.setShowhlsGrid = function () {
                $scope.showGrid = angular.isUndefined($scope.gridOptions.data) || $scope.gridOptions.data.length == 0 ? false : true;
            }

            this.setShowFirstCheck = function () {
                var result = angular.isUndefined($scope.gridOptions.colsChk) ? false : true;

                //if (result) {
                //    result = angular.isUndefined($scope.gridOptions.colsChk) ? false : true;

                //    result = result ? $scope.gridOptions.colsChk.showCheck : false;
                //}

                $scope.showFirstCheck = result;
            }

            this.setShowOperator = function () {
                $scope.showOperator = angular.isDefined($scope.gridOptions.colsOpr) ? true : false;
            }
            //init selected data
            this.initSelectedGridData = function () {
                var checkAll = true;
                angular.forEach($scope.gridOptions.data, function (record) {
                    if (angular.isDefined($scope.gridOptions.colsChk) && angular.isDefined($scope.gridOptions.colsChk.data)) {
                        var exist = false;
                        angular.forEach($scope.gridOptions.colsChk.data, function (selectedData) {
                            if (selectedData[$scope.gridOptions.colsChk.keyName] == record[$scope.gridOptions.colsChk.keyName]) {
                                exist = true;
                            }
                        });
                        record[$scope.gridCheck.checkboxName] = exist;
                    }
                    checkAll = checkAll ? record[$scope.gridCheck.checkboxName] : checkAll;
                });
                $scope.gridCheck.checkAll = checkAll;
            }

            this.render = function () {

            }

            $scope.showView = function (record) {
                if (angular.isFunction($scope.gridOptions.colsOpr.init.showView)) {
                    return $scope.gridOptions.colsOpr.init.showView(record);
                }
                else {
                    return $scope.gridOptions.colsOpr.init.showView;
                }
            };

            $scope.showEdit = function (record) {
                if (angular.isFunction($scope.gridOptions.colsOpr.init.showEdit)) {
                    return $scope.gridOptions.colsOpr.init.showEdit(record);
                }
                else {
                    return $scope.gridOptions.colsOpr.init.showEdit;
                }
            };

            $scope.showDelete = function (record) {
                if (angular.isFunction($scope.gridOptions.colsOpr.init.showDelete)) {
                    return $scope.gridOptions.colsOpr.init.showDelete(record);
                }
                else {
                    return $scope.gridOptions.colsOpr.init.showDelete;
                }
            };

            $scope.viewFunction = function (record, $event) {
                $scope.gridOptions.colsOpr.init.viewFn(record);

                $event.stopPropagation();
            }

            $scope.editFunction = function (record, $event) {
                $scope.gridOptions.colsOpr.init.editFn(record);

                $event.stopPropagation();
            }

            $scope.deleteFunction = function (record, $event) {
                $scope.gridOptions.colsOpr.init.delFn(record);

                $event.stopPropagation();
            }

            $scope.checkAllChange = function () {
                //self code
                angular.forEach($scope.gridOptions.data, function (record) {
                    record[$scope.gridCheck.checkboxName] = $scope.gridCheck.checkAll;
                });
                //selected data
                if (angular.isDefined($scope.gridOptions.colsChk) && angular.isDefined($scope.gridOptions.colsChk.data) &&
                    angular.isDefined($scope.gridOptions.colsChk.keyName)) {
                    angular.forEach($scope.gridOptions.data, function (rowData) {
                        var dataExist = false;
                        angular.forEach($scope.gridOptions.colsChk.data, function (selectedData) {
                            if (rowData[$scope.gridOptions.colsChk.keyName] === selectedData[$scope.gridOptions.colsChk.keyName]) {
                                dataExist = true;
                                if (!$scope.gridCheck.checkAll) {
                                    $scope.gridOptions.colsChk.data.remove(selectedData);
                                }
                            }
                        });
                        if ($scope.gridCheck.checkAll && !dataExist) {
                            $scope.gridOptions.colsChk.data.push(rowData);
                        }
                    });
                }

                //call outside
                if (angular.isDefined($scope.gridOptions.colsChk.checkAllChange)) {
                    $scope.gridOptions.colsChk.checkAllChange();
                }

            }

            $scope.rowCheckChange = function (record, $event) {
                //self code
                var selectAll = true;
                angular.forEach($scope.gridOptions.data, function (rowData) {
                    if (!rowData[$scope.gridCheck.checkboxName]) {
                        selectAll = false;
                    }
                });
                //selected data
                if (angular.isDefined($scope.gridOptions.colsChk) && angular.isDefined($scope.gridOptions.colsChk.data) &&
                    angular.isDefined($scope.gridOptions.colsChk.keyName)) {
                    var dataExist = false;
                    angular.forEach($scope.gridOptions.colsChk.data, function (selectedData) {
                        if (selectedData[$scope.gridOptions.colsChk.keyName] == record[$scope.gridOptions.colsChk.keyName]) {
                            dataExist = true;
                            if (!record[$scope.gridCheck.checkboxName]) {
                                $scope.gridOptions.colsChk.data.remove(selectedData);
                            }
                        }
                    });
                    if (record[$scope.gridCheck.checkboxName] && !dataExist) {
                        $scope.gridOptions.colsChk.data.push(record);
                    }
                }
                $scope.gridCheck.checkAll = selectAll;
                //call outside
                if (angular.isDefined($scope.gridOptions.colsChk) && angular.isDefined($scope.gridOptions.colsChk.rowCheckChange)) {
                    $scope.gridOptions.colsChk.rowCheckChange(record, $event);
                }

            }

            $scope.rowSelected = function (record, $event) {
                if (angular.isDefined($scope.gridOptions.rowOpr)) {
                    if (angular.isFunction($scope.gridOptions.rowOpr.rowSelected)) {
                        $scope.gridOptions.rowOpr.rowSelected(record, $event);
                    }
                }
            }

            $scope.getFieldValue = function (record, colInfo) {
                //record[colInfo.FieldName]
                var fieldValue = '';
                if (colInfo.IsObject) {
                    var names = colInfo.FieldName.split('.');
                    fieldValue = record;
                    for (var i = 0; i < names.length; i++) {
                        fieldValue = fieldValue[names[i]];
                        if (angular.isUndefined(fieldValue) || fieldValue == null) {
                            fieldValue = '';
                            break;
                        }
                    }
                } else {
                    fieldValue = record[colInfo.FieldName];
                }
                if (angular.isDefined(colInfo.Formatter) && angular.isFunction(colInfo.Formatter)) {
                    fieldValue = colInfo.Formatter(fieldValue);
                }
                if (angular.isDefined(colInfo.trustAsHtml) && colInfo.trustAsHtml == true) {
                    fieldValue = $sce.trustAsHtml(fieldValue);
                }
                return fieldValue;
            }

            $scope.operatorShowIcon = function (aInfo) {
                if (angular.isDefined(aInfo.iconClass) && aInfo.iconClass != '') {
                    return true;
                }
                return false;
            }

            $scope.inithlsGridScope = function () {
                self.setShowFirstCheck();

                self.setShowOperator();

                self.setShowhlsGrid();

                //set $scope.gridCheck.checkboxName
                if (angular.isDefined($scope.gridOptions.colsChk) && angular.isDefined($scope.gridOptions.colsChk.rowCheckname)) {
                    $scope.gridCheck.checkboxName = $scope.gridOptions.colsChk.rowCheckname;
                }
            }

            $scope.extentionGridOptions = function () {
                //get selected rows.must has first checkbox
                $scope.gridOptions.getSelectedRows = function () {
                    var result = [];
                    angular.forEach($scope.gridOptions.data, function (record) {
                        if (record[$scope.gridCheck.checkboxName]) {
                            result.push(record);
                        }
                    });
                    return result;
                }
            }

            $scope.$watch('gridOptions.data', function () {
                $scope.hlsGridViewInfo = [];

                self.inithlsGrid();

                self.setShowhlsGrid();

                self.initSelectedGridData();
            });

            $scope.$watch('gridOptions.colsChk.data', function () {

                self.initSelectedGridData();
            }, true);

            $scope.inithlsGridScope();

            $scope.extentionGridOptions();
        }])
        .constant('hlsGridConfig', {})
        /*
         Note:
         gridOptions = {
         data: [],
         cols: [{ FieldName: 'UserNo', DisplayName: 'User No', ClassName: '',Formatter:function(){}, IsShow: true, },...],
         colsOpr: {headName: 'Operator',headClass: '',
         init: { showView: true,viewFn: function (data) {},showEdit: true,
         editFn: function (data) {},showDelete: true,delFn: function (data) {}},
         colInfo: [{title: '自定义', iconClass: 'glyphicon glyphicon-arrow-right',clickFn: function (data) {}},...],

         },
         colsChk: {rowCheckname: 'checked',checkAllChange: function () {},
         rowCheckChange: function (data) {
         },
         keyName:'ID',data:[],
         },
         colsHidden: ['gender', 'UserNo'],
         rowOpr:{rowSelected:function(record){},},
         }
         function:
         getSelectedRows()
         */
        .directive('hlsGrid', function () {
            return {
                restrict: 'EA',
                scope: {
                    gridOptions: '=',
                },
                replace: true,
                controller: 'hlsGridController',
                templateUrl: 'template/hls/grid.html',
                link: function (scope, element, attrs, ctrls) {
                }
            };
        });


    angular.module('hls.ui.upload', [])
        .run(["$templateCache", function ($templateCache) {
            $templateCache.put("template/hls/upload.html",
                '<form id="{{formId}}">' +
                '   <div class="col-md-5" style="padding:0;">' +
                '       <input class="form-control disabled" disabled ="true" ng-model="disName" type="text">' +
                '   </div>' +
                '   <div class="text-left col-md-5">' +
                '      <input id="{{inputId}}" name="upload" type="file" style="display:none" fileread="fileread">' +
                '      <button type="button" ng-if="hlsOption.clean.enable"  ng-show="files.length>0" ng-class="hlsOption.clean.cleanClass" ng-click="cleanFile()">' +
                '         <span ng-class="hlsOption.clean.icon" ng-bind="hlsOption.clean.text"></span>' +
                '      </button>' +

                '       <button type="button" ng-show="files.length>0"  ng-class="hlsOption.upload.uploadClass" ng-click="uploadFile()">' +
                '          <span ng-class="hlsOption.upload.icon" ng-bind="hlsOption.upload.text"></span>' +
                '       </button>' +

                '       <button type="button" ng-class="hlsOption.brower.browerClass" ng-click="browerFile()">' +
                '           <span ng-class="hlsOption.brower.icon" ng-bind="hlsOption.brower.text"></span>' +
                '       </button>' +
                '   </div>' +
                '</form>'
            )
        }])

        .controller('hlsUiUploadController', ['$scope', 'blockUI', '$q', '$request', '$timeout', function ($scope, blockUI, $q, $request, $timeout) {

            $scope.fileread = {};

            if ($scope.hlsOption.multiple) {
                $scope.multiple = true;
            } else {
                $scope.multiple = false;
            }

            if (!$scope.hlsOption.clean) {
                $scope.hlsOption.clean = {};
                $scope.hlsOption.clean.enable = false;
            } else if (!$scope.hlsOption.clean.enable) {
                $scope.hlsOption.clean.enable = false;
            }

            $scope.files = [];

            $scope.selectChange = function (target) {
                if (target.files.length === 0) return;
                var filesName = "";
                for (var i = 0; i < target.files.length; i++) {
                    if (i > 0) filesName += ", ";
                    filesName += target.files[i].name;
                }
                $scope.files = target.files;
                $scope.disName = filesName;
            }
            $scope.browerFile = function () {
                $timeout(function () {
                    $('input[id=' + $scope.inputId + ']').click();
                });
            }

            $scope.uploadFile = function () {
                var formdata = new FormData();
                if ($scope.files.length == 0) {
                    return false;
                }
                blockUI.start();
                if ($scope.files.length == 1) {
                    formdata.append($scope.hlsOption.id, $scope.files[0]);
                }
                else {
                    for (var i = 0; i < $scope.files.length; i++) {
                        formdata.append($scope.hlsOption.id + i, $scope.files[i]);
                    }
                }
                if ($scope.hlsOption.data && typeof ($scope.hlsOption.data) === "object") {
                    for (var i in $scope.hlsOption.data) {
                        formdata.append(i, $scope.hlsOption.data[i]);
                    }
                }
                $timeout(function () {
                    var promiss = sendData();
                    promiss.then(function (response) {
                        blockUI.stop();
                        try {
                            response = angular.fromJson(response);
                        } catch (e) {
                        }
                        $scope.hlsOption.success(response);
                    }, function (error) {
                        blockUI.stop();
                        $scope.hlsOption.error(error);
                    })
                }, 10);

                function sendData() {
                    var deferred = $q.defer();
                    $.ajax({
                        url: $scope.hlsOption.url,
                        type: 'POST',
                        data: formdata,
                        async: true,
                        cache: false,
                        contentType: false,
                        processData: false,
                        success: function (response) {
                            deferred.resolve(response);
                        },
                        error: function (error) {
                            deferred.reject(error);
                        }
                    });
                    return deferred.promise;
                }
            }

            $scope.cleanFile = function () {

                $scope.disName = "";
            }

            $scope.$watch("disName", function (newValue, oldValue, scope) {
                if (newValue == "") {
                    $('input[id=' + $scope.inputId + ']').val("");
                }
            })

        }])
        .directive('hlsUpload', ['$data', function ($data) {
            return {
                restrict: 'AE',
                scope: {
                    hlsOption: "="
                },
                replace: true,
                controller: 'hlsUiUploadController',
                templateUrl: 'template/hls/upload.html',
                link: function (scope, element, attrs, ctrls) {
                    scope.formId = 'form_' + $data.randomStr(10);
                    scope.inputId = scope.formId + '_file';
                }
            };
        }]).directive("fileread", [function () {
        return {
            scope: {
                fileread: "="
            },
            link: function (scope, element, attr) {
                if (scope.$parent.hlsOption.multiple) {
                    scope.multiple = true;
                } else {
                    scope.multiple = false;
                }

                attr.$set("multiple", scope.multiple);

                element.bind("change", function (changeEvent) {
                    scope.$apply(function () {
                        scope.$parent.selectChange(changeEvent.target);
                    });
                });

                //element.bind("change", function (changeEvent) {
                //    var reader = new FileReader();
                //    reader.onload = function (loadEvent) {
                //        scope.$apply(function () {
                //            scope.fileread = loadEvent.target.result;
                //        });
                //    }
                //    reader.readAsDataURL(changeEvent.target.files[0]);
                //});
            }
        }
    }]);

    //==========================列表=================================//
    angular.module('hls.ui.list', [])
        .directive('shutters', function(){
            return {
                restrict: 'EAC',
                link: function(scope,element,attrs){
                    shutters();

                    function shutters(){
                        var index_b = -1,
                            index_t = -1,
                            covers = element.find(".cover"),
                            length = covers.length,
                            t_timer = null,
                            b_timer = null;

                        setTimeout(move_b, 4000);
                        setInterval(move_t, 8000);      
                        setTimeout(function(){setInterval(move_b, 8000)}, 4000);

                        function move_b(){
                            b_timer = setInterval(function(){
                                if(index_b>=length-1){
                                    clearInterval(b_timer);
                                    index_b = -1;
                                    return;
                                }else{
                                    index_b++;
                                }
                                covers.eq(index_b).animate({
                                    top: 0
                                }, {duration:500, queue:false});
                            }, 80);
                        }

                        function move_t(){
                            t_timer = setInterval(function(){
                                if(index_t>=length-1){
                                    clearInterval(t_timer);
                                    index_t = -1;
                                    return;
                                }else{
                                    index_t++;
                                }
                                covers.eq(index_t).animate({
                                    top: -30
                                }, {duration:500, queue:false});
                            }, 80);
                        }
                    }
                }
            }
        })

    //==========================表单验证-2(ng-messages封装)=================================//    
    angular.module('ngMsgValidate', [])
        .directive('passwordCharactersValidator', function() {
                var PASSWORD_FORMATS = [
                    ///[^\w\s]+/, 
                    ///[A-Z]+/, 
                    ///\w+/,                                 
                    /\d+|[a-z]+/ 
                ];

                return {
                    require: 'ngModel',
                    link : function(scope, element, attrs, ngModel) {
                        ngModel.$parsers.push(function(value) {
                            var status = true;
                            angular.forEach(PASSWORD_FORMATS, function(regex) {
                                status = status && regex.test(value);
                            });
                            ngModel.$setValidity('password-characters', status);
                            return value;
                        });
                    }
                }
            })
        .directive('charactersValidator', function() {                                   
            
            var REGEX = {
                "tel": /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/,             //手机
                "IdCard": /(^\d{15}$)|(^\d{17}([0-9]|X)$)/,                                                 //身份证
                "username_merge": /^([\u2E80-\u9FFF]|[a-zA-Z0-9_]){2,12}$/im,                               //姓名&昵称
                "detail_address": /^([\u2E80-\u9FFF]|[a-zA-Z0-9_\,\，\(\)\（\）\-\s\\s]){5,150}$/im,        //详细地址
                "qq": /^[1-9][0-9]{4,9}$/,                                                                  //qq号码
                "baseMix": /^([\u2E80-\u9FFF]|[a-zA-Z0-9_]){3,30}$/im,                                     //中文，英文，数字下划线混合
                "SKU": /^[0-9a-zA-Z_#*\-+:@&]+$/im,                                                         //SKU        
                "stock": /^([1-9]\d*|0)$/m,                                                                 //库存相关
                "price": /^([1-9]\d*\.\d{2}|0\.\d[1-9]|0\.[1-9]\d)$/m,                                      //价格
                "tel_fax": /^((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)$/m, //手机||固定电话(传真)
                "postCode": /^[1-9][0-9]{5}$/m,                                                             //邮编
                "email": /(^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+\.[a-zA-Z0-9_-]+$)|(^$)/m,                         //email 
                "Chinese": /^[\u2E80-\u9FFF\s\\s]+$/m,                                                      //中文
                "letter": /^[A-Za-z\s\\s]+$/m,                                                              //字母                               
                //可添加更多
            }

            return {
                require: 'ngModel',
                link : function(scope, element, attrs, ngModel) {
                    var key = attrs.charactersValidator; 
                    ngModel.$parsers.push(function(value){
                        var status = true;
                        if(value==''){
                            ngModel.$setValidity(key, true);
                        }else{
                            status = status && REGEX[key].test(value);
                            ngModel.$setValidity(key, status);
                        }
                        return value;
                    })
                }
            }
        })
        .directive('verifyValidator', function(){
            return {
                require: 'ngModel',
                link: function(scope, element, attrs, ngModel){
                    ngModel.$parsers.push(function(value){
                        ngModel.$setValidity('verify-wrong', value.toLowerCase() == scope.$eval(attrs.verifyValidator));
                        return value;
                    })
                }
            }
        })
        .directive('remoteRecordValidator', ['$http', function($http){
            return {
                require: 'ngModel',
                link: function(scope, element, attrs, ngModel){
                    var seedData = scope.$eval(attrs.remoteRecordValidator);  

                    ngModel.$parsers.push(function(value) {
                        valid(false,seedData.type);
                        loading(true,seedData.type);
                        return value;
                    });

                    element.on("blur", function(){
                        console.log(seedData.url+'&'+seedData.type+'='+ngModel.$modelValue);
                        $http.get(seedData.url+'&'+seedData.type+'='+ngModel.$modelValue)
                            .success(function(response, status, headers, config){
                                if(response.success){
                                    if(response.data && response.data.length > 0){
                                        valid(false,seedData.type);
                                        loading(false,seedData.type);
                                    }else{
                                        valid(true,seedData.type);
                                        loading(false,seedData.type);
                                        //scope.user[seedData.type] = ngModel.$viewValue;
                                    }
                                }else{
                                    valid(true,seedData.type);
                                }
                            });

                    });

                    function valid(bool,type) {
                        if(type.toLowerCase()=='email')
                            ngModel.$setValidity('record-taken', bool);    
                        else
                            ngModel.$setValidity('record-taken-username', bool);
                    }

                    function loading(bool,type) {
                        if(type.toLowerCase()=='email')
                            ngModel.$setValidity('record-loading', !bool);
                        else
                            ngModel.$setValidity('record-loading-username', !bool);
                    }
              }
          }
        }])  
        .directive('matchValidator', function(){
            return {
                require: 'ngModel',
                link : function(scope, element, attrs, ngModel) {
                    ngModel.$parsers.push(function(value) {
                        ngModel.$setValidity('match-password', value == scope.$eval(attrs.matchValidator));
                        return value;
                    });
                }
            }
      });

});
