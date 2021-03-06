
package com.ats.adminpanel.controller;

import java.io.FileOutputStream;
import java.util.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ats.adminpanel.commons.AccessControll;
import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.commons.VpsImageUpload;
import com.ats.adminpanel.model.ExportToExcel;
import com.ats.adminpanel.model.Info;
import com.ats.adminpanel.model.ItemDepartment;
import com.ats.adminpanel.model.StockItem;
import com.ats.adminpanel.model.TrayType;
import com.ats.adminpanel.model.RawMaterial.ItemDetailList;
import com.ats.adminpanel.model.RawMaterial.RawMaterialUom;
import com.ats.adminpanel.model.accessright.ModuleJson;
import com.ats.adminpanel.model.item.AllItemsListResponse;
import com.ats.adminpanel.model.item.CategoryListResponse;
import com.ats.adminpanel.model.item.FrItemStock;
import com.ats.adminpanel.model.item.FrItemStockConfigureList;
import com.ats.adminpanel.model.item.FrItemStockConfigurePost;
import com.ats.adminpanel.model.item.GetItemSup;
import com.ats.adminpanel.model.item.GetPrevItemStockResponse;
import com.ats.adminpanel.model.item.Item;
import com.ats.adminpanel.model.item.ItemSup;
import com.ats.adminpanel.model.item.ItemSupList;
import com.ats.adminpanel.model.item.MCategoryList;
import com.ats.adminpanel.model.item.StockDetail;
import com.ats.adminpanel.model.item.SubCategory;
import com.ats.adminpanel.model.mastexcel.ItemList;
import com.ats.adminpanel.model.mastexcel.TallyItem;
import com.ats.adminpanel.model.modules.ErrorMessage;

