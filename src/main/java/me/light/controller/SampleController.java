package me.light.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/sample/*")
public class SampleController {
	
	@GetMapping("/all")
	public void doAll() {
		System.out.println("누구나");
	}
	
	@GetMapping("/member")
	public void doMember() {
		System.out.println("회원만");
	}
	
	@GetMapping("admin")
	public void doAdmin() {
		System.out.println("관리자만");
	}
}
