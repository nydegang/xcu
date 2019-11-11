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
				<!-- 搜索框 -->
				<div class=" layui-card-header layuiadmin-card-header-auto" lay-filter="app-content-comment">
					<form class="layui-form" action="" lay-filter="bookSearchLay">
						<div class="layui-form-item">
							<div class="layui-inline">
								<label class="layui-form-label">书名</label>
								<div class="layui-input-inline">
									<input type="text" name="name" placeholder="请输入" autocomplete="off" class="layui-input">
								</div>
							</div>

							<div class="layui-inline">
								<label class="layui-form-label">类型</label>
								<div class="layui-input-inline">
									<select name="tid" lay-filter="tid" id="tidSel2">
										<option value="-1">--请选择--</option>
									</select>
								</div>
							</div>
							<div class="layui-inline">
								<button class="layui-btn layuiadmin-btn-comm" data-type="reload" lay-submit="" lay-filter="book-search">
									<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
								</button>
							</div>
						</div>
					</form>
				</div>
				<!-- ./搜索框 -->
				<table class="layui-hide" id="test" lay-filter="test"></table>
			</div>
		</div>
		<div class="layui-footer">
			<!-- 底部固定区域 -->
			© layui.com - 底部固定区域
		</div>
	</div>
	<script type="text/html" id="toolbarDemo">
  <div class="layui-btn-container">
    <button class="layui-btn layui-btn-sm" lay-event="getCheckData">获取选中行数据</button>
    <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">获取选中数目</button>
    <button class="layui-btn layui-btn-sm" lay-event="isAll">验证是否全选</button>
    <button class="layui-btn layui-btn-sm" lay-event="bookAdd">新增</button>
  </div>
</script>
	<!-- 按钮部分 -->
	<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
	<!-- 这里放置书籍修改表单，用户不点击不应该显示 -->
	<div style="display: none;" id="bookEditDiv">
		<form class="layui-form" action="" lay-filter="bookEditLay">
			<!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
			<input type="hidden" name="id"> <input type="hidden" name="photo" id="photoInput">
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
					<button type="button" class="layui-btn" id="photoxInput">
						<i class="layui-icon">&#xe67c;</i>上传图片
					</button>
					<img alt="" id="previewImg">
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-input-block">
					<button class="layui-btn" lay-submit lay-filter="bookBtn">立即提交</button>
					<button type="reset" class="layui-btn layui-btn-primary">重置</button>
				</div>
			</div>
		</form>

	</div>
	<!-- .///书籍表单 -->
	<script src="bower_components/layui/dist/layui.js"></script>
	<script src="book/bookList.min.js"></script>

</body>
</html>