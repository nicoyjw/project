'use strict'

define([], function () {
    //== Services ================================================================//
    angular.module('hls.util', ['blockUI', 'hls.ui'])
        //本地存储操作服务
        .factory('$store', ['$window', function ($window) {
            return {
                set: function (key, value) {
                    $window.localStorage[key] = escape(value);
                },
                get: function (key, defaultValue) {
                    return unescape($window.localStorage[key] || defaultValue);
                },
                remove: function (key) {
                    delete $window.localStorage[key]
                },
                clean: function () {
                    for (var key in $window.localStorage) {
                        delete $window.localStorage[key];
                    }
                },
                getJson: function (key) {
                    var value = this.get(key, "{}");
                    if (value == "{}") return undefined;
                    return angular.fromJson(unescape(value));
                },
                setJson: function (key, value) {
                    var jsonStr = angular.toJson(value);
                    $window.localStorage[key] = escape(jsonStr);
                },
                getUserInfo: function () {
                    return this.getJson("USERINFO");
                },
                setUserInfo: function (user) {
                    this.setJson("USERINFO", user);
                },
                removeUserInfo: function () {
                    this.remove("USERINFO");
                }
            }
        }])
        //提供数据服务, 如:cookie操作，controller间数据传递、以及controller事件通知
        .factory('$data', ['$timeout', '$window', function ($timeout, $window) {
            var Dictionary = function () {
                var me = this;
                this.CompareMode = 1;
                this.Count = 0;
                this.arrKeys = new Array();
                this.arrValues = new Array();
                this.ThrowException = true;
                this.Item = function (key) {
                    var idx = GetElementIndexInArray(me.arrKeys, key);
                    if (idx != -1) {
                        return me.arrValues[idx];
                    } else {
                        if (me.ThrowException)
                            throw "在获取键对应的值时发生错误，键不存在。";
                    }
                }

                this.Keys = function () {
                    return me.arrKeys;
                }

                this.Values = function () {
                    return me.arrValues;
                }

                this.Add = function (key, value) {
                    if (CheckKey(key)) {
                        me.arrKeys[me.Count] = key;
                        me.arrValues[me.Count] = value;
                        me.Count++;
                    } else {
                        if (me.ThrowException)
                            throw "在将键和值添加到字典时发生错误，可能是键无效或者键已经存在。";
                    }
                }

                this.BatchAdd = function (keys, values) {
                    var bSuccessed = false;
                    if (keys != null && keys != undefined && values != null && values != undefined) {
                        if (keys.length == values.length && keys.length > 0) {
                            var allKeys = me.arrKeys.concat(keys);
                            if (!IsArrayElementRepeat(allKeys)) {
                                me.arrKeys = allKeys;
                                me.arrValues = me.arrValues.concat(values);
                                me.Count = me.arrKeys.length;
                                bSuccessed = true;
                            }
                        }
                    }
                    return bSuccessed;
                }

                this.Clear = function () {
                    if (me.Count != 0) {
                        me.arrKeys.splice(0, me.Count);
                        me.arrValues.splice(0, me.Count);
                        me.Count = 0;
                    }
                }

                this.ContainsKey = function (key) {
                    return GetElementIndexInArray(me.arrKeys, key) != -1;
                }

                this.ContainsValue = function (value) {
                    return GetElementIndexInArray(me.arrValues, value) != -1;
                }

                this.Remove = function (key) {
                    var idx = GetElementIndexInArray(me.arrKeys, key);
                    if (idx != -1) {
                        me.arrKeys.splice(idx, 1);
                        me.arrValues.splice(idx, 1);
                        me.Count--;
                        return true;
                    }
                    else {
                        return false;
                    }
                }

                this.TryGetValue = function (key, defaultValue) {
                    var idx = GetElementIndexInArray(me.arrKeys, key);
                    if (idx != -1) {
                        return me.arrValues[idx];
                    } else {
                        return defaultValue;
                    }
                }

                this.toString = function () {
                    if (me.Count == 0) {
                        return "";
                    } else {
                        return me.arrKeys.toString() + ";" + me.arrValues.toString();
                    }
                }

                function CheckKey(key) {
                    if (key == null || key == undefined || key == "" || key == NaN) {
                        return false;
                    }
                    return !me.ContainsKey(key);
                }

                // 得到指定元素在数组中的索引，如果元素存在于数组中，返回索引；否则返回-1
                function GetElementIndexInArray(arr, e) {
                    var idx = -1;
                    var i;
                    if (!(arr == null || arr == undefined || typeof (arr) != "object")) {
                        for (i = 0; i < arr.length; i++) {
                            var bEqual;
                            if (me.CompareMode == 0) {
                                bEqual = (arr[i] === e);    //二进制比较
                            } else {
                                bEqual = (arr[i] == e);     //文本比较
                            }
                            if (bEqual) {
                                idx = i;
                                break;
                            }
                        }
                    }
                    return idx;
                }

                //判断数组中的元素是否存在重复情况，如果存在返回true, 否则返回false
                function IsArrayElementRepeat(arr) {
                    var bRepeat = false;
                    if (arr != null && arr != undefined && typeof (arr) == "object") {
                        var i;
                        for (i = 0; i < arr.length - 1; i++) {
                            var bEqual;
                            if (me.CompareMode == 0) {
                                bEqual = (arr[i] === arr[i + 1]);   //二进制比较
                            }
                            else {
                                bEqual = (arr[i] == arr[i + 1]);    //文本比较
                            }
                            if (bEqual) {
                                bRepeat = true;
                                break;
                            }
                        }
                    }
                    return bRepeat;
                }
            };

            var isLoad = false;

            var dicData = new Dictionary();

            var dicWatch = new Dictionary();

            function newGuid() {
                var guid = "";
                for (var i = 1; i <= 32; i++) {
                    var n = Math.floor(Math.random() * 16.0).toString(16);
                    guid += n;
                    if ((i == 8) || (i == 12) || (i == 16) || (i == 20))
                        guid += "-";
                }
                return guid;
            }

            return {
                //cookie操作
                // expires 分钟 如果没有设置，默认30天
                setCookie: function (name, value, expires) {
                    var expires = expires ? expires : 30 * 24 * 60;
                    var exp = new Date();
                    exp.setTime(exp.getTime() + expires * 60 * 1000);
                    document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString();
                },
                getCookie: function (name) {
                    var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
                    if (arr = document.cookie.match(reg))
                        return unescape(arr[2]);
                    else
                        return null;
                },
                delCookie: function (name) {
                    var exp = new Date();
                    exp.setTime(exp.getTime() - 1);
                    var cval = this.getCookie(name);
                    if (cval != null)
                        document.cookie = name + "=" + cval + ";expires=" + exp.toGMTString()+";path=/";
                },

                //共享数据操作
                setData: function (key, value) {
                    dicData.Add(key, value);
                },
                getData: function (key, isCache) {
                    var result = dicData.TryGetValue(key, null);
                    if (result != null) {
                        if (angular.isUndefined(isCache)) {
                            isCache = false;
                        }
                        if (!isCache) {
                            dicData.Remove(key);
                        }
                    }
                    return result;
                }
                ,
                delData: function (key) {
                    dicData.Remove(key);
                }
                ,

                //事件注册、回调操作
                registerEvent: function (scope, key, callback) {
                    if (angular.isFunction(callback)) {
                        var item = dicWatch.TryGetValue(key, null);
                        if (item == null) {
                            item = {};
                            item.data = null;
                            item.guid = null;
                            dicWatch.Add(key, item);
                        }
                        scope[key] = item;
                        scope.$watch(key, function (newValue, oldValue) {
                            if (item.guid != null && angular.isDefined(newValue) && angular.isDefined(oldValue)) {
                                if (newValue.guid != oldValue.guid) {
                                    callback(item.data);
                                }
                            }
                        }, true);
                    }
                },

                unregisterEvent: function (scope, key) {

                },

                raiseEvent: function (key, arg) {
                    if (angular.isDefined(arg)) {
                        var item = dicWatch.TryGetValue(key, null);
                        if (item != null) {
                            item.data = arg;
                            item.guid = newGuid();          //生成guid，以触发watch
                        }
                    }
                },

                //Iframe父子间事件注册、回调操作
                registerIframeEvent: function (key, callback) {
                    window.addEventListener('message', function (e) {
                        if (e.data.eventKey == key) {
                            callback(e.data.data);
                        }
                    }, false);
                },
                raiseIframeEvent: function (key, data) {
                    var arg = {
                        eventKey: key,
                        data: data
                    }
                    if (top != self) {
                        window.parent.postMessage(arg, "*");
                    }
                    if (window.frames != null && window.frames.length > 0) {
                        for (var i = 0; i < window.frames.length; i++) {
                            window.frames[i].postMessage(arg, "*");
                        }
                    }
                },
                randomNum: function (min, max) {
                    var Range = max - min;
                    var Rand = Math.random();
                    return (min + Math.round(Rand * Range));
                }
                ,
                //返回一定长度的随机字符串
                // 默认纯小写字母   参数hasUpper=true 包含大写小写字母 参数 hasNum=true 包含数字
                randomStr: function (length, hasUpper, hasNum) {
                    var str = "abcdefghijklmnopqrstuvwxyz";
                    if (hasUpper) {
                        str += "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                    }
                    if (hasNum) {
                        str += "1234567890";
                    }

                    var result = "";
                    for (var i = 0; i < length; i++) {
                        var num = this.randomNum(0, str.length - 1);
                        result += str[num];
                    }

                    return result;
                },
                MD5: function (string, isLower) {

                    if (!string && string != 0) {
                        return "";
                    }
                    function RotateLeft(lValue, iShiftBits) {
                        return (lValue << iShiftBits) | (lValue >>> (32 - iShiftBits));
                    }

                    function AddUnsigned(lX, lY) {
                        var lX4, lY4, lX8, lY8, lResult;
                        lX8 = (lX & 0x80000000);
                        lY8 = (lY & 0x80000000);
                        lX4 = (lX & 0x40000000);
                        lY4 = (lY & 0x40000000);
                        lResult = (lX & 0x3FFFFFFF) + (lY & 0x3FFFFFFF);
                        if (lX4 & lY4) {
                            return (lResult ^ 0x80000000 ^ lX8 ^ lY8);
                        }
                        if (lX4 | lY4) {
                            if (lResult & 0x40000000) {
                                return (lResult ^ 0xC0000000 ^ lX8 ^ lY8);
                            } else {
                                return (lResult ^ 0x40000000 ^ lX8 ^ lY8);
                            }
                        } else {
                            return (lResult ^ lX8 ^ lY8);
                        }
                    }

                    function F(x, y, z) {
                        return (x & y) | ((~x) & z);
                    }

                    function G(x, y, z) {
                        return (x & z) | (y & (~z));
                    }

                    function H(x, y, z) {
                        return (x ^ y ^ z);
                    }

                    function I(x, y, z) {
                        return (y ^ (x | (~z)));
                    }

                    function FF(a, b, c, d, x, s, ac) {
                        a = AddUnsigned(a, AddUnsigned(AddUnsigned(F(b, c, d), x), ac));
                        return AddUnsigned(RotateLeft(a, s), b);
                    };

                    function GG(a, b, c, d, x, s, ac) {
                        a = AddUnsigned(a, AddUnsigned(AddUnsigned(G(b, c, d), x), ac));
                        return AddUnsigned(RotateLeft(a, s), b);
                    };

                    function HH(a, b, c, d, x, s, ac) {
                        a = AddUnsigned(a, AddUnsigned(AddUnsigned(H(b, c, d), x), ac));
                        return AddUnsigned(RotateLeft(a, s), b);
                    };

                    function II(a, b, c, d, x, s, ac) {
                        a = AddUnsigned(a, AddUnsigned(AddUnsigned(I(b, c, d), x), ac));
                        return AddUnsigned(RotateLeft(a, s), b);
                    };

                    function ConvertToWordArray(string) {
                        var lWordCount;
                        var lMessageLength = string.length;
                        var lNumberOfWords_temp1 = lMessageLength + 8;
                        var lNumberOfWords_temp2 = (lNumberOfWords_temp1 - (lNumberOfWords_temp1 % 64)) / 64;
                        var lNumberOfWords = (lNumberOfWords_temp2 + 1) * 16;
                        var lWordArray = Array(lNumberOfWords - 1);
                        var lBytePosition = 0;
                        var lByteCount = 0;
                        while (lByteCount < lMessageLength) {
                            lWordCount = (lByteCount - (lByteCount % 4)) / 4;
                            lBytePosition = (lByteCount % 4) * 8;
                            lWordArray[lWordCount] = (lWordArray[lWordCount] | (string.charCodeAt(lByteCount) << lBytePosition));
                            lByteCount++;
                        }
                        lWordCount = (lByteCount - (lByteCount % 4)) / 4;
                        lBytePosition = (lByteCount % 4) * 8;
                        lWordArray[lWordCount] = lWordArray[lWordCount] | (0x80 << lBytePosition);
                        lWordArray[lNumberOfWords - 2] = lMessageLength << 3;
                        lWordArray[lNumberOfWords - 1] = lMessageLength >>> 29;
                        return lWordArray;
                    };

                    function WordToHex(lValue) {
                        var WordToHexValue = "", WordToHexValue_temp = "", lByte, lCount;
                        for (lCount = 0; lCount <= 3; lCount++) {
                            lByte = (lValue >>> (lCount * 8)) & 255;
                            WordToHexValue_temp = "0" + lByte.toString(16);
                            WordToHexValue = WordToHexValue + WordToHexValue_temp.substr(WordToHexValue_temp.length - 2, 2);
                        }
                        return WordToHexValue;
                    };

                    function Utf8Encode(string) {
                        string = string.replace(/\r\n/g, "\n");
                        var utftext = "";

                        for (var n = 0; n < string.length; n++) {

                            var c = string.charCodeAt(n);

                            if (c < 128) {
                                utftext += String.fromCharCode(c);
                            }
                            else if ((c > 127) && (c < 2048)) {
                                utftext += String.fromCharCode((c >> 6) | 192);
                                utftext += String.fromCharCode((c & 63) | 128);
                            }
                            else {
                                utftext += String.fromCharCode((c >> 12) | 224);
                                utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                                utftext += String.fromCharCode((c & 63) | 128);
                            }

                        }

                        return utftext;
                    };

                    var x = Array();
                    var k, AA, BB, CC, DD, a, b, c, d;
                    var S11 = 7, S12 = 12, S13 = 17, S14 = 22;
                    var S21 = 5, S22 = 9, S23 = 14, S24 = 20;
                    var S31 = 4, S32 = 11, S33 = 16, S34 = 23;
                    var S41 = 6, S42 = 10, S43 = 15, S44 = 21;

                    string = Utf8Encode(string);

                    x = ConvertToWordArray(string);

                    a = 0x67452301;
                    b = 0xEFCDAB89;
                    c = 0x98BADCFE;
                    d = 0x10325476;

                    for (k = 0; k < x.length; k += 16) {
                        AA = a;
                        BB = b;
                        CC = c;
                        DD = d;
                        a = FF(a, b, c, d, x[k + 0], S11, 0xD76AA478);
                        d = FF(d, a, b, c, x[k + 1], S12, 0xE8C7B756);
                        c = FF(c, d, a, b, x[k + 2], S13, 0x242070DB);
                        b = FF(b, c, d, a, x[k + 3], S14, 0xC1BDCEEE);
                        a = FF(a, b, c, d, x[k + 4], S11, 0xF57C0FAF);
                        d = FF(d, a, b, c, x[k + 5], S12, 0x4787C62A);
                        c = FF(c, d, a, b, x[k + 6], S13, 0xA8304613);
                        b = FF(b, c, d, a, x[k + 7], S14, 0xFD469501);
                        a = FF(a, b, c, d, x[k + 8], S11, 0x698098D8);
                        d = FF(d, a, b, c, x[k + 9], S12, 0x8B44F7AF);
                        c = FF(c, d, a, b, x[k + 10], S13, 0xFFFF5BB1);
                        b = FF(b, c, d, a, x[k + 11], S14, 0x895CD7BE);
                        a = FF(a, b, c, d, x[k + 12], S11, 0x6B901122);
                        d = FF(d, a, b, c, x[k + 13], S12, 0xFD987193);
                        c = FF(c, d, a, b, x[k + 14], S13, 0xA679438E);
                        b = FF(b, c, d, a, x[k + 15], S14, 0x49B40821);
                        a = GG(a, b, c, d, x[k + 1], S21, 0xF61E2562);
                        d = GG(d, a, b, c, x[k + 6], S22, 0xC040B340);
                        c = GG(c, d, a, b, x[k + 11], S23, 0x265E5A51);
                        b = GG(b, c, d, a, x[k + 0], S24, 0xE9B6C7AA);
                        a = GG(a, b, c, d, x[k + 5], S21, 0xD62F105D);
                        d = GG(d, a, b, c, x[k + 10], S22, 0x2441453);
                        c = GG(c, d, a, b, x[k + 15], S23, 0xD8A1E681);
                        b = GG(b, c, d, a, x[k + 4], S24, 0xE7D3FBC8);
                        a = GG(a, b, c, d, x[k + 9], S21, 0x21E1CDE6);
                        d = GG(d, a, b, c, x[k + 14], S22, 0xC33707D6);
                        c = GG(c, d, a, b, x[k + 3], S23, 0xF4D50D87);
                        b = GG(b, c, d, a, x[k + 8], S24, 0x455A14ED);
                        a = GG(a, b, c, d, x[k + 13], S21, 0xA9E3E905);
                        d = GG(d, a, b, c, x[k + 2], S22, 0xFCEFA3F8);
                        c = GG(c, d, a, b, x[k + 7], S23, 0x676F02D9);
                        b = GG(b, c, d, a, x[k + 12], S24, 0x8D2A4C8A);
                        a = HH(a, b, c, d, x[k + 5], S31, 0xFFFA3942);
                        d = HH(d, a, b, c, x[k + 8], S32, 0x8771F681);
                        c = HH(c, d, a, b, x[k + 11], S33, 0x6D9D6122);
                        b = HH(b, c, d, a, x[k + 14], S34, 0xFDE5380C);
                        a = HH(a, b, c, d, x[k + 1], S31, 0xA4BEEA44);
                        d = HH(d, a, b, c, x[k + 4], S32, 0x4BDECFA9);
                        c = HH(c, d, a, b, x[k + 7], S33, 0xF6BB4B60);
                        b = HH(b, c, d, a, x[k + 10], S34, 0xBEBFBC70);
                        a = HH(a, b, c, d, x[k + 13], S31, 0x289B7EC6);
                        d = HH(d, a, b, c, x[k + 0], S32, 0xEAA127FA);
                        c = HH(c, d, a, b, x[k + 3], S33, 0xD4EF3085);
                        b = HH(b, c, d, a, x[k + 6], S34, 0x4881D05);
                        a = HH(a, b, c, d, x[k + 9], S31, 0xD9D4D039);
                        d = HH(d, a, b, c, x[k + 12], S32, 0xE6DB99E5);
                        c = HH(c, d, a, b, x[k + 15], S33, 0x1FA27CF8);
                        b = HH(b, c, d, a, x[k + 2], S34, 0xC4AC5665);
                        a = II(a, b, c, d, x[k + 0], S41, 0xF4292244);
                        d = II(d, a, b, c, x[k + 7], S42, 0x432AFF97);
                        c = II(c, d, a, b, x[k + 14], S43, 0xAB9423A7);
                        b = II(b, c, d, a, x[k + 5], S44, 0xFC93A039);
                        a = II(a, b, c, d, x[k + 12], S41, 0x655B59C3);
                        d = II(d, a, b, c, x[k + 3], S42, 0x8F0CCC92);
                        c = II(c, d, a, b, x[k + 10], S43, 0xFFEFF47D);
                        b = II(b, c, d, a, x[k + 1], S44, 0x85845DD1);
                        a = II(a, b, c, d, x[k + 8], S41, 0x6FA87E4F);
                        d = II(d, a, b, c, x[k + 15], S42, 0xFE2CE6E0);
                        c = II(c, d, a, b, x[k + 6], S43, 0xA3014314);
                        b = II(b, c, d, a, x[k + 13], S44, 0x4E0811A1);
                        a = II(a, b, c, d, x[k + 4], S41, 0xF7537E82);
                        d = II(d, a, b, c, x[k + 11], S42, 0xBD3AF235);
                        c = II(c, d, a, b, x[k + 2], S43, 0x2AD7D2BB);
                        b = II(b, c, d, a, x[k + 9], S44, 0xEB86D391);
                        a = AddUnsigned(a, AA);
                        b = AddUnsigned(b, BB);
                        c = AddUnsigned(c, CC);
                        d = AddUnsigned(d, DD);
                    }

                    var temp = WordToHex(a) + WordToHex(b) + WordToHex(c) + WordToHex(d);
                    if (isLower) temp = temp.toLowerCase();
                    return temp;
                },
                getDate: function (tick, formatter) {
                    if (!tick) return null;
                    var date = new Date(tick * 1000);
                    if (!formatter) formatter = "yyyy-MM-dd HH:mm:ss";
                    return date.format(formatter);
                },
                bubbleSort:function(arr,val,compare){
                    if(compare){
                        for (var i = 0; i <arr.length; i++) {
                            for (var j = 0; j < i; j++) {
                                if(arr[j][val] > arr[i][val]){
                                    var obj = arr[j];
                                    arr[j] = arr[i];
                                    arr[i] = obj;
                                }
                            }
                        }
                        return arr;
                    }else{
                        for (var i = 0; i <arr.length; i++) {
                            for (var j = 0; j < i; j++) {
                                if(arr[j][val] < arr[i][val]){
                                    var obj = arr[j];
                                    arr[j] = arr[i];
                                    arr[i] = obj;
                                }
                            }
                        }
                        return arr;
                    }
                },
                getTimestamp: function (date) {
                    if (!date) return null
                    date = new Date(date);
                    return Math.round(date.getTime() / 1000);
                },
                getInterval: function (tick) {
                    if (!tick) return null;
                    var date = new Date(tick * 1000);

                    var now = new Date();
                    var year = now.getYear() - date.getYear();
                    if (year > 0) {
                        return year + "年前";
                    }
                    var month = now.getMonth() - date.getMonth();
                    if (month > 0) {
                        return month + "月前";
                    }
                    var day = now.getDate() - date.getDate();
                    if (day > 0) {
                        return day + "天前";
                    }
                    var hour = now.getHours() - date.getHours();
                    if (hour > 0) {
                        return hour + "小时前";
                    }
                    var munite = now.getMinutes() - date.getMinutes();
                    if (munite > 0) {
                        return munite + "分钟前";
                    }
                    return "1分钟内";
                },
                toJson: function (str) {
                    var obj = {};
                    try {
                        obj = eval("(" + str + ")");
                    } catch (e) {
                        obj = null;
                    }
                    return obj;
                }, getAddress: function (data) {
                    var address = "";
                    if (data.district && data.district.cn) {
                        angular.forEach(data.district.cn, function (cn) {
                            address += cn + " ";
                        })
                    }
                    address += data.address;
                    return address;
                }, getOrderState: function (state) {
                    switch (state + "") {
                        case "0":
                            return "待付款";
                        case "1":
                            return "待收货";
                        case "2":
                            return "处理中";
                        case "3":
                            return "已完成";
                        case "-1":
                            return "已取消";
                    }

                    return "";
                }, getMerchantState: function (state) {
                    switch (state + "") {
                        case "0":
                            return "待审核";
                        case "1":
                            return "已通过";
                        case "-1":
                            return "未通过";

                    }
                    return "";
                }, getPickupState: function (state) {
                    switch (state + "") {
                        case "0":
                            return "待处理";
                        case "1":
                            return "待取货";
                        case "2":
                            return "已完成";
                        case "-1":
                            return "已取消";
                    }
                    return "";
                }
            }
        }])
        //ajax请求服务
        .factory('$request', ['$http', 'blockUI', '$config', '$ui', '$q', '$data', 'validateService', function ($http, blockUI, $config, $ui, $q, $data, validateService) {
            var urlPrefix = "";

            var successHandler = function (response, successFunction, status, url) {
                if (!response) {
                    $ui.error("返回为空!  url :" + url
                        + "  status :" + status
                        + "  response :" + response);
                }
                else if (angular.isFunction(successFunction)) {
                    successFunction(response, status);
                }
            };
            var errorHandler = function (response, status, config, headers, errorFunction) {
                var exceptionMsg = "";
                if (response) {
                    exceptionMsg += response.ExceptionMessage;
                    exceptionMsg += response.ExceptionType;
                    exceptionMsg += response.Message;
                    exceptionMsg += response.StackTrace;
                } else {
                    exceptionMsg = "status" + status;
                }
                var ishandle = false;
                if (angular.isFunction(errorFunction)) {
                    ishandle = errorFunction(exceptionMsg);
                }
                if (!ishandle) {
                    // $ui.error(ExceptionMessage);
                }
            };

            var getUrl = function (url) {
                if (url.indexOf('http://') > -1) {
                    return url;
                } else {
                    return $config.getApiUrl() + url;
                }
            };

            var joinData = function (data) {
                var arr = [];
                for (var i in data) {
                    if (typeof (data[i]) == "function" || data[i] == undefined || data[i] == null) {
                        continue;
                    }
                    else if (typeof (data[i]) == "array" || typeof (data[i]) == "object") {
                        arr = arr.concat(joinData(data[i]));
                    } else if (typeof (data[i]) == "boolean") {
                        arr.push(i + (data[i] ? "1" : "0"));
                    } else {
                        arr.push(i + data[i] + "");
                    }
                }
                return arr;
            };
            var appendData = function (data) {
                if (typeof(data) != "object") {
                    alert("$request传递的数据类型必须为Object,声明请使用{}");
                    return false;
                }

                if (data instanceof Array) {
                    alert("$request传递的数据类型必须为Object,声明请使用{}");
                    return false;
                }
                var temArr = joinData(data);
                var str = temArr.sort().join("");
                str = str.trim().toLowerCase();

                str = str.replace(/\s+/g, '');
                data.tk = $data.MD5(str);
                data.PHPSESSID = $data.getCookie('PHPSESSID');
                data = encodeParam(data);
                return data;
            };

            var encodeParam = function (data) {
                var arr = {};
                for (var i in data) {
                    if (typeof (data[i]) == "function") {
                        continue;
                    }
                    else if (data[i] == undefined) {
                        data[i] = "";
                    }
                    else if (typeof (data[i]) == "array" || typeof (data[i]) == "object") {
                        arr[i] = (encodeParam(data[i]));
                    } else if (typeof (data[i]) == "string") {
                        arr[i] = encodeURIComponent(data[i]);
                    } else {
                        arr[i] = data[i];
                    }
                }
                return arr;
            }

            return {
                post: function (url, data, successFunction, errorFunction) {
                    url = getUrl(url);
                    data = appendData(data);
                    if (!data) {
                        return false;
                    }
                    blockUI.start();
                    setTimeout(function () {
                        $http.post(url, data).success(function (response, status, config, headers) {
                            blockUI.stop();
                            successHandler(response, successFunction, status, url);
                        }).error(function (response, status, config, headers) {
                            blockUI.stop();
                            errorHandler(response, status, config, headers, errorFunction);
                        });
                    }, 10);
                },
                postWithNoBlock: function (url, data, successFunction, errorFunction) {
                    url = getUrl(url);
                    data = appendData(data);
                    if (!data) {
                        return false;
                    }
                    setTimeout(function () {
                        $http.post(url, data).success(function (response, status, config, headers) {
                            successHandler(response, successFunction, status, url);
                        }).error(function (response, status, config, headers) {
                            errorHandler(response, status, config, headers, errorFunction);
                        });
                    }, 10);
                },
                postFile: function (url, formData, successFunction, errorFunction) {
                    url = getUrl(url);
                    formData = appendData(formData);
                    if (!formData) {
                        return false;
                    }
                    blockUI.start();
                    setTimeout(function () {
                        var promiss = sendData(url, formData);
                        promiss.then(function (response) {
                            blockUI.stop();
                            successFunction(response);
                        }, function (error) {
                            blockUI.stop();
                            errorFunction(error);
                        })
                    }, 10);
                    function sendData(url, formData) {
                        var deferred = $q.defer();
                        $.ajax({
                            url: url,
                            type: 'POST',
                            data: formData,
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
                },
                get: function (url, successFunction, errorFunction) {
                    url = getUrl(url);
                    blockUI.start();
                    var data = {};
                    data.PHPSESSID = $data.getCookie('PHPSESSID');

                    setTimeout(function () {
                        $http({
                            method: 'GET',
                            url: url,
                            params: data
                        }).success(function (response, status, config, headers) {
                            blockUI.stop();
                            successHandler(response, successFunction, status, url);
                        }).error(function (response, status, config, headers) {
                            blockUI.stop();
                            errorHandler(response, status, config, headers, errorFunction);
                        });
                    }, 10);
                },
                getWithData: function (url, data, successFunction, errorFunction) {
                    url = getUrl(url);
                    if (data) {
                        data = appendData(data);
                        if (!data) {
                            return false;
                        }
                    }
                    else {
                        data = {};
                        data.PHPSESSID = $data.getCookie('PHPSESSID');
                    }
                    blockUI.start();
                    setTimeout(function () {
                        $http({
                            method: 'GET',
                            url: url,
                            params: data
                        }).success(function (response, status, config, headers) {
                            blockUI.stop();
                            successHandler(response, successFunction, status, url);
                        }).error(function (response, status, config, headers) {
                            blockUI.stop();
                            errorHandler(response, status, config, headers, errorFunction);
                        });
                    }, 10);
                },
                getWithNoBlock: function (url, successFunction, errorFunction) {
                    url = getUrl(url);
                    var data = {};
                    data.PHPSESSID = $data.getCookie('PHPSESSID');
                    setTimeout(function () {
                        $http({
                            method: 'GET',
                            url: url,
                            params: data
                        }).success(function (response, status, config, headers) {
                            successHandler(response, successFunction, status, url);
                        }).error(function (response, status, config, headers) {
                            errorHandler(response, status, config, headers, errorFunction);
                        });
                    }, 10);
                },

            }
        }])
        //提供界面类操作，如弹出窗，错误提示 ，确认框等
        .factory('$ui', ['$q', '$rootScope', '$location', '$dialogs', '$data', '$stateParams', function ($q, $rootScope, $location, $dialogs, $data, $stateParams) {
            function loadJs(url, action, callback) {
                var js = '';
                if (angular.isDefined(action) && action != null) {
                    js = action;
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
                    var dependencies = [js];
                    var deferred = $q.defer();
                    require(dependencies, function () {
                        $rootScope.$apply(function () {
                            deferred.resolve();

                            callback();
                        });
                    });
                    deferred.promise;
                }
            };

            return {
                locate: function (url) {
                    if (url.indexOf('http') < 0) {
                        var nurl = window.location.protocol + '//' + window.location.host + '/' + url;
                        window.location.href = nurl;
                    }
                    else {
                        window.location.href = url;
                    }
                },
                locateWithData: function (url, data) {
                    this.setData(data);
                    this.locate(url);
                },
                locatePart: function (url) {
                    $location.path(url);
                },
                locatePartWithData: function (url, data) {
                    this.setData(data);
                    this.locatePart(url);
                },
                locateLogin: function () {
                    var url = "user.html#/user/login?module=" + $stateParams.module + "&action=" + $stateParams.action;
                    this.locate(url);
                },
                locate404: function () {
                    this.locate("user.html#/error/404");
                },
                locate500: function () {
                    this.locate("user.html#/error/500");
                },
                locateCustomError: function (msg) {
                    this.locate("user.html#/error/custom?msg=" + msg);
                },
                locateLogout: function (returnUrl) {
                    this.locateLogin(returnUrl);
                },
                locateBlank: function (url) {
                    var nurl = window.location.protocol + '//' + window.location.host + '/Main/Main/Frame#' + url;
                    window.open(nurl);
                },
                goBack: function () {
                    window.history.back();
                },
                notify: function (msg, title, callback_ok) {
                    $dialogs.notify(title, msg, callback_ok);
                },
                error: function (msg, callback_ok) {
                    $dialogs.error(msg, callback_ok);
                },
                confirm: function (msg, title, callback_ok, callback_cancel) {
                    $dialogs.confirm(title, msg, callback_ok, callback_cancel);
                },
                openWindow: function (url, ctrl, data, callback_ok, callback_cancel, action) {
                    loadJs(url, action, function () {
                        $dialogs.openModal(url, ctrl, data, 'lg', callback_ok, callback_cancel);
                    });
                },
                openWindowSm: function (url, ctrl, data, callback_ok, callback_cancel, action) {
                    loadJs(url, action, function () {
                        $dialogs.openModal(url, ctrl, data, 'sm', callback_ok, callback_cancel);
                    });
                },
                setData: function (data) {
                    $data.delData('trans');
                    $data.setData('trans', data);
                },
                getData: function () {
                    return $data.getData('trans');
                },
                getUrlParam: function () {
                    if (!$stateParams.params) {
                        return $stateParams.params
                    }
                    var paramArr = $stateParams.params.split("&");
                    var params = {};
                    angular.forEach(paramArr, function (p) {
                        var param = p.split('=');
                        params[param[0]] = param[1];
                    })

                    return params;
                },
                getKeyByUrl: function () {
                    var result = null;
                    var href = window.location.href;
                    var dx = href.indexOf("?");
                    if (dx > -1) {
                        var temUrl = href.substring(dx + 1, href.length);
                        dx = temUrl.indexOf("#");
                        if (dx > 0) {
                            temUrl = temUrl.substring(0, dx);
                        }
                        if (temUrl.indexOf("&") > 0) {
                            var args = temUrl.split('&');
                            angular.forEach(args, function (arg) {
                                var kv = arg.split('=');
                                if (kv.length > 1) {
                                    if (result == null) {
                                        result = {};
                                    }
                                    result[kv[0]] = kv[1];
                                }
                            });
                        } else {
                            var kv = temUrl.split('=');
                            if (kv.length > 1) {
                                if (result == null) {
                                    result = {};
                                }
                                result[kv[0]] = kv[1];
                            }
                        }
                    }

                    return result;
                },
            }
        }
        ])
        //提供数据验证服务
        .factory('$validate', ['validateService', function (validateService) {
            return {
                isEmpty: function (input) {
                    return validateService.isEmpty(input);
                },
                isNum: function (input) {
                    return validateService.isNum(input);
                },
                isFloat: function (input) {
                    return validateService.isFloat(input);
                },
                isArray: function (input) {
                    if (validateService.isEmpty(input)) {
                        return false;
                    }
                    if (typeof (input) == "object" && angular.isDefined(input.length)) {
                        return true;
                    }

                    return false;
                },
                equal: function (source, target) {
                    return validateService.equal(source, target);
                },
                minLength: function (input, minLength) {
                    return validateService.minLength(input, minLength);
                },
                maxLength: function (input, maxLength) {
                    return validateService.maxLength(input, maxLength);
                },
                rangeLength: function (input, minLength, maxLength) {
                    return validateService.rangeLength(input, minLength, maxLength);
                },
                min: function (input, min) {
                    return validateService.min(input, min);
                },
                max: function (input, max) {
                    return validateService.max(input, max);
                },
                range: function (input, min, max) {
                    return validateService.range(input, min, max);
                },
                email: function (input) {
                    return validateService.email(input);
                },
                passLevel: function (input) {
                    return validateService.passLevel(input);

                },
                addError: function (ctrl, error) {
                    var parentElement = ctrl.parent();
                    parentElement.addClass('has-error');
                    var showMsg = '<span class="help-block dir-error">' + error + '</span>';
                    ctrl.after(showMsg);
                },
                removeError: function (ctrl) {
                    var parentElement = ctrl.parent();

                    parentElement.removeClass('has-error');

                    var spanInfos = parentElement.find('span');

                    angular.forEach(spanInfos, function (value) {
                        var span = angular.element(value);
                        if (span.hasClass('dir-error')) {
                            span.remove();
                        }
                    });
                }
            }
        }])
        //权限模块
        .factory('$permission', ['$http', '$config', function ($http, $config) {

        }])
        //服务配置
        .factory('$config', function () {

            function randomNum(min, max) {
                var Range = max - min;
                var Rand = Math.random();
                return (min + Math.round(Rand * Range));
            }

            function randomStr(length, hasUpper, hasNum) {
                var str = "abcdefghijklmnopqrstuvwxyz1234567890";
                var result = "";
                for (var i = 0; i < length; i++) {
                    var num = randomNum(0, str.length - 1);
                    result += str[num];
                }
                return result;
            }

            var config = {};
            config.getApiUrl = function () {
                return 'http://127.0.0.1/';
            }

            config.getCheckImg = function () {
                return "/api/view/img.php?r=" + randomStr(10);
            }

            return config;
        })

})
;