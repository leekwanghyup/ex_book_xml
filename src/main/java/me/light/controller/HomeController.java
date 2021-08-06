package me.light.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import me.light.service.MainService;

@Controller
public class HomeController {
	
	@Autowired
	private MainService service; 

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		model.addAttribute("lastest",service.getListWith(null));
		model.addAttribute("free",service.getListWith("free"));
		model.addAttribute("notice",service.getListWith("notice"));
		model.addAttribute("strategy",service.getListWith("strategy"));
		model.addAttribute("qna",service.getListWith("qna"));
		return "home";
	}

	@GetMapping("/accessError")
	public void accessDenined() {
		System.out.println("dddddd"); 
	}
	
	
	@GetMapping("/customLogout")
	public String logoutPage() {
		 return "/member/logout";
	}
}
