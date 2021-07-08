package me.light.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import me.light.domain.BoardVO;
import me.light.domain.Criteria;
import me.light.domain.PageDTO;
import me.light.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Autowired
	private BoardService service;
	
	@GetMapping("/list")
	public void list(Model model,Criteria cri, String category) {
		cri.setCategory(category);
		model.addAttribute("list",service.getList(cri)); 
		model.addAttribute("pageMaker", new PageDTO(cri, service.getTotal(cri)));
	}
	
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		service.register(board);
		rttr.addFlashAttribute("register",board.getBno());
		String cateName = "cateName="+board.getCateName(); 
		String category = "category="+board.getCategory(); 
		return "redirect:/board/list?"+category;
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(Long bno, Model model) {
		 model.addAttribute("board", service.get(bno)); 
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr) {
		if(service.modify(board)) {
			rttr.addFlashAttribute("modify",board.getBno());
		}
		String category = "category="+board.getCategory();
		return "redirect:/board/list?"+category;
	}
	
	@PostMapping("/remove")
	public String remove(Long bno,String category, RedirectAttributes rttr) {
		if(service.remove(bno)) {
			rttr.addFlashAttribute("modify",bno);
		}
		return "redirect:/board/list?category="+category;
	}
	
	@GetMapping("/register")
	public void register() {}
	
}
