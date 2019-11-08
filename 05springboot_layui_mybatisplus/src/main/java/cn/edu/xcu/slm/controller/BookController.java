package cn.edu.xcu.slm.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.velocity.shaded.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ResourceUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import cn.edu.xcu.slm.entity.Book;
import cn.edu.xcu.slm.service.IBookService;

/**
 * <p>
 * 前端控制器
 * </p>
 *
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
	public IPage<Book> list(
			@RequestParam(defaultValue="1",required=false) int page,
			@RequestParam(defaultValue="2",required=false)int limit,
			@RequestParam(defaultValue="-1",required=false) int tid,
			@RequestParam(defaultValue="",required=false) String name
			) {

		// 告诉要看那一页以及查询提交
		IPage<Book> toWhichPage = new Page<Book>(page, limit);
		QueryWrapper<Book> wrapper = new QueryWrapper<>();// 构建查询条
		if (tid!=-1) {
			wrapper.eq("tid", tid);
		}
		if (StringUtils.hasText(name)) {
			wrapper.like("name", name);
		}
		IPage<Book> resultPage = iBookService.page(toWhichPage, wrapper);

		return resultPage;
	}

	@RequestMapping("/delete")
	@ResponseBody
	public Map<String, Object> delete(Integer id) {
		boolean result = iBookService.removeById(id);
		Map<String, Object> ret = new HashMap<>();
		if (result) {
			ret.put("code", 1);
			ret.put("msg", "删除成功");
		} else {
			ret.put("code", -1);
			ret.put("msg", "删除失败");
		}
		return ret;

	}
	@RequestMapping("/upload")
	@ResponseBody
	public Map<String, Object> doUpload(@RequestParam MultipartFile photox,HttpServletRequest request) throws IllegalStateException, IOException{
		//保存到服务器某个目录
		String newFileName=UUID.randomUUID()+"."+FilenameUtils.getExtension(photox.getOriginalFilename());
		//起个新名字
		//路径翻译：到类路径的static目录执行：ResourceUtils.getFile("classpath:")
		photox.transferTo(new File(ResourceUtils.getFile("classpath:")+"/static/upload/"+newFileName));
		Map<String, Object> ret=new HashMap<>();
		ret.put("newFileName", newFileName);
		ret.put("code", 0);
		return ret;
	}
	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object>  update(Book book){
		Map<String, Object> ret=new HashMap<>();
		//如果id为0，新增；否则更新
		boolean result=iBookService.saveOrUpdate(book);
		if (result) {
			ret.put("code",1);
			ret.put("msg", "成功");
		} else {
			ret.put("code", -1);
			ret.put("msg", "失败");
		}
		
		return ret;
	}
	
}
