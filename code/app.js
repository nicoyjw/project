/*
* @Author: 刘玉洁
* @Date:   2016-05-17 18:17:34
* @Last Modified by:   Administrator
* @Last Modified time: 2016-05-20 18:25:09
*/

'use strict'
var remoteUrl = 'http://cdn.93myb.com/';
require.config({

    baseUrl: "",

    paths: {
        'jquery': remoteUrl + 'jquery/dist/jquery.min',
        'angular': remoteUrl + 'angular/angular',
        'uiRouter': remoteUrl + 'angular-ui-router/release/angular-ui-router.min',
        'angularAMD': remoteUrl + 'angularAMD/angularAMD.min',
        'angular-animate': remoteUrl + 'angular-animate/angular-animate',
        'bootstrap': remoteUrl + 'bootstrap/dist/js/bootstrap.min',
        'angular-sanitize': remoteUrl + 'angular-sanitize/angular-sanitize.min',
        'ui-bootstrap-tpls': remoteUrl + 'angular-bootstrap/ui-bootstrap-tpls',
        'moment': remoteUrl + 'moment/moment',
        'locale': remoteUrl + 'moment/locale/zh-cn',
        'datetimepicker': remoteUrl + 'angular-bootstrap-datetimepicker/src/js/datetimepicker',
        'summernote': remoteUrl + 'summernote/dist/summernote.min',
        'angular-summernote': remoteUrl + 'angular-summernote/dist/angular-summernote.min',
        'summernote-lang': remoteUrl + 'summernote/dist/lang/summernote-zh-CN.min',
        'fileinput': remoteUrl + 'fileinput/js/fileinput',
        'fileinput-lang': remoteUrl + 'fileinput/js/fileinput_locale_zh',
        //'angular-city': remoteUrl + 'angular-city-select/dist/angular-city-select',
        'angular-messages': 'common/js/vendor/angular-message/ng-messages',
        'blockUI': 'common/js/vendor/angular-block-ui/dist/angular-block-ui.min',
        'angular-translate': 'common/js/vendor/angular-translate/angular-translate.min',
        'angular-translate-loader': 'common/js/vendor/angular-translate-loader-static-files/angular-translate-loader-static-files.min',
        'hls-core': 'common/js/hls/hls-core',
        'hls-util': 'common/js/hls/hls-util',
        'hls-ui': 'common/js/hls/hls-ui'
    },
    map: {
        '*': {
            'css': remoteUrl + 'require-css/css.js'
        }
    },
    // Add angular modules that does not support AMD out of the box, put it in a shim
    shim: {
        "angular": {exports: "angular"},
        'angularAMD': ['angular'],
        'uiRouter': ["angular"],
        'angular-animate': ['angular'],
        'ui-bootstrap-tpls': ['angular'],
        'angular-sanitize': ['angular'],
        'blockUI': ['angular',
            'css!' + remoteUrl + 'angular-block-ui/dist/angular-block-ui.css'],
        'bootstrap': ['jquery',
            'css!' + remoteUrl + 'bootstrap/dist/css/bootstrap.css',
            'css!' + remoteUrl + 'bootstrap/dist/css/bootstrap-theme.css',
            'css!' + remoteUrl + 'font-awesome/css/font-awesome.css',
            'css! css/bootstrap-hls.css',],
        'summernote': ['bootstrap',
            'css!' + remoteUrl + 'summernote/dist/summernote.css'],
        'summernote-lang': ['summernote'],
        'angular-summernote': ['angular', 'summernote', 'summernote-lang'],
        'fileinput': ['bootstrap',
            'css!' + remoteUrl + 'fileinput/css/fileinput.min.css'],
        'fileinput-lang': ['fileinput'],
        'datetimepicker': [
            //'css!' + remoteUrl + 'angular-bootstrap-datetimepicker/src/css/datetimepicker.css'
        ],
        //'angular-city': ['angular', 'css!' + remoteUrl + 'angular-city-select/dist/angular-city-select.css'],
        'angular-messages': ['angular'],
        'angular-translate': ['angular'],
        'angular-translate-loader': ['angular', 'angular-translate'],
        'hls-ui': ['hls-core',
            'css! css/hls-ui.css'
        ],
        'hls-util': ['hls-ui'],
    }
});

