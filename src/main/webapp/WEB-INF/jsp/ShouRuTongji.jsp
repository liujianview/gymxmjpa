
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js"></script>

<script src="${pageContext.request.contextPath}/static/echarts.min.js"></script>
<head>
    <title>收入统计图</title>
</head>
<body background="${pageContext.request.contextPath}/static/HTmoban/images/tongji4.jpg">
<div class="panel panel-default">
    <div class="panel-body" style="width:400px; display: inline-block" >
        <select id="xuan" class="form-control" oninput="cha()" style="width:200px; margin-right: 10px; float: left">
            <option value="1">柱状图</option>
            <option value="2">饼状图</option>
            <option value="3">折线图</option>
        </select>

    </div>
    <div id="main" style="width: 1100px;height:550px;">

    </div>


</div>
    <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
        function cha(){
            var a= $("#xuan").val();
            if(a==1){
                option = {
                    title: {
                        text: '2020年每月收入统计'
                    },
                    tooltip: {},
                    legend: {
                        data:['金额']
                    },
                    xAxis: {
                        data: ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
                        axisLabel :{
                            interval:0
                        }
                    },
                    yAxis: {},
                    series: [{
                        name: '金额',
                        type: 'bar',
                        data:[]
                    }]
                };

                // 使用刚指定的配置项和数据显示图表。
                myChart.setOption(option);
                $.post('${pageContext.request.contextPath}/cz/tongji',{},function(data){
                    //重新给table绑定数据
                    myChart.setOption({
                        xAxis: {
                            data: ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"]
                        },
                        series: [{
                            // 根据名字对应到相应的系列
                            name: '金额',
                            data: data
                        }]
                    });
                }) ;
            }else if(a==2){
                option = {
                    title : {
                        text: '2020年每月收入统计',
                        subtext: '',
                        x:'center'
                    },
                    tooltip : {
                        trigger: 'item',
                        formatter: "{a} <br/>{b} : {c} ({d}%)"
                    },
                    legend: {
                        orient : 'vertical',
                        x : 'left',
                        data:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"]
                    },
                    toolbox: {
                        show : true,
                        feature : {
                            mark : {show: true},
                            dataView : {show: true, readOnly: false},
                            magicType : {
                                show: true,
                                type: ['pie', 'funnel'],
                                option: {
                                    funnel: {
                                        x: '25%',
                                        width: '50%',
                                        funnelAlign: 'left',
                                        max: 1548
                                    }
                                }
                            },
                            restore : {show: true},
                            saveAsImage : {show: true}
                        }
                    },
                    calculable : true,
                    series : [
                        {
                            name:'',
                            type:'pie',
                            radius : '55%',
                            center: ['50%', '60%'],
                            data:[],
                            itemStyle: {
                                normal:{
                                    label:{
                                        show: function(value){
                                            if(value == 0.00) return false;
                                        }(),
                                        formatter: '{b} : {c} ({d}%)'
                                    },
                                    labelLine :{
                                        show:function(value){
                                            if(value == 0.00) return false;
                                        }()
                                    }
                                }
                            }

                        }
                    ]
                };
                ;
                if (option && typeof option === "object") {
                    myChart.setOption(option, true);
                }

                //饼图动态赋值
                $.ajax({
                    type: "post",
                    url: "${pageContext.request.contextPath}/cz/tongji",
                    cache : false,    //禁用缓存
                    dataType: "json",
                    success: function(result) {
                    	//定义两个数组
                        var names=["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"];
                        var nums=[];
                        $.each(result,function(key,values){ //此处我返回的是list<String,map<String,String>>循环map
                            var obj = new Object();
                            obj.name = names[key];
                            obj.value = values;
                            nums.push(obj);
                        });
                        myChart.setOption({ //加载数据图表
                            legend: {
                                data: names
                            },
                            series: {
                                // 根据名字对应到相应的系列
                                name: ['金额'],
                                data: nums
                            }
                        });
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown) {
                        alert("查询失败");
                    }
                });
            }else if(a==3){
                option = {
                    title: {
                        text: '2020年每月收入统计'
                    },
                    xAxis: {
                        type: 'category',
                        axisLabel :{
                            interval:0
                        },
                        data:  ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"]
                    },
                    yAxis: {
                        type: 'value'
                    },
                    series: [{
                        data: [],
                        type: 'line'
                    }]
                };


                // 使用刚指定的配置项和数据显示图表。
                myChart.setOption(option);
                $.post('${pageContext.request.contextPath}/cz/tongji',{},function(data){
                    //重新给table绑定数据
                    myChart.setOption({
                        xAxis: {
                            data: ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"]
                        },
                        series: [{
                            // 根据名字对应到相应的系列
                            data: data
                        }]
                    });
                }) ;
            }
        }

        // 指定图表的配置项和数据
        var option=null;
        option = {
            title: {
                text: '2020年每月收入统计'
            },
            tooltip: {},
            legend: {
                data:['金额']
            },
            xAxis: {
                data: ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
                axisLabel :{
                    interval:0
                }
            },
            yAxis: {},
            series: [{
                name: '金额',
                type: 'bar',
                data:[]
            }]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
        $.post('${pageContext.request.contextPath}/cz/tongji',{},function(data){
            //重新给table绑定数据
            myChart.setOption({
                xAxis: {
                    data: ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"]
                },
                series: [{
                    // 根据名字对应到相应的系列
                    name: '金额',
                    data: data
                }]
            });
        }) ;
    </script>
</body>
</html>
