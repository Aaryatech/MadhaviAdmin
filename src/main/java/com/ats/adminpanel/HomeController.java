package com.ats.adminpanel;

import java.io.IOException;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.commons.DateConvertor;
import com.ats.adminpanel.model.AllFrIdNameList;
import com.ats.adminpanel.model.Login;
import com.ats.adminpanel.model.OrderCount;
import com.ats.adminpanel.model.OrderCountsResponse;

import com.ats.adminpanel.model.accessright.ModuleJson;
import com.ats.adminpanel.model.billing.Company;
import com.ats.adminpanel.model.dashboard.GetAdvanceOrderList;
import com.ats.adminpanel.model.dashboard.ItemOrderHis;
import com.ats.adminpanel.model.dashboard.ItemOrderList;
import com.ats.adminpanel.model.login.UserResponse;

/**
 * Handles requests for the application home page.
 */

@Controller
public class HomeController {

	// github testing file changes

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	RestTemplate restTemplate = new RestTemplate();

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView displayLogin(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("login");
		logger.info("/ request mapping.");

		return model;

	}

	@RequestMapping(value = "/homenew", method = RequestMethod.GET)
	public ModelAndView displayHome(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("homenew");
		logger.info("/homenew request mapping.");

		return model;

	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView redirectToLogin(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("login");
		Login login = new Login();
		Constants.mainAct = 0;
		Constants.subAct = 0;
		model.addObject("login", login);
		return model;

	}

	@RequestMapping(value = "/homeold", method = RequestMethod.GET)
	public ModelAndView redirectToOldHome(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("homeold");

		return model;

	}

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("index request mapping.");
		return "index";
	}

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public ModelAndView showLogin(HttpServletRequest request, HttpServletResponse response) {
		logger.info(" /home request mapping.");

		ModelAndView mav = new ModelAndView("home");
		try {

			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

			map.add("cDate", dateFormat.format(new Date()));
			OrderCountsResponse orderCountList = restTemplate.postForObject(Constants.url + "/showOrderCounts", map,
					OrderCountsResponse.class);
			List<OrderCount> orderCounts = new ArrayList<OrderCount>();
			orderCounts = orderCountList.getOrderCount();
			mav.addObject("orderCounts", orderCounts);
			mav.addObject("cDate", dateFormat.format(new Date()));

			System.err.println("menu list" + orderCounts.toString());

			map = new LinkedMultiValueMap<>();

			map.add("cDate", dateFormat.format(new Date()));
			map.add("isBilled", -1);
			GetAdvanceOrderList[] holListArray = restTemplate
					.postForObject(Constants.url + "/advanceOrderHistoryHeaderAdmin", map, GetAdvanceOrderList[].class);

			List<GetAdvanceOrderList> advList = new ArrayList<>(Arrays.asList(holListArray));

			for (int i = 0; i < advList.size(); i++) {
				advList.get(i).setDeliveryDate(DateConvertor.convertToDMY(advList.get(i).getDeliveryDate()));
				advList.get(i).setOrderDate(DateConvertor.convertToDMY(advList.get(i).getOrderDate()));
				advList.get(i).setProdDate(DateConvertor.convertToDMY(advList.get(i).getProdDate()));

			}
			mav.addObject("advList", advList);

		} catch (Exception e) {
			System.out.println("HomeController Home Request Page Exception:  " + e.getMessage());
		}

		return mav;
	}

