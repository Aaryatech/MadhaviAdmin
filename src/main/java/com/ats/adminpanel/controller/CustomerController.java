package com.ats.adminpanel.controller;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
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
import com.ats.adminpanel.commons.DateConvertor;
import com.ats.adminpanel.model.AllFrIdName;
import com.ats.adminpanel.model.AllFrIdNameList;
import com.ats.adminpanel.model.Customer;
import com.ats.adminpanel.model.CustomerSaleReport;
import com.ats.adminpanel.model.ExportToExcel;
import com.ats.adminpanel.model.franchisee.Menu;

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
	
	
	AllFrIdNameList allFrIdNameList = new AllFrIdNameList();
	
	///CUSTOMER SALE REPORT
	@RequestMapping(value = "/customerSaleReport", method = RequestMethod.GET)
	public ModelAndView showCustomerSaleReport(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = null;
		RestTemplate restTemplate = new RestTemplate();

		model = new ModelAndView("customer/customerSaleReport");
		try {
			String type = "1,2";
			if (request.getParameter("addedFrom") != null) {
				type = request.getParameter("addedFrom");
			}
			model.addObject("type", type);
			
			
			allFrIdNameList = new AllFrIdNameList();
			try {

				allFrIdNameList = restTemplate.getForObject(Constants.url + "getAllFrIdName",
						AllFrIdNameList.class);

			} catch (Exception e) {
				e.printStackTrace();
			}
			model.addObject("frList", allFrIdNameList.getFrIdNamesList());
			
			
			ZoneId z = ZoneId.of("Asia/Calcutta");
			LocalDate date = LocalDate.now(z);
			DateTimeFormatter formatters = DateTimeFormatter.ofPattern("d-MM-uuuu");
			String todaysDate = date.format(formatters);
			model.addObject("todaysDate", todaysDate);
			
		} catch (Exception e) {
			System.out.println("" + e.getMessage());
		}

		return model;
	}
	
	@RequestMapping(value = "/getAllFrListForCustReport", method = RequestMethod.GET)
	@ResponseBody
	public List<AllFrIdName> getFrListForDatewiseReport(HttpServletRequest request, HttpServletResponse response) {

		return allFrIdNameList.getFrIdNamesList();
	}

	
	List<CustomerSaleReport> custSaleReportList=new ArrayList<>();
	
	@RequestMapping(value = "/getCustSaleReportAjax", method = RequestMethod.GET)
	@ResponseBody
	public List<CustomerSaleReport> getCustSaleReportAjax(HttpServletRequest request, HttpServletResponse response) {

		RestTemplate restTemplate = new RestTemplate();
		try {
			
			String type = "1,2";
			if (request.getParameter("addedFrom") != null) {
				type = request.getParameter("addedFrom");
				type = type.substring(1, type.length() - 1);
				type = type.replaceAll("\"", "");
			}
			System.err.println("TYPE -------------------- "+type);
			
			String selectedFr = request.getParameter("fr_id_list");
			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");

			selectedFr = selectedFr.substring(1, selectedFr.length() - 1);
			selectedFr = selectedFr.replaceAll("\"", "");
			
			System.err.println("DATE - "+fromDate+"     to      "+toDate);
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("type", type);
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));
			map.add("frId", selectedFr);

			CustomerSaleReport[] custArr = restTemplate.postForObject(Constants.url + "getCustListByAddedTypeForSale", map,
					CustomerSaleReport[].class);
			custSaleReportList = new ArrayList<CustomerSaleReport>(Arrays.asList(custArr));
			
			
			
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
						rowData.add("Sell AMT");
						rowData.add("Discount AMT");
						rowData.add("Wallet AMT");
						rowData.add("Extra Charges AMT");
						
						expoExcel.setRowData(rowData);
						exportToExcelList.add(expoExcel);

						int srno = 1;
						
						float totalSell=0,totalDisc=0,totalWallet=0,totalExCh=0;

						for (CustomerSaleReport cust : custSaleReportList) {

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
							
							rowData.add(""+cust.getPayableAmt());
							rowData.add(""+cust.getDiscAmt());
							rowData.add(""+cust.getWallet());
							rowData.add(""+cust.getExtraCh());

							expoExcel.setRowData(rowData);
							exportToExcelList.add(expoExcel);

							srno = srno + 1;
							
							totalSell=totalSell+cust.getPayableAmt();
							totalDisc=totalDisc+cust.getDiscAmt();
							totalWallet=totalWallet+cust.getWallet();
							totalExCh=totalExCh+cust.getExtraCh();
							

						}
						expoExcel = new ExportToExcel();
						rowData = new ArrayList<String>();
						
						rowData.add("TOTAL");
						rowData.add(" ");
						rowData.add(" ");
						rowData.add(" ");
						rowData.add(" ");
						rowData.add(" ");
						rowData.add(""+totalSell);
						rowData.add(""+totalDisc);
						rowData.add(""+totalWallet);
						rowData.add(""+totalExCh);
						
						expoExcel.setRowData(rowData);
						exportToExcelList.add(expoExcel);

						HttpSession session = request.getSession();
						session.setAttribute("exportExcelListNew", exportToExcelList);
						session.setAttribute("excelNameNew", "CustomerSalesReport");
						session.setAttribute("reportNameNew", "Customer Sales Report");

						String addedType = "";
						if (type.equalsIgnoreCase("1,2")) {
							addedType = " (POS/Online)";
						} else if (type.equalsIgnoreCase("1")) {
							addedType = " (POS)";
						} else if (type.equalsIgnoreCase("2")) {
							addedType = " (Online)";
						}

						session.setAttribute("searchByNew", "Added From : " + addedType);
						session.setAttribute("mergeUpto1", "$A$1:$J$1");
						session.setAttribute("mergeUpto2", "$A$2:$J$2");
			
			
		}catch(Exception e) {}
		
		return custSaleReportList;
	}
	
	// PDF
		@RequestMapping(value = "pdf/customerSaleReportPdf/{type}", method = RequestMethod.GET)
		public ModelAndView customerSaleReportPdf(@PathVariable String type, HttpServletRequest request,
				HttpServletResponse response) {

			ModelAndView model = new ModelAndView("customer/custSaleReportPdf");

			model.addObject("FACTORYNAME", Constants.FACTORYNAME);
			model.addObject("FACTORYADDRESS", Constants.FACTORYADDRESS);
			model.addObject("custList", custSaleReportList);
			model.addObject("type", type);

			return model;
		}

	
	
	

}
