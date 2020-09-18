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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.model.Customer;
import com.ats.adminpanel.model.ExportToExcel;

@Controller
@Scope("session")
public class CustomerController {

	List<Customer> custList = new ArrayList<>();

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

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("type", type);

			Customer[] custArr = restTemplate.postForObject(Constants.url + "getCustListByAddedType", map,
					Customer[].class);
			custList = new ArrayList<Customer>(Arrays.asList(custArr));

			model.addObject("custList", custList);

			// EXCEL-----
			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			rowData.add("Sr");
			rowData.add("Name");
			rowData.add("Phone");
			rowData.add("Email");
			rowData.add("Address");
			rowData.add("Added From");
			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

			int srno = 1;

			for (Customer cust : custList) {

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();

				rowData.add("" + srno);
				rowData.add(cust.getCustName());
				rowData.add(cust.getPhoneNumber());
				rowData.add(cust.getEmailId());
				rowData.add(cust.getAddress());

				String typeName = "";
				if (cust.getAddedFromType() == 1) {
					typeName = "POS";
				} else if (cust.getAddedFromType() == 2) {
					typeName = "Online";
				}
				rowData.add(typeName);

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				srno = srno + 1;

			}
			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();

			HttpSession session = request.getSession();
			session.setAttribute("exportExcelListNew", exportToExcelList);
			session.setAttribute("excelNameNew", "CustomerReport");
			session.setAttribute("reportNameNew", "Customer Report");

			String addedType = "";
			if (type.equalsIgnoreCase("1,2")) {
				addedType = " (POS/Online)";
			} else if (type.equalsIgnoreCase("1")) {
				addedType = " (POS)";
			} else if (type.equalsIgnoreCase("2")) {
				addedType = " (Online)";
			}

			session.setAttribute("searchByNew", "Added From : " + addedType);
			session.setAttribute("mergeUpto1", "$A$1:$F$1");
			session.setAttribute("mergeUpto2", "$A$2:$F$2");

		} catch (Exception e) {
			System.out.println("" + e.getMessage());
		}

		return model;
	}

	@RequestMapping(value = "/getCustomerReportListAjax", method = RequestMethod.GET)
	public @ResponseBody List<Customer> getCustomerReportListAjax(HttpServletRequest request, HttpServletResponse response) {
		return custList;
	}

	// PDF
	@RequestMapping(value = "pdf/customerReportPdf/{type}", method = RequestMethod.GET)
	public ModelAndView customerReportPdf(@PathVariable String type, HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView model = new ModelAndView("customer/custReportPdf");

		model.addObject("FACTORYNAME", Constants.FACTORYNAME);
		model.addObject("FACTORYADDRESS", Constants.FACTORYADDRESS);
		model.addObject("custList", custList);
		model.addObject("type", type);

		return model;
	}

}
