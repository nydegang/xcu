package cn.edu.xcu.slm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
  @RequestMapping("/main")
  public String home() {
	  return "main";
  }
}
