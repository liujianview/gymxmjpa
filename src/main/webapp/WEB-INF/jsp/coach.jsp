
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js">
    window.onunload(alert("jin3"))
</script>
<html>
<head>
    <title>会员卡列表</title>
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
                url:'${pageContext.request.contextPath}/coach/query',
                method:'post',
                contentType:"application/x-www-form-urlencoded",
                columns:[{ checkbox:true
            }, {
                field: 'coachId',
                title: '编号'
            },{
                field: 'coachName',
                title: '教练名称'
            },{
                field: 'coachPhone',
                title: '教练电话'
            },{
                field: 'coachSex',
                title: '性别',
                    formatter:function(value,row,index) {
                    if (value == 0) {
                        return "男";
                    }
                    return "女";
                }
            },{
                field: 'coachAddress',
                title: '家庭住址'
            },
            {
                field: 'coachData',
                title: '工作时间'
            },
            {
                field: 'coachStatic',
                title: '教练状态',
                formatter:function(value,row,index) {
                    if (value == 0) {
                        return "正常";
                    }if(value == 1){
                        return "<p style='color:red'>休假</p>";
                    }
                    return "<p style='color:green'>离职</p>";
                }
            },
            {
                field: 'teach',
                title: '教龄'
            },{
                field: 'coachWages',
                title: '工资'
            },
                    {
                        field:'xx',title:'操作',
                        formatter : function(value, row, index) {
                            return "<a title='删除' href='javascript:del1("
                                + row.coachId + ")'><span class='glyphicon glyphicon-trash'></span></a> | <a href='javascript:upd1("+row.coachId+")' class='glyphicon glyphicon-pencil'></a>";
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
                    if (isConfirm) {var opt=$('#table').bootstrapTable('getOptions');
                        var coachid=$('#coachidid').val();

                        $.post('${pageContext.request.contextPath}/coach/del',{'id':id,"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"cardname":coachid},function(data){
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
                "id":$('#coachidid').val(),
            };
            return i;
        }
        //查询
        function search(){
            var opt=$('#table').bootstrapTable('getOptions');
            var coachid=$('#coachidid').val();

            $.post("${pageContext.request.contextPath}/coach/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"coachname":coachid},function (releset) {
                $("#table").bootstrapTable('load',releset) ;
            })
        }


        function save(){
            if(!validateAdd()){
                return;
            }
            //接收数据
            var opt=$('#table').bootstrapTable('getOptions');
            var coachid=$('#coachidid').val();
            var name=$("#name").val();
            var age = $("#age").val();
            var phone = $("#phone").val();
            var address = $("#address").val();
            var date= $("#date").val();
            var sex = $('input[name="sex"]:checked').val();
            var jl =$("#jl").val() ;
            var xz =$('#xz').val() ;
            $("#myModal").modal("hide") ;
            $.post("${pageContext.request.contextPath}/coach/count",{"coachName":name},function (releset) {
                $("#table").bootstrapTable('load',releset) ;
                if(releset<1){
                    $.post('${pageContext.request.contextPath}/coach/add',{'coachName':name,'coachPhone':phone,'coachSex':sex,'coachAge':age,'coachData':date,"teach":jl,"coachWages":xz,'coachAddress':address},function(data){
                        $("#table").bootstrapTable("load",data) ;
                        $.post("${pageContext.request.contextPath}/coach/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"coachname":coachid},function (releset) {
                            $("#table").bootstrapTable('load',releset) ;
                        })
                        swal("添加！", "添加新教练信息成功",
                            "success");
                    }) ;
                }else if(releset>0){
                    swal("失败！", "已有该教练信息，请重新输入！",
                        "error");
                    $.post("${pageContext.request.contextPath}/coach/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"coachname":coachid},function (releset) {
                        $("#table").bootstrapTable('load',releset) ;
                    })
                }
            })
        }

        function validateAdd() {
            $("#name").parent().find("span").remove();
            $("#phone").parent().find("span").remove();
            $("#age").parent().find("span").remove();
            $("#date").parent().find("span").remove();
            $("#address").parent().find("span").remove();
            $("#jl").parent().find("span").remove();
            $("#xz").parent().find("span").remove();

            var name = $("#name").val().trim();
            if(name == null || name == ""){
                $("#name").parent().append("<span style='color:red'>请填写教练名称</span>");
                return false;
            }


            var age = $("#age").val().trim();
            if(age == null || age == ""){
                $("#age").parent().append("<span style='color:red'>请填写教练年龄</span>");
                return false;
            }

            if(!(/^[1-9]\d*$/.test(age))){
                $("#age").parent().append("<span style='color:red'>年龄只能为正整数</span>");
                return false;
            }

            var phone = $("#phone").val().trim();
            if(phone == null || phone == ""){
                $("#phone").parent().append("<span style='color:red'>请填写教练电话</span>");
                return false;
            }

            if(!(/^1(3|4|5|6|7|8|9)\d{9}$/.test(phone))){
                $("#phone").parent().append("<span style='color:red'>手机号码格式不正确</span>");
                return false;
            }

            var address = $("#address").val().trim();
            if(address == null || address == ""){
                $("#address").parent().append("<span style='color:red'>请填写家庭住址</span>");
                return false;
            }

            var date = $("#date").val().trim();
            if(date == null || date == ""){
                $("#date").parent().append("<span style='color:red'>请选择开始上班时间</span>");
                return false;
            }



            var jl = $("#jl").val().trim();
            if(jl == null || jl == ""){
                $("#jl").parent().append("<span style='color:red'>请填写教龄</span>");
                return false;
            }

            if(!(/^[1-9]\d*$/.test(jl))){
                $("#jl").parent().append("<span style='color:red'>教龄只能为正整数</span>");
                return false;
            }

            var xz = $("#xz").val().trim();
            if(xz == null || xz == ""){
                $("#xz").parent().append("<span style='color:red'>请填写薪资</span>");
                return false;
            }

            if(!(/^[0-9,.]*$/.test(xz))){
                $("#xz").parent().append("<span style='color:red'>薪资只能为只能为正整数或小数</span>");
                return false;
            }
            return true;
        }

        function jl() {
            $("#name").val("");
            $("#age").val("");
            $("#phone").val("");
            $("#address").val("");
            $("#date").val("");
            $("#jl").val("") ;
            $('#xz').val("") ;
        }
       function upd1(id){
            $("#myModal2").modal("show");
            $('#id').val(id);
            $.post('${pageContext.request.contextPath}/coach/cha',{'id':id},function(data){
                $("#table").bootstrapTable("load",data) ;
                $("#xgname").val(data.coachName);
                $("#xgage").val(data.coachAge);
                $("#xgphone").val(data.coachPhone);
                $("#xgaddress").val(data.coachAddress);
                $('#xgdate').val(data.coachData);
                $('#xgstatic').val(data.coachStatic);
                $('#xgjl').val(data.teach);
                $('#xgxz').val(data.coachWages);
                $('#xgsex').val(data.coachSex);
               // $("input[name=xgsex][value="+data.coachSex+"]").attr("checked",true);

            }) ;

        }
        function upd(){
            if(!validateUpd()){
                return;
            }
            var opt=$('#table').bootstrapTable('getOptions');
            var coachid=$('#coachidid').val();
            var id =  $('#id').val();
            var name = $("#xgname").val();
            var age=$("#xgage").val();
            var phone= $("#xgphone").val();
            var address= $("#xgaddress").val();
            var date=$('#xgdate').val();
            var xgstatic= $('#xgstatic').val();
            var sex = $('#xgsex').val();
            var jl= $('#xgjl').val();
            var xz=  $('#xgxz').val();
            $("#myModal2").modal("hide") ;
            $.post('${pageContext.request.contextPath}/coach/upd',{'coachId':id,'coachName':name,'coachPhone':phone,'coachSex':sex,'coachAge':age,'coachData':date,"teach":jl,"coachWages":xz,'coachAddress':address,'coachStatic':xgstatic},function(data){
                $.post("${pageContext.request.contextPath}/coach/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"coachname":coachid},function (releset) {
                    $("#table").bootstrapTable('load',releset) ;
                })
                $("#table").bootstrapTable("load",data) ;
                swal("修改！", "修改成功",
                    "success");
            }) ;
        }

        function validateUpd() {
            $("#xgname").parent().find("span").remove();
            $("#xgphone").parent().find("span").remove();
            $("#xgage").parent().find("span").remove();
            $("#xgdate").parent().find("span").remove();
            $("#xgaddress").parent().find("span").remove();
            $("#xgjl").parent().find("span").remove();
            $("#xgxz").parent().find("span").remove();

            var xgname = $("#xgname").val().trim();
            if(xgname == null || xgname == ""){
                $("#xgname").parent().append("<span style='color:red'>请填写教练名称</span>");
                return false;
            }


            var xgage = $("#xgage").val().trim();
            if(xgage == null || xgage == ""){
                $("#xgage").parent().append("<span style='color:red'>请填写教练年龄</span>");
                return false;
            }

            if(!(/^[1-9]\d*$/.test(xgage))){
                $("#xgage").parent().append("<span style='color:red'>年龄只能为正整数</span>");
                return false;
            }

            var xgphone = $("#xgphone").val().trim();
            if(xgphone == null || xgphone == ""){
                $("#xgphone").parent().append("<span style='color:red'>请填写教练电话</span>");
                return false;
            }

            if(!(/^1(3|4|5|6|7|8|9)\d{9}$/.test(xgphone))){
                $("#xgphone").parent().append("<span style='color:red'>手机号码格式不正确</span>");
                return false;
            }

            var xgaddress = $("#xgaddress").val().trim();
            if(xgaddress == null || xgaddress == ""){
                $("#xgaddress").parent().append("<span style='color:red'>请填写家庭住址</span>");
                return false;
            }

            var xgdate = $("#xgdate").val().trim();
            if(xgdate == null || xgdate == ""){
                $("#xgdate").parent().append("<span style='color:red'>请选择开始上班时间</span>");
                return false;
            }



            var xgjl = $("#xgjl").val().trim();
            if(xgjl == null || xgjl == ""){
                $("#xgjl").parent().append("<span style='color:red'>请填写教龄</span>");
                return false;
            }

            if(!(/^[1-9]\d*$/.test(xgjl))){
                $("#xgjl").parent().append("<span style='color:red'>教龄只能为正整数</span>");
                return false;
            }

            var xgxz = $("#xgxz").val().trim();
            if(xgxz == null || xgxz == ""){
                $("#xgxz").parent().append("<span style='color:red'>请填写薪资</span>");
                return false;
            }

            if(!(/^[0-9,.]*$/.test(xgxz))){
                $("#xgxz").parent().append("<span style='color:red'>薪资只能为正整数或小数</span>");
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
                <label for="coachidid" class="control-label">教练名称:</label>
                <input id="coachidid" type="text" class="form-control">
            </div>
            <button onclick="search()" type="button" class="btn btn-default" style="margin-top: 20px" >查询</button>
             <button type="button" class="btn btn-default" onclick="jl()" style="float: right; margin-top: 20px" data-toggle="modal" data-target="#myModal"><span class="glyphicon glyphicon-plus"></span>添加教练</button>
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
                    <h4 class="modal-title" id="myModalLabel">增加新教练信息</h4>
                </div>
                <div class="modal-body">
                    <!-- form开始 -->
                    <form>
                        <div class="form-group">
                            <label for="name" class="col-sm-4 control-label"style="margin-top: 10px">教练名称</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="name" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="age" class="col-sm-4 control-label"style="margin-top: 10px">教练年龄</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="age" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="phone" class="col-sm-4 control-label"style="margin-top: 10px">教练电话</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="phone" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="address" class="col-sm-4 control-label"style="margin-top: 10px">家庭住址</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="address" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="date" class="col-sm-4 control-label"style="margin-top: 10px">开始上班时间</label>
                            <div class="col-sm-8">
                                <input type="date"style="margin-top: 10px" class="form-control" id="date" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="name" class="col-sm-4 control-label"style="margin-top: 10px">教龄</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="jl" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="name" class="col-sm-4 control-label"style="margin-top: 10px">薪资</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="xz" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 control-label">性别</label>
                            <div class="col-sm-8">
                                <div class="radio radio-transparent">
                                    <input type="radio" name="sex" id="one" value="1" checked>
                                    <label for="one">女</label>
                                </div>
                                <div class="radio radio-transparent">
                                    <input type="radio" name="sex" id="zero" value="0">
                                    <label for="zero">男</label>
                                </div>
                            </div>&nbsp;
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
                    <h4 class="modal-title" id="myModalLabel2">修改教练信息</h4>
                </div>
                <div class="modal-body">
                    <!-- form开始 -->
                    <form>
                        <input type="hidden" id="id" name="id">
                        <div class="form-group">
                            <label for="name" class="col-sm-4 control-label"style="margin-top: 10px">教练名称</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="xgname" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="age" class="col-sm-4 control-label"style="margin-top: 10px">教练年龄</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="xgage" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="phone" class="col-sm-4 control-label"style="margin-top: 10px">教练电话</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="xgphone" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="address" class="col-sm-4 control-label"style="margin-top: 10px">家庭住址</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="xgaddress" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="date" class="col-sm-4 control-label"style="margin-top: 10px">开始上班时间</label>
                            <div class="col-sm-8">
                                <input type="date"style="margin-top: 10px" class="form-control" id="xgdate" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="xgstatic" class="col-sm-4 control-label"style="margin-top: 10px">教练状态</label>
                            <div class="col-sm-8">
                                <select id="xgstatic" style="margin-top: 10px" class="form-control">
                                    <option value="0">正常</option>
                                    <option value="1">休假</option>
                                    <option value="2">离职</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="name" class="col-sm-4 control-label"style="margin-top: 10px">教龄</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="xgjl" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="name" class="col-sm-4 control-label"style="margin-top: 10px">薪资</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="xgxz" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 control-label"style="margin-top: 10px">性别</label>
                            <div class="col-sm-8">
                                <select id="xgsex" style="margin-top: 10px" class="form-control">
                                    <option value="0">男</option>
                                    <option value="1">女</option>
                                </select>
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
        </div>
 </div>
</body>
</html>
