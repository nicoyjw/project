/**
 * Created by fengxiaofei on 2015/12/10.
 */
'use strict'
define([], function () {
        var testSummernoteModule = angular.module("testSummernoteModule", []);

        testSummernoteModule.controller('testSummernoteCtrl', ['$scope', '$store', '$request', function ($scope, $store, $request) {
            $scope.content = "测试数据";

            //$scope.imageUpload = function (files) {
            //    sendFile(files[0], $scope.editor, $scope.editable);
            //    function sendFile(file, editor, $editable) {
            //        $(".note-toolbar.btn-toolbar").append('正在上传图片 ');
            //        var filename = false;
            //        try {
            //            filename = file['name'];
            //        } catch (e) {
            //            filename = false;
            //        }
            //        if (!filename) {
            //            $(".note-alarm").remove();
            //        }
            //        //以上防止在图片在编辑器内拖拽引发第二次上传导致的提示错误
            //        var ext = filename.substr(filename.lastIndexOf("."));
            //        ext = ext.toUpperCase();
            //        var timestamp = new Date().getTime();
            //        var name = timestamp + "_" + $("#summernote").attr('aid') + ext;
            //        //name是文件名，自己随意定义，aid是我自己增加的属性用于区分文件用户
            //        var data = new FormData();
            //        data.append("file", file);
            //        data.append("key", name);
            //        data.append("token", $("#summernote").attr('token'));
            //        $request.post('api/?action=test', data, function (response) {
            //            //data是返回的hash,key之类的值，key是定义的文件名
            //            editor.insertImage($editable, $("#summernote").attr('url-head') + response['key']);
            //            //url-head是自己七牛云的domain
            //            $(".note-alarm").html("上传成功,请等待加载");
            //            setTimeout(function () {
            //                $(".note-alarm").remove();
            //            }, 3000);
            //        }, function (error) {
            //            $(".note-alarm").html("上传失败");
            //            setTimeout(function () {
            //                $(".note-alarm").remove();
            //            }, 3000);
            //        });
            //    }
            //}

            $scope.sendContent = function () {
                var data = {};
                data.content = angular.copy($scope.content);
                $request.post('api/?action=test', data, function (response) {
                    alert(response);
                }, function (error) {
                    alert(error);
                });
            }
        }]);
    }
)