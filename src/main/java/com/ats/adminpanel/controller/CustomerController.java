package com.ats.adminpanel.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.model.Customer;

@Controller
@Scope("session") 
public class CustomerController {

	@RequestMapping(value = "/customerReport", method = RequestMethod.GET)
	public ModelAndView showCustomerReport(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = null;
		RestTemplate restTemplate = new RestTemplate();

		// List<ModuleJson> newModuleList = (List<ModuleJson>)
		// session.getAttribute("newModuleList");
		// Info view = AccessControll.checkAccess("customerReport", "customerReport",
		// "1", "0", "0", "0", newModuleList);

		// if (view.getError() == true) {

		// model = new ModelAndView("accessDenied");

		// } else {
		model = new ModelAndView("customer/custReport");
		try {
			String type = "1,2";
			if (request.getParameter("addedFrom") != null) {
				type = request.getParameter("addedFrom");
			}
			model.addObject("type", type);
			System.err.println("TYPE - " + type);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("type", type);

			Customer[] custArr = restTemplate.postForObject(Constants.url + "getCustListByAddedType", map,
					Customer[].class);
			List<Customer> custList = new ArrayList<Customer>(Arrays.asList(custArr));

			model.addObject("custList", custList);
		} catch (Exception e) {
			System.out.println("" + e.getMessage());
		}
		// }
		return model;
	}

}
