package com.ats.adminpanel.controller;

import java.text.SimpleDateFormat;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.commons.DateConvertor;
import com.ats.adminpanel.model.AllFrIdNameList;
import com.ats.adminpanel.model.Info;
import com.ats.adminpanel.model.billing.BillTransaction;
import com.ats.adminpanel.model.billing.Expense;
import com.ats.adminpanel.model.billing.ExpenseTransaction;
import com.ats.adminpanel.model.billing.FrBillHeaderForPrint;
import com.ats.adminpanel.model.billing.GetBillListByFrIdToSettle;
 import com.steadystate.css.ParseException;
import com.sun.corba.se.impl.orbutil.closure.Constant;
  
@Controller
@Scope("session")
public class ExpenseAdminController {
	public AllFrIdNameList allFrIdNameList = new AllFrIdNameList();

	@RequestMapping(value = "/showExpenseList", method = RequestMethod.GET)
	public ModelAndView showExpenseList(HttpServletRequest request, HttpServletResponse response) {
		RestTemplate restTemplate = new RestTemplate();

		ModelAndView model = null;
		HttpSession session = request.getSession();
		String fromDate = "";
		String toDate = "";
		String type = "";
		model = new ModelAndView("Expense/expenseList");

		allFrIdNameList = new AllFrIdNameList();
		allFrIdNameList = restTemplate.getForObject(Constants.url + "getAllFrIdName", AllFrIdNameList.class);

		System.out.println("fr list:" + allFrIdNameList.toString());

		model.addObject("allFrIdNameList", allFrIdNameList.getFrIdNamesList());
		fromDate = request.getParameter("fromDate");
		toDate = request.getParameter("toDate");
		type = request.getParameter("type");
		String instruments = null;
		try {
			String[] typeIds = request.getParameterValues("fr_id");

			System.out.println("mId" + typeIds);

			StringBuilder sb = new StringBuilder();

			for (int i = 0; i < typeIds.length; i++) {
				sb = sb.append(typeIds[i] + ",");
			}
			instruments = sb.toString();
			instruments = instruments.substring(0, instruments.length() - 1);
		} catch (Exception e) {
			instruments = "-1";
		}

		if (fromDate == null && toDate == null) {

			System.err.println("in catch");
			type = "1";
			Date date = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
			fromDate = formatter.format(date);
			toDate = formatter.format(date);

		}

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

		map.add("type", type);
		map.add("fromDate", DateConvertor.convertToYMD(fromDate));
		map.add("toDate", DateConvertor.convertToYMD(toDate));
		map.add("frIdList", instruments);

		Expense[] frSetting = restTemplate.postForObject(Constants.url + "getAllExpense", map, Expense[].class);

		List<Expense> expList = new ArrayList<Expense>(Arrays.asList(frSetting));

		model.addObject("expList", expList);

		System.out.println("Excep list:" + expList.toString());

		model.addObject("fromDate", fromDate);
		model.addObject("toDate", toDate);

		return model;
	}

	@RequestMapping(value = "/getBillListForSettle", method = RequestMethod.GET)
	public @ResponseBody List<GetBillListByFrIdToSettle> getBillListForSettle(HttpServletRequest request,
			HttpServletResponse response) {
		RestTemplate restTemplate = new RestTemplate();

		List<GetBillListByFrIdToSettle> billList=new ArrayList<GetBillListByFrIdToSettle>();
		
		try {
			System.err.println("hii");
			int frId = Integer.parseInt(request.getParameter("frId"));
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frId);
			 

			GetBillListByFrIdToSettle[] frSetting = restTemplate.postForObject(Constants.url + "getBillByFrToSettle", map, GetBillListByFrIdToSettle[].class);

			billList= new ArrayList<GetBillListByFrIdToSettle>(Arrays.asList(frSetting));
			
			System.err.println("bill are"+billList.toString());
	 
		}catch (Exception e) {
			 
		}
		
