
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js">
    window.onunload(alert("jin9"))
</script>
<html>
<head>
    <title>物品遗失</title>
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
                url:'${pageContext.request.contextPath}/loos/query',
                method:'post',
                contentType:"application/x-www-form-urlencoded",
                columns:[
                    { field:'loosId',title:'遗失物品编号',sortable: true},
                    { field:'loosName',title:'遗失物品名称',sortable: true},
                    { field:'loosAddress',title:'在哪找的',sortable: true},
                    { field:'loosjdate',title:'捡到时间',sortable: true},
                    { field:'scavenger',title:'被谁捡到的',sortable: true},
                    { field:'scavengerPhone',title:'被捡到的人的电话',sortable: true},
                    { field:'loosldate',title:'领走时间',sortable: true},
                    { field:'loosStatus',title:'状态',
                        sortable: true,
                        formatter: function (value, row, index) {
                            if (value == 0) {
                                return "未领回";
                            }
                            return "已领走";
                        }
                    },
                    {
                        field:'xx',title:'操作',
                        formatter : function(value, row, index) {
                            if(row.loosStatus==0){
                                return "<a title='取回' href='javascript:quhui("
                                    + row.loosId + ")'><span class='glyphicon glyphicon-arrow-right'>取回</span></a>";
                            }else{
                                return "<a title='查看' href='javascript:chakan("
                                    + row.loosId + ")'>查看详情</a>";
                            }

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

        //取回
        function quhui(id){
            $("#myModal2").modal("show");
            $('#id').val(id);

        }
        function  chakan(id) {
            $("#myModal3").modal("show");
            $('#id').val(id);
            var opt=$('#table').bootstrapTable('getOptions');
            var loosId=$('#cardid').val();
            $.post('${pageContext.request.contextPath}/loos/cha',{'loosId':id},function(data) {
                $("#table").bootstrapTable("load", data);
                $("#swmc").val(data.loosName);
                $("#srxm").val(data.scavenger);
                $("#srdh").val(data.scavengerPhone);
                $("#swdd").val(data.loosAddress);
                $("#dsxm").val(data.receiveName);
                $("#dsdh").val(data.receivePhone);
                $("#jtime").val(data.loosjdate);
                $("#qtime").val(data.loosldate);

            })
            $.post("${pageContext.request.contextPath}/loos/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"loosName":loosId},function (releset) {
                $("#table").bootstrapTable('load',releset) ;
            })
        }
        function xxiu() {
            if(!validateUpd()){
                return;
            }
            $("#myModal2").modal("hide") ;
            var opt=$('#table').bootstrapTable('getOptions');
            var loosId=$('#cardid').val();
            var id  = $('#id').val();
            var dname=$("#dname").val();
            var dphone = $("#dphone").val();
            var nahui = $("#nahui").val();
            var state =1;
            $.post('${pageContext.request.contextPath}/loos/quhui',{'loosId':id,"loosStatus":state,"receiveName":dname,'receivePhone':dphone,'loosldate':nahui},function(data){

                $("#table").bootstrapTable("load",data) ;
                $.post("${pageContext.request.contextPath}/loos/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"loosName":loosId},function (releset) {
                    $("#table").bootstrapTable('load',releset) ;
                })
                swal("修改！", "取回成功",
                    "success");
            }) ;
        }
        function validateUpd() {
            $("#dname").parent().find("span").remove();
            $("#dphone").parent().find("span").remove();
            $("#nahui").parent().find("span").remove();

            var dname = $("#dname").val().trim();
            if(dname == null || dname == ""){
                $("#dname").parent().append("<span style='color:red'>请填写丢失人姓名</span>");
                return false;
            }


            var dphone = $("#dphone").val().trim();
            if(dphone == null || dphone == ""){
                $("#dphone").parent().append("<span style='color:red'>请填写丢失人电话</span>");
                return false;
            }

            if(!(/^1(3|4|5|6|7|8|9)\d{9}$/.test(dphone))){
                $("#dphone").parent().append("<span style='color:red'>手机号码格式不正确</span>");
                return false;
            }

            var nahui = $("#nahui").val().trim();
            if(nahui == null || nahui == ""){
                $("#nahui").parent().append("<span style='color:red'>请填写拿回物品日期</span>");
                return false;
            }
            return true;
        }


        //获取当前的条件个页面页数即使更新值
        function queryParams(afds){
            var i={
                "pageSize":afds.pageSize,
                "pageNumber":afds.pageNumber,
                "id":$('#cardid').val(),
            };
            return i;
        }
        //查询
        function search(){
            var opt=$('#table').bootstrapTable('getOptions');
            var loosId=$('#cardid').val();

            $.post("${pageContext.request.contextPath}/loos/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"loosName":loosId},function (releset) {
                $("#table").bootstrapTable('load',releset) ;
            })
        }

        function save(){
            if(!validateAdd()){
                return;
            }
            //接收数据
            var opt=$('#table').bootstrapTable('getOptions');
            var loosId=$('#cardid').val();
            var name=$("#name").val();
            var time = $("#time").val();
            var address = $("#address").val();
            var jname = $("#jname").val();
            var jphone = $("#jphone").val();
            var state  = 0;
            var admin  ="admin";
            var img = "1";
            $("#myModal").modal("hide") ;
            $.post('${pageContext.request.contextPath}/loos/add',{'loosName':name,"loosImages":img,'loosAddress':address,'loosjdate':time,"loosStatus":state,'scavenger':jname,'scavengerPhone':jphone,"admin":admin},function(data){

                $("#table").bootstrapTable("load",data) ;
                $.post("${pageContext.request.contextPath}/loos/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"loosId":loosId},function (releset) {
                    $("#table").bootstrapTable('load',releset) ;
                })
                swal("添加！", "添加成功",
                    "success");
            }) ;
        }

        function validateAdd() {
            $("#name").parent().find("span").remove();
            $("#time").parent().find("span").remove();
            $("#address").parent().find("span").remove();
            $("#jname").parent().find("span").remove();
            $("#jphone").parent().find("span").remove();

            var name = $("#name").val().trim();
            if(name == null || name == ""){
                $("#name").parent().append("<span style='color:red'>请填写遗失物名称</span>");
                return false;
            }

            var time = $("#time").val().trim();
            if(time == null || time == ""){
                $("#time").parent().append("<span style='color:red'>请选择拾物时间</span>");
                return false;
            }

            var address = $("#address").val().trim();
            if(address == null || address == ""){
                $("#address").parent().append("<span style='color:red'>请填写拾物地点</span>");
                return false;
            }

            var jname = $("#jname").val().trim();
            if(jname == null || jname == ""){
                $("#jname").parent().append("<span style='color:red'>请填写拾物人姓名</span>");
                return false;
            }

            var jphone = $("#jphone").val().trim();
            if(jphone == null || jphone == ""){
                $("#jphone").parent().append("<span style='color:red'>请填写拾物人电话</span>");
                return false;
            }

            if(!(/^1(3|4|5|6|7|8|9)\d{9}$/.test(jphone))){
                $("#jphone").parent().append("<span style='color:red'>手机号码格式不正确</span>");
                return false;
            }
            return true;
        }



        function loos() {
            $("#name").val("");
            $("#time").val("");
            $("#address").val("");
            $("#jname").val("");
            $("#jphone").val("");
        }


    </script>