@Controller
public class ItemController {

	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);

	AllItemsListResponse allItemsListResponse;

	public static List<MCategoryList> mCategoryList = null;

	public static CategoryListResponse categoryListResponse;

	public static List<MCategoryList> itemsWithCategoriesList;
	public int settingValue;

	public static List<FrItemStockConfigurePost> frItemStockConfigureList;

	ArrayList<Item> itemList;

	public static List<GetPrevItemStockResponse> getPrevItemStockResponsesList;

	ArrayList<String> tempItemList;
	public int catId = 0;
	int suppId;
	int suppCatId;
	String suppItemName;
	boolean isError = false;
	ArrayList<StockItem> tempStockItemList;

	@RequestMapping(value = "/updateHsnAndPer", method = RequestMethod.GET)
	public ModelAndView updateHsnAndPer(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = null;
		HttpSession session = request.getSession();

		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info view = AccessControll.checkAccess("updateHsnAndPer", "updateHsnAndPer", "1", "0", "0", "0", newModuleList);

		if (view.getError() == true) {

			model = new ModelAndView("accessDenied");

		} else {
			model = new ModelAndView("items/updateHsnPer");
			try {
				RestTemplate restTemplate = new RestTemplate();
				allItemsListResponse = restTemplate.getForObject(Constants.url + "getAllItems",
						AllItemsListResponse.class);

				List<Item> itemsList = new ArrayList<Item>();
				itemsList = allItemsListResponse.getItems();

				categoryListResponse = restTemplate.getForObject(Constants.url + "showAllCategory",
						CategoryListResponse.class);
				mCategoryList = categoryListResponse.getmCategoryList();
				List<MCategoryList> resCatList = new ArrayList<MCategoryList>();
				for (MCategoryList mCat : mCategoryList) {
					if (mCat.getCatId() != 5 && mCat.getCatId() != 6) {
						resCatList.add(mCat);
					}
				}
				model.addObject("itemsList", itemsList);
				model.addObject("mCategoryList", resCatList);
			} catch (Exception e) {
				System.out.println("" + e.getMessage());
			}
		}
		return model;
	}

	@RequestMapping(value = "/updateHsnAndTaxPerc", method = RequestMethod.POST)
	public String updateHsnAndTaxPer(HttpServletRequest request, HttpServletResponse response) {
		try {
			RestTemplate restTemplate = new RestTemplate();

			String[] item = request.getParameterValues("items[]");
			StringBuilder sb = new StringBuilder();
			for (int i = 0; i < item.length; i++) {
				sb = sb.append(item[i] + ",");
			}
			String items = sb.toString();
			items = items.substring(0, items.length() - 1);

			float itemTax1 = Float.parseFloat(request.getParameter("item_tax1"));

			float itemTax2 = Float.parseFloat(request.getParameter("item_tax2"));

			float itemTax3 = Float.parseFloat(request.getParameter("item_tax3"));

			String itemHsncd = request.getParameter("hsn_code");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("items", items);
			map.add("itemHsncd", itemHsncd);
			map.add("itemTax1", itemTax1);
			map.add("itemTax2", itemTax2);
			map.add("itemTax3", itemTax3);

			Info info = restTemplate.postForObject(Constants.url + "updateItemHsnAndPer", map, Info.class);

			System.err.println(info.toString());

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/updateHsnAndPer";
	}
	@RequestMapping(value = "/updateItemRateAndMrp", method = RequestMethod.GET)
	public @ResponseBody Info updateItemRateAndMrp(HttpServletRequest request, HttpServletResponse response) {
		Info info=null;
		try {
			RestTemplate restTemplate = new RestTemplate();
			
			int id = Integer.parseInt(request.getParameter("id"));

			float itemRate1 = Float.parseFloat(request.getParameter("inputRate"));

			float itemMrp1 = Float.parseFloat(request.getParameter("inputMrp"));

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("id", id);
			map.add("rate", itemRate1);
			map.add("mrp", itemMrp1);

			 info = restTemplate.postForObject(Constants.url + "updateItemRateAndMrp", map, Info.class);
			System.err.println(info.toString());

		} catch (Exception e) {
			e.printStackTrace();
		}
		return info;
	}
	@RequestMapping(value = "/addItem", method = RequestMethod.GET)
	public ModelAndView addItem(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = null;
		HttpSession session = request.getSession();

		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info view = AccessControll.checkAccess("addItem", "addItem", "1", "0", "0", "0", newModuleList);

		if (view.getError() == true) {

			model = new ModelAndView("accessDenied");

		} else {

			model = new ModelAndView("items/addnewitem");
			Constants.mainAct = 1;
			Constants.subAct = 4;
			try {

				System.out.println("Add Item Request");

				RestTemplate restTemplate = new RestTemplate();
				
				Item[] item = restTemplate.getForObject(Constants.url + "/getItems", Item[].class); //getItemsByCatId
				ArrayList<Item> itemList = new ArrayList<Item>(Arrays.asList(item));
				logger.info("itemList Found" + itemList.toString());
				model.addObject("itemList", itemList);
				
				// CategoryListResponse
				categoryListResponse = restTemplate.getForObject(Constants.url + "showAllCategory",
						CategoryListResponse.class);
				mCategoryList = new ArrayList<MCategoryList>();
				mCategoryList = categoryListResponse.getmCategoryList();
				System.out.println("Main Cat is  " + categoryListResponse.toString());
				// Integer maxId = restTemplate.getForObject(Constants.url +
				// "getUniqueItemCode", Integer.class);

				// model.addObject("itemId", maxId);
				
				List<ItemDepartment> deptList = restTemplate.getForObject(Constants.url + "/getAllItemDepartment",
						List.class);
				model.addObject("deptList", deptList);
				
				model.addObject("mCategoryList", mCategoryList);
				model.addObject("isError", isError);
				isError = false;

			} catch (Exception e) {
				System.out.println("error in item show sachin" + e.getMessage());
			}
		}
		return model;
	}

	@RequestMapping(value = "/getGroup2ByCatId", method = RequestMethod.GET)
	public @ResponseBody List<SubCategory> subCatById(@RequestParam(value = "catId", required = true) int catId) {
		logger.debug("finding Items for menu " + catId);

		List<SubCategory> subCatList = new ArrayList<SubCategory>();
		System.out.println("CatId" + mCategoryList.size());
		for (int x = 0; x < mCategoryList.size(); x++) {
			System.out.println("mCategoryList.get(x).getCatId(" + mCategoryList.get(x).getCatId());
			if (mCategoryList.get(x).getCatId() == catId) {
				subCatList = mCategoryList.get(x).getSubCategoryList();
			}

		}

		return subCatList;
	}

	@RequestMapping(value = "/showFrItemConfiguration")
	public ModelAndView showFrItemConfiguration(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("Item Request");
		ModelAndView model = new ModelAndView("items/itemConfig");
		Constants.mainAct = 2;
		Constants.subAct = 13;

		try {

			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			String settingKey = "frItemStockType";

			map.add("settingKeyList", settingKey);

			FrItemStockConfigureList settingList = restTemplate.postForObject(Constants.url + "getDeptSettingValue",
					map, FrItemStockConfigureList.class);

			System.out.println("SettingKeyList" + settingList.toString());

			System.out.println("settingValue-------------------------------------------=="
					+ settingList.getFrItemStockConfigure().get(0).getSettingValue());
			settingValue = settingList.getFrItemStockConfigure().get(0).getSettingValue();
			CategoryListResponse itemsWithCategoryResponseList = restTemplate
					.getForObject(Constants.url + "showAllCategory", CategoryListResponse.class);

			itemsWithCategoriesList = itemsWithCategoryResponseList.getmCategoryList();

			// System.out.println("item Id Cat Name --" +
			// itemsWithCategoriesList.toString());

			for (int i = 0; i < itemsWithCategoriesList.size(); i++) {

				// System.out.println("cat id== " + itemsWithCategoriesList.get(i).getCatId());
				if (itemsWithCategoriesList.get(i).getCatId() == 5) {

					itemsWithCategoriesList.remove(i);

				}

			}

			for (int i = 0; i < itemsWithCategoriesList.size(); i++) {

				// System.out.println("cat id== " + itemsWithCategoriesList.get(i).getCatId());
				if (itemsWithCategoriesList.get(i).getCatId() == 6) {

					itemsWithCategoriesList.remove(i);

				}

			}

			model.addObject("settingValue", settingValue);
			model.addObject("ItemIdCategory", itemsWithCategoriesList);
			model.addObject("catId", catId);
			model.addObject("itemList", getPrevItemStockResponsesList);

		} catch (Exception e) {

			System.out.println("Exception in showing fr Item Stock Confi " + e.getMessage());
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/showFrItemConfP")
	public ModelAndView showFrItemConfP(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = null;
		HttpSession session = request.getSession();

		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info view = AccessControll.checkAccess("showAddNewFranchisee", "showAddNewFranchisee", "1", "0", "0", "0",
				newModuleList);

		if (view.getError() == true) {

			model = new ModelAndView("accessDenied");

		} else {
			model = new ModelAndView("items/itemConfP");
			Constants.mainAct = 2;
			Constants.subAct = 13;

			try {

				model.addObject("catId", catId);
				model.addObject("itemList", tempItemList);

			} catch (Exception e) {

				e.printStackTrace();
			}
		}
		return model;
	}

	@RequestMapping(value = "/getItemsbySubCatId", method = RequestMethod.POST)
	public ModelAndView getItemsbySubCatId(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("items/itemConfP");
		try {

			catId = Integer.parseInt(request.getParameter("cat_name"));

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("subCatId", catId);
			map.add("type", 8);
			RestTemplate restTemplate = new RestTemplate();

			StockItem[] item = restTemplate.postForObject(Constants.url + "getStockItemsBySubCatId", map,
					StockItem[].class);

			tempStockItemList = new ArrayList<StockItem>(Arrays.asList(item));

			model.addObject("itemList", tempStockItemList);
			model.addObject("catId", catId);

		} catch (Exception e) {

			System.out.println("exe in item get By CatId frItemConf " + e.getMessage());
			e.printStackTrace();
		}

		return model;

	}

	@RequestMapping(value = "/getItemsbyCatIdProcess", method = RequestMethod.GET)
	public String getItemsbyCatIdProcess(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("items/itemConfig");
		try {

			String catIds = request.getParameter("cat_name");
			if (catIds == null || catIds == "") {
				catId = catId;
			} else {
				catId = Integer.parseInt(catIds);
			}
			System.out.println("cat Id " + catId);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			// MultiValueMap<String, Object> mapItemList = new LinkedMultiValueMap<String,
			// Object>();

			map.add("itemGrp1", catId);

			RestTemplate restTemplate = new RestTemplate();

			//Item[] item = restTemplate.postForObject(Constants.url + "getItemsByCatId", map, Item[].class);
			Item[] item = restTemplate.postForObject(Constants.url + "getStockableItemsByCatId", map, Item[].class);

			ArrayList<Item> tempItemList = new ArrayList<Item>(Arrays.asList(item));

			StringBuilder stringBuilder = new StringBuilder();

			String itemId;

			for (int i = 0; i < tempItemList.size(); i++) {

				itemId = (tempItemList.get(i).getId()) + ",";
				stringBuilder.append(itemId);

			}

			String itemIds = stringBuilder.toString();
			itemIds = itemIds.substring(0, itemIds.length() - 1);

			System.out.println("itemId :" + itemIds);

			map = new LinkedMultiValueMap<String, Object>();

			map.add("itemId", itemIds);

			getPrevItemStockResponsesList = new ArrayList<GetPrevItemStockResponse>();

			ParameterizedTypeReference<List<GetPrevItemStockResponse>> typeRef = new ParameterizedTypeReference<List<GetPrevItemStockResponse>>() {
			};

			ResponseEntity<List<GetPrevItemStockResponse>> responseEntity = restTemplate
					.exchange(Constants.url + "getAllFrItemConfPost", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getPrevItemStockResponsesList = responseEntity.getBody();

			if (getPrevItemStockResponsesList.size() < tempItemList.size()) {

				List<GetPrevItemStockResponse> tempPrevItemStockList = new ArrayList<GetPrevItemStockResponse>();

				for (int i = 0; i < tempItemList.size(); i++) {

					Item tempItem = tempItemList.get(i);

					GetPrevItemStockResponse tempItemStockResponse = new GetPrevItemStockResponse();

					tempItemStockResponse.setItemId(tempItem.getId());
					tempItemStockResponse.setItemName(tempItem.getItemName());

					List<StockDetail> stockDetailsList = new ArrayList<StockDetail>();

					for (int j = 1; j <= settingValue; j++) {

						StockDetail stockDetail = new StockDetail();

						stockDetail.setFrStockId(0);
						stockDetail.setMaxQty(0);
						stockDetail.setMinQty(0);
						stockDetail.setType(j);
						stockDetail.setReorderQty(0);
						stockDetailsList.add(stockDetail);

					}

					tempItemStockResponse.setStockDetails(stockDetailsList);

					for (int j = 0; j < getPrevItemStockResponsesList.size(); j++) {

						if (getPrevItemStockResponsesList.get(j).getItemId() == tempItemList.get(i).getId()) {

							//tempItemStockResponse = getPrevItemStockResponsesList.get(j);
							
							List<StockDetail> details=tempItemStockResponse.getStockDetails();
							
							
							for(int k=0;k<details.size();k++) {
								
								for(int m=0;m<getPrevItemStockResponsesList.get(j).getStockDetails().size();m++) {
									
									if(details.get(k).getType()==getPrevItemStockResponsesList.get(j).getStockDetails().get(m).getType()) {
										
										details.get(k).setFrStockId(getPrevItemStockResponsesList.get(j).getStockDetails().get(m).getFrStockId());
										details.get(k).setMaxQty(getPrevItemStockResponsesList.get(j).getStockDetails().get(m).getMaxQty());
										details.get(k).setMinQty(getPrevItemStockResponsesList.get(j).getStockDetails().get(m).getMinQty());
										details.get(k).setType(getPrevItemStockResponsesList.get(j).getStockDetails().get(m).getType());
										details.get(k).setReorderQty(getPrevItemStockResponsesList.get(j).getStockDetails().get(m).getReorderQty());
										
										break;
									}
									
								}
								
							}
							
						}

					}

					tempPrevItemStockList.add(tempItemStockResponse);

				}

				System.out.println("\n\n ####### Updated Stock List is: " + tempPrevItemStockList.toString());

				getPrevItemStockResponsesList = new ArrayList<GetPrevItemStockResponse>();

				getPrevItemStockResponsesList = tempPrevItemStockList;
			}

			itemList = new ArrayList<Item>(Arrays.asList(item));

			System.out.println(" item Stock response  List " + getPrevItemStockResponsesList.toString());
			System.out.println("item list size= " + getPrevItemStockResponsesList.size());

			model.addObject("catId", catId);
			model.addObject("itemList", getPrevItemStockResponsesList);

		} catch (Exception e) {

			System.out.println("exe in item get By CatId frItemConf " + e.getMessage());
			e.printStackTrace();
		}

		return "redirect:/showFrItemConfiguration";

	}

	@RequestMapping(value = "/frItemStockConfInsert", method = RequestMethod.POST)
	public String frItemStockConfInsert(HttpServletRequest request, HttpServletResponse response) {

		List<FrItemStock> frItemStocksList = new ArrayList<FrItemStock>();
		try {
			RestTemplate rest = new RestTemplate();

			if (tempStockItemList.size() > 0) {

				for (int i = 0; i < tempStockItemList.size(); i++) {

					StockItem stockItemRes = tempStockItemList.get(i);

					String minQty = request.getParameter(stockItemRes.getId() + "min" + i);
					String maxQty = request.getParameter(stockItemRes.getId() + "max" + i);
					String reorderQty = request.getParameter(stockItemRes.getId() + "reorder" + i);
					if (Integer.parseInt(maxQty) > 0) {
						FrItemStock frItemStock = new FrItemStock();
						frItemStock.setFrStockId(stockItemRes.getFrStockId());
						frItemStock.setMinQty(Integer.parseInt(minQty));
						frItemStock.setMaxQty(Integer.parseInt(maxQty));
						frItemStock.setReorderQty(Integer.parseInt(reorderQty));
						frItemStock.setItemId(stockItemRes.getId());
						frItemStock.setType(8);
						frItemStocksList.add(frItemStock);
					}

				}
			}

			System.out.println("Fr item Stock " + frItemStocksList.toString());
			System.out.println("fr item stock size " + frItemStocksList.size());

			ErrorMessage errorResponse = rest.postForObject(Constants.url + "frItemStockPost", frItemStocksList,
					ErrorMessage.class);

		} catch (Exception e) {

			System.out.println("exe in fr Item  stock insert  process  " + e.getMessage());

			e.printStackTrace();
		}

		return "redirect:/showFrItemConfP";

	}

	@RequestMapping(value = "/frItemStockConfigurationProcess", method = RequestMethod.POST)
	public String frItemStockInsertProcess(HttpServletRequest request, HttpServletResponse response) {
		// ModelAndView mav = new ModelAndView("items/itemlist");

		List<FrItemStock> frItemStocksList = new ArrayList<FrItemStock>();

		try {

			RestTemplate rest = new RestTemplate();

			// catId = Integer.parseInt(request.getParameter("cat_name"));

			for (int i = 0; i < getPrevItemStockResponsesList.size(); i++) {

				GetPrevItemStockResponse getPrevItemStockResponse = getPrevItemStockResponsesList.get(i);

				for (int j = 0; j < getPrevItemStockResponse.getStockDetails().size(); j++) {

					FrItemStock frItemStock = new FrItemStock();
					StockDetail stockDetail = getPrevItemStockResponse.getStockDetails().get(j);

					// ${item.itemId}stockId${count.index}

					String frStockId = request.getParameter("" + getPrevItemStockResponse.getItemId() + "stockId" + j);
					String minQty = request.getParameter("" + getPrevItemStockResponse.getItemId() + "min" + j);

					String maxQty = request.getParameter("" + getPrevItemStockResponse.getItemId() + "max" + j);
					String reorderQty = request.getParameter("" + getPrevItemStockResponse.getItemId() + "reorder" + j);

					System.out.println("min Qty = " + minQty);
					System.out.println("max Qty = " + maxQty);
					System.out.println("reorder Qty = " + reorderQty);

					if (!minQty.equalsIgnoreCase("") && minQty != null && !maxQty.equalsIgnoreCase("") && maxQty != null
							&& !reorderQty.equalsIgnoreCase("") && reorderQty != null) {

						if (Integer.parseInt(minQty) != stockDetail.getMinQty()
								|| Integer.parseInt(maxQty) != stockDetail.getMaxQty()
								|| Integer.parseInt(reorderQty) != stockDetail.getReorderQty()) {

							frItemStock.setFrStockId(Integer.parseInt(frStockId));
							frItemStock.setMinQty(Integer.parseInt(minQty));
							
							frItemStock.setMaxQty(Integer.parseInt(minQty));
							frItemStock.setReorderQty(Integer.parseInt(minQty));

							//frItemStock.setMaxQty(Integer.parseInt(maxQty));
							//frItemStock.setReorderQty(Integer.parseInt(reorderQty));

							frItemStock.setItemId(getPrevItemStockResponse.getItemId());
							frItemStock.setType(j + 1);
							frItemStocksList.add(frItemStock);

						}
					}

				}
			}

			System.out.println("Fr item Stock " + frItemStocksList.toString());
			System.out.println("fr item stock size " + frItemStocksList.size());

			ErrorMessage errorResponse = rest.postForObject(Constants.url + "frItemStockPost", frItemStocksList,
					ErrorMessage.class);

		} catch (Exception e) {

			System.out.println("exe in fr Item  stock insert  process  " + e.getMessage());

			e.printStackTrace();
		}

		return "redirect:/getItemsbyCatIdProcess";

	}

	@RequestMapping(value = "/addItemProcess", method = RequestMethod.POST)
	public String addItemProcess(HttpServletRequest request, HttpServletResponse response,
			@RequestParam("item_image") List<MultipartFile> file) {
		ModelAndView mav = new ModelAndView("items/itemlist");
		
		String itemId = request.getParameter("item_id");

		int minQty = Integer.parseInt(request.getParameter("min_qty"));

		String itemName = request.getParameter("item_name");

		String itemGrp1 = request.getParameter("item_grp1");

		String itemGrp2 = request.getParameter("item_grp2");

		String itemGrp3 = request.getParameter("item_grp3");

		double itemRate1 = Double.parseDouble(request.getParameter("item_rate1"));

		int itemRate2 = Integer.parseInt(request.getParameter("item_rate2"));

		double itemRate3 = Double.parseDouble(request.getParameter("item_rate3"));

		double itemMrp1 = Double.parseDouble(request.getParameter("item_mrp1"));

		double itemMrp2 = Double.parseDouble(request.getParameter("item_mrp2"));

		double itemMrp3 = Double.parseDouble(request.getParameter("item_mrp3"));

		// String itemImage = request.getParameter("item_image");

		double itemTax1 = Double.parseDouble(request.getParameter("item_tax1"));

		double itemTax2 = Double.parseDouble(request.getParameter("item_tax2"));

		double itemTax3 = Double.parseDouble(request.getParameter("item_tax3"));

		int itemIsUsed = Integer.parseInt(request.getParameter("is_used"));

		String itemSortId = request.getParameter("item_sort_id");
		System.err.println("SORT ID - "+itemSortId);

		int grnTwo = Integer.parseInt(request.getParameter("grn_two"));

		int itemShelfLife = Integer.parseInt(request.getParameter("item_shelf_life"));
		
		int isSaleable = Integer.parseInt(request.getParameter("isSaleable"));
		
		int isStockable = Integer.parseInt(request.getParameter("isStockable"));
		
		int isFactOrFr = Integer.parseInt(request.getParameter("isFactOrFr"));
		
		int isBillable = Integer.parseInt(request.getParameter("isBillable"));
		int isDecimal = Integer.parseInt(request.getParameter("isDecimal"));
		
		String[] billableItem = request.getParameterValues("billable_item");  
		
		String billItems = null;
		if(billableItem!=null) {
		logger.info(" array is" + billableItem[0]);

		StringBuilder sb = new StringBuilder();

		for (int i = 0; i < billableItem.length; i++) {
			sb = sb.append(billableItem[i] + ",");

		}
		billItems = sb.toString();
		billItems = billItems.substring(0, billItems.length() - 1);

		logger.info("Billable Iitems---------" + billItems);
		}else {
			billItems = "";
		}

		VpsImageUpload upload = new VpsImageUpload();

		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");

		Timestamp timestamp = new Timestamp(System.currentTimeMillis());

		String curTimeStamp = sdf.format(cal.getTime());

		
		RestTemplate rest = new RestTemplate();
		try {

			LinkedMultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			String tempFileName;
			FileOutputStream fo;

			tempFileName = curTimeStamp + "-" + file.get(0).getOriginalFilename();
			fo = new FileOutputStream(tempFileName);
			fo.write(file.get(0).getBytes());
			fo.close();
			map.add("file", new FileSystemResource(tempFileName));
			map.add("imageName", tempFileName);
			map.add("type", "item");
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.MULTIPART_FORM_DATA);

			HttpEntity<LinkedMultiValueMap<String, Object>> requestEntity = new HttpEntity<>(map, headers);
			Info infoRes = rest.postForObject(Constants.url + "/photoUpload", requestEntity, Info.class);

		} catch (Exception e) {
			e.printStackTrace();
		}

		MultiValueMap<String, Object> map  = new LinkedMultiValueMap<String, Object>();

		map.add("itemId", itemId);
		map.add("itemName", itemName);
		map.add("itemGrp1", itemGrp1);
		map.add("itemGrp2", itemGrp2);
		map.add("itemGrp3", itemGrp3);
		map.add("minQty", minQty);
		map.add("itemRate1", itemRate1);
		map.add("itemRate2", itemRate2);
		map.add("itemRate3", itemRate3);
		map.add("itemMrp1", itemMrp1);
		map.add("itemMrp2", itemMrp2);
		map.add("itemMrp3", itemMrp3);
		map.add("itemImage", curTimeStamp + "-" + file.get(0).getOriginalFilename());
		map.add("itemTax1", itemTax1);
		map.add("itemTax2", itemTax2);
		map.add("itemTax3", itemTax3);
		map.add("itemIsUsed", itemIsUsed);

		map.add("itemSortId", itemSortId);
		map.add("grnTwo", grnTwo);
		map.add("itemShelfLife", itemShelfLife);
		map.add("isSaleable", isSaleable);
		map.add("isStockable", isStockable);
		map.add("isFactOrFr", isFactOrFr);
		map.add("isBillable", isBillable);
		map.add("isDecimal", isDecimal);
		map.add("billItems", billItems);
		
		System.err.println("ID - "+itemId);
		System.err.println("itemName - "+itemName);
		System.err.println("itemGrp1 - "+itemGrp1);
		System.err.println("itemGrp2 - "+itemGrp2);
		System.err.println("itemGrp3 - "+itemGrp3);
		System.err.println("minQty - "+minQty);
		System.err.println("itemRate1 - "+itemRate1);
		System.err.println("itemRate2 - "+itemRate2);
		System.err.println("itemRate3 - "+itemRate3);
		System.err.println("itemMrp1 - "+itemMrp1);
		System.err.println("itemMrp2 - "+itemMrp2);
		System.err.println("itemMrp3 - "+itemMrp3);
		System.err.println("itemTax1 - "+itemTax1);
		System.err.println("itemTax2 - "+itemTax2);
		System.err.println("itemTax3 - "+itemTax3);
		System.err.println("itemIsUsed - "+itemIsUsed);
		System.err.println("itemSortId - "+itemSortId);
		System.err.println("grnTwo - "+grnTwo);
		System.err.println("itemShelfLife - "+itemShelfLife);
		System.err.println("isSaleable - "+isSaleable);
		System.err.println("isStockable - "+isStockable);
		System.err.println("isFactOrFr - "+isFactOrFr);
		System.err.println("isBillable - "+isBillable);
		System.err.println("isDecimal - "+isDecimal);
		System.err.println("billItems - "+billItems);
		
		try {
			Item itemRes = rest.postForObject("" + Constants.url + "insertItem", map, Item.class);
			
			if (itemRes != null) {
				isError = false;

				suppId = itemRes.getId();
				logger.info("Item Id -----------------"+suppId);
				
				int ans =  itemRes.getExtInt1();
				logger.info("Ext Int1 -----------------"+ans);
				
				if(ans==1) {				
					MultiValueMap<String, Object> mavp = new LinkedMultiValueMap<String, Object>();

					mavp.add("itmId", suppId);
					Info var = rest.postForObject("" + Constants.url + "updtBillableItem", mavp, Info.class);
					logger.info("Response -----------------"+var);
				}
				
				suppCatId = Integer.parseInt(itemGrp1);
				suppItemName = itemRes.getItemName();
				return "redirect:/showAddItemSup";
			} else {
				isError = true;
				return "redirect:/addItem";
			}

		} catch (Exception e) {
			isError = true;
			return "redirect:/addItem";

		}
		//return "redirect:/addItem";

	}

	@RequestMapping(value = "/itemList")
	public ModelAndView showAddItem(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("List Item Request");

		Constants.mainAct = 1;
		Constants.subAct = 5;

		ModelAndView mav = null;
		HttpSession session = request.getSession();

		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info view = AccessControll.checkAccess("itemList", "itemList", "1", "0", "0", "0", newModuleList);

		if (view.getError() == true) {

			mav = new ModelAndView("accessDenied");

		} else {

			mav = new ModelAndView("items/itemlist");
			RestTemplate restTemplate = new RestTemplate();
			// CategoryListResponse
			categoryListResponse = restTemplate.getForObject(Constants.url + "showAllCategory",
					CategoryListResponse.class);
			List<MCategoryList> mCategoryList = new ArrayList<MCategoryList>();
			mCategoryList = categoryListResponse.getmCategoryList();

			mav.addObject("mCategoryList", mCategoryList);
			try {

				// RestTemplate restTemplate = new RestTemplate();
				allItemsListResponse = restTemplate.getForObject(Constants.url + "getAllItems",
						AllItemsListResponse.class);

				List<Item> itemsList = new ArrayList<Item>();
				itemsList = allItemsListResponse.getItems();
				System.out.println("LIst of items" + itemsList.toString());

				mav.addObject("mCategoryList", mCategoryList);
				mav.addObject("itemsList", itemsList);
				mav.addObject("url", Constants.ITEM_IMAGE_URL);

				// exportToExcel

				ItemList itemResponse = restTemplate.getForObject(Constants.url + "tally/getAllExcelItems",
						ItemList.class);

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr. No.");
				rowData.add("Id");
				rowData.add("Item Code");
				rowData.add("Item Name");
				rowData.add("Category");
				rowData.add("Group1");
				rowData.add("Group2");
				rowData.add("HsnCode");
				rowData.add("UOM");
				rowData.add("Rate1");
				rowData.add("Rate2");
				rowData.add("Rate3");
				rowData.add("Mrp1");
				rowData.add("Mrp2");
				rowData.add("Mrp3");
				rowData.add("Sgst %");
				rowData.add("Cgst %");
				rowData.add("Igst %");
				rowData.add("Cess %");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				List<TallyItem> excelItems = itemResponse.getItemList();
				for (int i = 0; i < excelItems.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					rowData.add("" + (i + 1));
					rowData.add("" + excelItems.get(i).getId());
					rowData.add(excelItems.get(i).getItemCode());
					rowData.add(excelItems.get(i).getItemName());
					rowData.add(excelItems.get(i).getItemGroup());
					rowData.add(excelItems.get(i).getSubGroup());
					rowData.add(excelItems.get(i).getSubSubGroup());
					rowData.add(excelItems.get(i).getHsnCode());

					rowData.add(excelItems.get(i).getUom());
					rowData.add("" + excelItems.get(i).getItemRate1());
					rowData.add("" + excelItems.get(i).getItemRate2());
					rowData.add("" + excelItems.get(i).getItemRate3());
					rowData.add("" + excelItems.get(i).getItemRate1());
					rowData.add("" + excelItems.get(i).getItemRate2());
					rowData.add("" + excelItems.get(i).getItemRate3());
					rowData.add("" + excelItems.get(i).getSgstPer());
					rowData.add("" + excelItems.get(i).getCgstPer());
					rowData.add("" + excelItems.get(i).getIgstPer());
					rowData.add("" + excelItems.get(i).getCessPer());

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

				}

				session = request.getSession();
				session.setAttribute("exportExcelList", exportToExcelList);
				session.setAttribute("excelName", "itemsList");

				List<ExportToExcel> exportExcelListDummy = new ArrayList<ExportToExcel>();

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();

				rowData.add("Item Id");
				rowData.add("Item Name");
				rowData.add("ItemGroup");
				rowData.add("SubGroup");
				rowData.add("SubSubGroup");
				rowData.add("Rate1");
				rowData.add("Rate2");
				rowData.add("Rate3");
				rowData.add("Mrp1");
				rowData.add("Mrp2");
				rowData.add("Mrp3");
				rowData.add("Sgst %");
				rowData.add("Cgst %");
				rowData.add("Igst %");
				rowData.add("Sort Id");
				rowData.add("Is Grn2 App?(1/0)");
				rowData.add("Min Qty");
				rowData.add("Item Shelf Life");

				expoExcel.setRowData(rowData);
				exportExcelListDummy.add(expoExcel);

				session.setAttribute("exportExcelListDummy", exportExcelListDummy);
				session.setAttribute("excelName", "ItemExcelImportFormat");

			} catch (Exception e) {
				System.out.println("exce in listing filtered group itme" + e.getMessage());
			}
		}
		return mav;

	}

	@RequestMapping(value = "/uploadItemsByFile", method = RequestMethod.POST)
	public String uploadItemsByFile(Model model, @RequestParam("file") MultipartFile excelfile,
			HttpServletRequest request, HttpServletResponse response) {

		try {

			System.out.println("Excel File name " + excelfile.getOriginalFilename());

			// Creates a workbook object from the uploaded excelfile
			XSSFWorkbook workbook = new XSSFWorkbook(excelfile.getInputStream());
			// Creates a worksheet object representing the first sheet
			XSSFSheet worksheet = workbook.getSheetAt(0);
			// Reads the data in excel file until last row is encountered

			List<Item> itemListRes = new ArrayList<Item>();

			System.out.println("Last Row Number is " + worksheet.getLastRowNum());

			for (int i = 1; i <= worksheet.getLastRowNum(); i++) {
				// Creates an object for the UserInfo Model

				Item item = new Item();

				// Creates an object representing a single row in excel
				XSSFRow row = worksheet.getRow(i);

				// System.err.println("row = " +row.toString());
				// Sets the Read data to the model class
				// user.setId((int) row.getCell(0).getNumericCellValue());
				try {
					item.setId(0);

					item.setItemId(getCellValueAsString(row.getCell(0)));

					item.setItemName(getCellValueAsString(row.getCell(1)));

					item.setItemGrp1(Integer.parseInt(getCellValueAsString(row.getCell(2))));

					item.setItemGrp2(Integer.parseInt(getCellValueAsString(row.getCell(3))));

					item.setItemGrp3(Integer.parseInt(getCellValueAsString(row.getCell(4))));

					item.setItemRate1(Float.parseFloat(getCellValueAsString(row.getCell(5))));

					item.setItemRate2(Float.parseFloat(getCellValueAsString(row.getCell(6))));

					item.setItemRate3(Float.parseFloat(getCellValueAsString(row.getCell(7))));

					item.setItemMrp1(Float.parseFloat(getCellValueAsString(row.getCell(8))));

					item.setItemMrp2(Float.parseFloat(getCellValueAsString(row.getCell(9))));

					item.setItemMrp3(Float.parseFloat(getCellValueAsString(row.getCell(10))));

					item.setItemTax1(Float.parseFloat(getCellValueAsString(row.getCell(11))));

					item.setItemTax2(Float.parseFloat(getCellValueAsString(row.getCell(12))));

					item.setItemTax3(Float.parseFloat(getCellValueAsString(row.getCell(13))));

					item.setItemSortId(Float.parseFloat(getCellValueAsString(row.getCell(14))));

					item.setGrnTwo(Integer.parseInt(getCellValueAsString(row.getCell(15))));
					item.setMinQty(Integer.parseInt(getCellValueAsString(row.getCell(16))));

					item.setShelfLife(Integer.parseInt(getCellValueAsString(row.getCell(17))));
					item.setDelStatus(0);
					item.setItemImage("");

					itemListRes.add(item);
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
			workbook.close();

			// userService.addListUser(lstUser);

			// model.addAttribute("bean", bean);

			System.out.println("Excel File Arraylist " + itemListRes.toString());
			System.out.println("Excel File Arraylist Size: " + itemListRes.size());

			RestTemplate rest = new RestTemplate();
			List<Item> info = rest.postForObject(Constants.url + "/insertItemList", itemListRes, List.class);
			System.out.println("Response " + info.toString());

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/itemList";

	}

	public static String getCellValueAsString(Cell cell) {
		String strCellValue = null;
		if (cell != null) {
			switch (cell.getCellType()) {
			case Cell.CELL_TYPE_STRING:
				strCellValue = cell.toString();
				break;
			case Cell.CELL_TYPE_NUMERIC:
				if (DateUtil.isCellDateFormatted(cell)) {
					SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
					strCellValue = dateFormat.format(cell.getDateCellValue());
				} else {
					Double value = cell.getNumericCellValue();
					Long longValue = value.longValue();
					strCellValue = new String(longValue.toString());
				}
				break;
			case Cell.CELL_TYPE_BOOLEAN:
				strCellValue = new String(new Boolean(cell.getBooleanCellValue()).toString());
				break;
			case Cell.CELL_TYPE_BLANK:
				strCellValue = "";
				break;
			}
		}
		return strCellValue;
	}

	@RequestMapping(value = "/searchItem")
	public ModelAndView showSearchItem(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("List Item Request");

		int catId = Integer.parseInt(request.getParameter("catId"));
		ModelAndView mav = new ModelAndView("items/itemlist");

		RestTemplate restTemplate = new RestTemplate();
		categoryListResponse = restTemplate.getForObject(Constants.url + "showAllCategory", CategoryListResponse.class);
		// mCategoryList = new ArrayList<MCategoryList>();
		List<MCategoryList> mCategoryList = categoryListResponse.getmCategoryList();

		try {

			List<Item> tempItemsList = new ArrayList<Item>();
			List<Item> itemsList = new ArrayList<Item>();
			itemsList = allItemsListResponse.getItems();

			System.out.println("item count before" + itemsList.size());

			System.out.println("item to show m cat is " + catId);
			for (int i = 0; i < itemsList.size(); i++) {

				if (itemsList.get(i).getItemGrp1() == catId) {
					tempItemsList.add(itemsList.get(i));

				}

			}

			System.out.println("after filter itemList " + tempItemsList.toString());

			mav.addObject("catId", catId);
			mav.addObject("mCategoryList", mCategoryList);
			mav.addObject("itemsList", tempItemsList);

			mav.addObject("url", Constants.ITEM_IMAGE_URL);
		} catch (Exception e) {
			System.out.println("exce in listing filtered group itme" + e.getMessage());
		}

		return mav;

	}

	@RequestMapping(value = "/deleteItem/{idList}", method = RequestMethod.GET)
	public String deleteItem(@PathVariable String[] idList) {

		// String id=request.getParameter("id");
		try {
			ModelAndView mav = new ModelAndView("items/itemList");

			RestTemplate rest = new RestTemplate();

			String strItemIds = new String();
			for (int i = 0; i < idList.length; i++) {
				strItemIds = strItemIds + "," + idList[i];
			}
			strItemIds = strItemIds.substring(1);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("id", strItemIds);

			ErrorMessage errorResponse = rest.postForObject("" + Constants.url + "deleteItem", map, ErrorMessage.class);
			System.out.println(errorResponse.toString());

			Info info = rest.postForObject("" + Constants.url + "deleteItemSup", map, Info.class);
			System.out.println(info.toString());

			if (errorResponse.getError()) {
				return "redirect:/itemList";

			} else {
				return "redirect:/itemList";

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/itemList";
	}

	@RequestMapping(value = "/inactiveItem/{idList}", method = RequestMethod.GET)
	public String inactiveItem(@PathVariable String[] idList) {

		// String id=request.getParameter("id");
		try {
			ModelAndView mav = new ModelAndView("items/itemList");

			RestTemplate rest = new RestTemplate();

			String strItemIds = new String();
			for (int i = 0; i < idList.length; i++) {
				strItemIds = strItemIds + "," + idList[i];
			}
			strItemIds = strItemIds.substring(1);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("id", strItemIds);

			ErrorMessage errorResponse = rest.postForObject("" + Constants.url + "inactivateItems", map,
					ErrorMessage.class);
			System.out.println(errorResponse.toString());

			if (errorResponse.getError()) {
				return "redirect:/itemList";

			} else {
				return "redirect:/itemList";

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/itemList";
	}
	
	
	@RequestMapping(value = "/activeItem/{idList}", method = RequestMethod.GET)
	public String activeItem(@PathVariable String[] idList) {

		// String id=request.getParameter("id");
		try {
			ModelAndView mav = new ModelAndView("items/itemList");

			RestTemplate rest = new RestTemplate();

			String strItemIds = new String();
			for (int i = 0; i < idList.length; i++) {
				strItemIds = strItemIds + "," + idList[i];
			}
			strItemIds = strItemIds.substring(1);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("id", strItemIds);

			ErrorMessage errorResponse = rest.postForObject("" + Constants.url + "activateItems", map,
					ErrorMessage.class);
			System.out.println(errorResponse.toString());

			if (errorResponse.getError()) {
				return "redirect:/itemList";

			} else {
				return "redirect:/itemList";

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/itemList";
	}

	@RequestMapping(value = "/updateItem/{id}", method = RequestMethod.GET)
	public ModelAndView updateMessage(@PathVariable int id) {
		ModelAndView mav = new ModelAndView("items/editItem");

		RestTemplate restTemplate = new RestTemplate();
		// CategoryListResponse
		categoryListResponse = restTemplate.getForObject(Constants.url + "showAllCategory", CategoryListResponse.class);
		mCategoryList = new ArrayList<MCategoryList>();
		mCategoryList = categoryListResponse.getmCategoryList();

		Item[] itemListResp = restTemplate.getForObject(Constants.url + "/getItems", Item[].class); //getItemsByCatId
		ArrayList<Item> itemListRespList = new ArrayList<Item>(Arrays.asList(itemListResp));
		logger.info("itemList Found" + itemListRespList.toString());
		mav.addObject("itemList", itemListRespList);
		
		List<ItemDepartment> deptList = restTemplate.getForObject(Constants.url + "/getAllItemDepartment",
				List.class);
		mav.addObject("deptList", deptList);
		
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		map.add("id", id);

		Item item = restTemplate.postForObject("" + Constants.url + "getItem", map, Item.class);
		System.out.println("ItemResponse" + item);
		// String grp1 = item.getItemGrp1();
		mav.addObject("grp1", item.getItemGrp1());

		// String grp2 = item.getItemGrp2();
		// System.out.println("GrP 2=#### " + grp2);
		// mav.addObject(" grp2 id",grp2);

		mav.addObject("mCategoryList", mCategoryList);

		List<SubCategory> subCategoryList = new ArrayList<SubCategory>();

		for (int i = 0; i < mCategoryList.size(); i++) {
			if (item.getItemGrp1() == (mCategoryList.get(i).getCatId()))
				subCategoryList = mCategoryList.get(i).getSubCategoryList();

		}

		String selectedItem = "";
		int selectedItemId = 0;
		System.out.println("sub cat list is =" + subCategoryList.toString());
		for (int i = 0; i < subCategoryList.size(); i++) {

			if (subCategoryList.get(i).getSubCatId() == item.getItemGrp2()) {

				selectedItem = subCategoryList.get(i).getSubCatName();
				selectedItemId = subCategoryList.get(i).getSubCatId();

				subCategoryList.remove(i);

			}

		}
		System.out.println("Removed item $$$$$ " + selectedItem);

		mav.addObject("selectedItem", selectedItem);
		mav.addObject("selectedItemId", String.valueOf(selectedItemId));
		mav.addObject("subCategoryList", subCategoryList);

		int grn2app = item.getGrnTwo();
		String strGrnAppl = String.valueOf(grn2app);
		mav.addObject("strGrnAppl", strGrnAppl);

		int isUsed = item.getItemIsUsed();
		String strIsUsed = String.valueOf(isUsed);
		mav.addObject("strIsUsed", strIsUsed);

		mav.addObject("item", item);
		mav.addObject("url", Constants.ITEM_IMAGE_URL);

		int itemGrp3 = item.getItemGrp3();
		mav.addObject("itemGrp3", String.valueOf(itemGrp3));

		return mav;

	}

	@RequestMapping(value = "/updateItem/updateItemProcess", method = RequestMethod.POST)

	public String updateMessage(HttpServletRequest request, HttpServletResponse response,
			@RequestParam("item_image") List<MultipartFile> file) {
		System.out.println("HI");

		ModelAndView model = new ModelAndView("items/itemList");

		RestTemplate restTemplate = new RestTemplate();
		String itemId = request.getParameter("item_id");

		int minQty = Integer.parseInt(request.getParameter("min_qty"));

		String itemName = request.getParameter("item_name");

		String itemGrp1 = request.getParameter("item_grp1");

		String itemGrp2 = request.getParameter("item_grp2");

		String itemGrp3 = request.getParameter("item_grp3");

		double itemRate1 = Double.parseDouble(request.getParameter("item_rate1"));

		double itemRate2 = Double.parseDouble(request.getParameter("item_rate2"));

		double itemRate3 = Double.parseDouble(request.getParameter("item_rate3"));

		double itemMrp1 = Double.parseDouble(request.getParameter("item_mrp1"));

		double itemMrp2 = Double.parseDouble(request.getParameter("item_mrp2"));

		double itemMrp3 = Double.parseDouble(request.getParameter("item_mrp3"));

		/*
		 * String itemImage = request.getParameter("item_image");
		 */
		double itemTax1 = Double.parseDouble(request.getParameter("item_tax1"));

		double itemTax2 = Double.parseDouble(request.getParameter("item_tax2"));

		double itemTax3 = Double.parseDouble(request.getParameter("item_tax3"));

		int itemIsUsed = Integer.parseInt(request.getParameter("is_used"));

		double itemSortId = Double.parseDouble(request.getParameter("item_sort_id"));

		int grnTwo = Integer.parseInt(request.getParameter("grn_two"));
		int id = Integer.parseInt(request.getParameter("itemId"));
		int shelfLife = Integer.parseInt(request.getParameter("item_shelf_life"));
		
        int isSaleable = Integer.parseInt(request.getParameter("isSaleable"));
		
		int isStockable = Integer.parseInt(request.getParameter("isStockable"));
		int isBillable = Integer.parseInt(request.getParameter("isBillable"));
		
		int isFactOrFr = Integer.parseInt(request.getParameter("isFactOrFr"));
		int isDecimal = Integer.parseInt(request.getParameter("isDecimal"));
		
        String[] billableItem = request.getParameterValues("billable_item");  
		
		String billItems = null;
		if(billableItem!=null) {

		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < billableItem.length; i++) {
			sb = sb.append(billableItem[i] + ",");
		}
		billItems = sb.toString();
		billItems = billItems.substring(0, billItems.length() - 1);
		logger.info("Billable Iitems---------" + billItems);
		
		}else {
			billItems = "";
		}
		
		logger.info("Add new item request mapping.");
		RestTemplate rest = new RestTemplate();
		String itemImage = request.getParameter("prevImage");

		if (!file.get(0).getOriginalFilename().equalsIgnoreCase("")) {
			itemImage = null;

			VpsImageUpload upload = new VpsImageUpload();

			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
			System.out.println(sdf.format(cal.getTime()));

			String curTimeStamp = sdf.format(cal.getTime());
			itemImage = curTimeStamp + "-" + file.get(0).getOriginalFilename();
			/*
			 * try { itemImage = curTimeStamp + "-" + file.get(0).getOriginalFilename();
			 * upload.saveUploadedFiles(file, Constants.ITEM_IMAGE_TYPE, curTimeStamp + "-"
			 * + file.get(0).getOriginalFilename());
			 * System.out.println("upload method called " + file.toString());
			 * 
			 * } catch (IOException e) {
			 * 
			 * System.out.println("Exce in File Upload In Item Update " + e.getMessage());
			 * e.printStackTrace(); }
			 */
			try {
				LinkedMultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				String tempFileName;
				FileOutputStream fo;

				tempFileName = curTimeStamp + "-" + file.get(0).getOriginalFilename();
				fo = new FileOutputStream(tempFileName);
				fo.write(file.get(0).getBytes());
				fo.close();
				map.add("file", new FileSystemResource(tempFileName));
				map.add("imageName", tempFileName);
				map.add("type", "item");
				HttpHeaders headers = new HttpHeaders();
				headers.setContentType(MediaType.MULTIPART_FORM_DATA);

				HttpEntity<LinkedMultiValueMap<String, Object>> requestEntity = new HttpEntity<>(map, headers);
				Info infoRes = rest.postForObject(Constants.url + "/photoUpload", requestEntity, Info.class);

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		map.add("itemId", itemId);
		map.add("itemName", itemName);
		map.add("itemGrp1", itemGrp1);
		map.add("itemGrp2", itemGrp2);
		map.add("itemGrp3", itemGrp3);
		map.add("itemRate1", itemRate1);
		map.add("itemRate2", itemRate2);
		map.add("itemRate3", itemRate3);
		map.add("minQty", minQty);
		map.add("itemMrp1", itemMrp1);
		map.add("itemMrp2", itemMrp2);
		map.add("itemMrp3", itemMrp3);
		map.add("itemImage", itemImage);
		map.add("itemTax1", itemTax1);
		map.add("itemTax2", itemTax2);
		map.add("itemTax3", itemTax3);
		map.add("itemIsUsed", itemIsUsed);
		map.add("itemSortId", itemSortId);
		map.add("grnTwo", grnTwo);
		map.add("id", id);

		map.add("itemShelfLife", shelfLife);
		map.add("isSaleable", isSaleable);
		map.add("isStockable", isStockable);
		map.add("isBillable", isBillable);
		map.add("isDecimal", isDecimal);
		map.add("isFactOrFr", isFactOrFr);
		map.add("billItems", billItems);
		ErrorMessage errorResponse = rest.postForObject("" + Constants.url + "updateItem", map, ErrorMessage.class);

		return "redirect:/itemList";

	}

	@RequestMapping(value = "/showAddItemSup", method = RequestMethod.GET)
	public ModelAndView showAddItemSup(HttpServletRequest request, HttpServletResponse response) {
		Constants.mainAct = 1;
		Constants.subAct = 109;

		ModelAndView model = null;
		HttpSession session = request.getSession();

		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info view = AccessControll.checkAccess("showAddItemSup", "showAddItemSup", "1", "0", "0", "0", newModuleList);

		if (view.getError() == true) {

			model = new ModelAndView("accessDenied");

		} else {
			model = new ModelAndView("items/itemSup");
			try {
				RestTemplate restTemplate = new RestTemplate();

				categoryListResponse = restTemplate.getForObject(Constants.url + "showAllCategory",
						CategoryListResponse.class);
				mCategoryList = categoryListResponse.getmCategoryList();
				List<MCategoryList> resCatList = new ArrayList<MCategoryList>();
				for (MCategoryList mCat : mCategoryList) {
					if (mCat.getCatId() != 5 && mCat.getCatId() != 6) {
						resCatList.add(mCat);
					}
				}
				List<RawMaterialUom> rawMaterialUomList = restTemplate
						.getForObject(Constants.url + "rawMaterial/getRmUom", List.class);
				model.addObject("rmUomList", rawMaterialUomList);
				List<TrayType> trayTypeList = restTemplate.getForObject(Constants.url + "/getTrayTypes", List.class);
				System.out.println("Tray Types:" + trayTypeList.toString());
				model.addObject("trayTypes", trayTypeList);

				model.addObject("mCategoryList", resCatList);
				model.addObject("isEdit", 0);
				model.addObject("suppCatId", suppCatId);
				model.addObject("suppId", suppId);
				model.addObject("suppItemName", suppItemName);
				suppCatId = 0;
				suppId = 0;
				suppItemName = "";
			} catch (Exception e) {
				System.out.println("Excption In /showAddItemSup");
			}
		}
		return model;

	}

	@RequestMapping(value = "/getItemsByCatId", method = RequestMethod.GET)
	public @ResponseBody List<Item> getItemsByCatId(HttpServletRequest request, HttpServletResponse response) {

		ArrayList<Item> itemsList = new ArrayList<Item>();
		try {
			int catId = Integer.parseInt(request.getParameter("cat_id"));
			System.out.println("cat Id " + catId);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("itemGrp1", catId);

			RestTemplate restTemplate = new RestTemplate();

			Item[] item = restTemplate.postForObject(Constants.url + "getItemsByCatIdForSup", map, Item[].class);

			itemsList = new ArrayList<Item>(Arrays.asList(item));

		} catch (Exception e) {
			System.out.println("Exception in /AJAX getItemsByCatId");
		}
		return itemsList;
	}

	@RequestMapping(value = "/showItemSupList", method = RequestMethod.GET)
	public ModelAndView itemSupList(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = null;
		HttpSession session = request.getSession();

		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info view = AccessControll.checkAccess("showItemSupList", "showItemSupList", "1", "0", "0", "0", newModuleList);

		if (view.getError() == true) {

			mav = new ModelAndView("accessDenied");

		} else {

			mav = new ModelAndView("items/itemSupList");
			Constants.mainAct = 1;
			Constants.subAct = 110;

			RestTemplate restTemplate = new RestTemplate();

			try {
				ItemSupList itemSupList = restTemplate.getForObject(Constants.url + "/getItemSupList",
						ItemSupList.class);

				List<TrayType> trayTypeList = restTemplate.getForObject(Constants.url + "/getTrayTypes", List.class);
				System.out.println("Tray Types:" + trayTypeList.toString());
				mav.addObject("trayTypes", trayTypeList);
				mav.addObject("itemsList", itemSupList.getItemSupList());

			} catch (Exception e) {
				System.out.println("Exc In /itemSupList" + e.getMessage());
			}
		}
		return mav;

	}

	// ------------------------------ADD ItemSup
	// Process------------------------------------
	@RequestMapping(value = "/addItemSupProcess", method = RequestMethod.POST)
	public String addItemSupProcess(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("items/itemSup");
		try {

			int id = 0;

			try {
				id = Integer.parseInt(request.getParameter("id"));

			} catch (Exception e) {
				id = 0;
				System.out.println("In Catch of Add ItemSup Process Exc:" + e.getMessage());

			}
			int itemId = Integer.parseInt(request.getParameter("sel_item_id"));

			String itemHsncd = request.getParameter("item_hsncd");

			int uomId = Integer.parseInt(request.getParameter("item_uom"));

			String uom = request.getParameter("uom");

			float actualWeight = Float.parseFloat(request.getParameter("actual_weight"));

			float baseWeight = Float.parseFloat(request.getParameter("base_weight"));

			float inputPerQty = Float.parseFloat(request.getParameter("input_per_qty"));
			int trayType = Integer.parseInt(request.getParameter("tray_type"));

			int noOfItemPerTray = Integer.parseInt(request.getParameter("no_of_item"));

			int isGateSale = Integer.parseInt(request.getParameter("is_gate_sale"));

			int isGateSaleDisc = Integer.parseInt(request.getParameter("is_gate_sale_disc"));

			int isAllowBday = Integer.parseInt(request.getParameter("is_allow_bday"));
			int cutSection = Integer.parseInt(request.getParameter("cut_section"));
			String shortName = request.getParameter("short_name");
			System.err.println("Short Name " + shortName);
			ItemSup itemSup = new ItemSup();
			itemSup.setId(id);
			itemSup.setItemId(itemId);
			itemSup.setUomId(uomId);
			itemSup.setItemUom(uom);
			itemSup.setItemHsncd(itemHsncd);
			itemSup.setIsGateSale(isGateSale);
			itemSup.setActualWeight(actualWeight);
			itemSup.setBaseWeight(baseWeight);
			itemSup.setInputPerQty(inputPerQty);
			itemSup.setIsGateSaleDisc(isGateSaleDisc);
			itemSup.setIsAllowBday(isAllowBday);
			itemSup.setNoOfItemPerTray(noOfItemPerTray);
			itemSup.setTrayType(trayType);
			itemSup.setDelStatus(0);
			itemSup.setIsTallySync(0);
			itemSup.setCutSection(cutSection);
			itemSup.setShortName(shortName);

			RestTemplate restTemplate = new RestTemplate();

			Info info = restTemplate.postForObject(Constants.url + "/saveItemSup", itemSup, Info.class);
			System.out.println("Response: " + info.toString());

			if (info.getError() == true) {

				System.out.println("Error:True" + info.toString());
				return "redirect:/showItemSupList";

			} else {
				return "redirect:/showItemSupList";
			}

		} catch (Exception e) {

			System.out.println("Exception In Add Item Sup Process:" + e.getMessage());

		}

		return "redirect:/showItemSupList";
	}

	// ----------------------------------------END---------------------------------------------------

	@RequestMapping(value = "/updateItemSup/{id}", method = RequestMethod.GET)
	public ModelAndView updateItemSup(@PathVariable("id") int id, HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("items/itemSup");

		RestTemplate restTemplate = new RestTemplate();

		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("id", id);

			GetItemSup itemSupRes = restTemplate.postForObject(Constants.url + "/getItemSup", map, GetItemSup.class);
			System.out.println("itemSupRes" + itemSupRes.toString());
			List<RawMaterialUom> rawMaterialUomList = restTemplate.getForObject(Constants.url + "rawMaterial/getRmUom",
					List.class);
			mav.addObject("rmUomList", rawMaterialUomList);
			List<TrayType> trayTypeList = restTemplate.getForObject(Constants.url + "/getTrayTypes", List.class);

			mav.addObject("trayTypes", trayTypeList);
			mav.addObject("itemSupp", itemSupRes);
			mav.addObject("isEdit", 1);

		} catch (Exception e) {
			System.out.println("Exc In /updateItemSup" + e.getMessage());
		}

		return mav;

	}

	@RequestMapping(value = "/getItemCode", method = RequestMethod.GET)
	public @ResponseBody Info getItemCode(HttpServletRequest request, HttpServletResponse response) {
		String code = "";
		RestTemplate restTemplate = new RestTemplate();
		Info info = new Info();
		try {
			int catId = Integer.parseInt(request.getParameter("item_grp1"));
			int subCatId = Integer.parseInt(request.getParameter("item_grp2"));

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("catId", catId);
			map.add("subCatId", subCatId);

			code = restTemplate.postForObject(Constants.url + "/getItemCode", map, String.class);
			System.err.println(code + "code");
			info.setMessage(code);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return info;
	}
	
	
	
	
	@RequestMapping(value = "/showRecipeList")
	public ModelAndView showRecipeList(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = null;
		HttpSession session = request.getSession();

		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info view = AccessControll.checkAccess("itemList", "itemList", "1", "0", "0", "0", newModuleList);

		if (view.getError() == true) {

			mav = new ModelAndView("accessDenied");

		} else {

			mav = new ModelAndView("items/recipeList");
			RestTemplate restTemplate = new RestTemplate();
			
			try {
				
				int typeId=1;
				try {
					typeId=Integer.parseInt(request.getParameter("typeId"));
				}catch (Exception e) {
					typeId=1;
				}
				
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("type", typeId);

				ItemDetailList itemDetailsList = restTemplate.postForObject(Constants.url + "rawMaterial/getRecipeListByItemAndType", map,
						ItemDetailList.class);

				mav.addObject("type", typeId);
				mav.addObject("itemDetailsList", itemDetailsList.getItemDetailList());

				// exportToExcel

				

			/*	List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr. No.");
				rowData.add("Item Name");
				rowData.add("Raw Material");
				rowData.add("RM Qty");
				rowData.add("No of Pieces/Item");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				List<TallyItem> excelItems = itemResponse.getItemList();
				for (int i = 0; i < excelItems.size(); i++) {
					
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					
					rowData.add("" + (i + 1));
					rowData.add("" + excelItems.get(i).getId());
					rowData.add(excelItems.get(i).getItemCode());
					rowData.add(excelItems.get(i).getItemName());
					rowData.add(excelItems.get(i).getItemGroup());

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

				}

				session = request.getSession();
				session.setAttribute("exportExcelList", exportToExcelList);
				session.setAttribute("excelName", "recipeList");*/

			} catch (Exception e) {
				System.out.println("exce in listing filtered group itme" + e.getMessage());
				e.printStackTrace();
			}
		}
		return mav;

	}
	

}
