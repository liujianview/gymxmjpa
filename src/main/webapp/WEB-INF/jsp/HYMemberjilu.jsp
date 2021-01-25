
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


            $('#xdate').datetimepicker({
                //viewMode: 'day',
                format: 'YYYY-MM-DD'
            });
            $('#ddate').datetimepicker({
                format: 'YYYY-MM-DD',
                useCurrent: false //Important! See issue #1075
            });
            $("#xdate").on("dp.change", function (e) {
                $('#secondDate').data("DateTimePicker").minDate(e.date);
            });
            $("#ddate").on("dp.change", function (e) {
                $('#firstDate').data("DateTimePicker").maxDate(e.date);
            });
            $('#dg').bootstrapTable({
                url:'${pageContext.request.contextPath}/cz/query',
                method:'post',
                contentType:"application/x-www-form-urlencoded",
                columns:[
                    { field:'member.memberId',title:'会员编号'},
                    { field:'member.memberName',title:'名称'},
                    { field:'xxx',title:'充值类型',
                        formatter:function (index,row,value) {
                            if(row.czStatic==2){
                                return "续卡"
                            }else if(row.czStatic==1){
                                return "续费"
                            }
                        }
                    },
                    { field:'membertype.typeName',title:'名称'},
                    { field:'money',title:'金额'},
                    { field:'ssmoney',title:'实收金额'},
                    { field:'zlmoney',title:'找零'},
                    { field:'date',title:'日期'},
                    
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

        
        //获取当前的条件个页面页数即使更新值
        function queryParams(afds){
            var i={
                "pageSize":afds.pageSize,
                "pageNumber":afds.pageNumber,
                "xdate":$('#xdate').val(),
                "ddate":$('#ddate').val(),
            };
            return i;
        }
        //查询
        function search(){
            var opt=$('#dg').bootstrapTable('getOptions');
            var xdate=$('#xdate').val();
            var ddate=$('#ddate').val();
            $.post("${pageContext.request.contextPath}/cz/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"xdate":xdate,"ddate":ddate},function (releset) {
                $("#dg").bootstrapTable('load',releset) ;
            })
        }
    </script>
</head>
<body background="${pageContext.request.contextPath}/static/HTmoban/images/tongji4.jpg">
    <%--    //查询--%>
    <div class="panel panel-default">
    <div class="panel-body">
        <form class="form-inline">
            <div  class="input-group input-daterange">
                <label for="xdate" class="control-label">日期从:</label>
                <input id="xdate" type="text" class="form-control">
            </div>
            <div  class="input-group input-daterange">
                <label for="ddate" class="control-label">到:</label>
                <input id="ddate" type="text" class="form-control">
            </div>
            <button onclick="search()" type="button" class="btn btn-default" style="margin-top: 20px" >查询</button>
            <button type="button" id="download" style="margin-left:20px;" id="btn_download" class="btn btn-primary" onClick ="$('#dg').tableExport({ type: 'excel', escape: 'false' })">数据导出</button>
        </form>
    </div>

</div>
    <%--//页面数据展示--%>
    <div>
        <table id="dg"></table>
    </div>
</body>
</html>
