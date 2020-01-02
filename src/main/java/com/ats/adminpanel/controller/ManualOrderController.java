package com.ats.adminpanel.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.adminpanel.commons.AccessControll;
import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.commons.DateConvertor;
import com.ats.adminpanel.model.AddCustemerResponse;
import com.ats.adminpanel.model.Customer;
import com.ats.adminpanel.model.GenerateBill;
import com.ats.adminpanel.model.Info;
import com.ats.adminpanel.model.ItemForMOrder;
import com.ats.adminpanel.model.Orders;
import com.ats.adminpanel.model.SectionMaster;
import com.ats.adminpanel.model.accessright.ModuleJson;
import com.ats.adminpanel.model.billing.PostBillDataCommon;
import com.ats.adminpanel.model.billing.PostBillDetail;
import com.ats.adminpanel.model.billing.PostBillHeader;
import com.ats.adminpanel.model.franchisee.AdvanceOrderDetail;
import com.ats.adminpanel.model.franchisee.AdvanceOrderHeader;
import com.ats.adminpanel.model.franchisee.FranchiseeAndMenuList;
import com.ats.adminpanel.model.franchisee.FranchiseeList;
import com.ats.adminpanel.model.franchisee.Menu;
import com.ats.adminpanel.model.franchisee.NewSetting;
import com.ats.adminpanel.model.item.Item;

@Controller
@Scope("session")
public class ManualOrderController {
	List<Orders> orderList = new ArrayList<Orders>();
	String billNo = "0";
	FranchiseeAndMenuList franchiseeAndMenuList;

	@RequestMapping(value = "/showManualOrder", method = RequestMethod.GET)
	public ModelAndView showManualOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {

		ModelAndView model = null;
		HttpSession session = request.getSession();

		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info view = AccessControll.checkAccess("showManualOrder", "showManualOrder", "1", "0", "0", "0", newModuleList);

		if (view.getError() == true) {

			model = new ModelAndView("accessDenied");

		} else {
			model = new ModelAndView("orders/manualOrder");
			try {
				RestTemplate restTemplate = new RestTemplate();
				franchiseeAndMenuList = restTemplate.getForObject(Constants.url + "getFranchiseeAndMenu",
						FranchiseeAndMenuList.class);
				orderList = new ArrayList<Orders>();
				System.out.println("Franchisee Response " + franchiseeAndMenuList.getAllFranchisee());

				model.addObject("allFranchiseeAndMenuList", franchiseeAndMenuList);
				model.addObject("billNo", billNo);
				billNo = "0";

				SectionMaster[] sectionMasterArray = restTemplate.getForObject(Constants.url + "/getSectionListOnly",
						SectionMaster[].class);
				List<SectionMaster> sectionList = new ArrayList<SectionMaster>(Arrays.asList(sectionMasterArray));
				model.addObject("sectionList", sectionList);
				
				Customer[] customer = restTemplate.getForObject(Constants.url + "/getAllCustomers", Customer[].class);
				List<Customer> customerList = new ArrayList<>(Arrays.asList(customer));
				model.addObject("customerList", customerList);
				
				MultiValueMap<String, Object> mvm= new LinkedMultiValueMap<String, Object>();
				mvm.add("settingKey", "DEFLTCUST");
				NewSetting settingValue = restTemplate.postForObject(Constants.url + "/findNewSettingByKey", mvm,
						NewSetting.class);
	           System.err.println(settingValue.toString());
				model.addObject("defaultCustomer", settingValue.getSettingValue1());
				Customer defCust=new Customer();
				for(int i=0;i<customerList.size();i++)
				{
					if(customerList.get(i).getCustId()==Integer.parseInt(settingValue.getSettingValue1()))
					{
						defCust=customerList.get(i);
						break;
					}
				}
                model.addObject("defCust", defCust);
			} catch (Exception e) {
				System.out.println("Franchisee Controller Exception " + e.getMessage());
			}
		}
		return model;

	}

