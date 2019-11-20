package com.ats.adminpanel.controller;

import java.net.HttpURLConnection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.model.ewaybill.EwayBillSuccess;
import com.ats.adminpanel.model.ewaybill.EwayConstants;
import com.ats.adminpanel.model.ewaybill.EwayItemList;
import com.ats.adminpanel.model.ewaybill.GetAuthToken;
import com.ats.adminpanel.model.ewaybill.ReqEwayBill;
import com.ats.adminpanel.model.ewaybill.ResponseCode;
import com.ats.adminpanel.model.franchisee.AllMenuResponse;

@Controller
public class EwayBillController {

	@RequestMapping(value = "/checkToken", method = RequestMethod.GET)
	public ModelAndView checkIt(HttpServletRequest request1, HttpServletResponse response) {

		RestTemplate restTemplate = new RestTemplate();
		try {

			ReqEwayBill billReq = new ReqEwayBill();

			List<EwayItemList> itemList = new ArrayList<EwayItemList>();

			billReq.setSubSupplyType("I");
			billReq.setDocType("1");
			billReq.setDocDate("1/1/2019");
			billReq.setDocNo("MI123455");
			billReq.setFromGstin("05AAACG1625Q1ZK");
			billReq.setFromPincode(412221);
			billReq.setFromStateCode(27);
			billReq.setToStateCode(27);
			billReq.setToGstin("05AAACG1625Q1ZK");
			billReq.setToPincode(412525);
			billReq.setTransDistance("1400");
			billReq.setActToStateCode(27);
			billReq.setActFromStateCode(27);

			EwayItemList item = new EwayItemList();

			item.setCessNonAdvol(0.0f);
			item.setCessRate(0.0f);
			item.setCgstRate(1.2f);
			item.setHsnCode(11111111);
			item.setIgstRate(0);
			item.setIgstRate(0);
			item.setProductDesc("ff");
			item.setProductName("jj");
			item.setQtyUnit("KGS");
			item.setQuantity(14);
			item.setSgstRate(1);
			item.setTaxableAmount(1200);
			itemList.add(item);

			billReq.setItemList(itemList);
			/*
			 * "required": [ "supplyType", "subSupplyType", "docType", "docNo", "docDate",
			 * "fromGstin", "fromPincode", "fromStateCode", "toGstin", "toPincode",
			 * "toStateCode", "transDistance", "itemList", "actToStateCode",
			 * "actFromStateCode" ]
			 */

			/*
			 * EwayBillSuccess allMenuResponse =
			 * restTemplate.postForObject(EwayConstants.genEwayUrl,billReq,
			 * EwayBillSuccess.class);
			 */
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			/*
			 * EwayBillSuccess billRes =
			 * restTemplate.postForObject(EwayConstants.genEwayGenUrl,billReq,
			 * EwayBillSuccess.class); System.err.println("billRes " +billRes.toString());
			 */

			GetAuthToken tokenRes = restTemplate.getForObject(EwayConstants.getToken, GetAuthToken.class);
			System.err.println("tokenRes " + tokenRes.toString());

			ObjectMapper mapperObj = new ObjectMapper();

			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.APPLICATION_JSON);

			headers.set("action", "GENEWAYBILL");
			headers.set("aspid", "1629701119");
			headers.set("password", "pdMulani@123");
			headers.set("gstin", "05AAACG1625Q1ZK");
			headers.set("username", "05AAACG1625Q1ZK");
			headers.set("authtoken", "HTNuBLbfRugz84VkFdpTzxJcn");

			String jsonStr = null;
			jsonStr = mapperObj.writeValueAsString(billReq);

			HttpEntity<String> entity = new HttpEntity<String>(jsonStr, headers);

			ResponseEntity<String> orderListResponse = restTemplate.exchange(EwayConstants.genEwayGenUrl,
					HttpMethod.POST, entity, String.class);

			System.err.println("orderListResponse " + orderListResponse.getBody().toString());

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;

	}

}
