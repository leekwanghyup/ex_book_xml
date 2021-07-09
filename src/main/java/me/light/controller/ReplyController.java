package me.light.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import me.light.domain.ReplyVO;
import me.light.service.ReplyService;

@RestController
@RequestMapping("/replies")
public class ReplyController {
	
	@Autowired
	private ReplyService service; 
	
	@PostMapping(value="/new", consumes = {MediaType.APPLICATION_JSON_VALUE}, produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){ 
		return service.regisetr(vo) == 1 ? 
				new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); // 500 
	}
}
