//导入日历模块，让表单支持日期选择
layui.use('laydate', function() {
	var laydate = layui.laydate;
	// 执行一个laydate实例
	laydate.render({
		elem : '#pubdateInput' // 指定元素
	});
});
//
layui.use([ 'table', 'form' ], function() {
	// 页面加载后绘制搜索框
	// 发送ajax去拿类型数据，同时给书籍编辑框也添加选项
	layui.$.post("/type/findAll", function(data) {
		layui.$.each(data, function(index, item) {
			var option = new Option(item.name, item.id);
			layui.$('#search_tidSel,#tidSel').append(option);// 往下拉菜单里添加元素
			layui.form.render('select'); // 这个很重要
		});

	});

	var table = layui.table;

	table.render({
		elem : '#test',
		url : 'book/list',
		toolbar : '#toolbarDemo', // 开启头部工具栏，并为其绑定左侧模板
		defaultToolbar : [ 'filter', 'exports', 'print', { // 自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
			title : '提示',
			layEvent : 'LAYTABLE_TIPS',
			icon : 'layui-icon-tips'
		} ],
		title : '用户数据表',
		cols : [ [
				{
					type : 'checkbox',
					fixed : 'left'
				},
				{
					field : 'id',
					title : 'ID',
					fixed : 'left',
					unresize : true,
					sort : true
				},
				{
					field : 'name',
					title : '书名',
					edit : 'text'
				},
				{
					field : 'author',
					title : '作者',
					edit : 'text',
					sort : true
				},
				{
					field : 'tid',
					title : '类型'
				},
				{
					field : 'price',
					title : '价格'
				},
				{
					field : 'descri',
					title : '描述',
					sort : true
				},
				{
					field : 'pubdate',
					title : '出版日期'
				},
				{
					field : 'photo',
					title : '图片',
					sort : true,
					templet : function(res) {
						return '<img src="upload/' + res.photo
								+ '" style="height:200px;" >'
					}
				}, {
					fixed : 'right',
					title : '操作',
					toolbar : '#barDemo',
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
		limits : [ 1, 2, 4, 6, 8 ],// 修改分页大小
		limit : 1
	});

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
		case 'addBook':
			layer.open({
				type : 1,
				title : '书籍信息添加',
				area : [ '50%', '75%' ],
				content : layui.jquery('#editTpl'),// 把编辑框作为对话框的内容
				success : function(layero, index) {// 弹出成功时候回调的函数
					// 清空表单
					layui.form.val("editForm", {
						author : "",
						descri : "",
						id : "",
						name : "",
						photo : "",
						price : "",
						pubdate : "",
						tid : -1,
					});
					
				}
			}, function(value, index) {
				obj.update({
				// email : value
				});
				layer.close(index);
			});
			break;

		// 自定义头工具栏右侧图标 - 提示
		case 'LAYTABLE_TIPS':
			layer.alert('这是工具栏右侧自定义的一个图标按钮');
			break;
		}
	});

	// 监听行工具事件
	table.on('tool(test)', function(obj) {
		var data = obj.data;
		if (obj.event === 'del') {
			layer.confirm('真的删除行么', function(index) {
				// 向服务端发送删除指令，在这里可以使用Ajax异步
				// layui.jquery找到jQuery
				layui.jquery.post("book/delete", {// 这里传参数
					id : data.id
				}, function(ret) {// 成功回调函数
					if (ret.code == "1") {// 删除成功，刷新当前页表格
						layer.msg(ret.msg, {
							icon : 1,
							time : 1500
						}, function() {
							obj.del(); // 删除对应行（tr）的DOM结构，并更新缓存
							layer.close(index);
							table.reload('test');// 重新加载表单
						});
					} else if (ret.code == "-1") { // 删除失败
						layer.alert(ret.msg, {
							icon : 2
						}, function() {
							layer.close(index);
						});
					}
				});
			});
		} else if (obj.event === 'edit') {
			layer.open({
				type : 1,
				title : '书籍信息修改',
				area : [ '50%', '75%' ],
				content : layui.jquery('#editTpl'),// 把编辑框作为对话框的内容
				success : function(layero, index) {// 弹出成功时候回调的函数
					// obj.data是该行数据的值，这里layui.form.val把它回填到表单
					layui.form.val("editForm", obj.data);
					// 发送ajax去拿类型数据,这里只要选中即可
					layui.$('#tidSel').val(obj.data.tid?obj.data.tid:'-1')
				}
			}, function(value, index) {
				obj.update({
				// email : value
				});
				layer.close(index);
			});
		}
	});
	// 监听提交
	layui.form.on('submit(bookSubmit)', function(data) {
		formSubmit(data);
		return false;// 返回false采用Ajax提交
	});
	layui.form.on('submit(book-front-search)', function(data) {
		table.reload('test', {
			url : '/book/list',
			where : data.field,//添加搜索条件
			page:1//修正为看第一页
		});
		return false;// 返回false采用Ajax提交
	});
	// 提交表单
	function formSubmit(obj) {
		layui.$.ajax({
			type : "POST",
			data : layui.$("#editTpl>form").serialize(),
			url : "/book/update",
			success : function(data) {
				if (data.code == 1) {
					layer.alert(data.msg, function() {
						layer.closeAll();
						table.reload('test');
					});
				} else {
					layer.alert(data.msg);
				}
			},
			error : function() {
				layer.alert("操作请求错误，请您稍后再试", function() {
					layer.closeAll();
				});
			}
		});
	}
});
// 文件上传
layui.use([ 'upload' ], function() {
	var upload = layui.upload;
	// 执行实例
	var uploadInst = upload.render({
		elem : '#photoxInput', // 绑定元素
		url : '/book/upload/', // 上传接口
		before : function(obj) {
			// 预读本地文件示例，不支持ie8
			obj.preview(function(index, file, result) {
				layui.$('#previewImg').attr('src', result); // 图片链接（base64）
			});
		},
		done : function(res) {
			// 上传完毕回调
			layui.$("#photoInput").val(res.newFileName);
		},
		error : function() {
			// 请求异常回调
		}
	});
});