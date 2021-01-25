
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js">
    window.onunload(alert("yemian"))
</script>
<html>
<head>
    <title>器材管理</title>
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
    <script type="text/javascript">

        $(function () {
            $('#table').bootstrapTable({
                url:'${pageContext.request.contextPath}/qc/query',
                columns:[
                    {
                        field:'eqId',
                        title:'编号'
                    }, {
                        field:'eqName',
                        title:'器材名称'
                    },{
                        field:'eqText',
                        title:'器材说明'
                    },
                    {
                        field:'xx',title:'操作',
                        formatter : function(value, row, index) {
                            return "<a title='删除' href='javascript:del("
                                + row.eqId + ")'><span class='glyphicon glyphicon-trash'></span></a>";
                        }

                    }
                ],
                method:'post',
                contentType:"application/x-www-form-urlencoded",
                queryParamsType:'',
                queryParams:queryParams,
                height:360,
                pageList:[5,10,15],
                pageNumber:1,
                pageSize:5,
                pagination:true,
                sidePagination:'server',

            });
        })





        //获取当前的条件个页面页数即使更新值
        function queryParams(afds){
            var i={
                "pageSize":afds.pageSize,
                "pageNumber":afds.pageNumber,
                "id":$('#eqName').val(),
            };
            return i;
        }
        //查询
        function chaxun(){
            var opt=$('#table').bootstrapTable('getOptions');
            var eqname=$('#eqname').val();
            $.post("${pageContext.request.contextPath}/qc/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"hyname":eqname},function (data) {

                $("#table").bootstrapTable('load',data) ;
            })
        }

        function del(eqId) {
            $.post("${pageContext.request.contextPath}/qc/delete",{"eqId":eqId},function (releset) {
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
                    chaxun();
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


        //添加
        function insert() {
            $("#upname").val("");
            $("#uptext").val("");
            $('#exampleModal').modal('show');

        }



        function tianjia() {
            if(!validateAdd()){
                return;
            }
            var name=$('#upname').val();
            var text1 =$('#uptext').val();
            $.post("${pageContext.request.contextPath}/qc/insert",{"eqName":name,"eqText":text1},function (releset) {
                if(releset != null){
                    $("#table").bootstrapTable('load',releset) ;
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
        }

        function validateAdd() {
            $("#upname").parent().find("span").remove();
            var upname = $("#upname").val().trim();
            if(upname == null || upname == ""){
                $("#upname").parent().append("<span style='color:red'>请输入器材名称</span>");
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
                <label for="eqname" class="control-label">器材名称:</label>
                <input id="eqname" type="text" class="form-control">
            </div>
            <button onclick="chaxun()" type="button" class="btn btn-default" style="margin-top: 20px" >查询</button>
            <button type="button" class="btn btn-default" style="float: right; margin-top: 20px" data-toggle="modal" onclick="insert()"><span class="glyphicon glyphicon-plus"></span>添加器材</button>
        </form>
    </div>

</div>

<!--表格-->
<table id="table"></table>

<%--修改--%>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="updateModalLabel">器材添加</h4>
            </div>
            <div class="modal-body">
                <form>
                    <input type="hidden" id="upid">
                    <div class="form-group">
                        <label class="control-label">器材名称:</label>
                        <input type="text" class="form-control" id="upname">
                    </div>
                    <div class="form-group">
                        <label  class="control-label">器材说明:</label>
                        <input type="text" class="form-control" id="uptext">
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

</body>
</html>