define(['angular', 'angularAMD', 'uiRouter', 'blockUI', 'bootstrap', 'ui-bootstrap-tpls', 'angular-sanitize', 'angular-summernote', 'fileinput-lang',
    'hls-util', 'angular-translate', 'angular-translate-loader',

    // 'css! css/less,'
    'css! css/index', 'css! common/css/hls'], function (angular, angularAMD, blockUI) {
    // routes
    var registerRoutes = function ($stateProvider, $urlRouterProvider) {
        var jsResolve = {
            load: ['$q', '$rootScope', '$stateParams',
                function ($q, $rootScope, $stateParams) {

                    if ($stateParams.length == 0) {
                        return null;
                    }
                    var path = './views/' + $stateParams.module + "/" + $stateParams.action;
                    var deferred = $q.defer();
                    require([path], function () {
                        $rootScope.$apply(function () {
                            deferred.resolve();
                        });
                    });
                    return deferred.promise;
                }]
        };
        // default

        $urlRouterProvider.when('', '/home/index');
        //$urlRouterProvider.otherwise("/tutorials/main");

        // route
        $stateProvider.state('module', {
            url: "/{module}/{action}?{params}",
            templateUrl: function ($scope) {
                return 'views/' + $scope.module + '/' + $scope.action + '.html';
            },
            resolve: jsResolve
        });
    };
    // module
    var app = angular.module("indexModule", ["ui.router", 'blockUI', 'ui.bootstrap', 'ngSanitize', 'hls.util', 'summernote', 'pascalprecht.translate']);

    // config
    app.config(["$stateProvider", "$urlRouterProvider", registerRoutes]);

    app.config(function ($httpProvider) {
        //$httpProvider.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';
        //$httpProvider.defaults.headers.common['Access-Control-Allow-Origin'] = '*';
    });

    app.config(function (blockUIConfig) {
        // Change the default overlay message
        blockUIConfig.message = '<i class="fa fa-spinner fa-spin fa-lg fa-fw"></i>';
        // Change the default delay to 100ms before the blocking is visible
        blockUIConfig.delay = 100;
        // Disable automatically blocking of the user interface
        blockUIConfig.autoBlock = false;
    });

    app.config(['$translateProvider',function($translateProvider){
        var lang = window.localStorage.lang||'cn';
        window.localStorage.lang = lang;
        $translateProvider.preferredLanguage(lang);
        $translateProvider.useSanitizeValueStrategy('escape');
        $translateProvider.useStaticFilesLoader({
            prefix: '/i18n/',
            suffix: '.json'
        });

    }]);

    app.controller('indexCtrl', ['$scope', '$store', '$ui', '$data', '$http', '$rootScope',
        function ($scope, $store, $ui, $data, $http, $rootScope) {
            //获取所有图片相关数据（状态栏logo, 顶部logo, 底部logo, 底部二维码等等）
            $scope.getLogoImages = function(){
                $http.get('api/?model=news&action=check_one&tab=classify&key=type&val=pic')
                    .success(function(response,status,headers,config){
                        if(response.success){ 
                            $rootScope.logoImages = response.data;
                            $store.setJson('Images', response.data);
                        }
                    })
            }
            $scope.getLogoImages();
            $rootScope.lang = $store.get('lang');
        }]);

    app.filter("T", ['$translate', function($translate) {
        return function(key) {
            if(key){
                return $translate.instant(key);
            }
        };
    }]).filter('contentSubstr', function(){
        return function(content, length){
            if(content&&content.length>length){
                return content.substr(0, length)+' ...';
            }else{
                return content;
            }
        }
    });

    // bootstrap
    return angularAMD.bootstrap(app);

})
;



