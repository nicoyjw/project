/**
 * Created by fengxiaofei on 2015/12/18.
 */
'use strict'

define([], function () {
    angular.module('testGridModule', [])
        .controller('testGridCtrl', ['$scope', '$sce', function ($scope, $sce) {

            $scope.formatterGender = function (value) {
                if (value == '0') {
                    return '男';
                }
                else {
                    return '女';
                }
            }

            $scope.imgFormatter = function (value) {
                return $sce.trustAsHtml(value);
            }

            $scope.gridOptions = {
                tableClass: "table table-bordered table-striped table-hover",
                data: [],
                cols: [
                    {FieldName: 'userno', DisplayName: '工号', ClassName: '', IsShow: true,},
                    {FieldName: 'Username', DisplayName: '姓名',},
                    {FieldName: 'Account', DisplayName: '账号',},
                    {FieldName: 'Email', DisplayName: '邮件',},
                    {FieldName: 'gender', DisplayName: '性别', Formatter: $scope.formatterGender},
                    {FieldName: 'Phone', DisplayName: '电话',},
                    {FieldName: 'logo', DisplayName: '图片', trustAsHtml: true},
                    {FieldName: 'address', DisplayName: '地址',},
                    {FieldName: 'MyValue.Value', DisplayName: '复合形式',},
                ],
                colsOpr: {
                    headName: '操作',
                    headClass: '',
                    init: {
                        showView: true,
                        viewTitle: "查看信息",
                        viewIcon: "fa fa-eye text-success",
                        viewFn: function (data) {
                            alert('view');
                        },

                        showEdit: true,
                        editTitle: "编辑单条",
                        editIcon: "fa fa-edit text-primary",
                        editFn: function (data) {
                            alert('edit');
                        },

                        showDelete: true,
                        delTitle: "删除了",
                        delIcon: "fa fa-remove text-danger",
                        delFn: function (data) {
                            alert('delete');
                        }

                    },
                    colInfo: [
                        {
                            title: '自定义',
                            iconClass: 'fa fa-rss text-warning',
                            clickFn: function (data) {
                                alert('self define');
                            },
                        },
                    ],
                },
                colsChk: {//if not need checkbox,undefined this
                    //rowCheckname: 'checked',//if undefined,use default name
                    checkAllChange: function () {
                    },
                    rowCheckChange: function (data) {
                    },
                    keyName: 'ID',//if not get selected data.undefined
                    data: [],//if not get selected data.undefined
                },
                rowOpr: {
                    rowSelected: function (data) {
                        //alert("row selected");
                    },
                },
                colsHidden: [],
            }

            $scope.getSelectData = function () {
                alert(angular.toJson($scope.gridOptions.colsChk.data));
            }

            $scope.setSelectData = function () {
                var index = 1;
                angular.forEach($scope.gridOptions.data, function (record) {
                    if (index % 2 == 0) {
                        $scope.gridOptions.colsChk.data.push(record);
                    }
                    index++;
                });
            }

            $scope.clearSelectData = function () {
                $scope.gridOptions.colsChk.data = [];
            }

            $scope.InitGridData = function () {
                for (var i = 1; i <= 10; i++) {
                    var currObj = {
                        ID: i.toString(),
                        No: 'NO-' + i.toString(),
                        Name: 'name-' + i.toString(),
                        Account: 'account-' + i.toString(),
                        Email: i.toString() + '@vcyber.cn',
                        Gender: i % 2 == 0 ? '0' : '1',
                        Phone: 'phone-' + i.toString(),
                        logo: '<img src=\"../../img/icon/QQ.png\" alt=\"QQ图片\">',
                        Address: 'Address-' + i.toString(),
                        MyValue: {},
                    };
                    currObj.MyValue.Value = 'value-' + i.toString();
                    $scope.gridOptions.data.push(currObj);
                }
            }

            $scope.InitGridData();

        }]);
});