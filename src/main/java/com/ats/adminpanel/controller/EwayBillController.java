package com.ats.adminpanel.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.adminpanel.model.ewaybill.EwayBillSuccess;
import com.ats.adminpanel.model.ewaybill.EwayConstants;
import com.ats.adminpanel.model.ewaybill.EwayItemList;
import com.ats.adminpanel.model.ewaybill.GetAuthToken;
import com.ats.adminpanel.model.ewaybill.ReqEwayBill;
import com.ats.adminpanel.model.ewaybill.ResponseCode;

@Controller
public class EwayBillController {

	@RequestMapping(value = "/checkToken", method = RequestMethod.GET)
	public ModelAndView checkIt(HttpServletRequest request1, HttpServletResponse response) {

		RestTemplate restTemplate = new RestTemplate();
		try {

			ReqEwayBill billReq = new ReqEwayBill();

			ArrayList<EwayItemList> itemList = new ArrayList<EwayItemList>();
			
			billReq.setActFromStateCode(05);
			billReq.setActToStateCode(02);
			
			billReq.setCessNonAdvolValue(400);
			billReq.setCessValue(400.56);
			billReq.setCgstValue(0);
			
			billReq.setDispatchFromGSTIN("29AAAAA1303P1ZV");
			billReq.setDispatchFromTradeName("ABC Traders");
			
			billReq.setDocDate("15/12/2017");
			billReq.setDocNo("11449-1");
			billReq.setDocType("INV");
			
			billReq.setFromAddr1("2ND CROSS NO 59  19  A");
			billReq.setFromAddr2("GROUND FLOOR OSBORNE ROAD");
			billReq.setFromGstin("05AAACG1625Q1ZK");
			billReq.setFromPincode(263652);
			billReq.setFromPlace("FRAZER TOWN");
			billReq.setFromStateCode(05);
			billReq.setFromTrdName("welton");
			
			
			billReq.setIgstValue(300.67);
			billReq.setOtherValue(-100);
			billReq.setSgstValue(0);
			billReq.setShipToGSTIN("29ALSPR1722R1Z3");
			billReq.setShipToTradeName("XYZ Traders");
			billReq.setSubSupplyDesc("ppoo");
			
			billReq.setSubSupplyType("1");
			billReq.setSupplyType("O");
			
			billReq.setToAddr1("Shree Nilaya");
			billReq.setToAddr2("Dasarahosahalli");
			billReq.setToGstin("02EHFPS5910D2Z0");
			billReq.setToPincode(176036);
			billReq.setToPlace("Beml Nagar");
			
			billReq.setToStateCode(02);
			billReq.setTotalValue(56099);
			billReq.setTotInvValue(68358);
			billReq.setToTrdName("sthuthya");
			billReq.setTransactionType(4);
			billReq.setTransDistance("656");
			billReq.setTransDocDate("");
			billReq.setTransDocNo("");
			billReq.setTransMode("1");
			billReq.setTransporterId("");
			billReq.setTransporterName("");
			billReq.setVehicleNo("PVC1234");
			billReq.setVehicleType("R");
			
			EwayItemList item = new EwayItemList();
			item.setCessNonAdvol(0);
			item.setCessRate(0);
			item.setCgstRate(0);
			item.setHsnCode(8536);
			item.setIgstRate(3);
			item.setProductDesc("Wheat");
			item.setProductName("Wheat");
			item.setQtyUnit("BOX");
			item.setQuantity(4);
			item.setSgstRate(0);
			item.setTaxableAmount(56099);
			
			
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

			/*
			 * headers.set("action", "GENEWAYBILL"); headers.set("aspid", "1629701119");
			 * headers.set("password", "pdMulani@123"); headers.set("gstin",
			 * "05AAACG1625Q1ZK"); headers.set("username", "05AAACG1625Q1ZK");
			 * headers.set("authtoken", "uA3bGDKo93pZR40IoUqbdB38g");
			 */

			String jsonStr = null;
			jsonStr = mapperObj.writeValueAsString(billReq);
			System.err.println("jsonStr " +jsonStr.toString());

			HttpEntity<String> entity = new HttpEntity<String>(jsonStr, headers);
			
			
			/*
			 * EwayBillSuccess billRes =
			 * restTemplate.postForObject(EwayConstants.genEwayGenUrl,billReq,
			 * EwayBillSuccess.class); System.err.println("billRes " +billRes.toString());
			 */
					  
					 // String answer = restTemplate.postForObject(EwayConstants.genEwayGenUrl, entity, String.class);
					  
					 // EwayBillSuccess success=mapperObj.readValue(answer, EwayBillSuccess.class);
					  String 
					 		   answer = restTemplate.postForObject(EwayConstants.genEwayGenUrl, entity, String.class);


					  boolean isFound = answer.indexOf("status_cd") !=-1? true: false; //true
					  System.err.println("isFou"+isFound);


						  
					 // System.err.println("answer.get(\"ewayBillNo\") " +answer.);
			/*
			 * if(answer.get("ewayBillNo")!=null ){
			 * 
			 * EwayBillSuccess success=mapperObj.readValue(answer.toString(),
			 * EwayBillSuccess.class); System.err.println("Success 1" +success.toString());
			 * 
			 * }else { ResponseCode success=mapperObj.readValue(answer.toString(),
			 * ResponseCode.class); System.err.println("Success 2" +success.toString()); }
			 * 
			 * System.err.println("Ans " +answer.toString());
			 */

			/*
			 * ResponseEntity<String> orderListResponse =
			 * restTemplate.exchange(EwayConstants.genEwayGenUrl, HttpMethod.POST, entity,
			 * String.class);
			 * 
			 * System.err.println("orderListResponse " +
			 * orderListResponse.getBody().toString());
			 */

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;

	}

}
