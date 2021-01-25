
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js">
    window.onunload(alert("sp"))
</script>
<html>
<head>
    <title>商品列表</title>
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
                url:'${pageContext.request.contextPath}/goods/query',
                method:'post',
                contentType:"application/x-www-form-urlencoded",
                columns:[{ checkbox:true
            }, {
                field: 'goodsId',
                title: '商品编号'
            },{
                field: 'goodsName',
                title: '商品名称'
            },{
                field: 'unitPrice',
                title: '进价'
            },{
                field: 'sellPrice',
                title: '售价',

            },
               { field:'xxx',title:'库存',
                        formatter:function (value,row,index) {
                            if(row.inventory==0){
                                return "<p style='color:red'>请进货</p>"
                            }else if(row.inventory<10){
                                return "<p style='color:red'>货物不足10个</p>";
                            }else{
                                return row.inventory;
                            }
                        }
                    },
            {
                field: 'remark',
                title: '备注'
            }, {
                        field:'xx',title:'操作',
                        formatter : function(value, row, index) {
                            return "<a title='删除' href='javascript:del1("
                                + row.goodsId + ")'><span class='glyphicon glyphicon-trash'></span></a>  | <a> <span class='glyphicon glyphicon-pencil'></span></a> | <a href='javascript:upd1("+row.goodsId+")' class='glyphicon glyphicon-pencil'>进货</a> | <a href='javascript:upd3("+row.goodsId+")' class='glyphicon glyphicon-pencil'>退货</a>";
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
                onDblClickRow: function (row) {
                    $('#myModal3').modal("show");
                    id = row.goodsId;
                    $.post('${pageContext.request.contextPath}/goods/cha',{'goodsId':id},function(data){
                        $("#table").bootstrapTable("load",data) ;
                           $("#mc").val(data.goodsName);
                            $("#jj").val(data.unitPrice);
                            $("#sj").val(data.sellPrice);
                            $('#dw').val(data.unit);
                            $('#bz').val(data.remark);
                            $('#did').val(data.goodsId);
                            $('#spsl').val(data.inventory);
                    }) ;
                }
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

                        $.post('${pageContext.request.contextPath}/goods/del',{'goodsId':id,"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"goodsname":goodsid},function(data){
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
                "id":$('#goodsid').val(),
            };
            return i;
        }
        //查询
        function search(){
            var opt=$('#table').bootstrapTable('getOptions');
            var goodsid=$('#goodsid').val();
            $.post("${pageContext.request.contextPath}/goods/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"goodsname":goodsid},function (releset) {
                $("#table").bootstrapTable('load',releset) ;
            })
        }
        function save(){
            if(!validateAdd()){
                return;
            }
            //接收数据
            var opt=$('#table').bootstrapTable('getOptions');
            var goodsid=$('#goodsid').val();
            var name=$("#name").val();
            var unit = $("#unit").val();
            var count = $("#count").val();
            var unitprice = $("#unitprice").val();
            var sellprice= $("#sellprice").val();
            var remark = $('#remark').val();
            $("#myModal").modal("hide") ;
            $.post("${pageContext.request.contextPath}/goods/count",{"goodsName":name},function (releset) {
                $("#table").bootstrapTable('load',releset) ;
                if(releset<1){
                    $.post('${pageContext.request.contextPath}/goods/add',{'goodsName':name,'unit':unit,'unitPrice':unitprice,'sellPrice':sellprice,'inventory':count,"remark":remark},function(data){
                        $("#table").bootstrapTable("load",data) ;
                        $.post("${pageContext.request.contextPath}/goods/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"goodsname":goodsid},function (releset) {
                            $("#table").bootstrapTable('load',releset) ;
                        })
                        swal("添加！", "添加成功",
                            "success");
                    }) ;
                }else if(releset>0){
                    swal("失败！", "已有该商品，请重新输入！",
                        "error");
                    $.post("${pageContext.request.contextPath}/goods/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"goodsname":goodsid},function (releset) {
                        $("#table").bootstrapTable('load',releset) ;
                    })
                }
            })
        }

        function validateAdd() {
            $("#name").parent().find("span").remove();
            $("#unit").parent().find("span").remove();
            $("#unitprice").parent().find("span").remove();
            $("#sellprice").parent().find("span").remove();
            $("#count").parent().find("span").remove();

            var name = $("#name").val().trim();
            if(name == null || name == ""){
                $("#name").parent().append("<span style='color:red'>请填写商品名称</span>");
                return false;
            }

            var unit = $("#unit").val().trim();
            if(unit == -1){
                $("#unit").parent().append("<span style='color:red'>请选择商品单位</span>");
                return false;
            }


            var unitprice = $("#unitprice").val().trim();
            if(unitprice == null || unitprice == ""){
                $("#unitprice").parent().append("<span style='color:red'>请填写商品进价</span>");
                return false;
            }

            if(!(/^[0-9,.]*$/.test(unitprice))){
                $("#unitprice").parent().append("<span style='color:red'>商品进价只能为正整数或小数</span>");
                return false;
            }

            var sellprice = $("#sellprice").val().trim();
            if(sellprice == null || sellprice == ""){
                $("#sellprice").parent().append("<span style='color:red'>请填写商品售价</span>");
                return false;
            }

            if(!(/^[0-9,.]*$/.test(sellprice))){
                $("#sellprice").parent().append("<span style='color:red'>商品售价只能为正整数或小数</span>");
                return false;
            }



            var count = $("#count").val().trim();
            if(count == null || count == ""){
                $("#count").parent().append("<span style='color:red'>请填写商品数量</span>");
                return false;
            }

            if(!(/^[0-9]\d*$/.test(count))){
                $("#count").parent().append("<span style='color:red'>商品数量只能为正整数和0</span>");
                return false;
            }
            return true;
        }


       function upd1(id){
            $("#myModal2").modal("show");
            $('#tuihuo').hide();
            $('#jin').show();
            $('#th').text("进货数量");
           $('#myModalLabel2').text("商品进货");
            $('#id').val(id);
            $.post('${pageContext.request.contextPath}/goods/cha',{'goodsId':id},function(data){
                $("#table").bootstrapTable("load",data) ;
                $("#xgname").val(data.goodsName);
                $("#xgcount").val(data.inventory);
            }) ;

        }
        function update() {
            if(!validateUpd()){
                return;
            }
            var opt=$('#table').bootstrapTable('getOptions');
            var goodsid=$('#goodsid').val();
            var name=$("#mc").val();
            var unit = $("#dw").val();
            var unitprice = $("#jj").val();
            var sellprice= $("#sj").val();
            var remark = $('#bz').val();
            var id = $('#did').val();
            var count = $('#spsl').val();
            $("#myModal3").modal("hide") ;
            $.post('${pageContext.request.contextPath}/goods/update',{'goodsId':id,'goodsName':name,"unit":unit,"unitPrice":unitprice,"sellPrice":sellprice,"inventory":count,"remark":remark},function(data){
                $.post("${pageContext.request.contextPath}/goods/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"goodsname":goodsid},function (releset) {
                    $("#table").bootstrapTable('load',releset) ;
                })
                $("#table").bootstrapTable("load",data) ;
                swal("修改！", "修改商品信息成功",
                    "success");
            }) ;
        }

        function validateUpd() {
            $("#mc").parent().find("span").remove();
            $("#dw").parent().find("span").remove();
            $("#jj").parent().find("span").remove();
            $("#sj").parent().find("span").remove();
            $("#spsl").parent().find("span").remove();


            var mc = $("#mc").val().trim();
            if(mc == null || mc == ""){
                $("#mc").parent().append("<span style='color:red'>请填写商品名称</span>");
                return false;
            }

            var dw = $("#dw").val().trim();
            if(dw == -1){
                $("#dw").parent().append("<span style='color:red'>请选择商品单位</span>");
                return false;
            }


            var jj = $("#jj").val().trim();
            if(jj == null || jj == ""){
                $("#jj").parent().append("<span style='color:red'>请填写商品进价</span>");
                return false;
            }

            if(!(/^[0-9,.]*$/.test(jj))){
                $("#jj").parent().append("<span style='color:red'>商品进价只能为正整数或小数</span>");
                return false;
            }

            var sj = $("#sj").val().trim();
            if(sj == null || sj == ""){
                $("#sj").parent().append("<span style='color:red'>请填写商品售价</span>");
                return false;
            }

            if(!(/^[0-9,.]*$/.test(sj))){
                $("#sj").parent().append("<span style='color:red'>商品售价只能为正整数或小数</span>");
                return false;
            }

            var spsl = $("#spsl").val().trim();
            if(spsl == null || spsl == ""){
                $("#spsl").parent().append("<span style='color:red'>请填写商品数量</span>");
                return false;
            }

            if(!(/^[0-9]\d*$/.test(spsl))){
                $("#spsl").parent().append("<span style='color:red'>商品数量只能为正整数和0</span>");
                return false;
            }

            return true;
        }

        function upd3(id){
            $("#myModal2").modal("show");
            $('#jin').hide();
            $('#id').val(id);
            $('#myModalLabel2').text("商品退货");
            $('#th').text("退货数量");
            $('#tuihuo').show();
            $.post('${pageContext.request.contextPath}/goods/cha',{'goodsId':id},function(data){
                $("#table").bootstrapTable("load",data) ;
                $("#xgname").val(data.goodsName);
                $("#xgcount").val(data.inventory);
            }) ;

        }
        function upd(){
            if(!validateUpd1()){
                return;
            }
            var opt=$('#table').bootstrapTable('getOptions');
            var goodsid=$('#goodsid').val();
            var id =  $('#id').val();
            var inventory=parseInt($("#xgcount").val());
            var jinhuo = parseInt($('#jinhuo').val());
            var ss  = parseInt((inventory +jinhuo));
            $("#myModal2").modal("hide") ;
            $.post('${pageContext.request.contextPath}/goods/upd',{'goodsId':id,"inventory":ss},function(data){
                $.post("${pageContext.request.contextPath}/goods/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"goodsname":goodsid},function (releset) {
                    $("#table").bootstrapTable('load',releset) ;
                })
                $("#table").bootstrapTable("load",data) ;
                swal("成功！", "进货成功",
                    "success");
            }) ;
        }

        function validateUpd1() {
            $("#jinhuo").parent().find("span").remove();

            var jinhuo = $("#jinhuo").val().trim();
            if(jinhuo == null || jinhuo == ""){
                $("#jinhuo").parent().append("<span style='color:red'>请填写数量</span>");
                return false;
            }

            if(!(/^[0-9]\d*$/.test(jinhuo))){
                $("#jinhuo").parent().append("<span style='color:red'>数量只能为正整数和0</span>");
                return false;
            }

            return true;
        }

        function ss() {
            $("#name").val("");
            $("#unit").val("-1");
            $("#count").val("");
            $("#unitprice").val("");
            $("#sellprice").val("");
            $("#remark").val("");
        }
        function upd2(){
            if(!validateUpd1()){
                return;
            }
            var opt=$('#table').bootstrapTable('getOptions');
            var goodsid=$('#goodsid').val();
            var id =  $('#id').val();
            var inventory=parseInt($("#xgcount").val());
            var jinhuo = parseInt($('#jinhuo').val());
            var ss  = parseInt((inventory -jinhuo));
            $("#myModal2").modal("hide") ;
            if(inventory<jinhuo){
                swal("失败！", "库存不足，退货失败",
                    "error");
                $.post("${pageContext.request.contextPath}/goods/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"goodsname":goodsid},function (releset) {
                    $("#table").bootstrapTable('load',releset) ;
                })
            }else{
                $.post('${pageContext.request.contextPath}/goods/upd',{'goodsId':id,"inventory":ss},function(data){
                    $.post("${pageContext.request.contextPath}/goods/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"goodsname":goodsid},function (releset) {
                        $("#table").bootstrapTable('load',releset) ;
                    })
                    $("#table").bootstrapTable("load",data) ;
                    swal("成功！", "退货成功",
                        "success");
                }) ;
            }

        }
    </script>
