package com.ats.adminpanel.controller;

import java.math.BigDecimal;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
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
import com.ats.adminpanel.model.ExportToExcel;
import com.ats.adminpanel.model.franchisee.SubCategory;
import com.ats.adminpanel.model.item.AllItemsListResponse;
import com.ats.adminpanel.model.item.CategoryListResponse;
import com.ats.adminpanel.model.item.GetItemByCatId;
import com.ats.adminpanel.model.item.GetItemByCatIdList;
import com.ats.adminpanel.model.item.Item;
import com.ats.adminpanel.model.item.MCategoryList;
import com.ats.adminpanel.model.salesvaluereport.SalesReturnItemDaoList;
import com.ats.adminpanel.model.salesvaluereport.SalesReturnValueDaoList;

@Controller
@Scope("session")
public class SaleItemReportController {

	GetItemByCatIdList allItemsListResponse;

	public static float roundUp(float d) {
		return BigDecimal.valueOf(d).setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
	}

	@RequestMapping(value = "/showMonthlySalesValueWiseItemReport", method = RequestMethod.GET)
	public ModelAndView showMonthlySalesValueWiseItemReport(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = null;

		model = new ModelAndView("reports/sales/monthwisesalesitemvalue");
		RestTemplate restTemplate = new RestTemplate();

		try {

			CategoryListResponse categoryListResponse = restTemplate.getForObject(Constants.url + "showAllCategory",
					CategoryListResponse.class);
			List<MCategoryList> categoryList;
			categoryList = categoryListResponse.getmCategoryList();

			model.addObject("catList", categoryList);
			String year = request.getParameter("year");
			String catId = request.getParameter("selectCat");
			// String subCatId = request.getParameter("item_grp2");

			String subCatIds[] = request.getParameterValues("item_grp2");

			List<Integer> subIdList = new ArrayList<>();
			StringBuilder sb1 = new StringBuilder();

			for (int i = 0; i < subCatIds.length; i++) {
				sb1 = sb1.append(subCatIds[i] + ",");
				subIdList.add(Integer.parseInt(subCatIds[i]));
			}
			String subCatId = sb1.toString();
			subCatId = subCatId.substring(0, subCatId.length() - 1);

			System.err.println("SUB CAT ---- " + subCatId);
			System.err.println("CAT ---- " + catId);
			
			
			
			String dairyArray[] = request.getParameterValues("dairy_id");

			StringBuilder sb2 = new StringBuilder();

			for (int i = 0; i < dairyArray.length; i++) {
				sb2 = sb2.append(dairyArray[i] + ",");
			}
			String dairy = sb2.toString();
			dairy = dairy.substring(0, dairy.length() - 1);

			System.err.println("DAIRY ---- " + dairy);
			

			int billType = 1;

			try {
				billType = Integer.parseInt(request.getParameter("rd"));
				System.err.println("BILL TYPE - " + billType);
			} catch (Exception e) {
			}

			List<Integer> idList = new ArrayList<>();
			String[] typeIds = request.getParameterValues("type_id");

			System.out.println("mId" + typeIds);

			StringBuilder sb = new StringBuilder();

			for (int i = 0; i < typeIds.length; i++) {
				sb = sb.append(typeIds[i] + ",");
				idList.add(Integer.parseInt(typeIds[i]));
			}
			String instruments = sb.toString();
			instruments = instruments.substring(0, instruments.length() - 1);

			System.err.println("TYPE ---- " + instruments);

			model.addObject("idList", idList);
			System.out.println("catIdcatId" + catId);

			if (year != "") {
				List<SubCategory> subCatList = new ArrayList<SubCategory>();

				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();

				map1.add("catId", catId);
				subCatList = restTemplate.postForObject(Constants.url + "getSubCateListByCatId", map1, List.class);
				String[] yrs = year.split("-"); // returns an array with the 2 parts

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

				map.add("fromYear", yrs[0]);
				map.add("toYear", yrs[1]);
				map.add("subCatId", subCatId);
				map.add("typeIdList", instruments);
				map.add("billType", billType);
				map.add("dairyList", dairy);

				SalesReturnItemDaoList[] salesReturnValueReportListRes = restTemplate.postForObject(
						Constants.url + "getAdminSalesValueItemReport", map, SalesReturnItemDaoList[].class);

				List<SalesReturnItemDaoList> salesReturnValueReportList = new ArrayList<SalesReturnItemDaoList>(
						Arrays.asList(salesReturnValueReportListRes));

				map = new LinkedMultiValueMap<String, Object>();

				map.add("subCatId", subCatId);

				if (billType == 1) {
					map.add("type", 1);
				} else {
					map.add("type", 2);
				}

				allItemsListResponse = restTemplate.postForObject(Constants.url + "getItemBySubCatIds", map,
						GetItemByCatIdList.class);

				List<GetItemByCatId> itemsList = new ArrayList<GetItemByCatId>();
				itemsList = allItemsListResponse.getGetItemByCatId();
				System.err.println("salesReturnValueReportList" + salesReturnValueReportList.toString());
				LinkedHashMap<Integer, SalesReturnItemDaoList> salesReturnValueReport = new LinkedHashMap<>();

				for (int i = 0; i < salesReturnValueReportList.size(); i++) {
					salesReturnValueReport.put(i, salesReturnValueReportList.get(i));
					float totBillAmt = 0;
					float totGrnValue = 0;
					float totGvnValue = 0;
					for (int k = 0; k < salesReturnValueReportList.get(i).getSalesReturnValueItemDao().size(); k++) {
						totBillAmt = totBillAmt
								+ salesReturnValueReportList.get(i).getSalesReturnValueItemDao().get(k).getGrandTotal();
						totGrnValue = totGrnValue
								+ salesReturnValueReportList.get(i).getSalesReturnValueItemDao().get(k).getGrnQty();
						totGvnValue = totGvnValue
								+ salesReturnValueReportList.get(i).getSalesReturnValueItemDao().get(k).getGvnQty();
					}
					salesReturnValueReportList.get(i).setTotBillAmt(totBillAmt);
					salesReturnValueReportList.get(i).setTotGrnQty(totGrnValue);
					salesReturnValueReportList.get(i).setTotGvnQty(totGvnValue);
				}

				model.addObject("salesReturnValueReport", salesReturnValueReport);
				model.addObject("itemsList", itemsList);
				model.addObject("subCatList", subCatList);
				model.addObject("subCatId", subCatId);
				model.addObject("catId", catId);

				String bTypeIds = "";
				if (instruments.equalsIgnoreCase("1,2") || instruments.equalsIgnoreCase("2,1")) {
					bTypeIds = "0";
				} else {
					bTypeIds = instruments;
				}

				model.addObject("billTypeOpt", bTypeIds);
				model.addObject("billType", billType);
				
				
				String dairyIds = "";
				if (dairy.equalsIgnoreCase("1,2") || dairy.equalsIgnoreCase("2,1")) {
					dairyIds = "0";
				} else {
					dairyIds = instruments;
				}
				
				System.err.println("SELECTED DAIRY IDS ------------- "+dairy);
				
				model.addObject("dairySel", dairy);
				

				// exportToExcel
				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();
				rowData.add("Sr.");
				rowData.add("Item Name");
				for (int i = 0; i < salesReturnValueReport.size(); i++) {
					rowData.add(salesReturnValueReport.get(i).getMonth() + " Gross Sale");

					if (billType == 1) {
						rowData.add(salesReturnValueReport.get(i).getMonth() + " GRN Value");
						rowData.add(salesReturnValueReport.get(i).getMonth() + " GVN Value");

					} else {
						rowData.add(salesReturnValueReport.get(i).getMonth() + " CRN Value");

					}

					rowData.add(salesReturnValueReport.get(i).getMonth() + " Total");
				}
				rowData.add("Total Gross Sale");

				if (billType == 1) {
					rowData.add("Total GRN Value");
					rowData.add("Total GVN Value");
				} else {
					rowData.add("Total CRN Value");
				}

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				float totBillAmt = 0.0f;
				float totGrnAmt = 0.0f;
				float totGvnAmt = 0.0f;
				for (int k = 0; k < itemsList.size(); k++) {

					float grandTotal = 0.0f;
					float grnQty = 0.0f;
					float gvnQty = 0.0f;

					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					rowData.add("" + (k + 1));
					rowData.add("" + itemsList.get(k).getItemName());
					for (int i = 0; i < salesReturnValueReport.size(); i++) {
						for (int j = 0; j < salesReturnValueReport.get(i).getSalesReturnValueItemDao().size(); j++) {

							if (salesReturnValueReport.get(i).getSalesReturnValueItemDao().get(j)
									.getItemId() == itemsList.get(k).getId()) {
								rowData.add("" + roundUp(salesReturnValueReport.get(i).getSalesReturnValueItemDao()
										.get(j).getGrandTotal()));

								rowData.add("" + roundUp(
										salesReturnValueReport.get(i).getSalesReturnValueItemDao().get(j).getGrnQty()));

								if (billType == 1) {
									rowData.add("" + roundUp(salesReturnValueReport.get(i).getSalesReturnValueItemDao()
											.get(j).getGvnQty()));
								}

								rowData.add("" + roundUp(salesReturnValueReport.get(i).getSalesReturnValueItemDao()
										.get(j).getGrandTotal()
										- (salesReturnValueReport.get(i).getSalesReturnValueItemDao().get(j).getGvnQty()
												+ salesReturnValueReport.get(i).getSalesReturnValueItemDao().get(j)
														.getGrnQty())));
								grandTotal = grandTotal + salesReturnValueReport.get(i).getSalesReturnValueItemDao()
										.get(j).getGrandTotal();
								grnQty = grnQty
										+ salesReturnValueReport.get(i).getSalesReturnValueItemDao().get(j).getGrnQty();
								gvnQty = gvnQty
										+ salesReturnValueReport.get(i).getSalesReturnValueItemDao().get(j).getGvnQty();
							}

						}
					}
					rowData.add("" + roundUp(grandTotal));
					rowData.add("" + roundUp(grnQty));

					if (billType == 1) {
						rowData.add("" + roundUp(gvnQty));
					}

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);
					totBillAmt = totBillAmt + grandTotal;
					totGrnAmt = totGrnAmt + grnQty;
					totGvnAmt = totGvnAmt + gvnQty;

				}

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("");
				rowData.add("Total");
				for (int i = 0; i < salesReturnValueReport.size(); i++) {
					rowData.add("" + roundUp(salesReturnValueReport.get(i).getTotBillAmt()));

					rowData.add("" + roundUp(salesReturnValueReport.get(i).getTotGrnQty()));

					if (billType == 1) {
						rowData.add("" + roundUp(salesReturnValueReport.get(i).getTotGvnQty()));
					}

					rowData.add(roundUp((salesReturnValueReport.get(i).getTotBillAmt()
							- (salesReturnValueReport.get(i).getTotGvnQty()
									+ salesReturnValueReport.get(i).getTotGrnQty())))
							+ "");
				}
				rowData.add("" + totBillAmt);
				rowData.add("" + totGrnAmt);
				if (billType == 1) {
					rowData.add("" + totGvnAmt);
				}

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				System.err.println("exportToExcelList" + exportToExcelList.toString());
				HttpSession session = request.getSession();
				session.setAttribute("exportExcelList", exportToExcelList);
				session.setAttribute("excelName", "MonthlySalesReturnItemValueReport");

			}

		} catch (Exception e) {

		}
		// }
		return model;

	}

}
