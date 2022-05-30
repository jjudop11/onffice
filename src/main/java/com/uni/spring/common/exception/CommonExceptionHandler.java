package com.uni.spring.common.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice("com.uni.spring")
public class CommonExceptionHandler {
	
	@ExceptionHandler(value=Exception.class)
	public ModelAndView controllerExceptionHandler(Exception e) {
		e.printStackTrace();
		return new ModelAndView("common/errorPage").addObject("msg",e.getMessage());
	}
}
