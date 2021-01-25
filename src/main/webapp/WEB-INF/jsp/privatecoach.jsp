
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
            $("#subject").change(function () {
                var sid = $("#subject").val();
                $.post("${pageContext.request.contextPath}/private/cha",{"id":sid},function(e) {
                    $('#dj').val(e.sellingPrice);
                    var s = 1;
                    $('#sl').val(s);
                    $('#zje').val(e.sellingPrice*s);
                })
            })
            /*$('#sl').change(function () {
            var sl = $('#sl').val();
            var dj = $('#dj').val();
            var s = sl * dj;
            $('#zje').val(s);
        })
            $('#ssq').change(function () {
                var ssq = $('#ssq').val();
                var zje = $('#zje').val();
                var s = ssq-zje;
                $('#zl').val(s);
            })*/
            $('#table').bootstrapTable({
                url:'${pageContext.request.contextPath}/privateinfo/query',
                method:'post',
                contentType:"application/x-www-form-urlencoded",

                columns:[{
                field: 'pid',
                title: '编号'
            },
                    {
                    field: 'member.memberName',
                    title: '会员名称'
                },
              {
                field: 'coach.coachName',
                title: '教练名称'
            },{
                field: 'subject.subname',
                title: '课程名称'
            },
            {
                field: 'count',
                title: '数量',

            },
                    {
                        field:'xx',title:'操作',
                        formatter : function(value, row, index) {
                            return "<a title='删除' href='javascript:del1("
                                + row.pid + ")'><span class='glyphicon glyphicon-trash'></span></a> | <a href='javascript:upd(" + row.pid + ")' class='glyphicon glyphicon-pencil'></a>";

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
                detailView:true,
                onExpandRow:function(index, row, $detail){
                    var aa=$detail.html("<table></table>").find('table');
                    var idd=row.pid;
                    aa.bootstrapTable({
                        url:'${pageContext.request.contextPath}/privateinfo/query2?pid='+idd+'',
                        columns:[{
                                field:'pid',
                                title:'编号',
                             },
                            {
                                field: 'member.memberName',
                                title: '会员名称'
                            },
                            {
                                field: 'count',
                                title: '数量'
                            },{
                                field: 'state',
                                title: '状态',
                                formatter:function (value,row,index) {
                                    if(row.state==1){
                                        return "购买";
                                    }else{
                                        return "赠送";
                                    }
                                }
                            },{
                                field:'countprice',
                                title:'金额',
                            },
                            {
                                field: 'remark',
                                title: '备注',

                            },{
                                field:'date',
                                title:'开始日期',
                            }
                        ]
                    }) ;
                },
            })
        });
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
                      $.post("${pageContext.request.contextPath}/privateinfo/count",{'memid':id},function(e) {
                            $('#cishu').text(e);
                        })
                        $('#kh').val(e.memberId);
                        $('#xm').text(e.memberName);
                        $('#type').text(e.membertypes.typeName);
                        $('#dqdate').text(e.memberxufei);
                        $('#hystatic').text(e.memberStatic);
                        if(e.memberStatic==1){
                            $('#hystatic').text("正常");
                        }else{
                            $('#hystatic').text("请续费");
                        }
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
                        var coachid=$('#coachid').val();
                        var subjectid=$('#subjectid').val();
                        var memberid=$('#memberid').val();
                        $.post('${pageContext.request.contextPath}/privateinfo/del',{'id':id,"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"coachid":coachid,"subjectid":subjectid,"memberid":memberid},function(data){
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
                "coach.coachid":$('#coachid').val(),
                "subject.subjectid":$('#subjectid').val(),
                "member.memberid":$('#memberid').val(),
            };
            return i;
        }
        //查询
        function search(){
            var opt=$('#table').bootstrapTable('getOptions');
            var coachid=$('#coachid').val();
            var subjectid=$('#subjectid').val();
            var memberid=$('#memberid').val();
            $.post("${pageContext.request.contextPath}/privateinfo/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"coachid":coachid,"subjectid":subjectid,"memberid":memberid},function (releset) {
                $("#table").bootstrapTable('load',releset) ;
            })
        }
        //下拉框赋值
        function totian() {
            $("#kh").val("");
            $("#coach").val("");
            $("#subject").val("");
            $("#datett").val("");
            $("#bz").val("");
            $("#sl").val("") ;
            $('#zje').val("") ;
            $('#ssq').val("") ;
            $('#cishu').text("");
            $('#kh').val("");
            $('#xm').text("");
            $('#type').text("");
            $('#dqdate').text("");
            $('#hystatic').text("");
            $.post("${pageContext.request.contextPath}/private/topcoach",{},function (releset) {
                var e=releset;
                var ss ="";
                var ssss="";
                var sss="<option value='-1'>"+"--请选择--"+"</option>";
                $(e.coach).each(function () {
                    /*$('#coach').append('<option value='+this.coachId+' >'+this.coachName+'</option>');*/
                    ss += "<option value='"+this.coachId+"'>"+"❤"+this.coachName+"</option>";
                    ssss=sss+ss;
                    $('#coach').html(ssss);
                })
                var tt ="";
                var tttt="";
                var ttt="<option value='-1'>"+"--请选择--"+"</option>";
                $(e.subject).each(function () {
                    /* $('#subject').append('<option value='+this.subId+' >'+this.subname+'</option>');*/
                    tt += "<option value='"+this.subId+"'>"+"☆☆☆"+this.subname+"</option>";
                    tttt=ttt+tt;
                    $('#subject').html(tttt);
                })
            })
        }
        //添加
        function save(){
            if(!validateAdd()){
                return;
            }
            //接收数据
            var opt=$('#table').bootstrapTable('getOptions');
            var coachid=$('#coachid').val();
            var subjectid=$('#subjectid').val();
            var memberid=$('#memberid').val();
            var hyid=$("#kh").val();
            var jlid = $("#coach").val();
            var kcid = $("#subject").val();
            var admin = "asdf";
            var date= $("#datett").val();
            var state = 1;
            var remark =$("#bz").val() ;
            var count =$('#sl').val() ;
            var countprice =$("#zje").val() ;
            var realprice =$('#ssq').val() ;
            $("#myModal").modal("hide") ;

            $.post('${pageContext.request.contextPath}/coach/cha',{'id':jlid},function(data){
                $("#table").bootstrapTable("load",data) ;
                if(data.coachStatic==0){
                    $.post('${pageContext.request.contextPath}/private/add',{'member.memberId':hyid,'coach.coachId':jlid,'subject.subId':kcid,'count':count,'countprice':countprice,'realprice':realprice,'date':date,'state':state,"remark":remark,'admin':admin},function(data){
                        $("#table").bootstrapTable("load",data) ;
                        $.post("${pageContext.request.contextPath}/privateinfo/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"coachid":coachid,"subjectid":subjectid,"memberid":memberid},function (releset) {
                            $("#table").bootstrapTable('load',releset) ;
                        })
                        $.post('${pageContext.request.contextPath}/goodinfo/chamember',{'memberId':hyid},function(data){
                            var money = data.memberbalance;
                            var qian  = parseInt(money -countprice);
                            $.post('${pageContext.request.contextPath}/goodinfo/updmember',{'memberId':hyid,'memberbalance':qian},function(data){
                            });
                        });
                        swal("添加！", "添加私教课程成功",
                            "success");
                    }) ;
                }else{
                    swal("失败！", "此教练正休假或已离职",
                        "error");
                    $.post("${pageContext.request.contextPath}/privateinfo/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"coachid":coachid,"subjectid":subjectid,"memberid":memberid},function (releset) {
                        $("#table").bootstrapTable('load',releset) ;
                    })
                }

            })
        }

        function validateAdd() {
            $("#kh").parent().find("span").remove();
            $("#coach").parent().find("span").remove();
            $("#datett").parent().find("span").remove();
            $("#subject").parent().find("span").remove();
            $("#sl").parent().find("span").remove();
            $("#ssq").parent().find("span").remove();


            var kh = $("#kh").val().trim();
            if(kh == null || kh == ""){
                $("#kh").parent().append("<span style='color:red'>请选择会员卡号</span>");
                return false;
            }

            var coach = $("#coach").val().trim();
            if(coach==-1){
                $("#coach").parent().append("<span style='color:red'>请选择教练姓名</span>");
                return false;
            }

            var datett = $("#datett").val().trim();
            if(datett == null || datett == ""){
                $("#datett").parent().append("<span style='color:red'>请选择购买日期</span>");
                return false;
            }

            var subject = $("#subject").val().trim();
            if(subject==-1){
                $("#subject").parent().append("<span style='color:red'>请选择项目名称</span>");
                return false;
            }



            var sl = $("#sl").val().trim();
            if(sl == null || sl == ""){
                $("#sl").parent().append("<span style='color:red'>请填写数量</span>");
                return false;
            }

            if(!(/^[1-9]\d*$/.test(sl))){
                $("#sl").parent().append("<span style='color:red'>须为正整数</span>");
                return false;
            }

            var ssq = $("#ssq").val().trim();
            if(ssq == null || ssq == ""){
                $("#ssq").parent().append("<span style='color:red'>请填写实收钱</span>");
                return false;
            }

            if(!(/^[0-9,.]*$/.test(ssq))){
                $("#ssq").parent().append("<span style='color:red'>实收钱只能为正整数或小数</span>");
                return false;
            }


            return true;
        }


        //修改赋值
        function upd(id){
            $("#myModal2").modal("show");
            $('#id').val(id);
            $.post('${pageContext.request.contextPath}/privateinfo/cha',{'id':id},function(data){
               $("#table").bootstrapTable("load",data) ;
                $("#hykh").text(data.member.memberId);
                $("#hyxm").text(data.member.memberName);
                $("#yssj").text(data.coach.coachName);
                $.post("${pageContext.request.contextPath}/private/topcoach",{},function (releset) {
                    var e=releset;
                    var tt ="";
                    var tttt="";
                    var ttt="<option value='-1'>"+"--请选择--"+"</option>";
                    $(e.coach).each(function () {
                        tt += "<option value='"+this.coachId+"'>"+"❤"+this.coachName+"</option>";
                        tttt=ttt+tt;
                        $('#xgcoach').html(tttt);
                    })
                })
            }) ;
        }
        //修改
        function upd1() {
            if(!validateUpd()){
                return;
            }
            var opt=$('#table').bootstrapTable('getOptions');
            var coachid=$('#coachid').val();
            var subjectid=$('#subjectid').val();
            var memberid=$('#memberid').val();
            var id =  $('#id').val();
            var coachname = $("#xgcoach").val();
            $("#myModal2").modal("hide") ;
            $.post('${pageContext.request.contextPath}/privateinfo/upd',{'pid':id,'coach.coachId':coachname},function(data){
                $.post("${pageContext.request.contextPath}/privateinfo/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"coachid":coachid,"subjectid":subjectid,"memberid":memberid},function (releset) {
                    $("#table").bootstrapTable('load',releset) ;
                })
                $("#table").bootstrapTable("load",data) ;
                swal("修改！", "修改成功",
                    "success");
            }) ;
        }

        function validateUpd() {

            $("#xgcoach").parent().find("span").remove();

            var xgcoach = $("#xgcoach").val().trim();
            if(xgcoach==-1){
                $("#xgcoach").parent().append("<span style='color:red'>请选择变更私教</span>");
                return false;
            }

            return true;
        }


        function zql() {
            var jine=$('#zje').val();
            var ssjine=$('#ssq').val();
            var zhao=ssjine-jine;
            $('#zl').val(zhao);
        }

        function slChange() {
            var sl = $('#sl').val();
            var dj = $('#dj').val();
            var s = sl * dj;
            $('#zje').val(s);
        }

    </script>
