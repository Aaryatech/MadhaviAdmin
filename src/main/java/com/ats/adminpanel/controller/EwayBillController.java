package com.ats.adminpanel.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.core.ParameterizedTypeReference;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.model.billing.Company;
import com.ats.adminpanel.model.ewaybill.BillHeadEwayBill;
import com.ats.adminpanel.model.ewaybill.CustomErrEwayBill;
import com.ats.adminpanel.model.ewaybill.EwayBillSuccess;
import com.ats.adminpanel.model.ewaybill.EwayConstants;
import com.ats.adminpanel.model.ewaybill.GetAuthToken;
import com.ats.adminpanel.model.ewaybill.ReqEwayBill;
import com.ats.adminpanel.model.ewaybill.ResponseCode;
import com.ats.adminpanel.model.franchisee.FranchiseeList;
import com.ats.adminpanel.model.item.ErrorMessage;

@Controller
public class EwayBillController {

	@RequestMapping(value = "/genOutwardEwayBill", method = RequestMethod.POST)
	public @ResponseBody List<CustomErrEwayBill> checkIt(HttpServletRequest request, HttpServletResponse response) {
		List<CustomErrEwayBill> errorBillList = new ArrayList<CustomErrEwayBill>();
		RestTemplate restTemplate = new RestTemplate();
		try {
			ObjectMapper mapperObj = new ObjectMapper();
			String billList = new String();
			ResponseEntity<List<BillHeadEwayBill>> bRes = null;
			String[] selectedBills = request.getParameterValues("select_to_print");
			String vehNo = request.getParameter("vehNo");
			for (int i = 0; i < selectedBills.length; i++) {
				billList = selectedBills[i] + "," + billList;
			}

			billList = billList.substring(0, billList.length() - 1);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("billIdList", billList);

			ParameterizedTypeReference<List<BillHeadEwayBill>> typeRef1 = new ParameterizedTypeReference<List<BillHeadEwayBill>>() {
			};
			try {
				bRes = restTemplate.exchange(Constants.url + "getBillListForEwaybill", HttpMethod.POST,
						new HttpEntity<>(map), typeRef1);
			} catch (HttpClientErrorException e) {
				System.err.println("/getBillListForEwaybill Http Excep \n " + e.getResponseBodyAsString());
			}
			List<BillHeadEwayBill> billHeaderList = bRes.getBody();

			// System.err.println("billHeaderList " + billHeaderList.toString());

			GetAuthToken tokenRes = null; // = restTemplate.getForObject(EwayConstants.getToken, GetAuthToken.class);
			ResponseEntity<String> tokRes = null;

			ParameterizedTypeReference<String> typeRef2 = new ParameterizedTypeReference<String>() {
			};
			try {
				tokRes = restTemplate.exchange(EwayConstants.getToken, HttpMethod.GET, new HttpEntity<>(map), typeRef2);
				try {
					tokenRes = mapperObj.readValue(tokRes.getBody(), GetAuthToken.class);
					// System.err.println("Token Res " +tokenRes.toString());
				} catch (Exception e) {
					System.err.println("Inner try for getToken" + e.getMessage());
				}
			} catch (HttpClientErrorException e) {
				System.err.println("/getToken Http Excep \n " + e.getResponseBodyAsString());
			}

			// System.err.println("tokenRes " + tokenRes.toString());

			Company company = restTemplate.getForObject(Constants.url + "/getCompany", Company.class);
			System.err.println("company " + company.toString());

			for (int i = 0; i < billHeaderList.size(); i++) {

				BillHeadEwayBill bill = billHeaderList.get(i);

				FranchiseeList franchise = restTemplate.getForObject(Constants.url + "getFranchisee?frId={frId}",
						FranchiseeList.class, bill.getFrId());

				ReqEwayBill billReq = new ReqEwayBill();

				billReq.setActFromStateCode(company.getStateCode());
				billReq.setActToStateCode(franchise.getFrKg2());

				billReq.setCessNonAdvolValue(00);
				billReq.setCessValue(0);

				billReq.setCgstValue(bill.getCgstSum());

				billReq.setDispatchFromGSTIN(company.getGstin());
				billReq.setDispatchFromTradeName(company.getCompName());

				String billDate=new String();//bill.getBillDate().replace('-', '/');
				
				DateFormat df=new SimpleDateFormat("dd/MM/YYYY");
				billDate=df.format(new Date());
				billReq.setDocDate(billDate);
				billReq.setDocNo(bill.getInvoiceNo());

				billReq.setFromAddr1(company.getFactAddress());
				billReq.setFromAddr2("");
				billReq.setFromGstin(company.getGstin());
				billReq.setFromPincode(company.getFromPinCode());
				billReq.setFromPlace(company.getFactAddress());
				billReq.setFromStateCode(company.getStateCode());
				billReq.setFromTrdName(company.getCompName());

				billReq.setIgstValue(0);
				billReq.setOtherValue(0);
				billReq.setSgstValue(bill.getSgstSum());

				// billReq.setShipToGSTIN("29ALSPR1722R1Z3");
				// billReq.setShipToTradeName("XYZ Traders");
				// billReq.setSubSupplyDesc("ppoo");

				billReq.setSupplyType("O"); // While Selling it is O-Outward

				if (franchise.getFrKg1() == 0) {
					billReq.setSubSupplyType("1");// while selling to Other Fr -Supply(1)
					billReq.setDocType("INV");
				} else {
					billReq.setSubSupplyType("8");// while selling to Own Fr -Others(8)
					billReq.setDocType("CHL");
				}

				billReq.setTransactionType(1);

				billReq.setToAddr1(franchise.getFrAddress());
				billReq.setToAddr2("");
				billReq.setToGstin(franchise.getFrGstNo());
				billReq.setToPincode(franchise.getFrKg2());
				billReq.setToPlace(" ");
				billReq.setToStateCode(company.getStateCode());

				billReq.setTotalValue(bill.getTaxableAmt());
				billReq.setTotInvValue(bill.getGrandTotal());

				billReq.setToTrdName(franchise.getFrName());

				billReq.setTransMode("1");// Road/Rail/Air/Ship

				billReq.setTransDistance(""+franchise.getFrKg3());
				billReq.setTransDocDate("");
				billReq.setTransDocNo("");
				billReq.setTransporterId("");
				billReq.setTransporterName("");

				billReq.setVehicleNo(vehNo);
				billReq.setVehicleType("R");

				billReq.setItemList(billHeaderList.get(i).getItemList());

				HttpHeaders headers = new HttpHeaders();
				headers.setContentType(MediaType.APPLICATION_JSON);

				//String jsonStr = mapperObj.writeValueAsString(billReq);
				System.err.println("billReq " + billReq.toString());

				EwayBillSuccess ewaySuccRes = null;
				ResponseCode ewayErrRes = null;
				ParameterizedTypeReference<String> typeRef = new ParameterizedTypeReference<String>() {
				};
				ResponseEntity<String> responseEntity = null;

				try {
					responseEntity = restTemplate.exchange(EwayConstants.genEwayGenUrl + "" + tokenRes.getAuthtoken(),
							HttpMethod.POST, new HttpEntity<>(billReq), typeRef);

					try {
						ewaySuccRes = mapperObj.readValue(responseEntity.getBody(), EwayBillSuccess.class);
						System.err.println("ewaySuccRes " + ewaySuccRes.toString());

						map = new LinkedMultiValueMap<String, Object>();
						map.add("ewayBillNo", ewaySuccRes.getEwayBillNo());
						map.add("billNo", bill.getBillNo());
						
						ErrorMessage updateEwayBillNo=restTemplate.postForObject(Constants.url+"/tally/updateEwayBillNo",map, ErrorMessage.class);
					} catch (Exception e) {
						e.printStackTrace();
						System.err.println("Inner Try");
					}

				} catch (HttpClientErrorException e) {

					ewayErrRes = mapperObj.readValue(e.getResponseBodyAsString(), ResponseCode.class);
					System.err.println("ewayErrRes   " + ewayErrRes.toString());
					CustomErrEwayBill errRes=new CustomErrEwayBill();
					
					errRes.setBillNo(bill.getBillNo());
					errRes.setInvoiceNo(bill.getInvoiceNo());
					errRes.setTimeStamp("--");
					errRes.setErrorCode(ewayErrRes.getError().getError_cd());
					errRes.setMessage(ewayErrRes.getError().getMessage());
					
					errorBillList.add(errRes);
				}

			} // End of Bill Header For Loop

			/*
			 * ArrayList<EwayItemList> itemList = new ArrayList<EwayItemList>();
			 * 
			 * 
			 * EwayItemList item = new EwayItemList();
			 * 
			 * item.setCessNonAdvol(item.getCessNonAdvol());
			 * item.setCessRate(item.getCessRate()); item.setCgstRate(item.getCgstRate());
			 * item.setHsnCode(item.getHsnCode()); item.setIgstRate(item.getIgstRate());
			 * item.setProductDesc(item.getProductDesc());
			 * item.setProductName(item.getProductName());
			 * item.setQtyUnit(item.getQtyUnit()); item.setQuantity(item.getQuantity());
			 * item.setSgstRate(item.getSgstRate());
			 * item.setTaxableAmount(item.getTaxableAmount());
			 * 
			 * itemList.add(item);
			 * 
			 * billReq.setItemList(itemList);
			 */
			/*
			 * "required": [ "supplyType", "subSupplyType", "docType", "docNo", "docDate",
			 * "fromGstin", "fromPincode", "fromStateCode", "toGstin", "toPincode",
			 * "toStateCode", "transDistance", "itemList", "actToStateCode",
			 * "actFromStateCode" ]
			 */

			// System.err.println("jsonStr " +jsonStr.toString());

			/*
			 * HttpEntity<String> entity = new HttpEntity<String>(jsonStr, headers);
			 * 
			 * String answer=new String(); try { answer =
			 * restTemplate.postForObject(EwayConstants.genEwayGenUrl+""+tokenRes.
			 * getAuthtoken(), billReq, String.class); //System.err.println("In Catch "
			 * +answer.toString()); }catch (Exception e) { System.err.println("In Catch "
			 * +answer.toString()); e.printStackTrace();
			 * 
			 * }
			 */

			/*
			 * EwayBillSuccess ewaySuccRes = null; ResponseCode ewayErrRes = null;
			 * ParameterizedTypeReference<String> typeRef = new
			 * ParameterizedTypeReference<String>() { }; ResponseEntity<String>
			 * responseEntity = null; HttpStatus resStatus = null; try { responseEntity =
			 * restTemplate.exchange(EwayConstants.genEwayGenUrl + "" +
			 * tokenRes.getAuthtoken(), HttpMethod.POST, new HttpEntity<>(billReq),
			 * typeRef);
			 * 
			 * try { ewaySuccRes = mapperObj.readValue(responseEntity.getBody(),
			 * EwayBillSuccess.class); System.err.println("ewaySuccRes " +
			 * ewaySuccRes.toString()); } catch (Exception e) { e.printStackTrace();
			 * System.err.println("Inner Try"); }
			 * 
			 * } catch (HttpClientErrorException e) {
			 * 
			 * ewayErrRes = mapperObj.readValue(e.getResponseBodyAsString(),
			 * ResponseCode.class); System.err.println("ewayErrRes   " +
			 * ewayErrRes.toString()); }
			 */

		} catch (Exception e) {
			e.printStackTrace();
		}

		return errorBillList;

	}

	