</head>
<body background="${pageContext.request.contextPath}/static/HTmoban/images/tongji4.jpg">
    <%--    //查询--%>
    <div class="panel panel-default">
    <div class="panel-body">
        <form class="form-inline">
            <div  class="input-group input-daterange">
                <label for="goodsid" class="control-label">商品名称:</label>
                <input id="goodsid" type="text" class="form-control">
            </div>
            <button onclick="search()" type="button" class="btn btn-default" style="margin-top: 20px" >查询</button>
             <button type="button" class="btn btn-default" onclick="ss()" style="float: right; margin-top: 20px" data-toggle="modal" data-target="#myModal"><span class="glyphicon glyphicon-plus"></span>商品进货</button>
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
                    <h4 class="modal-title" id="myModalLabel">❤增加商品信息</h4>
                </div>
                <div class="modal-body">
                    <!-- form开始 -->
                    <form>
                        <div class="form-group">
                            <label for="name" class="col-sm-4 control-label"style="margin-top: 10px">商品名称</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="name" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="unit" class="col-sm-4 control-label"style="margin-top: 10px">商品单位</label>
                            <div class="col-sm-8">
                                <select id="unit" style="margin-top: 10px" class="form-control" autocomplete="off">
                                    <option value="-1" selected="selected">--请选择--</option>
                                    <option value="瓶">瓶</option>
                                    <option value="个">个</option>
                                    <option value="块">块</option>
                                    <option value="袋">袋</option>
                                    <option value="根">根</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="unitprice" class="col-sm-4 control-label"style="margin-top: 10px">商品进价</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="unitprice" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="sellprice" class="col-sm-4 control-label"style="margin-top: 10px">商品售价</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="sellprice" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="count" class="col-sm-4 control-label"style="margin-top: 10px">商品数量</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="count" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="remark" class="col-sm-4 control-label"style="margin-top: 10px">备注</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="remark" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
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
                    <h4 class="modal-title" id="myModalLabel3">❤修改商品信息</h4>
                </div>
                <div class="modal-body">
                    <!-- form开始 -->
                    <form>
                        <div class="form-group">
                            <label for="name" class="col-sm-4 control-label"style="margin-top: 10px">商品名称</label>
                            <div class="col-sm-8">
                                <input type="hidden" id="did">
                                <input type="text"style="margin-top: 10px" class="form-control" readonly id="mc" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="unit" class="col-sm-4 control-label"style="margin-top: 10px">商品单位</label>
                            <div class="col-sm-8">
                                <select id="dw" style="margin-top: 10px" class="form-control">
                                    <option value="-1">--请选择--</option>
                                    <option value="瓶">瓶</option>
                                    <option value="个">个</option>
                                    <option value="块">块</option>
                                    <option value="袋">袋</option>
                                    <option value="根">根</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="unitprice" class="col-sm-4 control-label"style="margin-top: 10px">商品进价</label>
                            <div class="col-sm-8">

                                <input type="text"style="margin-top: 10px" class="form-control" id="jj" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="sellprice" class="col-sm-4 control-label"style="margin-top: 10px">商品售价</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="sj" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="count" class="col-sm-4 control-label"style="margin-top: 10px">商品数量</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="spsl" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="remark" class="col-sm-4 control-label"style="margin-top: 10px">备注</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="bz" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                    </form>
                    &nbsp;
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button onclick="update()" id = "upd" type="button" class="btn btn-primary">提交</button>
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
                    <h4 class="modal-title" id="myModalLabel2">商品进货</h4>
                </div>
                <div class="modal-body">
                    <!-- form开始 -->
                    <form>
                        <input type="hidden" id="id" name="id">
                        <div class="form-group">
                            <label for="xgname" class="col-sm-4 control-label"style="margin-top: 10px">商品名称</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" readonly id="xgname" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="xgcount" class="col-sm-4 control-label"style="margin-top: 10px">商品库存</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control"  readonly id="xgcount" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="jinhuo" id="th" class="col-sm-4 control-label"style="margin-top: 10px">退货数量</label>
                            <div class="col-sm-8">
                                <input type="text"style="margin-top: 10px" class="form-control" id="jinhuo" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-type="email" parsley-validation-minlength="1">
                            </div>
                        </div>
                    </form>
                    &nbsp;
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button onclick="upd()"  id="jin" type="button" class="btn btn-primary">进货</button>
                        <button onclick="upd2()" id="tuihuo"  type="button" class="btn btn-primary">退货</button>
                    </div>
                </div>
            </div>
        </div>
 </div>
</body>
</html>