	@RequestMapping(value = "/searchOrdersCount", method = RequestMethod.POST)
	public ModelAndView searchOrdersCount(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = new ModelAndView("home");

		try {
			String date = request.getParameter("from_datepicker");
			String submit1 = request.getParameter("submit1");

			String submit2 = request.getParameter("submit2");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("cDate", date);
			OrderCountsResponse orderCountList = restTemplate.postForObject(Constants.url + "/showOrderCounts", map,
					OrderCountsResponse.class);
			List<OrderCount> orderCounts = new ArrayList<OrderCount>();
			orderCounts = orderCountList.getOrderCount();
			mav.addObject("orderCounts", orderCounts);
			mav.addObject("cDate", date);

			map = new LinkedMultiValueMap<>();
			String mappingName = "advanceOrderHistoryHeaderAdmin";
			if (submit1 != null) {

				System.err.println("sub 2 null");
				map.add("isBilled", 0);
				map.add("prodDate", date);
			} else if (submit2 != null) {
				System.err.println("else fd td fr");
				map.add("fromDate", request.getParameter("from_date"));
				map.add("toDate", request.getParameter("to_date"));
				map.add("frId", request.getParameter("selectFr"));
				mappingName= new String();
				mappingName = "advOrderHistoryHeaderAdminFdTdFrId";
			} else {
				System.err.println("sub 1 null");
				map.add("prodDate", date);
				map.add("isBilled", -1);
			}
			System.err.println("MAP  " + map + " mappingName" +mappingName);
			GetAdvanceOrderList[] holListArray = restTemplate.postForObject(Constants.url+"/"+mappingName,map,
					GetAdvanceOrderList[].class);

			List<GetAdvanceOrderList> advList = new ArrayList<>(Arrays.asList(holListArray));

			for (int i = 0; i < advList.size(); i++) {
				advList.get(i).setDeliveryDate(DateConvertor.convertToDMY(advList.get(i).getDeliveryDate()));
				advList.get(i).setOrderDate(DateConvertor.convertToDMY(advList.get(i).getOrderDate()));
				advList.get(i).setProdDate(DateConvertor.convertToDMY(advList.get(i).getProdDate()));

			}
			mav.addObject("advList", advList);
			mav.addObject("fromDate", request.getParameter("from_date"));
			mav.addObject("toDate", request.getParameter("to_date"));
			mav.addObject("frId", request.getParameter("selectFr"));
			mav.addObject("frList", allFrIdNameList.getFrIdNamesList());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/getAdvaceOrderDetail", method = RequestMethod.POST)
	public @ResponseBody List<ItemOrderHis> getAdvDetail(HttpServletRequest request, HttpServletResponse response) {

		ItemOrderList itm = new ItemOrderList();

		List<ItemOrderHis> itmList = new ArrayList<ItemOrderHis>();

		try {
			String date = request.getParameter("headId");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

			map.add("headId", date);
			itm = restTemplate.postForObject(Constants.url + "/advanceOrderHistoryDetailForAdmin", map,
					ItemOrderList.class);

			itmList = itm.getItemOrderList();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return itmList;
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		System.out.println("User Logout");

		session.invalidate();
		return "redirect:/";
	}

	@RequestMapping(value = "/AddNewFranchisee", method = RequestMethod.GET)
	public ModelAndView addNewFranchisee(HttpServletRequest request, HttpServletResponse response) {
		logger.info("Home request mapping.");

		ModelAndView mav = new ModelAndView("franchisee/addnewfranchisee");
		return mav;
	}

	public AllFrIdNameList allFrIdNameList = new AllFrIdNameList();

	@RequestMapping("/loginProcess")
	public ModelAndView helloWorld(HttpServletRequest request, HttpServletResponse res) throws IOException {

		String name = request.getParameter("username");
		String password = request.getParameter("userpassword");

		ModelAndView mav = new ModelAndView("login");

		res.setContentType("text/html");
		PrintWriter pw = res.getWriter();
		HttpSession session = request.getSession();

		try {
			System.out.println("Login Process " + name);

			if (name.equalsIgnoreCase("") || password.equalsIgnoreCase("") || name == null || password == null) {

				mav = new ModelAndView("login");
			} else {

				UserResponse userObj = restTemplate.getForObject(
						Constants.url + "/login?username=" + name + "&password=" + password, UserResponse.class);
				try {
					Company company = restTemplate.getForObject(Constants.url + "/getCompany", Company.class);
					Constants.FACTORYNAME = company.getCompName();
					Constants.FACTORYADDRESS = "Address:" + company.getFactAddress() + " ,Phone:"
							+ company.getPhoneNo1();
				} catch (Exception e) {
					e.printStackTrace();
				}
				session.setAttribute("UserDetail", userObj);
				session.setAttribute("userId", userObj.getUser().getId());
				UserResponse userResponse = (UserResponse) session.getAttribute("UserDetail");

				System.out.println("new Field Dept Id = " + userResponse.getUser().getDeptId());

				System.out.println("JSON Response Objet " + userObj.toString());
				String loginResponseMessage = "";

				if (userObj.getErrorMessage().isError() == false) {

					session.setAttribute("userName", name);

					loginResponseMessage = "Login Successful";
					mav.addObject("loginResponseMessage", loginResponseMessage);

					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
					int userId = userObj.getUser().getId();
					map.add("usrId", userId);
					System.out.println("Before web service");
					try {
						ParameterizedTypeReference<List<ModuleJson>> typeRef = new ParameterizedTypeReference<List<ModuleJson>>() {
						};
						ResponseEntity<List<ModuleJson>> responseEntity = restTemplate.exchange(
								Constants.url + "getRoleJson", HttpMethod.POST, new HttpEntity<>(map), typeRef);

						List<ModuleJson> newModuleList = responseEntity.getBody();

						System.err.println("new Module List " + newModuleList.toString());

						session.setAttribute("newModuleList", newModuleList);
						session.setAttribute("sessionModuleId", 0);
						session.setAttribute("sessionSubModuleId", 0);

						// System.out.println("Role Json "+Commons.newModuleList.toString());
					} catch (Exception e) {
						e.printStackTrace();
						System.out.println(e.getMessage());
					}

					mav = new ModelAndView("home");
					map = new LinkedMultiValueMap<String, Object>();
					DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

					map.add("cDate", dateFormat.format(new Date()));
					OrderCountsResponse orderCountList = restTemplate.postForObject(Constants.url + "/showOrderCounts",
							map, OrderCountsResponse.class);
					List<OrderCount> orderCounts = new ArrayList<OrderCount>();
					orderCounts = orderCountList.getOrderCount();
					mav.addObject("orderCounts", orderCounts);
					mav.addObject("cDate", dateFormat.format(new Date()));
					// System.out.println("menu list ==" + orderCounts.toString());
					// System.out.println("order count tile -" + orderCounts.get(0).getMenuTitle());
					// System.out.println("order count -" + orderCounts.get(0).getTotal());

					map = new LinkedMultiValueMap<>();

					map.add("prodDate", dateFormat.format(new Date()));
					map.add("isBilled", -1);
					GetAdvanceOrderList[] holListArray = restTemplate.postForObject(
							Constants.url + "/advanceOrderHistoryHeaderAdmin", map, GetAdvanceOrderList[].class);

					List<GetAdvanceOrderList> advList = new ArrayList<>(Arrays.asList(holListArray));

					for (int i = 0; i < advList.size(); i++) {
						advList.get(i).setDeliveryDate(DateConvertor.convertToDMY(advList.get(i).getDeliveryDate()));
						advList.get(i).setOrderDate(DateConvertor.convertToDMY(advList.get(i).getOrderDate()));
						advList.get(i).setProdDate(DateConvertor.convertToDMY(advList.get(i).getProdDate()));

					}
					mav.addObject("advList", advList);

					allFrIdNameList = new AllFrIdNameList();
					try {

						allFrIdNameList = restTemplate.getForObject(Constants.url + "getAllFrIdName",
								AllFrIdNameList.class);

					} catch (Exception e) {
						System.out.println("Exception in getAllFrIdName" + e.getMessage());
						e.printStackTrace();

					}
					mav.addObject("frList", allFrIdNameList.getFrIdNamesList());
					System.err.println("frList " + allFrIdNameList.getFrIdNamesList().toString());

				} else {

					mav = new ModelAndView("login");

					loginResponseMessage = "Invalid Login Credentials";
					mav.addObject("loginResponseMessage", loginResponseMessage);

					System.out.println("Invalid login credentials");

				}

			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("HomeController Login API Excep:  " + e.getMessage());
		}

		return mav;

	}

	@ExceptionHandler(LoginFailException.class)
	public String redirectToLogin() {
		System.out.println("HomeController Login Fail Excep:");

		return "login";
	}

	@RequestMapping(value = "/showCommingSoon", method = RequestMethod.GET)
	public ModelAndView showCommingSoon(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("commingSoon");
		logger.info("/ request mapping.");

		return model;

	}

	@RequestMapping(value = "/sessionTimeOut", method = RequestMethod.GET)
	public ModelAndView displayLoginAgain(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("login");

		logger.info("/login request mapping.");

		model.addObject("loginResponseMessage", "Session timeout ! Please login again . . .");

		return model;

	}

	@RequestMapping(value = "/setSubModId", method = RequestMethod.GET)
	public @ResponseBody void setSubModId(HttpServletRequest request, HttpServletResponse response) {
		int subModId = Integer.parseInt(request.getParameter("subModId"));
		int modId = Integer.parseInt(request.getParameter("modId"));
		HttpSession session = request.getSession();
		session.setAttribute("sessionModuleId", modId);
		session.setAttribute("sessionSubModuleId", subModId);
		session.removeAttribute("exportExcelList");
	}

}