		return billList;
		
	}
	
	@RequestMapping(value = "/submitRespose", method = RequestMethod.POST)
	public @ResponseBody int postCreamPrepData(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		 int flag=0;
		try {
			  List<ExpenseTransaction> expTransList = new ArrayList<ExpenseTransaction>();
				
			 RestTemplate restTemplate = new RestTemplate();
		 

			 String[] checkedList=request.getParameterValues("chkItem");
			 
			 String frId= (request.getParameter("frId"));
			 String delDate= (request.getParameter("delDate"));
			 String expId= (request.getParameter("expenseId"));
			 System.err.println("head id list "+checkedList.toString());
			 for(int i=0;i<checkedList.length;i++)
			 {
				 
				 System.err.println("head id "+checkedList[i]);
				 int headId=Integer.parseInt(checkedList[i]);
				 String billNo= (request.getParameter("billNo"+headId));
				 float billAmt=Float.parseFloat(request.getParameter("billAmt"+headId));
				 float paidAmt=Float.parseFloat(request.getParameter("paidAmt"+headId));
				 float pendingAmt=Float.parseFloat(request.getParameter("pendingAmt"+headId));
				 String billDate=request.getParameter("billDate"+headId);
				 float settleAmt=Float.parseFloat(request.getParameter("settleAmt"+headId));
				 ExpenseTransaction expTrans = new ExpenseTransaction();
				  
				 if(pendingAmt-settleAmt<=0) {
					 
					 expTrans.setBillClose(1);
				 }else {
					 expTrans.setBillClose(0); 
				 }
				   
					expTrans.setBillAmt(String.valueOf(billAmt));
					expTrans.setBillHeadId(headId);
					expTrans.setBillNo(billNo);
					expTrans.setPaidAmt(String.valueOf(settleAmt));

					expTrans.setDelivarableDate(delDate);
					expTrans.setExpId(Integer.parseInt(expId));
					
					expTrans.setFrId(Integer.parseInt(frId));//req qty set to Production
					expTrans.setExInt4(0);
					expTrans.setExInt2(0);
					expTrans.setExInt1(0);
					expTrans.setExInt3(0);
					expTrans.setExVar1(String.valueOf(pendingAmt-settleAmt));//+prodMixingReqP1.get(i).getMulFactor()
					expTrans.setExVar2("");
					expTrans.setExVar3("");
					expTrans.setExVar4("");
				 
																															// field
					expTransList.add(expTrans);
					
					 
			 }
			 
			 Info errorMessage = restTemplate.postForObject(Constants.url + "/saveExpTransList", expTransList, Info.class);
			if(errorMessage.getError()==false) {
				flag=2;
			}else {
				flag=0;
			}
				
		 }catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
		
	}
	//****************Pending Bill*************************
	@RequestMapping(value = "/showPendingBillList", method = RequestMethod.GET)
	public ModelAndView showPendingBillList(HttpServletRequest request, HttpServletResponse response) {
		RestTemplate restTemplate = new RestTemplate();

		ModelAndView model = null;

		model = new ModelAndView("billing/pendingBillList");

		allFrIdNameList = new AllFrIdNameList();
		allFrIdNameList = restTemplate.getForObject(Constants.url + "getAllFrIdName", AllFrIdNameList.class);

		System.out.println("fr list:" + allFrIdNameList.toString());

		model.addObject("allFrIdNameList", allFrIdNameList.getFrIdNamesList());
		
		String instruments = null;
		try {
			String[] typeIds = request.getParameterValues("fr_id");

			System.out.println("mId" + typeIds);

			StringBuilder sb = new StringBuilder();

			for (int i = 0; i < typeIds.length; i++) {
				sb = sb.append(typeIds[i] + ",");
			}
			instruments = sb.toString();
			instruments = instruments.substring(0, instruments.length() - 1);
		} catch (Exception e) {
			instruments = "-1";
		}
		
		
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
 
		map.add("frIdList", instruments);

		BillTransaction[] frSetting = restTemplate.postForObject(Constants.url + "getBillTransactionByFrId", map, BillTransaction[].class);

		List<BillTransaction> expList = new ArrayList<BillTransaction>(Arrays.asList(frSetting));

		model.addObject("billList", expList);

		System.out.println("Excep list:" + expList.toString());
 
		

		return model;
	}


	@RequestMapping(value = "/closeBill/{id}", method = RequestMethod.GET)
	public String deleteOtherItem(@PathVariable int id,HttpServletRequest request, HttpServletResponse response) {
		 
		try
		{
			RestTemplate rest = new RestTemplate();
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("tranId", id);
 			Info info = rest.postForObject("" + Constants.url + "closeBill", map, Info.class);
			System.out.println(info.toString());

			System.out.println("info " + info);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
 	 
		return "redirect:/showPendingBillList"; 
	}
	
}
