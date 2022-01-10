package com.reservation.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class UserController {

	@GetMapping("/main")
	public void main() {
		System.out.println("main");
	}
	
	@GetMapping("/booking")
	public void booking() {
		System.out.println("booking");
	}
}
