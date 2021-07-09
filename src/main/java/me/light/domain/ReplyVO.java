package me.light.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class ReplyVO {
	private Long rno; 
	private Long bno; 
	private String reply; 
	private String replyer; 
	private Date replyDate;
	private Date updateDate; 
	
}
