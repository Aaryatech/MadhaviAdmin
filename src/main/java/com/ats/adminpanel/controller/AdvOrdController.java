package com.ats.adminpanel.controller;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.commons.DateConvertor;
import com.ats.adminpanel.model.Info;
import com.ats.adminpanel.model.dashboard.ItemOrderList;
import com.ats.adminpanel.model.franchisee.AdvanceOrderDetail;
import com.ats.adminpanel.model.franchisee.AdvanceOrderHeader;
import com.ats.adminpanel.model.franchisee.FranchiseeList;

@Controller
public class AdvOrdController {

	@RequestMapping(value = "/editAdvanceOrderSubmit", method = RequestMethod.POST)
	@ResponseBody
	public AdvanceOrderHeader saveAdvanceOrder(HttpServletRequest request, HttpServletResponse response) {
		AdvanceOrderHeader info = null;
		RestTemplate restTemplate = new RestTemplate();

		try {
			int ordHeaderId = Integer.parseInt(request.getParameter("ordHeaderId"));

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("headId", ordHeaderId);
			AdvanceOrderHeader advHeader = restTemplate
					.postForObject(Constants.url + "/advanceOrderHistoryHedaerByHeadId", map, AdvanceOrderHeader.class);

			System.err.println("Header Received " + advHeader.toString());
			int frId = advHeader.getFrId();

			HttpSession session = request.getSession();

			FranchiseeList frDetails = restTemplate.getForObject(Constants.url + "getFranchisee?frId={frId}",
					FranchiseeList.class, frId);

			Date date = new Date(Calendar.getInstance().getTime().getTime());
			DateFormat dateFormat = new SimpleDateFormat("hh:mm:ss a");

			DateFormat dfReg1 = new SimpleDateFormat("dd-MM-yyyy");

			String todaysDate = dfReg1.format(date);

			String devDate = request.getParameter("deliveryDate");
			String prodDate = request.getParameter("prod_date");

			String deliveryTime = new String();
			try {
				deliveryTime = request.getParameter("delTime");
				System.err.println("deliveryTime Sac " +deliveryTime);
			} catch (Exception e) {
				deliveryTime = advHeader.getExVar2();
			}
			System.err.println("devDate" + devDate);
			Date date1 = dfReg1.parse(devDate);
			Date date2 = dfReg1.parse(todaysDate);
			String x1 = "";
			System.err.println(date1.compareTo(date2));
			if (date1.compareTo(date2) == 0) {
				x1 = incrementDate(DateConvertor.convertToYMD(devDate), 0);

			} else {
				x1 = incrementDate(DateConvertor.convertToYMD(devDate), -1);

			}

			int dm = 0;
			int rateCat = frDetails.getFrRateCat();

			dm = advHeader.getIsDailyMart();
			System.err.println("Order date: " + todaysDate);
			System.err.println("Production date: " + x1);
			System.err.println("Delivery date: " + devDate);

			String advanceAmt = request.getParameter("advanceAmt");
			// String remainAmt = request.getParameter("remainAmt");

			advHeader.setAdvanceAmt(Float.parseFloat(advanceAmt));
			String strDelTime = null;
			try {
				strDelTime =deliveryTime;// LocalTime.parse(deliveryTime).format(DateTimeFormatter.ofPattern("h:mm a"));
			} catch (Exception e) {
				strDelTime = advHeader.getExVar2();

			}
			advHeader.setExVar2(strDelTime);

			advHeader.setDeliveryDate(devDate);
			//advHeader.setProdDate(DateConvertor.convertToDMY(x1));
			advHeader.setProdDate(prodDate);//Sac
			
			advHeader.setOrderDate(DateConvertor.convertToDMY(advHeader.getOrderDate()));

			float discAmt = 0.0f;

			List<AdvanceOrderDetail> itmList = new ArrayList<AdvanceOrderDetail>();

			ItemOrderList itm = new ItemOrderList();
			try {

				map = new LinkedMultiValueMap<>();

				map.add("advHeadId", ordHeaderId);
				AdvanceOrderDetail[] detailList = restTemplate.postForObject(Constants.url + "/getAdvOrdDetailByHeadId",
						map, AdvanceOrderDetail[].class);

				itmList = new ArrayList<>(Arrays.asList(detailList));

			} catch (Exception e) {
				e.printStackTrace();
			}

			float grandTotal = 0.0f;
			for (int i = 0; i < itmList.size(); i++) {

				AdvanceOrderDetail det = itmList.get(i);
				String strQty = null;
				int qty = 0;
				String strRate = null;
				String strDiscPer = null;
				float rate = 0.0f;
				float discPer = det.getDiscPer();
				try {

					strQty = request.getParameter("tb_qty" + String.valueOf(det.getAdvDetailId()));
					strRate = request.getParameter("tb_rate" + String.valueOf(det.getAdvDetailId()));
					strDiscPer = request.getParameter("disc_per" + String.valueOf(det.getAdvDetailId()));
					System.err.println("inside strQty" + strQty);
					System.err.println("inside strRate" + strRate);
					System.err.println("inside strDiscPer" + strDiscPer);
					qty = Integer.parseInt(strQty);
					rate = Float.parseFloat(strRate);
					try {
						discPer = Float.parseFloat(strDiscPer);
					} catch (Exception e) {
						discPer = det.getDiscPer();
					}
				} catch (Exception e) {
					strQty = null;

				}
				if (qty > 0) {
					System.err.println("In qty >0");
					det.setDiscPer(discPer);
					// AdvanceOrderDetail det = new AdvanceOrderDetail();
					det.setDeliveryDate(devDate);
					det.setProdDate(advHeader.getProdDate());
					det.setDelStatus(0);
					if (dm == 2) {
						det.setDiscPer(det.getDiscPer());
						if (rateCat == 1) {
							det.setRate(rate);
							float calTotal = (Float.parseFloat(String.valueOf(det.getMrp()))) * qty;
							float discountAmount = (calTotal * det.getDiscPer()) / 100;
							discAmt = discAmt + discountAmount;
							float subTotal = calTotal - discountAmount;
							det.setSubTotal(roundUp(subTotal));
						} else if (rateCat == 3) {
							det.setRate(rate);
							float calTotal = (Float.parseFloat(String.valueOf(det.getMrp()))) * qty;
							float discountAmount = (calTotal * det.getDiscPer()) / 100;
							discAmt = discAmt + discountAmount;
							float subTotal = calTotal - discountAmount;
							det.setSubTotal(roundUp(subTotal));
						}
					} else {
						det.setDiscPer(det.getDiscPer());
						if (rateCat == 1) {
							det.setRate(rate);
							float calTotal = (Float.parseFloat(String.valueOf(det.getMrp()))) * qty;
							float discountAmount = (calTotal * det.getDiscPer()) / 100;
							float subTotal = calTotal - discountAmount;
							discAmt = discAmt + discountAmount;
							det.setSubTotal(roundUp(subTotal));
						} else if (rateCat == 3) {
							det.setRate(rate);
							float calTotal = (rate) * qty;
							float discountAmount = (calTotal * det.getDiscPer()) / 100;
							discAmt = discAmt + discountAmount;
							float subTotal = calTotal - discountAmount;
							det.setSubTotal(roundUp(subTotal));
						}
					}
					//det.setProdDate(DateConvertor.convertToDMY(x1));
					det.setProdDate(advHeader.getProdDate());
					det.setOrderDate(advHeader.getOrderDate());
					det.setQty(qty);
					System.err.println(" det.getSubTotal() " + det.getSubTotal());
					det.setDeliveryDate(advHeader.getDeliveryDate());

					grandTotal = det.getSubTotal() + grandTotal;
					System.err.println("grandTotal " + grandTotal);
					itmList.set(i, det);
				} else {
					System.err.println("qty<0 means Delete");
					det.setDelStatus(1);
					det.setQty(0);
					//det.setProdDate(DateConvertor.convertToDMY(x1));
					det.setProdDate(advHeader.getProdDate());
					det.setOrderDate(advHeader.getOrderDate());
					itmList.set(i, det);
				}
			}
			if (itmList.size() > 0) {
				advHeader.setDiscAmt(discAmt);
				// float remAmt=
				System.err.println("grandTotal " + grandTotal);
				advHeader.setTotal(grandTotal);
				advHeader.setRemainingAmt((advHeader.getTotal() - advHeader.getAdvanceAmt()));

				advHeader.setDetailList(itmList);
				System.err.println("HIII");
				if(advHeader.getIsBillGenerated()==0)
				info = restTemplate.postForObject(Constants.url + "/saveAdvanceOrderHeadAndDetail", advHeader,
						AdvanceOrderHeader.class);
			} else {
				System.err.println("inside saveAdvanceOrder");
				info = new AdvanceOrderHeader();
				info.setAdvHeaderId(0);
			}
			// System.err.println("inside saveAdvanceOrder"+info.toString());

		} catch (Exception e) {
			e.printStackTrace();
		}
		return info;
	}

	private String incrementDate(String date, int day) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
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

	public static float roundUp(float d) {
		return BigDecimal.valueOf(d).setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
	}

	@RequestMapping(value = "/deleteAdvOrder", method = RequestMethod.POST)
	@ResponseBody
	public Object deleteAdvOrder(HttpServletRequest request, HttpServletResponse response) {
		RestTemplate restTemplate = new RestTemplate();
		Info info = new Info();
		try {
			int ordHeaderId = Integer.parseInt(request.getParameter("ordHeaderIdForDel"));

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("ordHeaderId", ordHeaderId);
			info = restTemplate.postForObject(Constants.url + "/deleteAdvOrder", map, Info.class);

		} catch (Exception e) {
			e.printStackTrace();

		}
		return info;
	}
}