</head>
<body background="${pageContext.request.contextPath}/static/HTmoban/images/tongji4.jpg">
    <%--    //查询--%>
    <div class="panel panel-default">
    <div class="panel-body">
        <form class="form-inline">
                <div class="form-group">
                    会员编号：<input id="memberid" type="text" class="form-control" placeholder="请输入会员编号">
                    <a title='查询' onclick="kan2()" href="#"><span class='glyphicon glyphicon-search'></span></a>
                  </div>

                教练名称:
                <select id="coachid" class="form-control">
                    <option value="">请选择</option>
                    <c:forEach items="${a.coach}" var="coachq">
                        <option value="${coachq.coachId}">${coachq.coachName}</option>
                    </c:forEach>
                </select>
                课程编号:
                <select id="subjectid" class="form-control">
                    <option value="">请选择</option>
                    <c:forEach items="${a.subject}" var="s">
                        <option value="${s.subId}">${s.subname}</option>
                    </c:forEach>
                </select>
            <button onclick="search()" type="button" class="btn btn-default" >查询</button>
             <button type="button" class="btn btn-default"  style="float: right;" data-toggle="modal" data-target="#myModal" onclick="totian()"><span class="glyphicon glyphicon-plus"></span>添加会员私教课程</button>

        </form>
    </div>

