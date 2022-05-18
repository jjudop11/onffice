package com.uni.spring.common.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.slf4j.LoggerFactory;

import ch.qos.logback.classic.Logger;

// 선언적방법 테스트
public class LoggerAspect {
	
	private static final Logger logger = (Logger)LoggerFactory.getLogger(LoggerAspect.class);

	public Object loggerAdvice(ProceedingJoinPoint join) throws Throwable {
		
		Signature sig = join.getSignature();
		String type = sig.getDeclaringTypeName(); // 메소드 있는 클래스 풀네임
		String methodname = sig.getName();
		String cName = "";
		
		if(type.indexOf("Controller") > -1) {
			cName = "Controller: ";
		} else if (type.indexOf("Service") > -1) {
			cName = "Service: ";
		} else if (type.indexOf("Dao") > -1) {
			cName = "Dao: ";
		}
			
		logger.info("[Before]: "+ cName + type + "." + methodname + "()");
		Object obj = join.proceed(); // 전과 후를 나누는 기준
		logger.info("[After]: "+ cName + type + "." + methodname + "()");
		

		return obj;
	}
}
