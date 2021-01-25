
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js">
    window.onunload(alert("jin5"))
</script>
<html>
<head>
    <title>会员卡类型列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/table/bootstrap-table.min.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/table/bootstrap-table.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/table/locale/bootstrap-table-zh-CN.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/sweetalert/sweetalert.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/sweetalert/sweetalert.min.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/date/bootstrap-datetimepicker.min.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/date/Moment.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/date/bootstrap-datetimepicker.min.js"></script>

    <script>
        $(function () {
            $('#table').bootstrapTable({
                url:'${pageContext.request.contextPath}/ktype/queryq',
                method:'post',
                contentType:"application/x-www-form-urlencoded",
                columns:[
                    { field:'typeId',title:'会员卡编号',sortable: true},
                    { field:'typeName',title:'会员卡名称',sortable: true},
                    { field:'typeDay',title:'有效天数',sortable: true},
                    { field:'typeciShu',title:'有效次数',sortable: true},
                    { field:'typemoney',title:'售价',sortable: true},
                    {
                        field:'xx',title:'操作',
                        formatter : function(value, row, index) {
                            return " <a href='javascript:upd1("+row.typeId+")' class='glyphicon glyphicon-pencil'></a>";
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
                        var typeId=$('#cardid').val();
                        $.post('${pageContext.request.contextPath}/metype/del',{'typeId':id,"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"typeName":typeId},function(data){
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
                "typeId":$('#cardid').val(),
            };
            return i;
        }
        //查询
        function search(){
            var opt=$('#table').bootstrapTable('getOptions');
            var typeId=$('#cardid').val();

            $.post("${pageContext.request.contextPath}/ktype/queryq",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"typeName":typeId},function (releset) {
                $("#table").bootstrapTable('load',releset) ;
            })
        }

   function save(){
       if(!validateAdd()){
           return;
       }
            //接收数据
            var opt=$('#table').bootstrapTable('getOptions');
            var typeId=$('#cardid').val();
            var name=$("#name").val();
            var tianshu = $("#tianshu").val();
            var cishu = $("#cishu").val();
            var money = $("#money").val();
            $("#myModal").modal("hide") ;
            $.post('${pageContext.request.contextPath}/metype/add',{'typeName':name,'typeciShu':cishu,'typeDay':tianshu,'typemoney':money},function(data){

                $("#table").bootstrapTable("load",data) ;
                $.post("${pageContext.request.contextPath}/ktype/queryq",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"typeName":typeId},function (releset) {
                    $("#table").bootstrapTable('load',releset) ;
                })
                swal("添加！", "添加成功",
                    "success");
            }) ;
        }


        function validateAdd() {
            $("#name").parent().find("span").remove();
            $("#tianshu").parent().find("span").remove();
            $("#cishu").parent().find("span").remove();
            $("#money").parent().find("span").remove();

            var name = $("#name").val().trim();
            if(name == null || name == ""){
                $("#name").parent().append("<span style='color:red'>请填写会员卡名称</span>");
                return false;
            }

            var tianshu = $("#tianshu").val().trim();
            if(tianshu == null || tianshu == ""){
                $("#tianshu").parent().append("<span style='color:red'>请填写有效天数</span>");
                return false;
            }

            if(!(/^[1-9]\d*$/.test(tianshu))){
                $("#tianshu").parent().append("<span style='color:red'>有效天数只能为正整数</span>");
                return false;
            }

            var cishu = $("#cishu").val().trim();
            if(cishu == null || cishu == ""){
                $("#cishu").parent().append("<span style='color:red'>请填写有效次数</span>");
                return false;
            }

            if(!(/^(0|\+?[1-9][0-9]*)$/.test(cishu))){
                $("#cishu").parent().append("<span style='color:red'>有效次数只能为0或者正整数</span>");
                return false;
            }

            var money = $("#money").val().trim();
            if(money == null || money == ""){
                $("#money").parent().append("<span style='color:red'>请填写费用</span>");
                return false;
            }

            if(!(/^[1-9]\d*$/.test(money))){
                $("#money").parent().append("<span style='color:red'>费用只能为正整数</span>");
                return false;
            }

            return true;
        }

       function upd1(id){
            $("#myModal2").modal("show");
           $('#id').val(id);
            $.post('${pageContext.request.contextPath}/metype/cha',{'typeId':id},function(data){
                $("#table").bootstrapTable("load",data) ;
                $("#xgname").val(data.typeName);
                $("#xgtianshu").val(data.typeDay);
                $("#xgcishu").val(data.typeciShu);
                $("#xgmoney").val(data.typemoney);
            }) ;

        }
        function upd(){
            if(!validateUpd()){
                return;
            }
            var opt=$('#table').bootstrapTable('getOptions');
            var typeId=$('#cardid').val();
            var id =  $('#id').val();
            var name = $("#xgname").val();
            var tianshu=$("#xgtianshu").val();
            var cishu= $("#xgcishu").val();
            var money= $("#xgmoney").val();
            $("#myModal2").modal("hide") ;
            $.post('${pageContext.request.contextPath}/metype/upd',{'typeId':id,'typeName':name,'typeciShu':cishu,'typeDay':tianshu,'typemoney':money},function(data){
                $.post("${pageContext.request.contextPath}/ktype/queryq",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"typeName":typeId},function (releset) {
                    $("#table").bootstrapTable('load',releset) ;
                })
                $("#table").bootstrapTable("load",data) ;
                swal("修改！", "修改成功",
                    "success");
            }) ;
        }

        function validateUpd() {
            $("#xgname").parent().find("span").remove();
            $("#xgtianshu").parent().find("span").remove();
            $("#xgcishu").parent().find("span").remove();
            $("#xgmoney").parent().find("span").remove();

            var xgname = $("#xgname").val().trim();
            if(xgname == null || xgname == ""){
                $("#xgname").parent().append("<span style='color:red'>请填写会员卡名称</span>");
                return false;
            }

            var xgtianshu = $("#xgtianshu").val().trim();
            if(xgtianshu == null || xgtianshu == ""){
                $("#xgtianshu").parent().append("<span style='color:red'>请填写有效天数</span>");
                return false;
            }

            if(!(/^[1-9]\d*$/.test(xgtianshu))){
                $("#xgtianshu").parent().append("<span style='color:red'>有效天数只能为正整数</span>");
                return false;
            }

            var xgcishu = $("#xgcishu").val().trim();
            if(xgcishu == null || xgcishu == ""){
                $("#xgcishu").parent().append("<span style='color:red'>请填写有效次数</span>");
                return false;
            }

            if(!(/^(0|\+?[1-9][0-9]*)$/.test(xgcishu))){
                $("#xgcishu").parent().append("<span style='color:red'>有效次数只能为0或者正整数</span>");
                return false;
            }

            var xgmoney = $("#xgmoney").val().trim();
            if(xgmoney == null || xgmoney == ""){
                $("#xgmoney").parent().append("<span style='color:red'>请填写费用</span>");
                return false;
            }

            if(!(/^[1-9]\d*$/.test(xgmoney))){
                $("#xgmoney").parent().append("<span style='color:red'>费用只能为正整数</span>");
                return false;
            }
            return true;
        }


    </script>
</head>
<body background="${pageContext.request.contextPath}/static/HTmoban/images/tongji4.jpg">
    <%--    //查询--%>
    <div class="panel panel-default">
    <div class="panel-body">
        <form class="form-inline">
            <div  class="input-group input-daterange">
                <label for="cardid" class="control-label">会员卡名称:</label>
                <input id="cardid" type="text" class="form-control">
            </div>
            <button onclick="search()" type="button" class="btn btn-default" style="margin-top: 20px" >查询</button>
             <button type="button" class="btn btn-default" style="float: right; margin-top: 20px" data-toggle="modal" data-target="#myModal"><span class="glyphicon glyphicon-plus"></span>添加会员卡</button>
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
                    <h4 class="modal-title" id="myModalLabel">增加新会员卡</h4>
                </div>
                <div class="modal-body">
                    <!-- form开始 -->
                    <form>
                        <div class="form-group">
                            <label for="name" class="col-sm-4 control-label"style="margin-top: 10px">会员卡名称</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="name" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="tianshu" class="col-sm-4 control-label"style="margin-top: 10px">有效天数</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="tianshu" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="cishu" class="col-sm-4 control-label"style="margin-top: 10px">有效次数</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="cishu" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="money" class="col-sm-4 control-label"style="margin-top: 10px">费用</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="money" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
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
    <div class="modal fade" id="myModal2">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel2">修改会员卡信息</h4>
                </div>
                <div class="modal-body">
                    <!-- form开始 -->
                    <form>
                        <input type="hidden" id="id" name="id">
                        <div class="form-group">
                            <label for="xgname" class="col-sm-4 control-label"style="margin-top: 10px">会员卡名称</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="xgname" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="xgtianshu" class="col-sm-4 control-label"style="margin-top: 10px">有效天数</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="xgtianshu" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="xgcishu" class="col-sm-4 control-label"style="margin-top: 10px">有效次数</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="xgcishu" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="xgmoney" class="col-sm-4 control-label"style="margin-top: 10px">费用</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="xgmoney" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                    </form>
                    &nbsp;
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button onclick="upd()"  type="button" class="btn btn-primary">修改</button>
                    </div>
                </div>
            </div>
        </div></div>
</body>
</html>
