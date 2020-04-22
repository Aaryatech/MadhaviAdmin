package com.ats.adminpanel.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.time.Year;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
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
import com.ats.adminpanel.model.AllFrIdName;
import com.ats.adminpanel.model.AllFrIdNameList;
import com.ats.adminpanel.model.BillReceiptHeaderDisplay;
import com.ats.adminpanel.model.Franchisee;
import com.ats.adminpanel.model.Info;
import com.ats.adminpanel.model.billing.BillReceiptDetail;
import com.ats.adminpanel.model.billing.BillReceiptHeader;
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
	
	@RequestMapping(value = "/downloadExpenseAdmin/{id}", method = RequestMethod.GET)
	public String downloadExpense(@PathVariable("id") int id, HttpServletRequest request,
			HttpServletResponse response) throws FileNotFoundException {
	
		RestTemplate restTemplate = new RestTemplate();

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		map.add("expId", id);

		Expense expDoc = restTemplate.postForObject(Constants.url + "getExpenseByExpId", map, Expense.class);		
		
		String EXTERNAL_FILE_PATH = "/opt/apache-tomcat-8.5.37/webapps/uploads/GVN/"; //OPS //Defined in VpsImageUpload
		 //String EXTERNAL_FILE_PATH = "/home/maddy/ats-11/";
		
		//System.out.println("Expense Document-------------"+EXTERNAL_FILE_PATH);
		
		File file = new File(EXTERNAL_FILE_PATH + expDoc.getImgName());
		
		if (file.exists()) {

			//get the mimetype
			String mimeType = URLConnection.guessContentTypeFromName(file.getName());
			if (mimeType == null) {
				//unknown mimetype so set the mimetype to application/octet-stream
				mimeType = "application/octet-stream";
			}

			response.setContentType(mimeType);
			
			response.setHeader("Content-Disposition", String.format("attachment; filename=\"" + file.getName() + "\""));
				
			//response.setHeader("Content-Disposition", String.format("inline; filename=\"" + file.getName() + "\""));	
			
			response.setContentLength((int) file.length());

			InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

			try {
				FileCopyUtils.copy(inputStream, response.getOutputStream());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		
		return "redirect:/showExpenseList";

	}

	//----------------FOR BILL SETTLEMENT-----------------------
	List<GetBillListByFrIdToSettle> tempBillList = new ArrayList<>();
	//----------------FOR BILL SETTLEMENT-----------------------
	
	@RequestMapping(value = "/getBillListForSettle", method = RequestMethod.GET)
	public @ResponseBody List<GetBillListByFrIdToSettle> getBillListForSettle(HttpServletRequest request,
			HttpServletResponse response) {
		RestTemplate restTemplate = new RestTemplate();

		tempBillList.clear();
		List<GetBillListByFrIdToSettle> billList = new ArrayList<GetBillListByFrIdToSettle>();
		

		try {
			System.err.println("hii");
			int frId = Integer.parseInt(request.getParameter("frId"));
			int expId = Integer.parseInt(request.getParameter("expId"));
			double expAmt = Double.parseDouble(request.getParameter("expAmt"));

			System.err.println("EXPID - " + expId + "    EXPAMT - " + expAmt);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frId);

			GetBillListByFrIdToSettle[] frSetting = restTemplate.postForObject(Constants.url + "getBillByFrToSettle",
					map, GetBillListByFrIdToSettle[].class);

			billList = new ArrayList<GetBillListByFrIdToSettle>(Arrays.asList(frSetting));

			System.err.println("BILL_LIST -------------> " + billList);

			if (billList != null) {

				double remAmt = expAmt;

				for (int i = 0; i < billList.size(); i++) {

					GetBillListByFrIdToSettle bill = billList.get(i);

					if (remAmt > 0) {

						if (remAmt > Double.parseDouble(bill.getPendingAmt())) {

							remAmt = remAmt - Double.parseDouble(bill.getPendingAmt());

							double settleAmt = (remAmt - (remAmt - Double.parseDouble(bill.getPendingAmt())));
							double pendingAmt = (Double.parseDouble(bill.getBillAmt()) - settleAmt);

							GetBillListByFrIdToSettle newBill = new GetBillListByFrIdToSettle();
							newBill.setBillTransId(bill.getBillTransId());
							newBill.setBillHeadId(bill.getBillHeadId());
							newBill.setBillNo(bill.getBillNo());
							newBill.setBillAmt(bill.getBillAmt());
							newBill.setPaidAmt(bill.getPaidAmt());
							newBill.setBillDate(bill.getBillDate());
							newBill.setPendingAmt(bill.getPendingAmt());
							newBill.setFrId(bill.getFrId());
							newBill.setFrName(bill.getFrName());
							newBill.setSettleAmt(String.format("%.2f", settleAmt));

							tempBillList.add(newBill);

						} else if (remAmt < Double.parseDouble(bill.getPendingAmt())) {

							GetBillListByFrIdToSettle newBill = new GetBillListByFrIdToSettle();
							newBill.setBillTransId(bill.getBillTransId());
							newBill.setBillHeadId(bill.getBillHeadId());
							newBill.setBillNo(bill.getBillNo());
							newBill.setBillAmt(bill.getBillAmt());
							newBill.setPaidAmt(bill.getPaidAmt());
							newBill.setBillDate(bill.getBillDate());
							newBill.setPendingAmt(bill.getPendingAmt());
							newBill.setFrId(bill.getFrId());
							newBill.setFrName(bill.getFrName());
							newBill.setSettleAmt(String.format("%.2f", remAmt));

							tempBillList.add(newBill);

							remAmt = 0;

						} else {

							GetBillListByFrIdToSettle newBill = new GetBillListByFrIdToSettle();
							newBill.setBillTransId(bill.getBillTransId());
							newBill.setBillHeadId(bill.getBillHeadId());
							newBill.setBillNo(bill.getBillNo());
							newBill.setBillAmt(bill.getBillAmt());
							newBill.setPaidAmt(bill.getPaidAmt());
							newBill.setBillDate(bill.getBillDate());
							newBill.setPendingAmt(bill.getPendingAmt());
							newBill.setFrId(bill.getFrId());
							newBill.setFrName(bill.getFrName());
							newBill.setSettleAmt(String.format("%.2f", remAmt));

							tempBillList.add(newBill);

							remAmt = 0;
						}

					} else {

						GetBillListByFrIdToSettle newBill = new GetBillListByFrIdToSettle();
						newBill.setBillTransId(bill.getBillTransId());
						newBill.setBillHeadId(bill.getBillHeadId());
						newBill.setBillNo(bill.getBillNo());
						newBill.setBillAmt(bill.getBillAmt());
						newBill.setPaidAmt(bill.getPaidAmt());
						newBill.setBillDate(bill.getBillDate());
						newBill.setPendingAmt(bill.getPendingAmt());
						newBill.setFrId(bill.getFrId());
						newBill.setFrName(bill.getFrName());
						newBill.setSettleAmt("0");

						tempBillList.add(newBill);

					}

				}

			}

			System.err.println("bill are" + tempBillList.toString());

		} catch (Exception e) {
			e.printStackTrace();
		}

		return tempBillList;

	}

	@RequestMapping(value = "/submitRespose", method = RequestMethod.POST)
	public @ResponseBody int postCreamPrepData(HttpServletRequest request, HttpServletResponse response)
			throws ParseException {
		int flag = 0;
		try {

			RestTemplate restTemplate = new RestTemplate();

			int expId = Integer.parseInt(request.getParameter("expId"));
			float expAmt = Float.parseFloat(request.getParameter("expAmt"));

			List<BillTransaction> billTransactionList = new ArrayList<>();

			if (tempBillList != null) {

				for (int i = 0; i < tempBillList.size(); i++) {

					float billAmt = Math.round(Float.parseFloat(tempBillList.get(i).getBillAmt()));
					float paidAmt = Math.round(Float.parseFloat(tempBillList.get(i).getPaidAmt())
							+ Float.parseFloat(tempBillList.get(i).getSettleAmt()));
					float pendingAmt = Math.round(Float.parseFloat(tempBillList.get(i).getBillAmt()) - paidAmt);
					float settleAmt = Math.round(Float.parseFloat(tempBillList.get(i).getSettleAmt()));

//					System.err.println("billAmt = " + billAmt + "   paidAmt = " + paidAmt + "     pendingAmt = "
//							+ pendingAmt + "       settleAmt = " + settleAmt);

					if (settleAmt > 0) {

						BillTransaction bt = new BillTransaction();
						bt.setBillTransId(tempBillList.get(i).getBillTransId());
						bt.setBillHeadId(tempBillList.get(i).getBillHeadId());
						bt.setBillAmt(String.valueOf(billAmt));
						bt.setExVar1(String.valueOf(settleAmt));
						bt.setPaidAmt(String.valueOf(paidAmt));
						bt.setPendingAmt(String.valueOf(pendingAmt));
						bt.setExInt1(expId);// expId

						if (pendingAmt == 0) {
							bt.setIsClosed(1);
						} else {
							bt.setIsClosed(0);
						}

						billTransactionList.add(bt);

					}
				}

				Info errorMessage = restTemplate.postForObject(Constants.url + "/updateBillTranscForBillSettlement",
						billTransactionList, Info.class);

				if (errorMessage.getError() == false) {
					flag = 2;
					int frId = 0;
					List<BillReceiptDetail> detailList = new ArrayList<>();

					for (GetBillListByFrIdToSettle bill : tempBillList) {
						if (Float.parseFloat(bill.getSettleAmt()) > 0) {
							BillReceiptDetail detail = new BillReceiptDetail(0, 0, bill.getBillHeadId(),
									bill.getBillNo(), Float.parseFloat(bill.getBillAmt()),
									Float.parseFloat(bill.getSettleAmt()), 0, 0, "", "", 0, 0);
							detailList.add(detail);
							
						}
						frId = bill.getFrId();
					}

					Calendar cal = Calendar.getInstance();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					String date = sdf.format(cal.getTime());

					// Invoice Number
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
					map.add("settingId", 59);
					int val = 0;
					val = restTemplate.postForObject(Constants.url + "/getSettingValueById", map, Integer.class);

					map = new LinkedMultiValueMap<String, Object>();
					map.add("frId", frId);
					Franchisee fr = restTemplate.postForObject(Constants.url + "/getFrById", map, Franchisee.class);

					String invoiceNo = fr.getFrCode() + "" + getCurrYearForInvoice() + "-" + String.format("%05d", val);
					System.err.println("INVOICE - " + invoiceNo);

					BillReceiptHeader header = new BillReceiptHeader(0, invoiceNo, date, frId, expId, expAmt, 0, 0, "",
							"", 0, 0, detailList);

					BillReceiptHeader info = restTemplate.postForObject(Constants.url + "insertBillReceiptData", header,
							BillReceiptHeader.class);

				} else {
					flag = 0;
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;

	}

	public String getCurrYearForInvoice() {

		int year = Year.now().getValue();
		String curStrYear = String.valueOf(year);
		curStrYear = curStrYear.substring(2);

		int preMarchYear = Year.now().getValue() - 1;
		String preMarchStrYear = String.valueOf(preMarchYear);
		preMarchStrYear = preMarchStrYear.substring(2);

		System.out.println("Pre MArch year ===" + preMarchStrYear);

		int nextYear = Year.now().getValue() + 1;
		String nextStrYear = String.valueOf(nextYear);
		nextStrYear = nextStrYear.substring(2);

		System.out.println("Next  year ===" + nextStrYear);

		int postAprilYear = nextYear + 1;
		String postAprilStrYear = String.valueOf(postAprilYear);
		postAprilStrYear = postAprilStrYear.substring(2);

		System.out.println("Post April   year ===" + postAprilStrYear);

		java.util.Date date = new Date();
		Calendar cale = Calendar.getInstance();
		cale.setTime(date);
		int month = cale.get(Calendar.MONTH);

		month = month + 1;

		if (month <= 3) {

			curStrYear = preMarchStrYear + curStrYear;
			System.out.println("Month <= 3::Cur Str Year " + curStrYear);
		} else if (month >= 4) {

			curStrYear = curStrYear + nextStrYear;
			System.out.println("Month >=4::Cur Str Year " + curStrYear);
		}

		return curStrYear;

	}

	// ****************Pending Bill*************************
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

		BillTransaction[] frSetting = restTemplate.postForObject(Constants.url + "getBillTransactionByFrId", map,
				BillTransaction[].class);

		List<BillTransaction> expList = new ArrayList<BillTransaction>(Arrays.asList(frSetting));

		model.addObject("billList", expList);

		System.out.println("Excep list:" + expList.toString());

		return model;
	}

	@RequestMapping(value = "/closeBill/{id}", method = RequestMethod.GET)
	public String deleteOtherItem(@PathVariable int id, HttpServletRequest request, HttpServletResponse response) {

		try {
			RestTemplate rest = new RestTemplate();
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("tranId", id);
			Info info = rest.postForObject("" + Constants.url + "closeBill", map, Info.class);
			System.out.println(info.toString());

			System.out.println("info " + info);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/showPendingBillList";
	}
	
	@RequestMapping(value = "/showBillReceiptList", method = RequestMethod.GET)
	public ModelAndView showBillReceiptList(HttpServletRequest request, HttpServletResponse response) {
		RestTemplate restTemplate = new RestTemplate();

		ModelAndView model = null;
		String fromDate = "";
		String toDate = "";
		model = new ModelAndView("billing/billReceiptList");

		allFrIdNameList = new AllFrIdNameList();
		allFrIdNameList = restTemplate.getForObject(Constants.url + "getAllFrIdName", AllFrIdNameList.class);

		System.out.println("fr list:" + allFrIdNameList.toString());

		model.addObject("allFrIdNameList", allFrIdNameList.getFrIdNamesList());

		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
		fromDate = formatter.format(date);
		toDate = formatter.format(date);
		
		model.addObject("fromDate", fromDate);
		model.addObject("toDate", toDate);

		return model;
	}
	
	
	@RequestMapping(value = "/getFrList", method = RequestMethod.GET)
	public @ResponseBody List<AllFrIdName> getFrList(HttpServletRequest request,
			HttpServletResponse response) {

		List<AllFrIdName> res=allFrIdNameList.getFrIdNamesList();

		return res;

	}
	
	
	@RequestMapping(value = "/getReceiptList", method = RequestMethod.GET)
	public @ResponseBody List<BillReceiptHeaderDisplay> getReceiptList(HttpServletRequest request,
			HttpServletResponse response) {
		RestTemplate restTemplate = new RestTemplate();

		List<BillReceiptHeaderDisplay> res = new ArrayList<BillReceiptHeaderDisplay>();

		try {
			System.err.println("hii");
			
			String fromDate=request.getParameter("fromDate");
			String toDate=request.getParameter("toDate");
			
			String selFrId=request.getParameter("frId");
			selFrId = selFrId.substring(1, selFrId.length() - 1);
			selFrId = selFrId.replaceAll("\"", "");
			
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("fromDate", fromDate);
			map.add("toDate", toDate);
			map.add("frId", selFrId);

			BillReceiptHeaderDisplay[] billList = restTemplate.postForObject(Constants.url + "getBillReceiptList",
					map, BillReceiptHeaderDisplay[].class);

			res = new ArrayList<BillReceiptHeaderDisplay>(Arrays.asList(billList));

			System.err.println("BILL_LIST -------------> " + res);


		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;

	}
	
	
	@RequestMapping(value = "/getBillReceiptDetailList", method = RequestMethod.GET)
	public @ResponseBody List<BillReceiptDetail> getBillReceiptDetailList(HttpServletRequest request,
			HttpServletResponse response) {
		RestTemplate restTemplate = new RestTemplate();

		List<BillReceiptDetail> res = new ArrayList<BillReceiptDetail>();

		try {
			System.err.println("hii");
			
			int headerId=Integer.parseInt(request.getParameter("recId"));
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("headerId", headerId);

			BillReceiptDetail[] billList = restTemplate.postForObject(Constants.url + "getBillReceiptDetailList",
					map, BillReceiptDetail[].class);

			res = new ArrayList<BillReceiptDetail>(Arrays.asList(billList));

			System.err.println("BILL_LIST -------------> " + res);


		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;

	}
	

}
