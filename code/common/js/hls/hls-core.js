'use strict'

define(['angular'], function () {

    var coreModule = angular.module('hls.core', []);

    coreModule.run(function () {
        /*String扩展*/
        String.prototype.startWith = function (str) {
            var reg = new RegExp("^" + str);
            return reg.test(this);
        }

        String.prototype.endWith = function (str) {
            var reg = new RegExp(str + "$");
            return reg.test(this);
        }


        /*  数组扩展*/

        //过滤重复，确保唯一
        Array.prototype.unique = function () {
            var res = [];
            var json = {};
            for (var i = 0; i < this.length; i++) {
                if (!json[this[i]]) {
                    res.push(this[i]);
                    json[this[i]] = 1;
                }
            }
            return res;
        }

        // 判断包含
        Array.prototype.contains = function (element) {

            for (var i = 0; i < this.length; i++) {
                if (this[i] == element) {
                    return true;
                }
            }
            return false;
        }

        //数组删除
        Array.prototype.remove = function (val) {
            var index = this.indexOf(val);
            if (index > -1) {
                this.splice(index, 1);
            }
        };

        //chunk
        Array.prototype.chunk = function (input, size) {
            var result = [];

            for (var i = 0, len = input.length; i < len; i += size) {
                result.push(input.slice(i, i + size));
            }
            return result;
        }

        //数组如果是对象，按照某属性排序
        Array.prototype.sortby = function (key, desc) {

            return this.sort(function (a, b) {
                if (desc)return ~~(a[key] < b[key]) ? 1 : -1;
                return ~~(a[key] > b[key]) ? 1 : -1;
            });
        }

        //汉字排序
        Array.prototype.localeCompareSort = function (key, desc) {
            return this.sort(function (a, b) {
                return desc ? a[key].localeCompare(b[key]) : b[key].localeCompare(a[key])
            })
        }

        if (!Array.prototype.forEach) {
            Array.prototype.forEach = function (fun /*, thisp*/) {
                var len = this.length;
                if (typeof fun != "function")
                    throw new TypeError();

                var thisp = arguments[1];
                for (var i = 0; i < len; i++) {
                    if (i in this)
                        fun.call(thisp, this[i], i, this);
                }
            };
        }

        /** 扩展日期对象*/

        Date.prototype.format = function (fmt) {
            var o = {
                "M+": this.getMonth() + 1, //月份        
                "d+": this.getDate(), //日        
                "h+": this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, //小时        
                "H+": this.getHours(), //小时        
                "m+": this.getMinutes(), //分        
                "s+": this.getSeconds(), //秒        
                "q+": Math.floor((this.getMonth() + 3) / 3), //季度        
                "S": this.getMilliseconds() //毫秒        
            };
            var week = {
                "0": "\u65e5",
                "1": "\u4e00",
                "2": "\u4e8c",
                "3": "\u4e09",
                "4": "\u56db",
                "5": "\u4e94",
                "6": "\u516d"
            };
            if (/(y+)/.test(fmt)) {
                fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
            }
            if (/(E+)/.test(fmt)) {
                fmt = fmt.replace(RegExp.$1, ((RegExp.$1.length > 1) ? (RegExp.$1.length > 2 ? "\u661f\u671f" : "\u5468") : "") + week[this.getDay() + ""]);
            }
            for (var k in o) {
                if (new RegExp("(" + k + ")").test(fmt)) {
                    fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
                }
            }
            return fmt;
        }

    });

    coreModule.service('constService', function () {
        var service = {};

        service.gender = [
            {name: '男', value: '0'},
            {name: '女', value: '1'}
        ];

        service.dateInfo = {
            format: 'yyyy-MM-dd',
            opened: false,
            minDate: null,
            maxDate: null,
            dateOptions: {
                formatYear: 'yy',
                startingDay: 1
            },
            disabled: function (date, mode) {
                //                return (mode === 'day' && (date.getDay() === 0 || date.getDay() === 6));
                return false;
            },
            open: function ($event) {
                $event.preventDefault();
                $event.stopPropagation();

                this.opened = true;
            }
        };

        return service;
    });

    coreModule.service('dataFormatter', function (constService) {
        var service = {};

        service.formatterGender = function (genderValue) {
            var result = genderValue;
            angular.forEach(constService.gender, function (gender) {
                if (genderValue == gender['value']) {
                    result = gender['name'];
                }
            });

            return result;
        }

        return service;
    });

    coreModule.service('jsComService', function () {
        var service = {};

        service.clone = function (source) {
            var result = {};
            for (var key in source) {
                result[key] = typeof source[key] === 'object' ? service.clone(source[key]) : source[key];
            }
            return result;
        }

        //2015-01-01 11:12:13形式
        service.getLocalTime = function (nS) {
            return new Date(parseInt(nS) * 1000).toLocaleString().replace(/年|月/g, "-").replace(/日/g, " ");
        }

        //16->13
        service.changeTimeStamp = function (timestamp) {
            return parseInt(new String(timestamp).substr(0, 13), 10);
        }

        return service;
    });

    coreModule.service('validateService', function () {
        var service = {};

        service.isEmpty = function (input) {
            if (input == '' || input == null || angular.isUndefined(input)) {
                return true;
            }
            return false;
        }

        service.isNum = function (input) {
            if (!this.isEmpty(input)) {
                var r, re;
                re = /\d*/i; //\d表示数字,*表示匹配多个数字
                r = input.match(re);
                return (r == input) ? true : false;
            }
            return false;
        }

        service.isFloat = function (input) {
            if (this.isEmpty(input)) return false;

            var strP = /^\d+(\.\d+)?$/;
            if (!strP.test(input)) return false;
            try {
                if (parseFloat(input) != input) return false;
            } catch (ex) {
                return false;
            }

            return true;
        }

        service.equal = function (source, target) {
            if (source === target) {
                return true;
            }
            return false;
        }

        service.minLength = function (input, minLength) {
            if (input.length >= minLength) {
                return true;
            }
            return false;
        }

        service.maxLength = function (input, maxLength) {
            if (input.length <= maxLength) {
                return true;
            }
            return false;
        }

        service.rangeLength = function (input, minLength, maxLength) {
            if (this.isEmpty(input)) {
                return false;
            }
            if (input.length >= minLength && input.length <= maxLength) {
                return true;
            }
            return false;
        }

        service.min = function (input, min) {
            var inputValue = parseFloat(input);
            var minValue = parseFloat(min);
            if (input >= minValue) {
                return true;
            }
            return false;
        }

        service.max = function (input, max) {
            var inputValue = parseFloat(input);
            var maxValue = parseFloat(max);
            if (input <= maxValue) {
                return true;
            }
            return false;
        }

        service.range = function (input, min, max) {
            var inputValue = parseFloat(input);
            var minValue = parseFloat(min);
            var maxValue = parseFloat(max);
            if (input >= minValue && input <= maxValue) {
                return true;
            }
            return false;
        }

        service.email = function (input) {
            var myRegExp = /[a-z0-9-.]{1,30}@[a-z0-9-]{1,65}.(com|net|org|info|biz|([a-z]{2,3}.[a-z]{2}))/;
            return myRegExp.test(input);
        }

        service.passLevel = function (input) {
            function containSpecialChar(str) {
                var containSpecial = RegExp(/[(\ )(\~)(\!)(\@)(\#)(\$)(\%)(\^)(\&)(\*)(\()(\))(\-)(\_)(\+)(\=)(\[)(\])(\{)(\})(\|)(\\)(\;)(\:)(\')(\")(\,)(\.)(\/)(\<)(\>)(\?)(\)]+/);
                return (containSpecial.test(str));
            }

            var securityLevelFlag = 0;
            if (password.length < 6) {
                return 0;
            }
            else {
                if (/[a-z]/.test(password)) {
                    securityLevelFlag++;    //lowercase
                }
                if (/[A-Z]/.test(password)) {
                    securityLevelFlag++;    //uppercase
                }
                if (/[0-9]/.test(password)) {
                    securityLevelFlag++;    //digital
                }
                if (containSpecialChar(password)) {
                    securityLevelFlag++;    //specialcase
                }
                return securityLevelFlag;
            }

        }

        return service;
    });
})
;