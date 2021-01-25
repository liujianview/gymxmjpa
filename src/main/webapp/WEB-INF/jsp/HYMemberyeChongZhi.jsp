
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

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/date/bootstrap-datetimepicker.min.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/date/Moment.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/date/bootstrap-datetimepicker.min.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.4/css/bootstrap-select.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.4/js/bootstrap-select.min.js"></script>

    <%--<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap/">--%>
    <%--<script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap/bootstrap-select-1.12.4/js/bootstrap-select.js"></script>--%>

    <%--<script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap/bootstrap-select-1.12.4/js/i18n/defaults-*.min.js"></script>--%>

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
            $('#dg').bootstrapTable({
                url:'${pageContext.request.contextPath}/menber/query',
                method:'post',
                contentType:"application/x-www-form-urlencoded",
                columns:[
                    { field:'memberId',title:'会员编号',sortable: true},
                    { field:'memberName',title:'名称',sortable: true},
                    { field:'memberPhone',title:'电话',sortable: true},
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
                    { field:'xxx',title:'操作',
                        formatter:function (value,row,index) {
                            return "<a title='续费' href='javascript:xufei("
                                + row.memberId + ")'><span class='glyphicon glyphicon-arrow-right'>续费</span></a>";
                        }
                    },
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
        function xufei(id) {
            //$('#xztype').empty();
            $.post("${pageContext.request.contextPath}/ktype/query",{},function (releset) {
                var e=releset;
                $(e).each(function () {
                    $('#xztype').append('<option value='+this.typeId+' >'+this.typeName+'</option>');
                })
            });
            $('#ycy').val(id);
            $('#updateeModal').modal('show');
        }
        function cz() {
            if(!validateAdd()){
                return;
            }
            var id=$('#ycy').val();
            var jine=$('#xzmoney').val();
            var ssjine=$('#ssmoney').val();
            var zhaoqian=$('#zhaoqian').val();
            var bz=$('#bz').val();
            $.post("${pageContext.request.contextPath}/cz/xin",{"beizhu":bz,"member.memberId":id,"money":jine,"ssmoney":ssjine,"zlmoney":zhaoqian},function (releset) {
                if(releset != null){
                    $("#dg").bootstrapTable('load',releset) ;
                    $('#updateeModal').modal('hide');
                    swal(
                        {
                            title:"续费成功",
                            type:"success",
                            timer: 1500,
                            showConfirmButton: false
                        }
                    )
                }else{
                    swal(
                        {
                            title:"续费失败",
                            type:"warning",
                            timer: 1500,
                            showConfirmButton: false
                        }
                    )
                }
            })
        }

        function validateAdd() {
            $("#xzmoney").parent().find("span").remove();
            $("#ssmoney").parent().find("span").remove();


            var xzmoney = $("#xzmoney").val().trim();
            if(xzmoney == null || xzmoney == ""){
                $("#xzmoney").parent().append("<span style='color:red'>请填写金额</span>");
                return false;
            }

            if(!(/^[1-9]\d*$/.test(xzmoney))){
                $("#xzmoney").parent().append("<span style='color:red'>金额只能为正整数</span>");
                return false;
            }

            var ssmoney = $("#ssmoney").val().trim();
            if(ssmoney == null || ssmoney == ""){
                $("#ssmoney").parent().append("<span style='color:red'>请填写实收金额</span>");
                return false;
            }

            if(!(/^[1-9]\d*$/.test(ssmoney))){
                $("#ssmoney").parent().append("<span style='color:red'>实收金额只能为正整数</span>");
                return false;
            }



            return true;
        }

        function zql() {
            var jine=$('#xzmoney').val();
            var ssjine=$('#ssmoney').val();
            var zhao=ssjine-jine;
            $('#zhaoqian').val(zhao);
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
        </form>
    </div>

</div>
<%--//页面数据展示--%>
<div>
    <table id="dg"></table>
</div>
<%--修改--%>
<div class="modal fade" id="updateeModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="updateModalLabel">充值金额</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div>
                        <label for="xzmoney" class="control-label">金额:</label>
                        <input class="form-control" type="text" id="xzmoney">
                    </div>
                    <div>
                        <label for="ssmoney" class="control-label">实收金额:</label>
                        <input class="form-control" type="text" id="ssmoney" oninput="zql()">
                    </div>
                    <div>
                        <label for="zhaoqian" class="control-label">找钱:</label>
                        <input class="form-control" type="text" id="zhaoqian" readonly="readonly">
                    </div>
                    <div>
                        <label for="bz" class="control-label">备注:</label>
                        <input class="form-control" type="text" id="bz">
                    </div>
                    <input type="hidden" id="ycy">
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="cz()">充值</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
