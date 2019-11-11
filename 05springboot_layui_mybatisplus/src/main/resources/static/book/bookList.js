//JavaScript代码区域
layui.use('element', function() {
	var element = layui.element;
});
layui.use([ 'table', 'form' ], function() {
	var table = layui.table;
	// ///让搜索框的select 有选项
	layui.$.post("type/findAll", function(data) {
		for (var i = 0; i < data.length; i++) {
			var op = new Option(data[i].name, data[i].id);
			// 放置到select
			layui.$("#tidSel2,#tidSel").append(op);
		}
		// 不调用看不到select
		layui.form.render('select'); // 刷新select选择框渲染

	});
	// 监听书籍修改提交事件
	layui.form.on('submit(book-search)', function(data) {
		// 把搜索条件带给服务器，用满足条件的数据更新表格
		table.reload('test', {
			url : 'book/list',
			where : data.field
		});
		return false;
	});
	// ////////
	table.render({
		elem : '#test',
		url : 'book/list',
		toolbar : '#toolbarDemo' // 开启头部工具栏，并为其绑定左侧模板
		,
		defaultToolbar : [ 'filter', 'exports', 'print', { // 自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
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
				return '<img src="upload/' + res.photo + '">'
			}
		}, {
			fixed : 'right',
			title : '操作',
			toolbar : '#barDemo',
			width : 150
		} ] ],
		page : true,
		parseData : function(res) { // res 即为原始返回的数据
			return {
				"code" : 0, // 解析接口状态
				// "msg": res.message, //解析提示文本
				"count" : res.total, // 解析数据长度
				"data" : res.records
			// 解析数据列表
			};
		},
		limits : [ 1, 2, 4, 6, 8 ],// 修改分页大小值
		limit : 1
	});
	// ///////////////////////////////////////////////////////
	// 头工具栏事件
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
		case 'bookAdd':
			/*
			 * 弹出一个新增表单
			 */
			openBookForm({
				author : "",
				descri : "",
				id : "",
				name : "",
				photo : "",
				price : "",
				pubdate : "",
				tid : -1
			});
			break;
		// 自定义头工具栏右侧图标 - 提示
		case 'LAYTABLE_TIPS':
			layer.alert('这是工具栏右侧自定义的一个图标按钮');
			break;
		}
		;
	});
	// 监听行工具事件
	table.on('tool(test)', function(obj) {
		var data = obj.data;
		if (obj.event === 'del') {
			layer.confirm('真的删除行么', function(index) {// yes
				/**
				 * 
				 * 向服务器发送请求执行删除，服务器消息后对页面处理：1 成功，
				 */
				layui.$.post("book/del", {
					id : data.id,
					page : 1
				}, function(data) {

					// 关闭层
					layer.close(index);
					if (data.code == 1) {// 成功
						// 重新加载表格
						table.reload("test", {
							url : "book/list"
						});
					} else {// 失败
						layer.msg(data.msg, {
							icon : 1,
							time : 2000
						// 2秒关闭（如果不配置，默认是3秒）
						}, function() {

						});
					}
				});
			});
		} else if (obj.event === 'edit') {
			openBookForm(data, data.tid);
		}

	});
	// 监听书籍修改提交事件
	layui.form.on('submit(bookBtn)', function(data) {
		layui.$.post("book/update", data.field, function(res) {

			layer.closeAll();
			if (res.code == 0) {
				// 插入一行不合理，每页大小不正确；靠谱的方式重载表格
				// 重新加载表格
				table.reload("test", {
					url : "book/list"
				});
			} else {
				layer.msg(res.msg, {
					icon : 1,
					time : 2000
				// 2秒关闭（如果不配置，默认是3秒）
				}, function() {

				});
			}

		});
		return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
	});
	// /定义表单打开方法
	function openBookForm(bookData, tid) {
		layer.open({
			type : 1,
			title : "书籍维护",
			content : layui.$("#bookEditDiv"),
			area : [ '50%', '75%' ],
			success : function(layero, index) {
				layui.form.val("bookEditLay", bookData);
				// 如果有图片，显示出来
				if (bookData.photo) {
					layui.$("#previewImg").attr("src",
							"upload/" + bookData.photo);
				} else {
					layui.$("#previewImg").attr("src", "");

				}
			}

		});

	}

});

layui.use('laydate', function() {
	var laydate = layui.laydate;

	// 执行一个laydate实例
	laydate.render({
		elem : '#pubdateInput' // 指定元素
	});
});
// 文件上传
layui.use('upload', function() {
	var upload = layui.upload;

	// 执行实例
	var uploadInst = upload.render({
		elem : '#photoxInput', // 绑定元素
		
		url : 'book/upload' ,// 上传接口
		
		field : "photox",

		choose : function(obj) {
			obj.preview(function(index, file, result) {
				layui.$("#previewImg").attr("src", result);
			});

		},
		done : function(res) {
			// 上传完成后新文件名赋值给photo输入
			layui.$("#photoInput").val(res.newFileName);

		},
		error : function() {
			// 请求异常回调
		}
	});
});