	// ----------------------------------( METHOD)-------------------------
	@RequestMapping(value = "/getMenuForOrder", method = RequestMethod.GET)
	public @ResponseBody List<Menu> findAllMenu(@RequestParam(value = "fr_id", required = true) int frId) {

		List<Menu> menuList = new ArrayList<Menu>();
		List<Menu> confMenuList = new ArrayList<Menu>();
		try {
			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("frId", frId);
			// Calling Service to get Configured Menus
			Integer[] configuredMenuId = restTemplate.postForObject(Constants.url + "getConfiguredMenuId", map,
					Integer[].class);

			ArrayList<Integer> configuredMenuList = new ArrayList<Integer>(Arrays.asList(configuredMenuId));

			menuList = franchiseeAndMenuList.getAllMenu();

			for (Menu menu : menuList) {

				for (int i = 0; i < configuredMenuList.size(); i++) {
					if (menu.getMenuId() == configuredMenuList.get(i)) {
						confMenuList.add(menu);
					}

				}
			}
			System.out.println("configuredMenuList:" + confMenuList.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return confMenuList;
	}

	// ----------------------------------------END--------------------------------------------
	@RequestMapping(value = "/getItemsOfMenuId", method = RequestMethod.GET)
	public @ResponseBody List<Orders> commonItemById(@RequestParam(value = "menuId", required = true) int menuId,
			@RequestParam(value = "frId", required = true) int frId,
			@RequestParam(value = "by", required = true) int by,
			@RequestParam(value = "ordertype", required = true) int ordertype,
			@RequestParam(value = "isDairyMart", required = true) int isDairyMart,
			@RequestParam(value = "delType", required = true) int delType,
			@RequestParam(value = "delDate", required = true) String delDate) throws ParseException {

		try {
			orderList = new ArrayList<Orders>();
			RestTemplate restTemplate = new RestTemplate();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MM-yyyy");

			Date today = new Date();
			Date tomorrow = new Date(today.getTime() + (1000 * 60 * 60 * 24));
			java.sql.Date sqlCurrDate = new java.sql.Date(today.getTime());
			java.sql.Date sqlTommDate = new java.sql.Date(tomorrow.getTime());

			List<Menu> menuList = franchiseeAndMenuList.getAllMenu();
			Menu frMenu = new Menu();
			for (Menu menu : menuList) {
				if (menu.getMenuId() == menuId) {
					frMenu = menu;
					break;
				}
			}
			int selectedCatId = frMenu.getMainCatId();

			System.out.println("Finding Item List for Selected CatId=" + selectedCatId);

			java.util.Date utilDate = new java.util.Date(sqlCurrDate.getTime());
			if (delType == 3) {
				java.util.Date uDate = sdf1.parse(delDate);
				java.sql.Date sqDate = new java.sql.Date(uDate.getTime());
				utilDate = new Date(sqDate.getTime() - (1000 * 60 * 60 * 24));
			}

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("itemGrp1", selectedCatId);
			map.add("menuId", menuId);
			map.add("frId", frId);
			map.add("prodDate", formatter.format(utilDate));
			map.add("ordertype", ordertype);
			map.add("isDairyMart", isDairyMart);
			ItemForMOrder[] itemRes = restTemplate.postForObject(Constants.url + "getItemListForMOrder", map,
					ItemForMOrder[].class);
			ArrayList<ItemForMOrder> itemList = new ArrayList<ItemForMOrder>(Arrays.asList(itemRes));
			System.out.println("Filter Item List " + itemList.toString());

			franchiseeListRes = restTemplate.getForObject(Constants.url + "getFranchiseeAndMenu",
					FranchiseeAndMenuList.class);
			System.out.println("franchiseeList" + franchiseeListRes.toString());
			FranchiseeList franchiseeList = null;

			for (int i = 0; i < franchiseeListRes.getAllFranchisee().size(); i++) {
				if (franchiseeListRes.getAllFranchisee().get(i).getFrId() == frId) {
					franchiseeList = franchiseeListRes.getAllFranchisee().get(i);
				}
			}
			for (ItemForMOrder item : itemList) {

				Orders order = new Orders();
				if (by == 0) {
					if (franchiseeList.getFrRateCat() == 1) {
						order.setOrderRate(item.getItemRate1());
						order.setOrderMrp(item.getItemMrp1());
					} else {
						order.setOrderRate(item.getItemRate3());
						order.setOrderMrp(item.getItemMrp3());
					}
				} else {

					if (franchiseeList.getFrRateCat() == 1) {
						order.setOrderRate(item.getItemMrp1());
						order.setOrderMrp(item.getItemMrp1());
					} else {
						order.setOrderRate(item.getItemMrp3());
						order.setOrderMrp(item.getItemMrp3());
					}

				}
				if (ordertype == 0) {
					order.setRefId(0);
				} else {
					order.setRefId(1);
				}

				int frGrnTwo = franchiseeList.getGrnTwo();
				System.err.println("frGrnTwo" + frGrnTwo + "item.getGrnTwo()" + item.getGrnTwo());
				if (frGrnTwo == 1) {

					order.setGrnType(item.getGrnTwo());

				} else {

					order.setGrnType(2);
				}
				order.setOrderId(0);
				order.setItemId(String.valueOf(item.getId()));
				order.setItemName(item.getItemName() + "--[" + franchiseeList.getFrCode() + "]");
				order.setFrId(frId);
				if (delType == 1) { /// menuId == 29 || menuId == 86 || menuId == 87 || menuId == 68 || menuId == 75
					order.setDeliveryDate(sqlCurrDate);
					order.setProductionDate(sqlCurrDate);
				} else if (delType == 2) {
					order.setDeliveryDate(sqlTommDate);
					order.setProductionDate(sqlCurrDate);
				} else {
					java.util.Date date = sdf1.parse(delDate);
					java.sql.Date sqlDate = new java.sql.Date(date.getTime());
					Date prodDate = new Date(sqlDate.getTime() - (1000 * 60 * 60 * 24));
					java.sql.Date sqlProdDate = new java.sql.Date(prodDate.getTime());

					order.setDeliveryDate(sqlDate);
					order.setProductionDate(sqlProdDate);
				}
				order.setMinQty(item.getMinQty());
				order.setIsEdit(0);
				order.setEditQty(0);/// set order qty on submit
				order.setIsPositive(item.getDiscPer());
				order.setMenuId(menuId);
				order.setOrderDate(sqlCurrDate);
				order.setOrderDatetime("" + sqlCurrDate);
				order.setUserId(0);
				order.setOrderQty(item.getOrderQty());
				int value = (int) item.getItemMrp2();
				order.setOrderStatus(value);
				order.setOrderType(item.getItemGrp1());
				order.setOrderSubType(item.getItemGrp2());

				// order.setRefId(item.getId());
				orderList.add(order);

			}
			System.out.println("------------------------" + orderList.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return orderList;
	}

	@RequestMapping(value = "/getItemsByCatIdManOrder", method = RequestMethod.GET)
	public @ResponseBody List<ItemForMOrder> getItemsByCatIdManOrder(HttpServletRequest request,
			HttpServletResponse response) {

		ArrayList<ItemForMOrder> itemsList = new ArrayList<ItemForMOrder>();
		try {
			int menuId = Integer.parseInt(request.getParameter("menuId"));
			int isDairyMart = Integer.parseInt(request.getParameter("isDairyMart"));
			RestTemplate restTemplate = new RestTemplate();
			List<Menu> menuList = franchiseeAndMenuList.getAllMenu();
			Menu frMenu = new Menu();
			for (Menu menu : menuList) {
				if (menu.getMenuId() == menuId) {
					frMenu = menu;
					break;
				}
			}
			int catId = frMenu.getMainCatId();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date today = new Date();
			java.sql.Date sqlCurrDate = new java.sql.Date(today.getTime());
			java.util.Date utilDate = new java.util.Date(sqlCurrDate.getTime());

			map.add("itemGrp1", catId);
			map.add("menuId", menuId);
			map.add("frId", 0);
			map.add("prodDate", formatter.format(utilDate));
			map.add("ordertype", 2);
			map.add("isDairyMart", isDairyMart);
			ItemForMOrder[] itemRes = restTemplate.postForObject(Constants.url + "getItemListForMOrder", map,
					ItemForMOrder[].class);
			itemsList = new ArrayList<ItemForMOrder>(Arrays.asList(itemRes));
		} catch (Exception e) {
			System.out.println("Exception in /AJAX getItemsByCatId");
		}
		return itemsList;
	}

	FranchiseeAndMenuList franchiseeListRes = null;

	@RequestMapping(value = "/getItemsOfMenuIdForMulFr", method = RequestMethod.GET)
	public @ResponseBody List<Orders> getItemsOfMenuIdForMulFr(HttpServletRequest request,
			HttpServletResponse response) {

		try {
			String frIdString = request.getParameter("frIdStr");
			int menuId = Integer.parseInt(request.getParameter("menuId"));
			int by = Integer.parseInt(request.getParameter("by"));
			int ordertype = Integer.parseInt(request.getParameter("ordertype"));
			int flagRate = Integer.parseInt(request.getParameter("flagRate"));
			if (flagRate == 1) {
				orderList = new ArrayList<Orders>();
			}
			System.err.println(ordertype + "ordertype");
			int itemId = Integer.parseInt(request.getParameter("itemId"));
			int qty = Integer.parseInt(request.getParameter("qty"));
			int isDairyMart = Integer.parseInt(request.getParameter("isDairyMart"));

			frIdString = frIdString.substring(1, frIdString.length() - 1);
			frIdString = frIdString.replaceAll("\"", "");
			List<String> frId = Arrays.asList(frIdString.split(","));

			RestTemplate restTemplate = new RestTemplate();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

			Date today = new Date();
			Date tomorrow = new Date(today.getTime() + (1000 * 60 * 60 * 24));
			java.sql.Date sqlCurrDate = new java.sql.Date(today.getTime());
			java.sql.Date sqlTommDate = new java.sql.Date(tomorrow.getTime());

			List<Menu> menuList = franchiseeAndMenuList.getAllMenu();
			Menu frMenu = new Menu();
			for (Menu menu : menuList) {
				if (menu.getMenuId() == menuId) {
					frMenu = menu;
					break;
				}
			}
			int selectedCatId = frMenu.getMainCatId();

			System.out.println("Finding Item List for Selected CatId=" + selectedCatId);

			java.util.Date utilDate = new java.util.Date(sqlCurrDate.getTime());

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("itemGrp1", selectedCatId);
			map.add("menuId", menuId);
			map.add("frId", frId.get(0));
			map.add("prodDate", formatter.format(utilDate));
			map.add("ordertype", ordertype);
			map.add("isDairyMart", isDairyMart);
			ItemForMOrder[] itemRes = restTemplate.postForObject(Constants.url + "getItemListForMOrder", map,
					ItemForMOrder[].class);
			ArrayList<ItemForMOrder> itemList = new ArrayList<ItemForMOrder>(Arrays.asList(itemRes));
			System.out.println("Filter Item List " + itemList.toString());

			franchiseeListRes = restTemplate.getForObject(Constants.url + "getFranchiseeAndMenu",
					FranchiseeAndMenuList.class);
			System.out.println("franchiseeList" + franchiseeListRes.toString());

			ItemForMOrder item = null;

			for (ItemForMOrder itemResp : itemList) {
				if (itemResp.getId() == itemId) {
					item = itemResp;
				}
			}
			for (String fr : frId) {
				int flagForItem = 0;
				if (orderList.size() > 0) {
					flagForItem = isItemPresent(Integer.parseInt(fr), item.getId(), qty);
				}

				FranchiseeList franchiseeList = null;
				for (int i = 0; i < franchiseeListRes.getAllFranchisee().size(); i++) {
					if (franchiseeListRes.getAllFranchisee().get(i).getFrId() == Integer.parseInt(fr)) {
						franchiseeList = franchiseeListRes.getAllFranchisee().get(i);
					}
				}

				Orders order = new Orders();
				if (by == 0) {
					if (franchiseeList.getFrRateCat() == 1) {
						order.setOrderRate(item.getItemRate1());
						order.setOrderMrp(item.getItemMrp1());
					} else {
						order.setOrderRate(item.getItemRate3());
						order.setOrderMrp(item.getItemMrp3());
					}
				} else {

					if (franchiseeList.getFrRateCat() == 1) {
						order.setOrderRate(item.getItemMrp1());
						order.setOrderMrp(item.getItemMrp1());
					} else {
						order.setOrderRate(item.getItemMrp3());
						order.setOrderMrp(item.getItemMrp3());
					}

				}
				if (ordertype == 0) {
					order.setRefId(0);
				} else {
					order.setRefId(1);
				}

				int frGrnTwo = franchiseeList.getGrnTwo();
				System.err.println("frGrnTwo" + frGrnTwo + "item.getGrnTwo()" + item.getGrnTwo());
				if (frGrnTwo == 1) {

					order.setGrnType(item.getGrnTwo());

				} else {

					order.setGrnType(2);
				}
				order.setOrderId(0);
				order.setItemId(String.valueOf(item.getId()));
				order.setItemName(item.getItemName() + "--[" + franchiseeList.getFrName() + "]");
				order.setFrId(franchiseeList.getFrId());

				if (menuId == 29 || menuId == 86 || menuId == 87 || menuId == 68 || menuId == 75) {
					order.setDeliveryDate(sqlCurrDate);
				} else {
					order.setDeliveryDate(sqlTommDate);
				}
				order.setMinQty(item.getMinQty());
				order.setIsEdit(0);
				order.setEditQty(qty);// Order Qty
				order.setIsPositive(item.getDiscPer());
				order.setMenuId(menuId);
				order.setOrderDate(sqlCurrDate);
				order.setOrderDatetime("" + sqlCurrDate);
				order.setUserId(0);
				order.setOrderQty(qty);
				int value = (int) item.getItemMrp2();
				order.setOrderStatus(value);
				order.setOrderType(item.getItemGrp1());
				order.setOrderSubType(item.getItemGrp2());
				order.setProductionDate(sqlCurrDate);
				// order.setRefId(item.getId());
				System.err.println("flagForItem" + flagForItem);
				if (flagForItem == 0) {
					orderList.add(order);
				}

			}
			System.out.println("------------------------" + orderList.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return orderList;
	}

	private int isItemPresent(int frId, int id, int qty) {
		int flag = 0;
		for (int i = 0; i < orderList.size(); i++) {
			if (frId == orderList.get(i).getFrId() && orderList.get(i).getItemId().equals(id + "")) {
				flag = 1;
				orderList.get(i).setEditQty(qty);
				orderList.get(i).setOrderQty(qty);
			}
		}
		return flag;
	}

	@RequestMapping(value = "/insertItem", method = RequestMethod.GET)
	public @ResponseBody List<Orders> insertItem(HttpServletRequest request, HttpServletResponse response) {

		try {

			int itemId = Integer.parseInt(request.getParameter("itemId"));
			// System.out.println("itemId"+itemId);

			int frId = Integer.parseInt(request.getParameter("frId"));
			// System.out.println("frId"+frId);

			int menuId = Integer.parseInt(request.getParameter("menuId"));
			// System.out.println("menuId"+menuId);

			int qty = Integer.parseInt(request.getParameter("qty"));
			// System.out.println("qty"+qty);

			RestTemplate restTemplate = new RestTemplate();
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("id", itemId);

			Item item = restTemplate.postForObject("" + Constants.url + "getItem", map, Item.class);
			// System.out.println("ItemResponse" + item);

			map = new LinkedMultiValueMap<String, Object>();
			map.add("id", itemId);
			map.add("frId", frId);
			float discPer = restTemplate.postForObject(Constants.url + "getDiscById", map, Float.class);

			map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frId);

			FranchiseeList franchiseeList = restTemplate.getForObject(Constants.url + "getFranchisee?frId={frId}",
					FranchiseeList.class, frId);
			// System.out.println("franchiseeList" + franchiseeList.toString());

			Orders order = new Orders();

			if (franchiseeList.getFrRateCat() == 1) {
				order.setOrderRate(item.getItemRate1());
				order.setOrderMrp(item.getItemMrp1());
			} else {
				order.setOrderRate(item.getItemRate3());
				order.setOrderMrp(item.getItemMrp3());
			}
			int frGrnTwo = franchiseeList.getGrnTwo();
			// System.err.println("frGrnTwo"+frGrnTwo+"item.getGrnTwo()"+item.getGrnTwo());
			if (item.getGrnTwo() == 1) {

				if (frGrnTwo == 1) {

					order.setGrnType(1);

				} else {

					order.setGrnType(0);
				}
			} // end of if

			else {
				if (item.getGrnTwo() == 2) {
					order.setGrnType(2);

				} else {
					order.setGrnType(0);
				}
			} // end of else
			if (menuId == 29 || menuId == 30 || menuId == 42 || menuId == 43 || menuId == 44 || menuId == 47) {

				order.setGrnType(3);

			}
			// for push grn
			if (menuId == 48) {

				order.setGrnType(4);
			}

			Date today = new Date();
			Date tomorrow = new Date(today.getTime() + (1000 * 60 * 60 * 24));
			java.sql.Date sqlCurrDate = new java.sql.Date(today.getTime());
			java.sql.Date sqlTommDate = new java.sql.Date(tomorrow.getTime());

			order.setOrderId(0);
			order.setItemId(String.valueOf(itemId));
			order.setItemName(item.getItemName() + "--[" + franchiseeList.getFrCode() + "]");
			order.setFrId(frId);
			if (menuId == 29 || menuId == 86 || menuId == 87) {
				order.setDeliveryDate(sqlCurrDate);
			} else {
				order.setDeliveryDate(sqlTommDate);
			}
			order.setIsEdit(0);
			order.setEditQty(qty);
			order.setIsPositive(discPer);
			order.setMenuId(menuId);
			order.setOrderDate(sqlCurrDate);
			order.setOrderDatetime("" + sqlCurrDate);
			order.setUserId(0);
			order.setOrderQty(qty);
			order.setOrderStatus(0);
			order.setOrderType(item.getItemGrp1());
			order.setOrderSubType(item.getItemGrp2());
			order.setProductionDate(sqlCurrDate);
			order.setRefId(itemId);

			orderList.add(order);

			// System.out.println("orderListinserted:"+orderList.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return orderList;
	}

	@RequestMapping(value = "/generateManualBill", method = RequestMethod.POST)
	public String generateManualBill(HttpServletRequest request, HttpServletResponse response) {
		int frId = 0;
		GenerateBill[] orderListResponse = null;
		String partyName = "";
		String partyGstin = "";
		String partyAddress = "";
		String submitorder = request.getParameter("submitorder");
		String submitbill = request.getParameter("submitbill");

		int ordertype = Integer.parseInt(request.getParameter("ordertype"));
		int menuId = Integer.parseInt(request.getParameter("menu"));
		int delType= Integer.parseInt(request.getParameter("delType"));
		int dm= Integer.parseInt(request.getParameter("dailyFlagMart"));

		System.err.println("dm:" + dm);
		System.err.println("button:" + submitorder + submitbill);

		Date date = new Date(Calendar.getInstance().getTime().getTime());
		DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
		String currentDate = df.format(date);
		Calendar calender = Calendar.getInstance();
		SimpleDateFormat sdf1 = new SimpleDateFormat("HH:mm:ss");

		// without Adv Order start
		if (delType != 3) {

			System.err.println("not adv order");

			List<String> frIdList = new ArrayList<>();
			if (ordertype == 0 || ordertype == 1) {
				frId = Integer.parseInt(request.getParameter("fr_id"));
				frIdList.add("" + frId);
				partyName = request.getParameter("frName");
				partyGstin = request.getParameter("gstin");
				partyAddress = request.getParameter("address");
			} else {
				String frIdStr = "";
				String[] frIdString = request.getParameterValues("fr_id1");
				System.err.println("frIdString" + frIdString.toString());

				for (int i = 0; i < frIdString.length; i++) {
					frIdStr = frIdString[i] + "," + frIdStr;
				}

				frIdStr = frIdStr.substring(0, frIdStr.length() - 1);
				frIdList = Arrays.asList(frIdStr.split(","));
				System.err.println("frIdList" + frIdList.toString());

			}

			String sectionId = request.getParameter("sectionId");

			RestTemplate restTemplate = new RestTemplate();
			for (String frId1 : frIdList) {

				System.err.println("frId" + frId1);
				FranchiseeList franchiseeList = null;
				for (int i = 0; i < franchiseeListRes.getAllFranchisee().size(); i++) {
					if (franchiseeListRes.getAllFranchisee().get(i).getFrId() == Integer.parseInt(frId1)) {
						franchiseeList = franchiseeListRes.getAllFranchisee().get(i);
					}
				}
				if (ordertype == 2) {
					partyName = franchiseeList.getFrName();
					partyGstin = franchiseeList.getFrGstNo();
					partyAddress = franchiseeList.getFrAddress();
				}
				List<Orders> orderListSave = new ArrayList<>();
				try {
					if (orderList != null || !orderList.isEmpty()) {

						for (int i = 0; i < orderList.size(); i++) {

							int qty = Integer.parseInt(request.getParameter("qty" + orderList.get(i).getItemId() + "" + frId1));
							// if (submitorder == null) {
						 System.err.println("qty"+qty);
							float discPer = Float.parseFloat(
									request.getParameter("discper" + orderList.get(i).getItemId() + "" + frId1));// new
																													// on
																													// 15
							// feb for// dis on// bill
							orderList.get(i).setIsPositive(discPer);// new on 15 feb for dis on bill
							System.err.println("discPer==" + discPer);
							// }
							orderList.get(i).setEditQty(qty);
							orderList.get(i).setOrderQty(qty);
							if (qty > 0 && orderList.get(i).getFrId() == Integer.parseInt(frId1)) {
								orderListSave.add(orderList.get(i));
								System.err.println(frId1 + "frId" + orderList.get(i));
							}
						}

						if (submitorder != null) {
							orderListResponse = restTemplate.postForObject(Constants.url + "placeManualOrder",
									orderListSave, GenerateBill[].class);
						} else {// placeManualOrderNew --- not updates prev avail item order -each time new
								// entry
							orderListResponse = restTemplate.postForObject(Constants.url + "placeManualOrderNew",
									orderListSave, GenerateBill[].class);

						}
						System.err.println("orderListResponse" + orderListResponse.toString());

						List<GenerateBill> tempGenerateBillList = new ArrayList<GenerateBill>(
								Arrays.asList(orderListResponse));

						if (submitbill != null) {

							// System.out.println("Place Order Response" + orderListResponse.toString());

							PostBillDataCommon postBillDataCommon = new PostBillDataCommon();
							List<PostBillHeader> postBillHeaderList = new ArrayList<PostBillHeader>();
							List<PostBillDetail> postBillDetailsList = new ArrayList<PostBillDetail>();

							PostBillHeader header = new PostBillHeader();
							header.setFrId(Integer.parseInt(frId1));

							float sumTaxableAmt = 0, sumTotalTax = 0, sumGrandTotal = 0;
							float sumDiscAmt = 0;

							for (int j = 0; j < tempGenerateBillList.size(); j++) {

								GenerateBill gBill = tempGenerateBillList.get(j);

								System.out.println("Inner For frId " + gBill.getFrId());

								System.out.println("If condn true " + gBill.getFrId());

								PostBillDetail billDetail = new PostBillDetail();

								String billQty = "" + tempGenerateBillList.get(j).getOrderQty();
								float discPer = tempGenerateBillList.get(j).getIsPositive();

								// billQty = String.valueOf(gBill.getOrderQty());
								Float orderRate = (float) gBill.getOrderRate();
								Float tax1 = (float) gBill.getItemTax1();
								Float tax2 = (float) gBill.getItemTax2();
								Float tax3 = (float) gBill.getItemTax3();

								Float baseRate = (orderRate * 100) / (100 + (tax1 + tax2));
								baseRate = roundUp(baseRate);

								Float taxableAmt = (float) (baseRate * Integer.parseInt(billQty));

								System.out.println("taxableAmt: " + taxableAmt);
								taxableAmt = roundUp(taxableAmt);

								float sgstRs = (taxableAmt * tax1) / 100;
								float cgstRs = (taxableAmt * tax2) / 100;
								float igstRs = (taxableAmt * tax3) / 100;
								Float totalTax = sgstRs + cgstRs;
								float discAmt = 0;
								if (billQty == null || billQty == "") {// new code to handle hidden records
									billQty = "0";
								}

								if (gBill.getIsSameState() == 1) {
									baseRate = (orderRate * 100) / (100 + (tax1 + tax2));
									taxableAmt = (float) (baseRate * Integer.parseInt(billQty));
									// ----------------------------------------------------------
									discAmt = ((taxableAmt * discPer) / 100); // new row added
									System.out.println("discAmt: " + discAmt);// new row added
									sumDiscAmt = sumDiscAmt + discAmt;

									taxableAmt = taxableAmt - discAmt; // new row added
									// ----------------------------------------------------------
									sgstRs = (taxableAmt * tax1) / 100;
									cgstRs = (taxableAmt * tax2) / 100;
									igstRs = 0;
									totalTax = sgstRs + cgstRs;

								}

								else {
									baseRate = (orderRate * 100) / (100 + (tax3));
									taxableAmt = (float) (baseRate * Integer.parseInt(billQty));
									// ----------------------------------------------------------
									discAmt = ((taxableAmt * discPer) / 100); // new row added
									System.out.println("discAmt: " + discAmt);// new row added
									sumDiscAmt = sumDiscAmt + discAmt;

									taxableAmt = taxableAmt - discAmt; // new row added
									// ----------------------------------------------------------
									sgstRs = 0;
									cgstRs = 0;
									igstRs = (taxableAmt * tax3) / 100;
									totalTax = igstRs;
								}

								sgstRs = roundUp(sgstRs);
								cgstRs = roundUp(cgstRs);
								igstRs = roundUp(igstRs);

								// header.setSgstSum(sumT1);
								// header.setCgstSum(sumT2);
								// header.setIgstSum(sumT3);

								totalTax = roundUp(totalTax);

								Float grandTotal = totalTax + taxableAmt;
								grandTotal = roundUp(grandTotal);

								sumTaxableAmt = sumTaxableAmt + taxableAmt;
								sumTaxableAmt = roundUp(sumTaxableAmt);

								sumTotalTax = sumTotalTax + totalTax;
								sumTotalTax = roundUp(sumTotalTax);

								sumGrandTotal = sumGrandTotal + grandTotal;
								sumGrandTotal = roundUp(sumGrandTotal);

								billDetail.setOrderId(tempGenerateBillList.get(j).getOrderId());
								billDetail.setMenuId(gBill.getMenuId());
								billDetail.setCatId(gBill.getCatId());
								billDetail.setItemId(gBill.getItemId());
								billDetail.setOrderQty(gBill.getOrderQty());
								billDetail.setBillQty(Integer.parseInt(billQty));
								billDetail.setMrp((float) gBill.getOrderMrp());
								billDetail.setRateType(gBill.getRateType());
								billDetail.setRate((float) gBill.getOrderRate());
								billDetail.setBaseRate(roundUp(baseRate));
								billDetail.setTaxableAmt(roundUp(taxableAmt));
								billDetail.setDiscPer(discPer);// new
								billDetail.setRemark("" + roundUp(discAmt));// new
								billDetail.setSgstPer(tax1);
								billDetail.setSgstRs(sgstRs);
								billDetail.setCgstPer(tax2);
								billDetail.setCgstRs(cgstRs);
								billDetail.setIgstPer(tax3);
								billDetail.setIgstRs(igstRs);
								billDetail.setTotalTax(totalTax);
								billDetail.setGrandTotal(grandTotal);
								billDetail.setDelStatus(0);
								billDetail.setIsGrngvnApplied(0);
								billDetail.setHsnCode(gBill.getHsnCode());// newly added
								billDetail.setGrnType(gBill.getGrnType());// newly added

								header.setSgstSum(header.getSgstSum() + billDetail.getSgstRs());
								header.setCgstSum(header.getCgstSum() + billDetail.getCgstRs());
								header.setIgstSum(header.getIgstSum() + billDetail.getIgstRs());

								int itemShelfLife = gBill.getItemShelfLife();

								String deliveryDate = gBill.getDeliveryDate();

								String calculatedDate = incrementDate(deliveryDate, itemShelfLife);

								// inc exp date if these menuId
								if (gBill.getMenuId() == 67 || gBill.getMenuId() == 86 || gBill.getMenuId() == 90) {

									calculatedDate = incrementDate(calculatedDate, 1);

								}

								DateFormat Df = new SimpleDateFormat("dd-MM-yyyy");

								Date expiryDate = null;
								try {
									expiryDate = Df.parse(calculatedDate);
								} catch (ParseException e) {

									e.printStackTrace();
								}

								billDetail.setExpiryDate(expiryDate);
								postBillDetailsList.add(billDetail);
								header.setFrCode(gBill.getFrCode());

								header.setRemark("");
								header.setTaxApplicable((int) (gBill.getItemTax1() + gBill.getItemTax2()));

							}
							header.setBillDate(new Date());// hardcoded curr Date
							header.setTaxableAmt(roundUp(sumTaxableAmt));
							header.setGrandTotal(roundUp(sumGrandTotal));
							header.setDiscAmt(roundUp(sumDiscAmt));// new

							System.err.println("sumof grand total beofre " + sumGrandTotal);

							System.err.println("Math round up Sum " + header.getGrandTotal());
							header.setTotalTax(sumTotalTax);

							header.setStatus(1);
							header.setPostBillDetailsList(postBillDetailsList);

							ZoneId zoneId = ZoneId.of("Asia/Calcutta");
							ZonedDateTime zdt = ZonedDateTime.now(zoneId);

							SimpleDateFormat sdf = new SimpleDateFormat("kk:mm:ss ");
							TimeZone istTimeZone = TimeZone.getTimeZone("Asia/Kolkata");
							Date d = new Date();
							sdf.setTimeZone(istTimeZone);
							String strtime = sdf.format(d);

							DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							Calendar cal = Calendar.getInstance();

							header.setRemark(dateFormat.format(cal.getTime()));
							header.setTime(strtime);
							header.setPartyName(partyName);
							header.setPartyGstin(partyGstin);
							header.setPartyAddress(partyAddress);

							header.setBillTime(sdf1.format(calender.getTime()));
							header.setVehNo("-");
							header.setExVarchar1(sectionId);
							header.setExVarchar2("-");
							header.setExVarchar3(partyName);
							header.setExVarchar4(partyGstin);
							header.setExVarchar5(partyAddress);
							postBillHeaderList.add(header);

							postBillDataCommon.setPostBillHeadersList(postBillHeaderList);

							System.out.println("Test data : " + postBillDataCommon.toString());

							PostBillHeader[] respList = restTemplate.postForObject(Constants.url + "insertBillData",
									postBillDataCommon, PostBillHeader[].class);

							List<PostBillHeader> billRespList = new ArrayList<PostBillHeader>(Arrays.asList(respList));

							billNo = billNo + "," + billRespList.get(0).getBillNo();
							System.out.println("Save Res Data " + respList.toString());

						}
					}

				} catch (Exception e) {
					e.printStackTrace();
				}
			} // fr for
			orderList = new ArrayList<Orders>();
		} else {
			RestTemplate restTemplate = new RestTemplate();

			partyName = request.getParameter("frName");
			partyGstin = request.getParameter("gstin");
			partyAddress = request.getParameter("address");
		    String	billToName = request.getParameter("billToName");
		    String  billToGstin = request.getParameter("billToGstin");
		    String  billToAddress = request.getParameter("billToAddress");
			int custId= Integer.parseInt(request.getParameter("cust"));
			System.err.println("  adv order");
		    float advanceAmt=Float.parseFloat(request.getParameter("advanceAmt"));
			String devDate = request.getParameter("delDate");
			String delTime = request.getParameter("delTime");
			System.err.println("fr_id:" + Integer.parseInt(request.getParameter("fr_id")));
			// without Adv Order ends
			// to get fr
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("frId", Integer.parseInt(request.getParameter("fr_id")));
 			FranchiseeList franchiseeList = restTemplate.postForObject(Constants.url + "/getFranchiseeNew", map,
					FranchiseeList.class);
			 
 			String frString=franchiseeList.getFrName()+"##"+franchiseeList.getFrAddress()+"##"+franchiseeList.getFrGstNo();
 			DateFormat dateFormat1 = new SimpleDateFormat("hh:mm:ss a");
		 
			DateFormat dfReg1 = new SimpleDateFormat("dd-MM-yyyy");
			String todaysDate = dfReg1.format(date);
			System.err.println("fr details" + franchiseeList.toString());

			List<AdvanceOrderDetail> advDetailList = new ArrayList<AdvanceOrderDetail>();

			// with Adv order starts
			AdvanceOrderHeader advHeader = new AdvanceOrderHeader();
			advHeader.setAdvanceAmt(advanceAmt);
			advHeader.setCustId(custId);
			advHeader.setDelStatus(0);
			advHeader.setExFloat1(0);
			advHeader.setExFloat2(0);
			advHeader.setExInt1(1);
			advHeader.setExInt2(1);
			advHeader.setExVar1(dateFormat1.format(date));
			advHeader.setExVar2(delTime);
			advHeader.setIsDailyMart(dm);

			advHeader.setFrId(franchiseeList.getFrId());
			advHeader.setOrderDate(todaysDate);
			advHeader.setDeliveryDate(devDate);
			System.err.println("devDate"+devDate);
			Date date1 = new Date();
			Date date2 = new Date();
			try {
				date1 = dfReg1.parse(devDate);
				date2 = dfReg1.parse(todaysDate);
			} catch (Exception e) {

			}

			String x1 = "";
			if (date1.compareTo(date2) == 0) {
				x1 = incrementDate(devDate, 0);

			} else {
				x1 = incrementDate(devDate, -1);

			}
			System.err.println("x1"+x1);
			advHeader.setProdDate(x1);

			advHeader.setIsBillGenerated(0);
			advHeader.setIsSellBillGenerated(0);
			float discAmt = 0.0f;
			float totGrand = 0;
			for (int i = 0; i < orderList.size(); i++) {
				System.out.println("Save orderList.get(i).getItemId() " + orderList.get(i).getItemId() );
				int qty = 0;
				String strQty = null;

				try {

					strQty = request.getParameter("qty" + orderList.get(i).getItemId() + "" + Integer.parseInt(request.getParameter("fr_id")));
					System.err.println("inside det" + qty);
					 
					qty = Integer.parseInt(strQty);

				} catch (Exception e) {
					
					e.printStackTrace();
					strQty = null;
					qty = 0;

				}
				if (qty > 0) {
					AdvanceOrderDetail det = new AdvanceOrderDetail();
					det.setCatId(orderList.get(i).getOrderType());
					det.setDeliveryDate(devDate);
					det.setDelStatus(0);
					if (dm == 1) {
						System.err.println("  adv order with DM");

						det.setDiscPer(orderList.get(i).getIsPositive());
						det.setMrp(Float.parseFloat(String.valueOf(orderList.get(i).getOrderMrp())));
						det.setRate((Float.parseFloat(String.valueOf(orderList.get(i).getOrderMrp()))));
						float calTotal = (Float.parseFloat(String.valueOf(orderList.get(i).getOrderMrp()))) * qty;
						float discountAmount = (calTotal * orderList.get(i).getIsPositive()) / 100;
						discAmt = discAmt + discountAmount;
						float subTotal = calTotal - discountAmount;
						det.setSubTotal(roundUp(subTotal));

					} else {
						System.err.println("  adv order without DM");
						det.setDiscPer(orderList.get(i).getOrderStatus());

						det.setMrp(Float.parseFloat(String.valueOf(orderList.get(i).getOrderRate())));
						det.setRate((Float.parseFloat(String.valueOf(orderList.get(i).getOrderRate()))));
						float calTotal = (Float.parseFloat(String.valueOf(orderList.get(i).getOrderRate()))) * qty;

						int discPer1 = Integer
								.parseInt(request.getParameter("discper" + orderList.get(i).getItemId() + "" + Integer.parseInt(request.getParameter("fr_id"))));
						float discountAmount = (calTotal * discPer1) / 100;
						float subTotal = calTotal - discountAmount;
						discAmt = discAmt + discountAmount;
						det.setSubTotal(roundUp(subTotal));

					}
					det.setEvents("");
					det.setEventsName("");
					det.setExFloat1(0);
					det.setExFloat2(0);
					det.setExInt1(0);
					det.setExInt2(0);
					det.setExVar1("NA");
					det.setExVar2("NA");
					det.setFrId(franchiseeList.getFrId());
					int frGrnTwo = franchiseeList.getGrnTwo();
					if (frGrnTwo == 1) {
						det.setGrnType(franchiseeList.getGrnTwo());
					} else {

						det.setGrnType(2);
					}
					det.setIsBillGenerated(0);
					det.setItemId(Integer.parseInt(orderList.get(i).getItemId()));
					det.setMenuId(menuId);
					det.setOrderDate(todaysDate);
					det.setProdDate(DateConvertor.convertToDMY(x1));
					det.setQty(qty);
					det.setIsBillGenerated(0);
					det.setIsSellBillGenerated(0);
					det.setTax1(0);
					det.setTax1Amt(0);
					det.setTax2(0);
					det.setTax2Amt(0);
					det.setSubCatId(orderList.get(i).getOrderSubType());
					advDetailList.add(det);
					totGrand = totGrand + det.getSubTotal();
				}
			}

			advHeader.setRemainingAmt(totGrand-advanceAmt);
			advHeader.setTotal(totGrand);

			advHeader.setDetailList(advDetailList);
			GenerateBill[] orderListResponse1 = null;

			orderListResponse1 = restTemplate.postForObject(Constants.url + "placeManualAdvanceOrderNew", advHeader,
					GenerateBill[].class);

			List<GenerateBill> tempGenerateBillList = new ArrayList<GenerateBill>(Arrays.asList(orderListResponse1));

			// to save bill
			if (tempGenerateBillList != null) {
				System.err.println("saving bill with Advance"+tempGenerateBillList.toString());

				if (submitbill != null) {

				System.out.println("submitbill" + submitbill);

					PostBillDataCommon postBillDataCommon = new PostBillDataCommon();
					List<PostBillHeader> postBillHeaderList = new ArrayList<PostBillHeader>();
					List<PostBillDetail> postBillDetailsList = new ArrayList<PostBillDetail>();

					PostBillHeader header = new PostBillHeader();
					header.setFrId(frId);

					float sumTaxableAmt = 0, sumTotalTax = 0, sumGrandTotal = 0;
					float sumDiscAmt = 0;
					float orderRate = 0;
					for (int j = 0; j < tempGenerateBillList.size(); j++) {

						GenerateBill gBill = tempGenerateBillList.get(j);

						System.out.println("Inner For frId " + gBill.getFrId());

						System.out.println("If condn true " + gBill.getFrId());

						PostBillDetail billDetail = new PostBillDetail();

						String billQty = "" + tempGenerateBillList.get(j).getOrderQty();
						float discPer = tempGenerateBillList.get(j).getIsPositive();

						// billQty = String.valueOf(gBill.getOrderQty());

						if (dm == 1) {
							orderRate = (float) gBill.getOrderMrp();
						} else {
							orderRate = (float) gBill.getOrderRate();
						}

						Float tax1 = (float) gBill.getItemTax1();
						Float tax2 = (float) gBill.getItemTax2();
						Float tax3 = (float) gBill.getItemTax3();

						Float baseRate = (orderRate * 100) / (100 + (tax1 + tax2));
						baseRate = roundUp(baseRate);

						Float taxableAmt = (float) (baseRate * Integer.parseInt(billQty));

						System.out.println("taxableAmt: " + taxableAmt);
						taxableAmt = roundUp(taxableAmt);

						float sgstRs = (taxableAmt * tax1) / 100;
						float cgstRs = (taxableAmt * tax2) / 100;
						float igstRs = (taxableAmt * tax3) / 100;
						Float totalTax = sgstRs + cgstRs;
						float discAmt1 = 0;
						if (billQty == null || billQty == "") {// new code to handle hidden records
							billQty = "0";
						}

						if (gBill.getIsSameState() == 1) {
							baseRate = (orderRate * 100) / (100 + (tax1 + tax2));
							taxableAmt = (float) (baseRate * Integer.parseInt(billQty));
							// ----------------------------------------------------------
							discAmt1 = ((taxableAmt * discPer) / 100); // new row added
							System.out.println("discAmt: " + discAmt1);// new row added
							sumDiscAmt = sumDiscAmt + discAmt1;

							taxableAmt = taxableAmt - discAmt1; // new row added
							// ----------------------------------------------------------
							sgstRs = (taxableAmt * tax1) / 100;
							cgstRs = (taxableAmt * tax2) / 100;
							igstRs = 0;
							totalTax = sgstRs + cgstRs;

						}

						else {
							baseRate = (orderRate * 100) / (100 + (tax3));
							taxableAmt = (float) (baseRate * Integer.parseInt(billQty));
							// ----------------------------------------------------------
							discAmt1 = ((taxableAmt * discPer) / 100); // new row added
							System.out.println("discAmt: " + discAmt1);// new row added
							sumDiscAmt = sumDiscAmt + discAmt1;

							taxableAmt = taxableAmt - discAmt1; // new row added
							// ----------------------------------------------------------
							sgstRs = 0;
							cgstRs = 0;
							igstRs = (taxableAmt * tax3) / 100;
							totalTax = igstRs;
						}

						sgstRs = roundUp(sgstRs);
						cgstRs = roundUp(cgstRs);
						igstRs = roundUp(igstRs);

						// header.setSgstSum(sumT1);
						// header.setCgstSum(sumT2);
						// header.setIgstSum(sumT3);

						totalTax = roundUp(totalTax);

						Float grandTotal = totalTax + taxableAmt;
						grandTotal = roundUp(grandTotal);

						sumTaxableAmt = sumTaxableAmt + taxableAmt;
						sumTaxableAmt = roundUp(sumTaxableAmt);

						sumTotalTax = sumTotalTax + totalTax;
						sumTotalTax = roundUp(sumTotalTax);

						sumGrandTotal = sumGrandTotal + grandTotal;
						sumGrandTotal = roundUp(sumGrandTotal);

						billDetail.setOrderId(tempGenerateBillList.get(j).getOrderId());
						billDetail.setMenuId(gBill.getMenuId());
						billDetail.setCatId(gBill.getCatId());
						billDetail.setItemId(gBill.getItemId());
						billDetail.setOrderQty(gBill.getOrderQty());
						billDetail.setBillQty(Integer.parseInt(billQty));

						if (dm == 1) {
							billDetail.setMrp((float) gBill.getOrderMrp());
							billDetail.setRate((float) gBill.getOrderMrp());
						} else {
							billDetail.setMrp((float) gBill.getOrderMrp());
							billDetail.setRate((float) gBill.getOrderRate());
						}

						billDetail.setRateType(gBill.getRateType());

						billDetail.setBaseRate(roundUp(baseRate));
						billDetail.setTaxableAmt(roundUp(taxableAmt));
						billDetail.setDiscPer(discPer);// new
						billDetail.setRemark("" + roundUp(discAmt1));// new
						billDetail.setSgstPer(tax1);
						billDetail.setSgstRs(sgstRs);
						billDetail.setCgstPer(tax2);
						billDetail.setCgstRs(cgstRs);
						billDetail.setIgstPer(tax3);
						billDetail.setIgstRs(igstRs);
						billDetail.setTotalTax(totalTax);
						billDetail.setGrandTotal(grandTotal);
						billDetail.setDelStatus(0);
						billDetail.setIsGrngvnApplied(0);
						billDetail.setHsnCode(gBill.getHsnCode());// newly added
						billDetail.setGrnType(gBill.getGrnType());// newly added

						header.setSgstSum(header.getSgstSum() + billDetail.getSgstRs());
						header.setCgstSum(header.getCgstSum() + billDetail.getCgstRs());
						header.setIgstSum(header.getIgstSum() + billDetail.getIgstRs());
						header.setFrId(Integer.parseInt(request.getParameter("fr_id")));

						int itemShelfLife = gBill.getItemShelfLife();

						String deliveryDate = gBill.getDeliveryDate();

						String calculatedDate = incrementDate(deliveryDate, itemShelfLife);

						// inc exp date if these menuId
						if (gBill.getMenuId() == 67 || gBill.getMenuId() == 86 || gBill.getMenuId() == 90) {

							calculatedDate = incrementDate(calculatedDate, 1);

						}

						DateFormat Df = new SimpleDateFormat("dd-MM-yyyy");

						Date expiryDate = null;
						try {
							expiryDate = Df.parse(calculatedDate);
						} catch (ParseException e) {

							e.printStackTrace();
						}

						billDetail.setExpiryDate(expiryDate);
						postBillDetailsList.add(billDetail);
						header.setFrCode(gBill.getFrCode());

						header.setRemark("");
						header.setTaxApplicable((int) (gBill.getItemTax1() + gBill.getItemTax2()));
						
						
						

					}//for end
					
					header.setBillDate(new Date());// hardcoded curr Date
					header.setTaxableAmt(roundUp(sumTaxableAmt));
					header.setGrandTotal(roundUp(sumGrandTotal));
					header.setDiscAmt(roundUp(sumDiscAmt));// new
					header.setFrId(Integer.parseInt(request.getParameter("fr_id")));
					System.err.println("sumof grand total beofre " + sumGrandTotal);

					System.err.println("Math round up Sum " + header.getGrandTotal());
					header.setTotalTax(sumTotalTax);

					header.setStatus(1);
					header.setPostBillDetailsList(postBillDetailsList);

					ZoneId zoneId = ZoneId.of("Asia/Calcutta");
					ZonedDateTime zdt = ZonedDateTime.now(zoneId);

					SimpleDateFormat sdf = new SimpleDateFormat("kk:mm:ss ");
					TimeZone istTimeZone = TimeZone.getTimeZone("Asia/Kolkata");
					Date d = new Date();
					sdf.setTimeZone(istTimeZone);
					String strtime = sdf.format(d);

					DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Calendar cal = Calendar.getInstance();

					header.setRemark(dateFormat.format(cal.getTime()));
					header.setTime(strtime);
					header.setPartyName(partyName);
					header.setPartyGstin(partyGstin);
					header.setPartyAddress(partyAddress);

					header.setBillTime(sdf1.format(calender.getTime()));
					header.setVehNo("-");
					header.setExVarchar1("1");
					header.setExVarchar2("-");
					header.setExVarchar3(billToName);
					header.setExVarchar4(billToGstin);
					header.setExVarchar5(billToAddress);
					postBillHeaderList.add(header);

					postBillDataCommon.setPostBillHeadersList(postBillHeaderList);

					System.out.println("Test data : " + postBillDataCommon.toString());

					PostBillHeader[] respList = restTemplate.postForObject(Constants.url + "insertBillData",
							postBillDataCommon, PostBillHeader[].class);

					List<PostBillHeader> billRespList = new ArrayList<PostBillHeader>(Arrays.asList(respList));

					billNo = billNo + "," + billRespList.get(0).getBillNo();
					System.out.println("Save Res Data " + respList.toString());

				}

			}

		}

		return "redirect:/showManualOrder";
	}

	/*
	 * @RequestMapping(value = "/showManualOrder", method = RequestMethod.GET)
	 * public ModelAndView showManualOrder(HttpServletRequest request,
	 * HttpServletResponse response) {
	 * 
	 * ModelAndView model = new ModelAndView("orders/manualOrder"); try {
	 * RestTemplate restTemplate = new RestTemplate(); franchiseeAndMenuList =
	 * restTemplate.getForObject(Constants.url + "getFranchiseeAndMenu",
	 * FranchiseeAndMenuList.class); orderList=new ArrayList<Orders>();
	 * System.out.println("Franchisee Response " +
	 * franchiseeAndMenuList.getAllFranchisee());
	 * 
	 * model.addObject("allFranchiseeAndMenuList", franchiseeAndMenuList);
	 * 
	 * } catch (Exception e) { System.out.println("Franchisee Controller Exception "
	 * + e.getMessage()); } return model;
	 * 
	 * } // METHOD)-------------------------
	 * 
	 * @RequestMapping(value = "/getMenuForOrder", method = RequestMethod.GET)
	 * public @ResponseBody List<Menu> findAllMenu(@RequestParam(value = "fr_id",
	 * required = true) int frId) {
	 * 
	 * List<Menu> menuList = new ArrayList<Menu>(); List<Menu> confMenuList = new
	 * ArrayList<Menu>(); try { RestTemplate restTemplate = new RestTemplate();
	 * 
	 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
	 * Object>(); map.add("frId", frId); // Calling Service to get Configured Menus
	 * Integer[] configuredMenuId = restTemplate.postForObject(Constants.url +
	 * "getConfiguredMenuId", map, Integer[].class);
	 * 
	 * ArrayList<Integer> configuredMenuList = new
	 * ArrayList<Integer>(Arrays.asList(configuredMenuId));
	 * 
	 * menuList = franchiseeAndMenuList.getAllMenu();
	 * 
	 * for (Menu menu : menuList) { if(menu.getMainCatId()!=5 &&
	 * menu.getMenuId()!=42) { for (int i = 0; i < configuredMenuList.size(); i++) {
	 * if (menu.getMenuId() == configuredMenuList.get(i)) { confMenuList.add(menu);
	 * }
	 * 
	 * } } } System.out.println("configuredMenuList:"+confMenuList.toString()); }
	 * catch (Exception e) { e.printStackTrace(); } return confMenuList; } //
	 * ----------------------------------------END----------------------------------
	 * ----------
	 * 
	 * @RequestMapping(value = "/getItemsOfMenuId", method = RequestMethod.GET)
	 * public @ResponseBody List<CommonConf> commonItemById(@RequestParam(value =
	 * "menuId", required = true) int menuId) {
	 * 
	 * System.out.println("menuId " + menuId);
	 * 
	 * RestTemplate restTemplate = new RestTemplate();
	 * 
	 * List<Menu> menuList = franchiseeAndMenuList.getAllMenu(); Menu frMenu = new
	 * Menu(); for (Menu menu : menuList) { if (menu.getMenuId() == menuId) { frMenu
	 * = menu; break; } } int selectedCatId = frMenu.getMainCatId();
	 * 
	 * System.out.println("Finding Item List for Selected CatId=" + selectedCatId);
	 * 
	 * List<SpecialCake> specialCakeList = new ArrayList<SpecialCake>();
	 * 
	 * List<CommonConf> commonConfList = new ArrayList<CommonConf>();
	 * 
	 * if (selectedCatId == 5) { SpCakeResponse spCakeResponse =
	 * restTemplate.getForObject(Constants.url + "showSpecialCakeList",
	 * SpCakeResponse.class);
	 * System.out.println("SpCake Controller SpCakeList Response " +
	 * spCakeResponse.toString());
	 * 
	 * specialCakeList = spCakeResponse.getSpecialCake();
	 * 
	 * for (SpecialCake specialCake : specialCakeList) { CommonConf commonConf = new
	 * CommonConf(); commonConf.setId(specialCake.getSpId());
	 * commonConf.setName(specialCake.getSpCode() + "-" + specialCake.getSpName());
	 * commonConfList.add(commonConf); System.out.println("spCommonConf" +
	 * commonConf.toString()); }
	 * 
	 * System.out.println("------------------------"); } else {
	 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
	 * Object>(); map.add("itemGrp1", selectedCatId);
	 * 
	 * Item[] item = restTemplate.postForObject(Constants.url + "getItemsByCatId",
	 * map, Item[].class); ArrayList<Item> itemList = new
	 * ArrayList<Item>(Arrays.asList(item)); System.out.println("Filter Item List "
	 * + itemList.toString());
	 * 
	 * for (Item items : itemList) { CommonConf commonConf = new CommonConf();
	 * commonConf.setId(items.getId()); commonConf.setName(items.getItemName());
	 * commonConfList.add(commonConf); System.out.println("itemCommonConf" +
	 * commonConf.toString()); } System.out.println("------------------------"); }
	 * 
	 * return commonConfList; }
	 * 
	 * @RequestMapping(value = "/insertItem", method = RequestMethod.GET)
	 * public @ResponseBody List<Orders> insertItem(HttpServletRequest request,
	 * HttpServletResponse response) {
	 * 
	 * try {
	 * 
	 * int itemId=Integer.parseInt(request.getParameter("itemId"));
	 * System.out.println("itemId"+itemId);
	 * 
	 * int frId=Integer.parseInt(request.getParameter("frId"));
	 * System.out.println("frId"+frId);
	 * 
	 * int menuId=Integer.parseInt(request.getParameter("menuId"));
	 * System.out.println("menuId"+menuId);
	 * 
	 * int qty=Integer.parseInt(request.getParameter("qty"));
	 * System.out.println("qty"+qty);
	 * 
	 * RestTemplate restTemplate = new RestTemplate(); MultiValueMap<String, Object>
	 * map = new LinkedMultiValueMap<String, Object>(); map.add("id", itemId);
	 * 
	 * Item item = restTemplate.postForObject("" + Constants.url + "getItem",
	 * map,Item.class); System.out.println("ItemResponse" + item);
	 * 
	 * map = new LinkedMultiValueMap<String, Object>(); map.add("id", itemId);
	 * map.add("frId", frId); float discPer=restTemplate.postForObject(Constants.url
	 * + "getDiscById", map,Float.class);
	 * 
	 * map = new LinkedMultiValueMap<String, Object>();
	 * 
	 * map.add("frId", frId);
	 * 
	 * FranchiseeList franchiseeList = restTemplate.getForObject(Constants.url +
	 * "getFranchisee?frId={frId}", FranchiseeList.class, frId);
	 * System.out.println("franchiseeList" + franchiseeList.toString());
	 * 
	 * Orders order=new Orders();
	 * 
	 * if(franchiseeList.getFrRateCat()==1) {
	 * order.setOrderRate(item.getItemRate1());
	 * order.setOrderMrp(item.getItemMrp1()); } else
	 * if(franchiseeList.getFrRateCat()==2) {
	 * order.setOrderRate(item.getItemRate2());
	 * order.setOrderMrp(item.getItemMrp2()); } else {
	 * order.setOrderRate(item.getItemRate3());
	 * order.setOrderMrp(item.getItemMrp3()); } int
	 * frGrnTwo=franchiseeList.getGrnTwo();
	 * System.err.println("frGrnTwo"+frGrnTwo+"item.getGrnTwo()"+item.getGrnTwo());
	 * if(item.getGrnTwo()==1) {
	 * 
	 * if(frGrnTwo==1) {
	 * 
	 * order.setGrnType(1);
	 * 
	 * 
	 * }else {
	 * 
	 * order.setGrnType(0); } }//end of if
	 * 
	 * else { if(item.getGrnTwo()==2) { order.setGrnType(2);
	 * 
	 * } else { order.setGrnType(0); } }// end of else
	 * if(menuId==29||menuId==30||menuId==42||menuId==43|| menuId==44||menuId==47) {
	 * 
	 * order.setGrnType(3);
	 * 
	 * } //for push grn if(menuId==48) {
	 * 
	 * order.setGrnType(4); }
	 * 
	 * Date today = new Date(); Date tomorrow = new Date(today.getTime() + (1000 *
	 * 60 * 60 * 24)); java.sql.Date sqlCurrDate = new
	 * java.sql.Date(today.getTime()); java.sql.Date sqlTommDate = new
	 * java.sql.Date(tomorrow.getTime());
	 * 
	 * order.setOrderId(0); order.setItemId(String.valueOf(itemId));
	 * order.setItemName(item.getItemName()+"--["+franchiseeList.getFrCode()+"]");
	 * order.setFrId(frId); if(menuId==44||menuId==45) {
	 * order.setDeliveryDate(sqlCurrDate); }else {
	 * order.setDeliveryDate(sqlTommDate); } order.setIsEdit(0);
	 * order.setEditQty(qty); order.setIsPositive(discPer); order.setMenuId(menuId);
	 * order.setOrderDate(sqlCurrDate); order.setOrderDatetime(""+sqlCurrDate);
	 * order.setUserId(0); order.setOrderQty(qty); order.setOrderStatus(0);
	 * order.setOrderType(item.getItemGrp1());
	 * order.setOrderSubType(item.getItemGrp2());
	 * order.setProductionDate(sqlCurrDate); order.setRefId(itemId);
	 * 
	 * orderList.add(order);
	 * 
	 * System.out.println("orderListinserted:"+orderList.toString());
	 * 
	 * 
	 * } catch (Exception e) { e.printStackTrace(); }
	 * 
	 * return orderList; }
	 * 
	 * @RequestMapping(value = "/deleteItems", method = RequestMethod.GET)
	 * public @ResponseBody List<Orders> deleteItemDetail(HttpServletRequest
	 * request, HttpServletResponse response) { ResponseEntity<String>
	 * orderListResponse=null; try {
	 * 
	 * int index=Integer.parseInt(request.getParameter("key"));
	 * orderList.remove(index);
	 * 
	 * System.out.println("OrderList :"+orderList.toString()); } catch (Exception e)
	 * { e.printStackTrace();
	 * 
	 * } return orderList; }
	 * 
	 * @RequestMapping(value = "/generateManualBill", method = RequestMethod.GET)
	 * public @ResponseBody List<Orders> generateManualBill(HttpServletRequest
	 * request, HttpServletResponse response) {
	 * 
	 * List<Orders> orderListResponse=new ArrayList<>(); try { RestTemplate
	 * restTemplate = new RestTemplate(); if(orderList!=null ||
	 * !orderList.isEmpty()) { orderListResponse =
	 * restTemplate.postForObject(Constants.url + "placeOrder",
	 * orderList,List.class); orderList=new ArrayList<Orders>();
	 * System.out.println("Place Order Response" + orderListResponse.toString()); }
	 * } catch (Exception e) { e.printStackTrace(); } return orderListResponse; }
	 */

	public static float roundUp(float d) {
		return BigDecimal.valueOf(d).setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
	}

	public String incrementDate(String date, int day) {

		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
		Calendar c = Calendar.getInstance();
		try {
			c.setTime(sdf.parse(date));

		} catch (ParseException e) {
			System.out.println("Exception while incrementing date " + e.getMessage());
			e.printStackTrace();
		}
		c.add(Calendar.DATE, day); // number of days to add
		date = sdf.format(c.getTime());

		return date;

	}
	
	@RequestMapping(value = "/saveCustomerFromBill", method = RequestMethod.POST)
	@ResponseBody
	public AddCustemerResponse saveCustomerFromBill(HttpServletRequest request, HttpServletResponse responsel) {
		RestTemplate restTemplate = new RestTemplate();

		AddCustemerResponse info = new AddCustemerResponse();

		try {

			String customerName = request.getParameter("customerName");
			String mobileNo = request.getParameter("mobileNo");
			String dateOfBirth = request.getParameter("dateOfBirth");
			String buisness = request.getParameter("buisness");
			String companyName = request.getParameter("companyName");
			String gstNo = request.getParameter("gstNo");
			String custAdd = request.getParameter("custAdd");
			int custId = Integer.parseInt(request.getParameter("custId"));
			int custType = Integer.parseInt(request.getParameter("custType"));
			String ageRange = request.getParameter("ageRange");
			int gender = Integer.parseInt(request.getParameter("gender"));

			Customer save = new Customer();
			save.setCustName(customerName);
			save.setPhoneNumber(mobileNo);
			save.setIsBuissHead(Integer.parseInt(buisness));
			save.setCustDob(dateOfBirth);
			save.setCompanyName(companyName);
			save.setAddress(custAdd);
			save.setGstNo(gstNo);
			save.setDelStatus(0);
			save.setCustId(custId);
			
			save.setAgeGroup(ageRange);save.setExInt1(custType);save.setGender(gender);
			Customer res = restTemplate.postForObject(Constants.url + "/saveCustomer", save, Customer.class);

			Customer[] customer = restTemplate.getForObject(Constants.url + "/getAllCustomers", Customer[].class);
			List<Customer> customerList = new ArrayList<>(Arrays.asList(customer));

			if (res == null) {

				info.setError(true);
			} else {
				info.setCustomerList(customerList);
				info.setAddCustomerId(res.getCustId());
				info.setError(false);
			}

		} catch (Exception e) {
			e.printStackTrace();
			info.setError(true);
		}
		return info;
	}
	Customer edit = new Customer();

	@RequestMapping(value = "/editCustomerFromBill", method = RequestMethod.POST)
	@ResponseBody
	public Customer editCustomerFromBill(HttpServletRequest request, HttpServletResponse responsel) {
		RestTemplate restTemplate = new RestTemplate();

		edit = new Customer();

		try {

			int custId = Integer.parseInt(request.getParameter("custId"));

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("custId", custId);
			edit = restTemplate.postForObject(Constants.url + "/getCustomerByCustId", map, Customer.class);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return edit;
	}

	@RequestMapping(value = "/submitEditCustomer", method = RequestMethod.POST)
	@ResponseBody
	public AddCustemerResponse submitEditCustomer(HttpServletRequest request, HttpServletResponse responsel) {
		RestTemplate restTemplate = new RestTemplate();

		AddCustemerResponse info = new AddCustemerResponse();

		try {

			String customerName = request.getParameter("customerName");
			String mobileNo = request.getParameter("mobileNo");
			String dateOfBirth = request.getParameter("dateOfBirth");
			int buisness = Integer.parseInt(request.getParameter("buisness"));
			String companyName = request.getParameter("companyName");
			String gstNo = request.getParameter("gstNo");
			String custAdd = request.getParameter("custAdd");

			edit.setCustName(customerName);
			edit.setPhoneNumber(mobileNo);
			edit.setIsBuissHead(buisness);
			edit.setCustDob(dateOfBirth);
			if (buisness == 0) {
				edit.setCompanyName("");
				edit.setAddress("");
				edit.setGstNo("");
			} else {
				edit.setCompanyName(companyName);
				edit.setAddress(custAdd);
				edit.setGstNo(gstNo);
			}

			Customer res = restTemplate.postForObject(Constants.url + "/saveCustomer", edit, Customer.class);

			Customer[] customer = restTemplate.getForObject(Constants.url + "/getAllCustomers", Customer[].class);
			List<Customer> customerList = new ArrayList<>(Arrays.asList(customer));

			if (res == null) {

				info.setError(true);
			} else {
				info.setCustomerList(customerList);
				info.setAddCustomerId(res.getCustId());
				info.setError(false);
			}

		} catch (Exception e) {
			e.printStackTrace();
			info.setError(true);
		}
		return info;
	}
	@RequestMapping(value = "/checkEmailText", method = RequestMethod.GET)
	@ResponseBody
	public int checkEmailText(HttpServletRequest request, HttpServletResponse response) {

		Info info = new Info();
		int res = 0;

		try {

			String phoneNo = request.getParameter("phoneNo");
			System.out.println("Info" + phoneNo);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("phoneNo", phoneNo);
			RestTemplate restTemplate = new RestTemplate();
			info = restTemplate.postForObject(Constants.url + "/checkCustPhone", map, Info.class);
			System.out.println("Info" + info+"info.isError()"+info.getError());
			if (info.getError() == false) {
				res = 0;// exists
				System.out.println("0s" + res);
			} else {
				res = 1;
				System.out.println("1888" + res);
			}

		} catch (Exception e) {
			System.err.println("Exception in checkEmailText : " + e.getMessage());
			e.printStackTrace();
		}

		return res;

	}
}
