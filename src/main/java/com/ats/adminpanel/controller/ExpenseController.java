package com.ats.adminpanel.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.model.modules.ErrorMessage;

@Controller
@Scope("session")
public class ExpenseController {
	
	
	@RequestMapping(value = "/showAddExpense")
	public String addRate(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("Add Rate Request");

		ModelAndView mav = new ModelAndView("masters/rates");

		String sprName = request.getParameter("spr_name");
		double sprRate = Double.parseDouble(request.getParameter("spr_rate"));
		double sprAdOnRate = Double.parseDouble(request.getParameter("spr_adon_rate"));

		RestTemplate rest = new RestTemplate();
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		map.add("sprName", sprName);
		map.add("sprRate", sprRate);
		map.add("sprAddOnRate", sprAdOnRate);
		ErrorMessage errorResponse = rest.postForObject(Constants.url + "insertRate", map, ErrorMessage.class);
		System.out.println(errorResponse.toString());

		return "redirect:/showRates";
	}

}
