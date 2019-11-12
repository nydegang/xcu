package cn.edu.xcu.slm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import cn.edu.xcu.slm.entity.Type;
import cn.edu.xcu.slm.service.ITypeService;
@RestController
@RequestMapping("/type")
public class TypeController {
	@Autowired
	private ITypeService iTypeService;
	@RequestMapping("/findAll")
	@ResponseBody
	public List<Type> findAll(){
		return iTypeService.list();
	}
}