	@RequestMapping(value = "/genInwardEwayBill", method = RequestMethod.POST)
	public @ResponseBody List<CustomErrEwayBill> genInwardEwayBill(HttpServletRequest request, HttpServletResponse response) {
		List<CustomErrEwayBill> errorBillList = new ArrayList<CustomErrEwayBill>();
		RestTemplate restTemplate = new RestTemplate();
		try {
			ObjectMapper mapperObj = new ObjectMapper();
			String crnIdList = new String();
			ResponseEntity<List<BillHeadEwayBill>> bRes = null;
			String[] selectedCrns = request.getParameterValues("select_to_agree");
			String vehNo = request.getParameter("vehNo");
			for (int i = 0; i < selectedCrns.length; i++) {
				crnIdList = selectedCrns[i] + "," + crnIdList;
			}

			crnIdList = crnIdList.substring(0, crnIdList.length() - 1);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("crnIdList", crnIdList);

			ParameterizedTypeReference<List<BillHeadEwayBill>> typeRef1 = new ParameterizedTypeReference<List<BillHeadEwayBill>>() {
			};
			try {
				bRes = restTemplate.exchange(Constants.url + "getCreditListForEwaybill", HttpMethod.POST,
						new HttpEntity<>(map), typeRef1);
			} catch (HttpClientErrorException e) {
				System.err.println("/getBillListForEwaybill Http Excep \n " + e.getResponseBodyAsString());
			}
			List<BillHeadEwayBill> billHeaderList = bRes.getBody();

			// System.err.println("billHeaderList " + billHeaderList.toString());

			GetAuthToken tokenRes = null; // = restTemplate.getForObject(EwayConstants.getToken, GetAuthToken.class);
			ResponseEntity<String> tokRes = null;

			ParameterizedTypeReference<String> typeRef2 = new ParameterizedTypeReference<String>() {
			};
			try {
				tokRes = restTemplate.exchange(EwayConstants.getToken, HttpMethod.GET, new HttpEntity<>(map), typeRef2);
				try {
					tokenRes = mapperObj.readValue(tokRes.getBody(), GetAuthToken.class);
					// System.err.println("Token Res " +tokenRes.toString());
				} catch (Exception e) {
					System.err.println("Inner try for getToken" + e.getMessage());
				}
			} catch (HttpClientErrorException e) {
				System.err.println("/getToken Http Excep \n " + e.getResponseBodyAsString());
			}

			// System.err.println("tokenRes " + tokenRes.toString());

			Company company = restTemplate.getForObject(Constants.url + "/getCompany", Company.class);
			System.err.println("company " + company.toString());

			for (int i = 0; i < billHeaderList.size(); i++) {

				BillHeadEwayBill bill = billHeaderList.get(i);

				FranchiseeList franchise = restTemplate.getForObject(Constants.url + "getFranchisee?frId={frId}",
						FranchiseeList.class, bill.getFrId());

				ReqEwayBill billReq = new ReqEwayBill();

				billReq.setActFromStateCode(company.getStateCode());
				billReq.setActToStateCode(company.getStateCode());

				billReq.setCessNonAdvolValue(00);
				billReq.setCessValue(0);

				

				billReq.setDispatchFromGSTIN(franchise.getFrGstNo());
				billReq.setDispatchFromTradeName(franchise.getFrName());

				String billDate=new String();
						//bill.getBillDate().replace('-', '/');
				DateFormat df=new SimpleDateFormat("dd/MM/YYYY");
				billDate=df.format(new Date());
				billReq.setDocDate(billDate);
				billReq.setDocNo(bill.getInvoiceNo());

				billReq.setFromAddr1(franchise.getFrAddress());
				billReq.setFromAddr2("");
				billReq.setFromGstin(franchise.getFrGstNo());
				billReq.setFromPincode(franchise.getFrKg2());
				billReq.setFromPlace(franchise.getFrCity());
				billReq.setFromStateCode(company.getStateCode());
				billReq.setFromTrdName(franchise.getFrName());

				billReq.setIgstValue(bill.getIgstSum());
				billReq.setOtherValue(0);
				billReq.setCgstValue(bill.getCgstSum());
				billReq.setSgstValue(bill.getSgstSum());


				billReq.setSupplyType("I"); // While Return it is -Inward

				if (franchise.getFrKg1() == 0) {
					billReq.setSubSupplyType("7");// while RETURN FOR OTHER Fr CNT 7 FR GRN GVN
					billReq.setDocType("CHL");
				} else {
					billReq.setSubSupplyType("8");// while RETURN to Own Fr -CHL(8)
					billReq.setDocType("CHL");
				}

				billReq.setTransactionType(1); //need to discuss for Dairy Mart Sumit Sir

				billReq.setToAddr1(company.getFactAddress());
				billReq.setToAddr2("");
				billReq.setToGstin(company.getGstin());
				billReq.setToPincode(company.getFromPinCode());
				billReq.setToPlace(" ");
				billReq.setToStateCode(company.getStateCode());

				billReq.setTotalValue(bill.getTaxableAmt());
				billReq.setTotInvValue(bill.getGrandTotal());

				billReq.setToTrdName(company.getCompName());

				billReq.setTransMode("1");// Road/Rail/Air/Ship

				billReq.setTransDistance("" + franchise.getFrKg3());
				billReq.setTransDocDate("");
				billReq.setTransDocNo("");
				billReq.setTransporterId("");
				billReq.setTransporterName("");

				billReq.setVehicleNo(vehNo);
				billReq.setVehicleType("R");

				billReq.setItemList(billHeaderList.get(i).getItemList());

				HttpHeaders headers = new HttpHeaders();
				headers.setContentType(MediaType.APPLICATION_JSON);

				String jsonStr = mapperObj.writeValueAsString(billReq);
				System.err.println("billReq " + billReq.toString());

				EwayBillSuccess ewaySuccRes = null;
				ResponseCode ewayErrRes = null;
				ParameterizedTypeReference<String> typeRef = new ParameterizedTypeReference<String>() {
				};
				ResponseEntity<String> responseEntity = null;

				try {
					responseEntity = restTemplate.exchange(EwayConstants.genEwayGenUrl + "" + tokenRes.getAuthtoken(),
							HttpMethod.POST, new HttpEntity<>(billReq), typeRef);

					try {
						ewaySuccRes = mapperObj.readValue(responseEntity.getBody(), EwayBillSuccess.class);
						System.err.println("ewaySuccRes " + ewaySuccRes.toString());

						map = new LinkedMultiValueMap<String, Object>();
						map.add("ewayBillNo", ewaySuccRes.getEwayBillNo());
						map.add("crnId", bill.getBillNo());
						
						ErrorMessage updateEwayBillNo=restTemplate.postForObject(Constants.url+"/updateEwayBillNoInCNote",map, ErrorMessage.class);
					} catch (Exception e) {
						e.printStackTrace();
						System.err.println("Inner Try");
					}

				} catch (HttpClientErrorException e) {

					ewayErrRes = mapperObj.readValue(e.getResponseBodyAsString(), ResponseCode.class);
					System.err.println("ewayErrRes   " + ewayErrRes.toString());
					CustomErrEwayBill errRes=new CustomErrEwayBill();
					
					errRes.setBillNo(bill.getBillNo());
					errRes.setInvoiceNo(bill.getInvoiceNo());
					errRes.setTimeStamp("--");
					errRes.setErrorCode(ewayErrRes.getError().getError_cd());
					errRes.setMessage(ewayErrRes.getError().getMessage());
					
					errorBillList.add(errRes);
				}

			} // End of Bill Header For Loop

			

		} catch (Exception e) {
			e.printStackTrace();
		}

		return errorBillList;

	}
}
