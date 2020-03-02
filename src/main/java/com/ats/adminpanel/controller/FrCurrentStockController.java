package com.ats.adminpanel.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.model.AllFrIdName;
import com.ats.adminpanel.model.AllFrIdNameList;
import com.ats.adminpanel.model.ExportToExcel;
import com.ats.adminpanel.model.FrIdNames;
import com.ats.adminpanel.model.ItemNameId;
import com.ats.adminpanel.model.ViewFrStockBackEnd;
import com.ats.adminpanel.model.ViewStockBackEnd;
import com.ats.adminpanel.model.franchisee.FrNameIdByRouteIdResponse;
import com.ats.adminpanel.model.item.CategoryListResponse;
import com.ats.adminpanel.model.item.Item;
import com.ats.adminpanel.model.item.MCategoryList;
import com.ats.adminpanel.model.stock.PostFrItemStockHeader;

@Controller
public class FrCurrentStockController {

	AllFrIdNameList allFrIdNameList = new AllFrIdNameList();
	CategoryListResponse categoryListResponse;
	List<MCategoryList> mCategoryList = null;
	List<Item> allItemList = null;

	@RequestMapping(value = "/showfrCurStock")
	public ModelAndView showGenerateBill(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = null;

		try {
			model = new ModelAndView("stock/frCurStock");
			RestTemplate restTemplate = new RestTemplate();

			allFrIdNameList = new AllFrIdNameList();
			try {
				allFrIdNameList = restTemplate.getForObject(Constants.url + "getAllFrIdName", AllFrIdNameList.class);
			} catch (Exception e) {
				System.out.println("Exception in getAllFrIdName" + e.getMessage());
				e.printStackTrace();
			}

			try {
				categoryListResponse = new CategoryListResponse();
				categoryListResponse = restTemplate.getForObject(Constants.url + "showAllCategory",
						CategoryListResponse.class);
				mCategoryList = new ArrayList<MCategoryList>();
				mCategoryList = categoryListResponse.getmCategoryList();
			} catch (Exception e) {
				e.printStackTrace();
			}

			model.addObject("unSelectedFrList", allFrIdNameList.getFrIdNamesList());
			model.addObject("mCategoryList", mCategoryList);

		} catch (Exception e) {

			System.out.println("Exc in show showfrCurStock " + e.getMessage());
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/getAllFrListForStock", method = RequestMethod.GET)
	@ResponseBody
	public List<AllFrIdName> getFrListForDatewiseReport(HttpServletRequest request, HttpServletResponse response) {

		return allFrIdNameList.getFrIdNamesList();
	}

	@RequestMapping(value = "/getAllItemsByCategoryForFrStock", method = RequestMethod.GET)
	@ResponseBody
	public List<Item> getAllItemsByCategoryForFrStock(HttpServletRequest request, HttpServletResponse response) {

		RestTemplate restTemplate = new RestTemplate();

		int catId = Integer.parseInt(request.getParameter("catId"));

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		map.add("itemGrp1", catId);

		Item[] item = restTemplate.postForObject(Constants.url + "getStockableItemsByCatId", map, Item[].class);
		allItemList = new ArrayList<Item>(Arrays.asList(item));

		return allItemList;
	}

	@RequestMapping(value = "/selectAllFrListForStock", method = RequestMethod.GET)
	@ResponseBody
	public List<Item> selectAllFrListForStock(HttpServletRequest request, HttpServletResponse response) {
		return allItemList;
	}

	public String selectedFrArray;
	public List<String> frList = new ArrayList<>();

	@RequestMapping(value = "/getFrStock", method = RequestMethod.GET)
	public @ResponseBody ViewStockBackEnd getFrStock(HttpServletRequest request, HttpServletResponse response) {

		System.err.println("In Ajax Call get Fr Stock");

		selectedFrArray = null;
		List<String> itemsList = new ArrayList<>();
		List<ItemNameId> itemNameList = new ArrayList<ItemNameId>();

		List<ViewFrStockBackEnd> currentStockDetailList = new ArrayList<ViewFrStockBackEnd>();
		ViewStockBackEnd backEndStock = new ViewStockBackEnd();
		try {

			String selectedFr = request.getParameter("selectedFr");
			String selectedItems = request.getParameter("selectItem");
			int catId = Integer.parseInt(request.getParameter("catId"));

			selectedFr = selectedFr.substring(1, selectedFr.length() - 1);
			selectedFr = selectedFr.replaceAll("\"", "");
			System.err.println("Selected Fr after " + selectedFr);

			selectedItems = selectedItems.substring(1, selectedItems.length() - 1);
			selectedItems = selectedItems.replaceAll("\"", "");

			List<String> selectedItemList = new ArrayList<>();

			selectedItemList = Arrays.asList(selectedItems);

			frList = new ArrayList<>();
			frList = Arrays.asList(selectedFr);
			List<AllFrIdName> frIdNamesList = allFrIdNameList.getFrIdNamesList();
			List<FrIdNames> frIdNamesLists = new ArrayList<FrIdNames>();

			itemsList = Arrays.asList(selectedItems);

			PostFrItemStockHeader frItemStockHeader;

			try {

				int runningMonth = 0;

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				RestTemplate restTemplate = new RestTemplate();

				String[] frIdArr = selectedFr.split(",");
				System.out.println("Fr frIdArr  " + frIdArr.toString());

				for (int k = 0; k < frIdArr.length; k++) {

					String frId = frIdArr[k];

					System.err.println("fr Id from frIDArray " + frId);

					map = new LinkedMultiValueMap<String, Object>();
					map.add("frId", frId);

					frItemStockHeader = restTemplate.postForObject(Constants.url + "getRunningMonth", map,
							PostFrItemStockHeader.class);

					System.out.println("Fr Opening Stock " + frItemStockHeader.toString());
					runningMonth = frItemStockHeader.getMonth();

				}

				for (int k = 0; k < frIdArr.length; k++) {

					for (int b = 0; b < frIdNamesList.size(); b++) {
						if (Integer.parseInt(frIdArr[k]) == frIdNamesList.get(b).getFrId()) {
							FrIdNames frNames = new FrIdNames();

							frNames.setFrId(frIdNamesList.get(b).getFrId());
							frNames.setFrName(frIdNamesList.get(b).getFrName());
							frIdNamesLists.add(frNames);
						}
					}
				}

				System.err.println("//// Fr Names ss " + frIdNamesLists.toString());
				String[] selItemArr = selectedItems.split(",");
				for (int k = 0; k < selItemArr.length; k++) {

					for (int b = 0; b < allItemList.size(); b++) {
						if (Integer.parseInt(selItemArr[k]) == allItemList.get(b).getId()) {
							System.err.println("Item ID Matched ");
							ItemNameId itemNameId = new ItemNameId();

							itemNameId.setId("" + allItemList.get(b).getId());
							itemNameId.setItemName(allItemList.get(b).getItemName());
							itemNameList.add(itemNameId);
						}
					}
				}

				//

				DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
				DateFormat yearFormat = new SimpleDateFormat("yyyy");

				Date todaysDate = new Date();
				System.out.println(dateFormat.format(todaysDate));

				Calendar cal = Calendar.getInstance();
				cal.setTime(todaysDate);

				cal.set(Calendar.DAY_OF_MONTH, 1);

				Date firstDay = cal.getTime();

				System.out.println("First Day of month " + firstDay);

				String strFirstDay = dateFormat.format(firstDay);

				System.out.println("Year " + yearFormat.format(todaysDate));
				boolean isMonthCloseApplicable = false;

				map = new LinkedMultiValueMap<String, Object>();

				DateFormat dateFormat1 = new SimpleDateFormat("dd/MM/yyyy");
				Date date = new Date();
				System.out.println(dateFormat1.format(date));

				Calendar cal1 = Calendar.getInstance();
				cal1.setTime(date);

				int dayOfMonth = cal1.get(Calendar.DATE);

				int calCurrentMonth = cal1.get(Calendar.MONTH) + 1;
				System.out.println("Current Cal Month " + calCurrentMonth);

				System.out.println("Day Of Month is: " + dayOfMonth);

				if (runningMonth < calCurrentMonth) {

					isMonthCloseApplicable = true;
					System.out.println("Day Of Month End ......");

				}

				if (isMonthCloseApplicable) {
					System.err.println("### Inside iMonthclose app");
					String strDate;
					int year;
					if (runningMonth == 12) {
						System.err.println("running month =12");
						year = (Calendar.getInstance().getWeekYear() - 1);
						System.err.println("year value " + year);
					} else {
						System.err.println("running month not eq 12");
						year = Calendar.getInstance().getWeekYear();
						System.err.println("year value " + year);
					}

					// strDate="01/"+runningMonth+"/"+year;

					strDate = year + "/" + runningMonth + "/01";

					map.add("fromDate", strDate);
				} else {

					map.add("fromDate", dateFormat.format(firstDay));

				}

				map.add("frId", selectedFr);
				map.add("itemIdList", selectedItems);
				map.add("frStockType", 7);
				map.add("toDate", dateFormat.format(todaysDate));
				map.add("currentMonth", String.valueOf(runningMonth));
				map.add("year", yearFormat.format(todaysDate));
				map.add("catId", catId);

				ParameterizedTypeReference<List<ViewFrStockBackEnd>> typeRef2 = new ParameterizedTypeReference<List<ViewFrStockBackEnd>>() {
				};
				ResponseEntity<List<ViewFrStockBackEnd>> responseEntity2 = restTemplate.exchange(
						Constants.url + "getAdminCurrentStock", HttpMethod.POST, new HttpEntity<>(map), typeRef2);

				currentStockDetailList = responseEntity2.getBody();
				// System.out.println("Current Stock Details : " +
				// currentStockDetailList.toString());

				System.out.println("Current Stock Details : " + currentStockDetailList.toString());

			} catch (Exception e) {
				System.out.println("Exception " + e.getMessage());
				e.printStackTrace();
			}

			System.out.println("Current Stock Details : " + currentStockDetailList.toString());
			backEndStock.setCurrentStockDetailList(currentStockDetailList);
			backEndStock.setFrIdNamesList(frIdNamesLists);
			backEndStock.setItemList(itemNameList);

		} catch (Exception e) {
			System.out.println("Exception last catch " + e.getMessage());
			e.printStackTrace();
		}

		// ---------EXCEL------------

		try {
			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			rowData.add("Sr no");
			rowData.add("Product Name");

			for (FrIdNames f : backEndStock.getFrIdNamesList()) {
				rowData.add("" + f.getFrName());
			}
			rowData.add("TOTAL");

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

			int sr = 0;

			for (ItemNameId i : backEndStock.getItemList()) {

				float itemTotal = 0;

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("" + (sr + 1));
				rowData.add("" + i.getItemName());
				
				sr++;

				for (FrIdNames f : backEndStock.getFrIdNamesList()) {

					float frTotal = 0;

					for (ViewFrStockBackEnd s : backEndStock.getCurrentStockDetailList()) {

						if (s.getFrId() == f.getFrId() && String.valueOf(s.getItemId()).equalsIgnoreCase(i.getId())) {

							rowData.add("" + s.getRegCurStock());

							if (s.getRegCurStock() > 0) {
								itemTotal = itemTotal + s.getRegCurStock();

								frTotal = frTotal + s.getRegCurStock();
							}

						}

					}

				}

				rowData.add("" + itemTotal);
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
			}

			// TOTAL

			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();
			rowData.add("");
			rowData.add("TOTAL");

			for (FrIdNames f : backEndStock.getFrIdNamesList()) {

				float frTotal = 0;

				for (ViewFrStockBackEnd s : backEndStock.getCurrentStockDetailList()) {

					if (s.getFrId() == f.getFrId()) {

						if (s.getRegCurStock() > 0) {

							frTotal = frTotal + s.getRegCurStock();

						}

					}

				}

				rowData.add("" + frTotal);

			}

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

			HttpSession session = request.getSession();
			session.setAttribute("exportExcelListNew", exportToExcelList);
			session.setAttribute("excelNameNew", "StockReport");
			session.setAttribute("reportNameNew", "Franchisee Current Stock");
			session.setAttribute("searchByNew", "Franchisee");
			session.setAttribute("mergeUpto1", "$A$1:$L$1");
			session.setAttribute("mergeUpto2", "$A$2:$L$2");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Exception to genrate excel ");
		}

		return backEndStock;

	}

}
