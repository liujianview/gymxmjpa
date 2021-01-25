
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js">
    window.onunload(alert("jin"))
</script>
<html>
<head>
    <title>会员列表</title>
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
        $(function () {
            $.post("${pageContext.request.contextPath}/ktype/query",{},function (releset) {
                var e=releset;
                $(e).each(function () {
                    $('#ktype').append('<option value='+this.typeId+' >'+this.typeName+'</option>');
                })
            });
            $('#srdata').datetimepicker({
                //viewMode: 'day',
                format: 'MM-DD'
            });
            $('#upsrdata').datetimepicker({
                //viewMode: 'day',
                format: 'MM-DD'
            });
            $('#dg').bootstrapTable({
                url:'${pageContext.request.contextPath}/menber/query',
                method:'post',
                contentType:"application/x-www-form-urlencoded",
                columns:[
                    { field:'memberId',title:'会员编号',sortable: true},
                    { field:'memberName',title:'名称',sortable: true},
                    { field:'memberPhone',title:'电话',sortable: true},
                    { field:'memberSex',title:'性别',
                        formatter:function (value,row,index) {
                            if(row.memberSex==0){
                                return "女";
                            }else{
                                return "男";
                            }
                        }
                    },
                    { field:'memberAge',title:'年龄',sortable: true},
                    { field:'birthday',title:'生日',sortable: true},
                    { field:'membertypes.typeName',title:'卡类型'},
                    { field:'nenberDate',title:'录入日期'},
                    { field:'xxx',title:'会员状态',
                        formatter:function (value,row,index) {
                            if(row.memberStatic==1){
                                return "正常"
                            }else{
                                return "<p style='color:red'>请续卡</p>"
                            }
                        }
                    },
                    { field:'xxx',title:'会员余额',
                        formatter:function (value,row,index) {
                            if(row.memberbalance==0){
                                return "<p style='color:red'>请缴费</p>"
                            }else if(row.memberbalance<10){
                                return "<p style='color:red'>余额不足10元</p>";
                            }else{
                                return row.memberbalance;
                            }
                        }
                    },
                    { field:'memberxufei',title:'到期日期'},
                    {
                        field:'xx',title:'操作',
                        formatter : function(value, row, index) {
                            return "<a title='删除' href='javascript:del("
                                + row.memberId + ")'><span class='glyphicon glyphicon-trash'></span></a> | <a> <span class='glyphicon glyphicon-pencil'></span></a>";
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
                onDblClickRow:function(row,$element,field) {
                    $('#updateeModal').modal('show');
                    $.post("${pageContext.request.contextPath}/ktype/query",{},function (releset) {
                        var e=releset;
                        var tt ="";
                        var tttt="";
                        var ttt="<option value='-1'>"+"--请选择--"+"</option>";
                        $(e).each(function () {
                            tt += "<option value='"+this.typeId+"'>"+""+this.typeName+"</option>";
                            tttt=ttt+tt;
                            $('#upoptype').html(tttt);
                        })
                    }),//手下菠萝已足够
                    $('#upname').val(row.memberName);
                    $('#upphone').val(row.memberPhone);
                    $('#upsex').val(row.memberSex);
                    $('#upsrdata').val(row.birthday);
                    $('#upoptype').val(row.membertypes.typeId);
                    $('#updata').val(row.nenberDate);
                    $('#upage').val(row.memberAge);
                    $('#upid').val(row.memberId);

                    }
            })
        });

        //获取当前的条件个页面页数即使更新值
        function queryParams(afds){
            var i={
                "pageSize":afds.pageSize,
                "pageNumber":afds.pageNumber,
                "id":$('#hyid').val(),
                "ktype":$('#ktype').val()

            };
            return i;
        }
        //查询
        function search(){
            var opt=$('#dg').bootstrapTable('getOptions');
            var hyid=$('#hyid').val();
            var ktype=$('#ktype').val();


            $.post("${pageContext.request.contextPath}/menber/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"hyname":hyid,"ktype":ktype},function (releset) {
                $("#dg").bootstrapTable('load',releset) ;
            })
        }
        function insert() {
            $('#exampleModal').modal('show');
            $.post("${pageContext.request.contextPath}/ktype/query",{},function (releset) {
                var e=releset;
                var tt ="";
                var tttt="";
                var ttt="<option value='-1'>"+"--请选择--"+"</option>";
                $(e).each(function () {
                    tt += "<option value='"+this.typeId+"'>"+""+this.typeName+"</option>";
                    tttt=ttt+tt;
                    $('#optype').html(tttt);
                })


            })
            var mydate = new Date();
            var str = "" + mydate.getFullYear() + "-";
            str += (mydate.getMonth()+1) + "-";
            str += mydate.getDate();

            $('#data').val(str)
        }
        function del(memid) {
            $.post("${pageContext.request.contextPath}/menber/delete",{"memid":memid},function (releset) {
                if(releset != null){
                    $("#dg").bootstrapTable('load',releset) ;
                    swal(
                        {
                            title:"删除成功",
                            type:"success",
                            timer: 1500,
                            showConfirmButton: false
                        }
                    )
                }else{
                    swal(
                        {
                            title:"删除失败",
                            type:"warning",
                            timer: 1500,
                            showConfirmButton: false
                        }
                    )
                }
            })
        }
        function tianjia() {
            if(!validateAdd()){
                return;
            }
            var name=$('#name').val();
            var phone =$('#phone').val();
            var sex=$('#sex').val();
            var srdata=$('#srdata').val();
            var optype=$('#optype').val();
            var data=$('#data').val();
            var age=$('#age').val();


            $.post("${pageContext.request.contextPath}/ktype/query2",{"xztype":optype},function (releset) {
                var typetian=releset.typeDay;

                var date1 = new Date();
                var date2 = new Date(date1);
                var qb=date2.setDate(date1.getDate() + typetian);
                var rq=date2.getFullYear() + "-" + (date2.getMonth() + 1) + "-" + date2.getDate();
                $.post("${pageContext.request.contextPath}/menber/insert",{"memberName":name,"memberPhone":phone,"memberSex":sex,"birthday":srdata,"Membertypes.typeId":optype,"nenberDate":data,"memberAge":age,"Memberxufei":rq},function (releset) {
                    if(releset != null){
                        $("#dg").bootstrapTable('load',releset) ;
                        $('#exampleModal').modal('hide');
                        swal(
                            {
                                title:"添加成功",
                                type:"success",
                                timer: 1500,
                                showConfirmButton: false
                            }
                        )
                    }else{
                        swal(
                            {
                                title:"添加失败",
                                type:"warning",
                                timer: 1500,
                                showConfirmButton: false
                            }
                        )
                    }
                })
            })
        }

        function validateAdd() {
            $("#name").parent().find("span").remove();
            $("#phone").parent().find("span").remove();
            $("#age").parent().find("span").remove();
            $("#srdata").parent().find("span").remove();
            $("#optype").parent().find("span").remove();

            var name = $("#name").val().trim();
            if(name == null || name == ""){
                $("#name").parent().append("<span style='color:red'>请填写姓名</span>");
                return false;
            }

            var phone = $("#phone").val().trim();
            if(phone == null || phone == ""){
                $("#phone").parent().append("<span style='color:red'>请填写手机号</span>");
                return false;
            }

            if(!(/^1(3|4|5|6|7|8|9)\d{9}$/.test(phone))){
                $("#phone").parent().append("<span style='color:red'>手机号码格式不正确</span>");
                return false;
            }

            var age = $("#age").val().trim();
            if(age == null || age == ""){
                $("#age").parent().append("<span style='color:red'>请填写年龄</span>");
                return false;
            }

            if(!(/^[1-9]\d*$/.test(age))){
                $("#age").parent().append("<span style='color:red'>年龄只能为正整数</span>");
                return false;
            }


            var srdata = $("#srdata").val().trim();
            if(srdata == null || srdata == ""){
                $("#srdata").parent().append("<span style='color:red'>请选择生日</span>");
                return false;
            }

            var optype = $("#optype").val().trim();
            if(optype==-1){
                $("#optype").parent().append("<span style='color:red'>请选择会员卡型</span>");
                return false;
            }
            return true;
        }


        function upd() {
            if(!validateUpd()){
                return;
            }
            var id=$('#upid').val();
            var name=$('#upname').val();
            var phone =$('#upphone').val();
            var sex=$('#upsex').val();
            var srdata=$('#upsrdata').val();
            var optype=$('#upoptype').val();
            var data=$('#updata').val();
            var age=$('#upage').val();
            $.post("${pageContext.request.contextPath}/ktype/query2",{"xztype":optype},function (releset) {
                var typetian=releset.typeDay;

                var date1 = new Date();
                var date2 = new Date(date1);
                var qb=date2.setDate(date1.getDate() + typetian);
                var rq=date2.getFullYear() + "-" + (date2.getMonth() + 1) + "-" + date2.getDate();
                $.post("${pageContext.request.contextPath}/menber/update",{"memberId":id,"memberName":name,"memberPhone":phone,"memberSex":sex,"birthday":srdata,"membertypes.typeId":optype,"nenberDate":data,"memberAge":age,"Memberxufei":rq},function (releset) {
                            $("#dg").bootstrapTable('load',releset) ;
                            if(releset != null){
                                $("#dg").bootstrapTable('load',releset) ;
                                $('#updateeModal').modal('hide');
                                swal(
                                    {
                                        title:"修改成功",
                                        type:"success",
                                        timer: 1500,
                                        showConfirmButton: false
                                    }
                                )
                    }else{
                        swal(
                            {
                                title:"修改失败",
                                type:"warning",
                                timer: 1500,
                                showConfirmButton: false
                            }
                        )
                    }
                })
            })
        }

        function validateUpd() {
            $("#upname").parent().find("span").remove();
            $("#upphone").parent().find("span").remove();
            $("#upage").parent().find("span").remove();
            $("#upsrdata").parent().find("span").remove();
            $("#upoptype").parent().find("span").remove();

            var upname = $("#upname").val().trim();
            if(upname == null || upname == ""){
                $("#upname").parent().append("<span style='color:red'>请填写姓名</span>");
                return false;
            }

            var upphone = $("#upphone").val().trim();
            if(upphone == null || upphone == ""){
                $("#upphone").parent().append("<span style='color:red'>请填写手机号</span>");
                return false;
            }

            if(!(/^1(3|4|5|6|7|8|9)\d{9}$/.test(upphone))){
                $("#upphone").parent().append("<span style='color:red'>手机号码格式不正确</span>");
                return false;
            }

            var upage = $("#upage").val().trim();
            if(upage == null || upage == ""){
                $("#upage").parent().append("<span style='color:red'>请填写年龄</span>");
                return false;
            }

            if(!(/^[1-9]\d*$/.test(upage))){
                $("#upage").parent().append("<span style='color:red'>年龄只能为正整数</span>");
                return false;
            }


            var upsrdata = $("#upsrdata").val().trim();
            if(upsrdata == null || upsrdata == ""){
                $("#upsrdata").parent().append("<span style='color:red'>请选择生日</span>");
                return false;
            }

            var upoptype = $("#upoptype").val().trim();
            if(upoptype==-1){
                $("#upoptype").parent().append("<span style='color:red'>请选择会员卡型</span>");
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
                <label for="hyid" class="control-label">姓名:</label>
                <input id="hyid" type="text" class="form-control">
            </div>
            <div  class="input-group input-daterange">
                <label for="ktype" class="control-label">卡型:</label>
                <select class="form-control" id="ktype">
                    <option value="0">请选择</option>
                </select>
            </div>

            <button onclick="search()" type="button" class="btn btn-default" style="margin-top: 20px" >查询</button>
             <button type="button" class="btn btn-default" style="float: right; margin-top: 20px" data-toggle="modal" onclick="insert()"><span class="glyphicon glyphicon-plus"></span>添加会员</button>
            <button type="button" id="download" style="margin-left:20px;" id="btn_download" class="btn btn-primary" onClick ="$('#dg').tableExport({ type: 'excel', escape: 'false' })">数据导出</button>
        </form>
    </div>

</div>
    <%--//页面数据展示--%>
    <div>
        <table id="dg"></table>
    </div>
<%--添加--%>
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="exampleModalLabel">会员添加</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="name" class="control-label">姓名:</label>
                            <input type="text" class="form-control" id="name">
                        </div>
                        <div class="form-group">
                            <label for="phone" class="control-label">电话:</label>
                            <input type="text" class="form-control" id="phone">
                        </div>
                        <div class="form-group">
                            <label for="sex" class="control-label">性别:</label>
                            <select class="form-control" id="sex">
                                <option value="1">男</option>
                                <option value="0">女</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="age" class="control-label">年龄:</label>
                            <input type="text" class="form-control" id="age">
                        </div>
                        <div class="form-group">
                            <label for="srdata" class="control-label">生日:</label>
                            <input type="text" class="form-control" id="srdata">
                        </div>
                        <div class="form-group">
                            <label for="optype" class="control-label">卡型:</label>
                            <select class="form-control" id="optype">

                            </select>
                        </div>
                        <div class="form-group">
                            <label for="data" class="control-label">时间:</label>
                            <input type="text" class="form-control" id="data" disabled="disabled">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="tianjia()">添加</button>
                </div>
            </div>
        </div>
    </div>

<%--修改--%>
    <div class="modal fade" id="updateeModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="updateModalLabel">会员修改</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <input type="hidden" id="upid">
                        <div class="form-group">
                            <label for="name" class="control-label">姓名:</label>
                            <input type="text" class="form-control" id="upname">
                        </div>
                        <div class="form-group">
                            <label for="phone" class="control-label">电话:</label>
                            <input type="text" class="form-control" id="upphone">
                        </div>
                        <div class="form-group">
                            <label for="sex" class="control-label">性别:</label>
                            <select class="form-control" id="upsex">
                                <option value="1">男</option>
                                <option value="0">女</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="age" class="control-label">年龄:</label>
                            <input type="text" class="form-control" id="upage">
                        </div>
                        <div class="form-group">
                            <label for="srdata" class="control-label">生日:</label>
                            <input type="text" class="form-control" id="upsrdata">
                        </div>
                        <div class="form-group">
                            <label for="optype" class="control-label">卡型:</label>
                            <select class="form-control" id="upoptype">

                            </select>
                        </div>
                        <div class="form-group">
                            <label for="data" class="control-label">时间:</label>
                            <input type="text" class="form-control" id="updata" disabled="disabled">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="upd()">修改</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
