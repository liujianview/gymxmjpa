
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js">
    window.onunload(alert("spinfo"))
</script>
<html>
<head>
    <title>商品消费详情</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/table/bootstrap-table.min.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/table/bootstrap-table.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/table/locale/bootstrap-table-zh-CN.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/sweetalert/sweetalert.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/sweetalert/sweetalert.min.js"></script>
    <script src="${pageContext.request.contextPath}/static//bootstrap/js/tableExport.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/date/bootstrap-datetimepicker.min.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/date/Moment.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/date/bootstrap-datetimepicker.min.js"></script>

    <script>
        var s = 0;
        var count=0;
        var price=0;
        $(function () {
            $("#spid").change(function () {
                var sid = $("#spid").val();
                $.post("${pageContext.request.contextPath}/goods/cha",{"goodsId":sid},function(e) {
                   // s.val(e.sellingPrice);
                    s = e.sellPrice;
                })
            })
            $('#count').change(function () {
                count=parseInt($('#count').val());
                price = parseInt(s*count);
            })
            $('#table').bootstrapTable({
                url:'${pageContext.request.contextPath}/goodinfo/query',
                method:'post',
                contentType:"application/x-www-form-urlencoded",
                columns:[{ checkbox:true
            }, {
                field: 'id',
                title: '编号'
            },{
                field: 'goods.goodsName',
                title: '消费商品名称'
            },{
                    field: 'member.memberName',
                    title: '会员名称'

            },{
                field: 'count',
                title: '数量'
            },
            {
                field: 'price',
                title: '价钱'
            },
            {
                field: 'remark',
                title: '备注'
            }, {
                        field:'xx',title:'操作',
                        formatter : function(value, row, index) {
                            return "<a title='删除' href='javascript:del1("
                                + row.id + ")'><span class='glyphicon glyphicon-trash'></span></a>";
                        }

                    }
                ],
                queryParamsType:'',
                queryParams:queryParams,
                height:360,
                pageList:[5,10,15],
                pageNumber:1,
                pageSize:5,
                pagination:true,
                sidePagination:'server',

            })
        });
        //删除
        function del1(id){

            swal({
                    title: "确定删除吗？",
                    text: "您将无法恢复！",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "确定删除！",
                    cancelButtonText: "取消删除！",
                    closeOnConfirm: false,
                    closeOnCancel: false
                },
                function (isConfirm) {
                    if (isConfirm) {

                        var opt=$('#table').bootstrapTable('getOptions');
                        var goodsid=$('#goodsid').val();
                        var memberid=$('#memberid').val();
                        $.post('${pageContext.request.contextPath}/goodinfo/del',{'id':id,"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"goodsid":goodsid,"memberid":memberid},function(data){
                            //重新给table绑定数据
                            $("#table").bootstrapTable("load",data) ;
                        }) ;
                        swal("删除！", "删除成功",
                            "success");

                    } else {
                        swal("取消！", "您已取消删除)",
                            "error");
                    }
                });
        }

        //获取当前的条件个页面页数即使更新值
        function queryParams(afds){
            var i={
                "pageSize":afds.pageSize,
                "pageNumber":afds.pageNumber,
                "goods.goodsId":$('#goodsid').val(),
                "member.memberId":$('#memberid').val()
            };
            return i;
        }
        //查询
        function search(){
            var opt=$('#table').bootstrapTable('getOptions');
            var goodsid=$('#goodsid').val();
            var memberid=$('#memberid').val();
            $.post("${pageContext.request.contextPath}/goodinfo/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"goodsid":goodsid,"memberid":memberid},function (releset) {
                $("#table").bootstrapTable('load',releset) ;
            })
        }

        function ss() {
            $("#hyid").val("");
            $("#remark").val("");
            $("#count").val("");
            $.post("${pageContext.request.contextPath}/goods/topcoach",{},function (releset) {
                var e=releset;
                var tt ="";
                var tttt="";
                var ttt="<option value='-1'>"+"--请选择--"+"</option>";
                $(e.goods).each(function () {
                    tt += "<option value='"+this.goodsId+"'>"+"❤"+this.goodsName+"</option>";
                    tttt=ttt+tt;
                    $('#spid').html(tttt);
                })
            })
        }
        //添加消费记录
        function save(){
            if(!validateAdd()){
                return;
            }
            //接收数据
            var opt=$('#table').bootstrapTable('getOptions');
            var goodsid=$('#goodsid').val();
            var memberid=$('#memberid').val();
            var spid=$("#spid").val();
            var hyid = $("#namey").val();
            count =$("#count").val();
            var j = price;
            var remark= $("#remark").val();
            $("#myModal").modal("hide") ;


            $.post('${pageContext.request.contextPath}/goods/cha',{'goodsId':spid},function(data){
                $("#table").bootstrapTable("load",data) ;
                if(data.inventory>count){
                    $.post('${pageContext.request.contextPath}/goodinfo/add',{'member.memberId':hyid,'goods.goodsId':spid,'count':count,'price':j,'remark':remark},function(data){
                        $("#table").bootstrapTable("load",data) ;
                        $.post("${pageContext.request.contextPath}/goodinfo/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"goodsid":goodsid,"memberid":memberid},function (releset) {
                            $("#table").bootstrapTable('load',releset) ;
                        })
                        $.post('${pageContext.request.contextPath}/goodinfo/chamember',{'memberId':hyid},function(data){
                            var money = data.memberbalance;
                            var qian  = parseInt(money -j);
                            $.post('${pageContext.request.contextPath}/goodinfo/updmember',{'memberId':hyid,'memberbalance':qian},function(data){
                            });
                        });
                        $.post('${pageContext.request.contextPath}/goods/cha',{'goodsId':spid},function(data){
                            var inventory = data.inventory;
                            var shu  = parseInt(inventory -count);
                            $.post('${pageContext.request.contextPath}/goodinfo/updgoods',{'goodsId':spid,'inventory':shu},function(data){
                            });
                        });

                        swal("添加！", "添加消费记录成功",
                            "success");
                    });

                }else{
                    swal("失败！", "商品库存不足",
                        "error");
                    $.post("${pageContext.request.contextPath}/goodinfo/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"goodsid":goodsid,"memberid":memberid},function (releset) {
                        $("#table").bootstrapTable('load',releset) ;
                    })
                }
            })

        }

        function validateAdd() {
            $("#spid").parent().find("span").remove();
            $("#hyid").parent().find("span").remove();
            $("#count").parent().find("span").remove();

            var spid = $("#spid").val().trim();
            if(spid == -1){
                $("#spid").parent().append("<span style='color:red'>请选择商品名称</span>");
                return false;
            }

            var hyid = $("#hyid").val().trim();
            if(hyid == null || hyid == ""){
                $("#hyid").parent().append("<span style='color:red'>请选择会员名称</span>");
                return false;
            }

            var count = $("#count").val().trim();
            if(count == null || count == ""){
                $("#count").parent().append("<span style='color:red'>请填写数量</span>");
                return false;
            }

            if(!(/^[1-9]\d*$/.test(count))){
                $("#count").parent().append("<span style='color:red'>数量只能为正整数</span>");
                return false;
            }
            return true;
        }


        function kan1() {

            $("#myModal3").modal("show");
            $('#tb').bootstrapTable({
                url:'${pageContext.request.contextPath}/private/query2',
                method:'post',
                contentType:"application/x-www-form-urlencoded",
                columns:[{ radio:true
                }, {
                    field: 'memberId',
                    title: '编号'
                },{
                    field: 'memberName',
                    title: '会员名称'
                },{
                    field: 'membertypes.typeName',
                    title: '会员类型'
                }
                ],
                queryParamsType:'',
                queryParams:queryParams,
                height:360,
                pagination:true,
                onDblClickRow: function (row) {

                    $('#myModal3').modal("hide");
                    id = row.memberId;
                    $.post("${pageContext.request.contextPath}/private/cha2",{"id":id},function(e) {
                        $('#hyid').val(e.memberName);
                        $('#namey').val(e.memberId)
                    })
                }

            })
        }
        function kan2() {
            $("#myModal3").modal("show");
            $('#tb').bootstrapTable({
                url:'${pageContext.request.contextPath}/private/query2',
                method:'post',
                contentType:"application/x-www-form-urlencoded",
                columns:[{ radio:true
                }, {
                    field: 'memberId',
                    title: '编号'
                },{
                    field: 'memberName',
                    title: '会员名称'
                },{
                    field: 'membertypes.typeName',
                    title: '会员类型'
                }
                ],
                queryParamsType:'',
                queryParams:queryParams,
                height:360,
                pagination:true,
                onDblClickRow: function (row) {
                    $('#myModal3').modal("hide");
                    id = row.memberId;
                    $.post("${pageContext.request.contextPath}/private/cha2",{"id":id},function(e) {
                        $('#memberid').val(e.memberId);
                    })
                }
            })
        }
        function kan3() {
            $("#myModal4").modal("show");
            $('#tbb').bootstrapTable({
                url:'${pageContext.request.contextPath}/goods/query2',
                method:'post',
                contentType:"application/x-www-form-urlencoded",
                columns:[{ radio:true
                }, {
                    field: 'goodsId',
                    title: '商品编号'
                },{
                    field: 'goodsName',
                    title: '商品名称'
                }
                ],
                queryParamsType:'',
                queryParams:queryParams,
                height:360,
                pagination:true,
                onDblClickRow: function (row) {
                    $('#myModal4').modal("hide");
                    id = row.goodsId;
                    $.post("${pageContext.request.contextPath}/goods/cha",{"goodsId":id},function(e) {
                        $('#goodsid').val(e.goodsId);
                    })
                }
            })
        }
        //批量删除
        function dels(){
            var opt1 = $("#table").bootstrapTable('getSelections') ;
            var opt = $("#table").bootstrapTable('getOptions');
            var goodsid=$('#goodsid').val();
            var memberid=$('#memberid').val();
            var array = [];
            $(opt1).each(function (i, e) {
                array[i] = e.id;
            });
            swal({
                    title: "确定批量删除商品消费信息吗？",
                    text: "你将无法恢复删除的消费信息！",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#dd6248",
                    confirmButtonText: "确定删除！",
                    cancelButtonText: "取消删除！",
                    closeOnConfirm: false,
                    closeOnCancel: false
                },
                function(isConfirm){
                    if (isConfirm) {
                        swal("删除！", "你的消费信息已经被删除。",
                            "success");
                        $.ajax({
                            url:"${pageContext.request.contextPath}/goodinfo/dellist",
                            type:"post",
                            dataType:"json",
                            traditional: true,//加上这个属性，后台用 String[] arr 就可以接收到了
                            data:{
                                "array":array,
                                "pageSize":opt.pageSize,
                                "pageNumber":opt.pageNumber,
                                "goods.goodsId":$('#goodsid').val(),
                                "member.memberId":$('#memberid').val()
                            },
                            success:function(data){
                                $("#table").bootstrapTable("load",data);
                            }
                        });

                    } else {
                        swal("取消！", "你的消费信息是安全的:)",
                            "error");
                    }
                });
        }
    </script>
