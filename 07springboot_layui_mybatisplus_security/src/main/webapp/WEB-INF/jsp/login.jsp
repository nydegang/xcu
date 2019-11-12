<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>登录</title>
<link rel="stylesheet" href="/bower_components/layui/dist/css/layui.css">

</head>
<body>
	<div class="layui-container">
		<div class="layui-row">
			<div class="layui-col-md12">
				<div class="layui-card">
					<div class="layui-card-header">登录</div>
					<div class="layui-card-body">
						<form class="layui-form" action="/login" method="post">
							<div class="layui-form-item">
								<label class="layui-form-label">用户名</label>
								<div class="layui-input-block">
									<input type="text" name="name" required lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">密码</label>
								<div class="layui-input-block">
									<input type="password" name="pwd" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
								</div>

							</div>
							<div class="layui-form-item">
								<div class="layui-input-block">
									<button class="layui-btn" lay-submit lay-filter="formDemo">登录</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="/bower_components/layui/dist/layui.js"></script>
</body>
</html>