</head>
<body background="${pageContext.request.contextPath}/static/HTmoban/images/tongji4.jpg">
    <%--    //查询--%>
    <div class="panel panel-default">
    <div class="panel-body">
        <form class="form-inline">
            <div  class="input-group input-daterange">
                <label for="cardid" class="control-label">拾取物名称:</label>
                <input id="cardid" type="text" class="form-control">
            </div>
            <button onclick="search()" type="button" class="btn btn-default" style="margin-top: 20px" >查询</button>
             <button type="button" class="btn btn-default" onclick="loos()" style="float: right; margin-top: 20px" data-toggle="modal" data-target="#myModal"><span class="glyphicon glyphicon-plus"></span>添加拾取物详情</button>
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
                    <h4 class="modal-title" id="myModalLabel">添加拾取物</h4>
                </div>
                <div class="modal-body">
                    <!-- form开始 -->
                    <form>
                        <div class="form-group">
                            <label for="name" class="col-sm-4 control-label"style="margin-top: 10px">遗失物名称</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="name" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="time" class="col-sm-4 control-label"style="margin-top: 10px">拾物时间</label>
                            <div class="col-sm-8">
                                <input type="date"style="margin-top: 10px" class="form-control" id="time" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="address" class="col-sm-4 control-label"style="margin-top: 10px">拾物地点</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="address" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="jname" class="col-sm-4 control-label"style="margin-top: 10px">拾物人姓名</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="jname" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="jphone" class="col-sm-4 control-label"style="margin-top: 10px">拾物人电话</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="jphone" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
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
    <div class="modal fade" id="myModal3">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel3">查看详情</h4>
                </div>
                <div class="modal-body">
                    <!-- form开始 -->
                    <table id="sw"  style="width: 90%;margin: 0px auto">
                        <tr style="width: 100%;height: 80px">
                            <td style="width: 300px;height: 35px;">拾取物名称：<input style="width: 140px;"  class="form-control" type="text" id="swmc" readonly></td>
                            <td style="width:300px;height: 35px;">拾取人姓名：<input style="width: 140px;" class="form-control" type="text"  id="srxm" readonly></td>
                            <td style="width:300px;height: 35px;">拾取人电话：<input style="width: 140px;"  class="form-control" type="text"  id="srdh" readonly></td>
                            <td style="width:300px;height: 35px;">捡到时间：<input style="width: 140px;"  class="form-control" type="text"  id="jtime" readonly></td>
                        </tr>
                        <tr style="width: 100%;height: 80px">
                            <td style="width: 300px;height: 35px;">拾取物地点：<input style="width: 140px;"  class="form-control" type="text" id="swdd" readonly></td>
                            <td style="width: 300px;height: 35px;">领走人姓名：<input style="width: 140px;"  class="form-control" type="text" id="dsxm" readonly></td>
                            <td style="width: 300px;height: 35px;">领走人电话：<input style="width: 140px;"  class="form-control" type="text" id="dsdh" readonly></td>
                            <td style="width:300px;height: 35px;">领取时间：<input style="width: 140px;"  class="form-control" type="text"  id="qtime" readonly></td>
                        </tr>
                    </table>
                    &nbsp;
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
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
                    <h4 class="modal-title" id="myModalLabel2">取回遗失物品</h4>
                </div>
                <div class="modal-body">
                    <!-- form开始 -->
                    <form>
                        <input type="hidden" id="id" name="id">
                        <div class="form-group">
                            <label for="dname" class="col-sm-4 control-label"style="margin-top: 10px">丢失人姓名：</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="dname" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="dphone" class="col-sm-4 control-label"style="margin-top: 10px">丢失人电话：</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="dphone" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="nahui" class="col-sm-4 control-label"style="margin-top: 10px">拿回物品日期：</label>
                            <div class="col-sm-8">
                                <input type="date"style="margin-top: 10px" class="form-control" id="nahui" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                    </form>
                    &nbsp;
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button onclick="xxiu()"  type="button" class="btn btn-primary">修改</button>
                    </div>
                </div>
            </div>
        </div></div>
</body>
</html>