</head>
<body background="${pageContext.request.contextPath}/static/HTmoban/images/tongji4.jpg">
    <%--    //查询--%>
    <div class="panel panel-default">
    <div class="panel-body">
        <form class="form-inline">
                <div class="form-group">
                    消费物品编号：<input id="goodsid" type="text"class="form-control" placeholder="请输入商品编号">
                    <a title='查询'  onclick="kan3()" href="#"><span class='glyphicon glyphicon-search'></span></a>
                </div>

                <div class="form-group">
                    会员消费列表：<input id="memberid" type="text"class="form-control" placeholder="请输入会员编号">
                    <a title='查询' onclick="kan2()" href="#"><span class='glyphicon glyphicon-search'></span></a>
                </div>


            <button onclick="search()" type="button" class="btn btn-default"  >查询</button>
             <button type="button" onclick="ss()" class="btn btn-default" style="float: right; margin-right: 20px" data-toggle="modal" data-target="#myModal"><span class="glyphicon glyphicon-plus"></span>添加消费记录</button>
            <button type="button" onclick="dels()" class="btn btn-default" style="float: right; margin-right: 20px"><span class="glyphicon glyphicon-minus"></span>批量删除信息</button>
            <button type="button" id="download" style="margin-left:20px;" id="btn_download" class="btn btn-primary" onClick ="$('#table').tableExport({ type: 'excel', escape: 'false' })">数据导出</button>
        </form>
    </div>