</div>
    <%--//页面数据展示--%>
    <div>
        <table id="table"></table>
    </div>
    <div class="modal fade" id="myModal">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">❤增加新教练信息</h4>
                </div>
                <div class="modal-body">
                    <!-- form开始 -->
                    <form>
                        <label>会员信息</label>
                        <table style="margin-top:10px;border:1px solid #ccc;padding:20px;margin-bottom:20px;">
                            <tr style="margin: 20px; margin-left: 20px;padding: 20px;padding-left: 20px">
                                <td style="width:450px;padding-left: 20px"><label style="float: left;margin-top: 10px">会员卡号：</label><input type="text" id="kh" style="margin-top: 10px;width: 250px" class="form-control" readonly="readonly" >
                                    <a title='查询' onclick="kan1()" href="#" style="float: right;margin-top: -30px;margin-right: 20px" class='glyphicon glyphicon-search'></a>
                                </td>
                                <td style="width:300px"><label style="float: left;margin-top: 10px">会员姓名：</label><span style="display: inline-block;margin-top: 10px" id="xm"></span></td>
                                <td style="width:300px"><label style="float: left;margin-top: 10px">会员类型：</label><span style="display: inline-block;margin-top: 10px" id="type"></span></td>
                            </tr>
                            <tr style="margin-top: 20px; margin-left: 20px;padding: 20px;height: 40px;padding-left: 20px">
                                <td  style="width:450px;padding-left: 20px"><label style="float: left;margin-top: 10px">到期时间：</label><span style="display: inline-block;margin-top: 10px" id="dqdate"></span></td>
                                <td  style="width:300px"><label style="float: left;margin-top: 10px">私教次数：</label><span style="display: inline-block;margin-top: 10px" id="cishu"></span></td>
                                <td  style="width:300px"><label style="float: left;margin-top: 10px">会员状态：</label><span style="display: inline-block;margin-top: 10px" id="hystatic"></span> </td>
                            </tr>
                        </table>
                        <label>购买私教</label>
                        <table style="margin-top:10px;border:1px solid #ccc;padding:20px;margin-bottom:20px;">
                            <tr style="margin: 20px; margin-left: 20px;padding: 20px;">
                                <td style="width:450px;padding-left: 20px"><label style="float: left;margin-top: 10px">教练姓名：</label>
                                    <select style="margin-top: 10px;width: 300px" id="coach" style="margin-top: 10px" class="form-control">

                                     </select>
                                </td>
                                <td style="width:450px"><label style="float: left;margin-top: 10px">购买日期：</label><input type="date" id="datett" style="margin-top: 10px;width: 350px" class="form-control" ></td>
                            </tr>
                            <tr style="margin: 20px; margin-left: 20px;padding: 20px;">
                                <td style="width:400px;padding-left: 20px"><label style="float: left;margin-top: 10px">项目名称：</label>
                                    <select style="margin-top: 10px;width: 300px" id="subject" class="form-control">

                                    </select>
                                </td>
                                <td style="width:500px"><label style="float: left;margin-top: 10px">单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 价：</label><input type="text" id="dj" readonly style="float: left;margin-top: 10px;margin-right:20px;width: 125px" class="form-control" ><label style="float: left;margin-top: 10px">数&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量：</label><input type="text" id="sl" value="1" style="float: left;margin-top: 10px;width: 125px" oninput="slChange()" class="form-control" ></td>
                            </tr>
                            <tr style="margin: 20px; margin-left: 20px;padding: 20px;">
                                <td colspan="2" style="width:900px;padding-left: 20px"><label style="float: left;margin-top: 10px">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 注：</label>
                                    <input type="text" id="bz" style="margin-top: 10px;width: 740px" class="form-control" >
                                </td>
                            </tr>
                            <tr style="margin: 20px; margin-left: 20px;padding: 20px;">
                                <td colspan="2" style="width:900px;padding-left: 20px"><input type="text" style="float:right;margin-top: 10px;margin-right:30px;width: 100px" id="zje" class="form-control" readonly="readonly"><label style="float: right;margin-top: 10px">总金额：</label>

                                </td>
                            </tr>
                            <tr style="margin: 20px; margin-left: 20px;padding: 20px;">
                                <td colspan="2" style="width:900px;padding-left: 20px"><input type="text" style="float:right;margin-top: 10px;margin-right:30px;width: 100px" id="ssq"  oninput="zql()" class="form-control" ><label style="float: right;margin-top: 10px">实收钱：</label>

                                </td>
                            </tr>
                            <tr style="margin: 20px; margin-left: 20px;padding: 20px;margin-bottom: 30px">
                                <td colspan="2" style="width:900px;padding-left: 20px"><input type="text" style="float:right;margin-top: 10px;margin-right:30px;width: 100px" id="zl" class="form-control"  readonly="readonly"><label style="float: right;margin-top: 10px">找零：</label>

                                </td>
                            </tr>
                            <tr style="margin: 20px;padding: 20px;margin-bottom: 30px">

                            </tr>

                        </table>
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

    <div class="modal fade" id="myModal2">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel2">❤变更私教</h4>
                </div>
                <div class="modal-body">
                    <!-- form开始 -->
                    <form>
                        <input type="hidden" id="id" name="id">
                        <table  style="width: 90%;margin: 0px auto">
                               <tr style="width: 100%">
                                   <td style="width: 280px;height: 35px;">会员卡号：<span id="hykh"></span></td>
                                   <td style="width:280px;height: 35px;">会员姓名：<span id="hyxm"></span></td>
                               </tr>
                                <tr style="width: 100%">
                                    <td style="width: 280px;height: 35px;">原始私教：<span id="yssj"></span></td>
                                    <td style="width: 280px;height: 35px;">变更私教：
                                        <select style="width: 140px;float: right;margin-right: 30px" id="xgcoach"  class="form-control">
                                            <option value="-1">--请选择--</option>
                                        </select>
                                    </td>
                                </tr>
                        </table>
                    </form>
                    &nbsp;
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button onclick="upd1()"  type="button" class="btn btn-primary">修改</button>
                    </div>
                </div>
            </div>
        </div></div>
</body>
</html>
