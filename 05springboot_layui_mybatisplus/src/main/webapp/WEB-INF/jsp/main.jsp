<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>layout 后台大布局 - Layui</title>
<link rel="stylesheet" href="bower_components/layui/dist/css/layui.css">
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header">
			<div class="layui-logo">layui 后台布局</div>
			<!-- 头部区域（可配合layui已有的水平导航） -->
			<ul class="layui-nav layui-layout-left">
				<li class="layui-nav-item"><a href="">控制台</a></li>
				<li class="layui-nav-item"><a href="">商品管理</a></li>
				<li class="layui-nav-item"><a href="">用户</a></li>
				<li class="layui-nav-item"><a href="javascript:;">其它系统</a>
					<dl class="layui-nav-child">
						<dd>
							<a href="">邮件管理</a>
						</dd>
						<dd>
							<a href="">消息管理</a>
						</dd>
						<dd>
							<a href="">授权管理</a>
						</dd>
					</dl></li>
			</ul>
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item"><a href="javascript:;"> <img src="http://t.cn/RCzsdCq" class="layui-nav-img"> 贤心
				</a>
					<dl class="layui-nav-child">
						<dd>
							<a href="">基本资料</a>
						</dd>
						<dd>
							<a href="">安全设置</a>
						</dd>
					</dl></li>
				<li class="layui-nav-item"><a href="">退了</a></li>
			</ul>
		</div>

		<div class="layui-side layui-bg-black">
			<div class="layui-side-scroll">
				<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
				<ul class="layui-nav layui-nav-tree" lay-filter="test">
					<li class="layui-nav-item layui-nav-itemed"><a class="" href="javascript:;">所有商品</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;">列表一</a>
							</dd>
							<dd>
								<a href="javascript:;">列表二</a>
							</dd>
							<dd>
								<a href="javascript:;">列表三</a>
							</dd>
							<dd>
								<a href="">超链接</a>
							</dd>
						</dl></li>
					<li class="layui-nav-item"><a href="javascript:;">解决方案</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;">列表一</a>
							</dd>
							<dd>
								<a href="javascript:;">列表二</a>
							</dd>
							<dd>
								<a href="">超链接</a>
							</dd>
						</dl></li>
					<li class="layui-nav-item"><a href="">云市场</a></li>
					<li class="layui-nav-item"><a href="">发布商品</a></li>
				</ul>
			</div>
		</div>
		<div class="layui-body">
			<!-- 内容主体区域 -->
			<div style="padding: 15px;">
				<table class="layui-hide" id="test" lay-filter="test"></table>
			</div>
		</div>
		<div class="layui-footer">
			<!-- 底部固定区域 -->
			© layui.com - 底部固定区域
		</div>
	</div>
	<!-- 按钮部分 -->
	<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
	<!-- 这里放置书籍修改表单，用户不点击不应该显示 -->
	<div style="display: none;" id="bookEditDiv">
		<form class="layui-form" action="" lay-filter="bookEditLay" >
			<!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
			<div class="layui-form-item">
				<label class="layui-form-label">书名</label>
				<div class="layui-input-block">
					<input type="text" name="name" placeholder="请输入" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">作者</label>
				<div class="layui-input-block">
					<input type="text" name="author" placeholder="请输入" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">类型</label>
				<div class="layui-input-block">
					<select name="tid" lay-filter="tid" id="tidSel">
						<option value="-1">--请选择--</option>
					</select>
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">价格</label>
				<div class="layui-input-block">
					<input type="text" name="price" placeholder="请输入" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item layui-form-text">
				<label class="layui-form-label">描述</label>
				<div class="layui-input-block">
					<textarea placeholder="请输入内容" class="layui-textarea" name="descri"></textarea>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">出版日期</label>
				<div class="layui-input-block">
					<input type="text" name="pubdate" placeholder="请输入" autocomplete="off" class="layui-input" id="pubdateInput">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">图片</label>
				<div class="layui-input-block">
					<input type="file" name="photox" placeholder="请输入" autocomplete="off" id="photoxInput"> <img alt="" id="previewImg">
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-input-block">
					<button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
					<button type="reset" class="layui-btn layui-btn-primary">重置</button>
				</div>
			</div>
		</form>

	</div>
	<!-- .///书籍表单 -->
	<script src="bower_components/layui/dist/layui.js"></script>
	<script>
		//JavaScript代码区域
		layui.use('element', function() {
			var element = layui.element;
		});
	</script>
	<script>
		layui.use(['table','form'], function() {
			var table = layui.table;

			table.render({
				elem : '#test',
				url : 'book/list',
				toolbar : '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
				,
				defaultToolbar : [ 'filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
					title : '提示',
					layEvent : 'LAYTABLE_TIPS',
					icon : 'layui-icon-tips'
				} ],
				title : '用户数据表',
				cols : [ [ {
					type : 'checkbox',
					fixed : 'left'
				}, {
					field : 'id',
					title : 'ID',
					width : 80,
					fixed : 'left',
					unresize : true,
					sort : true
				}, {
					field : 'name',
					title : '书名',
					width : 120,
					edit : 'text'
				}, {
					field : 'author',
					title : '作者',
					width : 80,
					edit : 'text',
					sort : true
				}, {
					field : 'tid',
					title : '类型',
					width : 100
				}, {
					field : 'price',
					title : '价格'
				}, {
					field : 'descri',
					title : '描述',
					width : 80,
					sort : true
				}, {
					field : 'pubdate',
					title : '出版日期',
					width : 120
				}, {
					field : 'photo',
					title : '图片',
					width : 100,
					sort : true,
					templet : function(res) {
						return '<img src="' + res.photo + '">'
					}
				}, {
					fixed : 'right',
					title : '操作',
					toolbar : '#barDemo',
					width : 150
				} ] ],
				page : true,
				parseData : function(res) { //res 即为原始返回的数据
					return {
						"code" : 0, //解析接口状态
						//"msg": res.message, //解析提示文本
						"count" : res.total, //解析数据长度
						"data" : res.records
					//解析数据列表
					};
				},
				limits : [ 1, 2, 4, 6, 8 ],//修改分页大小值
				limit : 1
			});
			//头工具栏事件
			table.on('toolbar(test)', function(obj) {
				var checkStatus = table.checkStatus(obj.config.id);
				switch (obj.event) {
				case 'getCheckData':
					var data = checkStatus.data;
					layer.alert(JSON.stringify(data));
					break;
				case 'getCheckLength':
					var data = checkStatus.data;
					layer.msg('选中了：' + data.length + ' 个');
					break;
				case 'isAll':
					layer.msg(checkStatus.isAll ? '全选' : '未全选');
					break;

				//自定义头工具栏右侧图标 - 提示
				case 'LAYTABLE_TIPS':
					layer.alert('这是工具栏右侧自定义的一个图标按钮');
					break;
				}
				;
			});
			//监听行工具事件
			table.on('tool(test)', function(obj) {
				var data = obj.data;
				//console.log(obj)
				if (obj.event === 'del') {
					layer.confirm('真的删除行么', function(index) {//yes
						/* obj.del();
						 layer.close(index);*/
						/**
						
						   向服务器发送请求执行删除，服务器消息后对页面处理：1 成功，
						 */
						layui.$.post("book/del", {
							id : data.id,
							page : 1
						}, function(data) {

							if (data.code == 1) {//成功
								//关闭层
								layer.close(index);
								//重新加载表格
								table.reload("test", {
									url : "book/list"
								});
							} else {//失败
								//关闭层
								layer.close(index);
								layer.msg(data.msg, {
									icon : 1,
									time : 2000
								//2秒关闭（如果不配置，默认是3秒）
								}, function() {

								});
							}
						});
					});
				} else if (obj.event === 'edit') {
					/*layer.prompt({
					  formType: 2
					  ,value: data.email
					}, function(value, index){
					  obj.update({
					    email: value
					  });
					  layer.close(index);
					});*/
					layer.open({
						type : 1,
						title : "书籍修改",
						content : layui.$("#bookEditDiv"),
						area : [ '50%', '75%' ],
						  success: function(layero, index){
							    layui.form.val("bookEditLay",data);
							    //解决类型问题
							    layui.$.post("type/findAll",function(data){
                                         for(var i=0;i<data.length;i++){
                                          var op=new Option(data[i].name,data[i].id);
                                          if(data[i].id==obj.data.tid){
                                                    op.selected=true;
                                              }
                                          //放置到select
                                          
                                           layui.$("#tidSel").append(op);
                                         }
                                         //不调用看不到select
                                         layui.form.render('select'); //刷新select选择框渲染
								    
								    });
								    
							    
						 }

					});
				}
			});
		});
	</script>
	<script>
layui.use('laydate', function(){
  var laydate = layui.laydate;
  
  //执行一个laydate实例
  laydate.render({
    elem: '#pubdateInput' //指定元素
  });
});
</script>
<script>
//文件上传
layui.use('upload', function(){
  var upload = layui.upload;
   
  //执行实例
  var uploadInst = upload.render({
    elem: '#photoxInput' //绑定元素
    ,url: 'book/upload' //上传接口
    ,choose: function(obj){
    	obj.preview(function(index, file, result){
            layui.$("#previewImg").attr("src",result);
        });

     }
    ,done: function(res){
      //上传完毕回调
    }
    ,error: function(){
      //请求异常回调
    }
  });
});
</script>
</body>
</html>