</div>
    <%--//页面数据展示--%>
    <div>
        <table id="table"></table>
    </div>
    <div class="modal fade" id="myModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">增加新消费记录</h4>
                </div>
                <div class="modal-body">
                    <!-- form开始 -->
                    <form><div style="width: 90%;margin: 0px auto">
                        <div class="form-group">
                            <label for="spid" class="control-label"style="margin-top: 10px">商品名称</label>
                            <div>
                                <select style="width: 470px;margin-top: 10px" id="spid"  class="form-control">
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="hyid" class="control-label"style="margin-top: 10px">会员名称</label>
                            <div>
                                <input type="hidden" id="namey">
                                <input type="text"style="width: 470px;margin-top: 10px" class="form-control" readonly id="hyid" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                            <a title='查询' onclick="kan1()" href="#" style="float: right;margin-top: -25px;margin-right: -10px;transform: scale(1.5);width:25px;height:25px;" class='glyphicon glyphicon-search'></a>
                        </div>
                        <div class="form-group">
                            <label for="count" class="control-label"style="margin-top: 10px">数量</label>
                            <div>
                                <input type="text"style="width: 470px;margin-top: 10px" class="form-control" id="count" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <%--<div class="form-group">
                            <label for="price" class="col-sm-4 control-label"style="margin-top: 10px">价钱</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="price" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>--%>
                        <div class="form-group">
                            <label for="remark" class="control-label"style="margin-top: 10px">备注</label>
                            <div>
                                <input type="text"style="width: 470px;margin-top: 10px" class="form-control" id="remark" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        &nbsp;
                    </div>
                    </form>
                    &nbsp;
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button onclick="save()" id = "add" type="button" class="btn btn-primary">提交</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="myModal3">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- form开始 -->
                    <table id="tb"></table>
                    &nbsp;
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="myModal4">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- form开始 -->
                    <table id="tbb"></table>
                    &nbsp;
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
