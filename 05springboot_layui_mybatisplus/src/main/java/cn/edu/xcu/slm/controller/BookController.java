package cn.edu.xcu.slm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import cn.edu.xcu.slm.entity.Book;
import cn.edu.xcu.slm.service.IBookService;
/**
 * <p>
 * 前端控制器
 * </p>
 * @author nydegang
 * @since 2019-11-03
 */
@Controller
@RequestMapping("/book")
public class BookController {
	@Autowired
	private IBookService iBookService;
	@RequestMapping("/list")
	@ResponseBody//返回数据给客户端
	public IPage<Book> list(@RequestParam(defaultValue="1",required=false) int page,@RequestParam(defaultValue="2",required=false)int limit) {

		// 告诉要看那一页以及查询提交
		IPage<Book> toWhichPage = new Page<Book>(page, limit);
		QueryWrapper<Book> wrapper = new QueryWrapper<>();// 构建查询条
		IPage<Book> resultPage = iBookService.page(toWhichPage, wrapper);
		return resultPage;
	}
}