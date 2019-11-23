package com.ats.adminpanel.controller;

import java.util.ArrayList;
import java.util.List;

import javax.management.RuntimeErrorException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONObject;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.model.billing.Company;
import com.ats.adminpanel.model.billing.GetBillDetailPrint;
import com.ats.adminpanel.model.ewaybill.BillHeadEwayBill;
import com.ats.adminpanel.model.ewaybill.EwayBillSuccess;
import com.ats.adminpanel.model.ewaybill.EwayConstants;
import com.ats.adminpanel.model.ewaybill.EwayItemList;
import com.ats.adminpanel.model.ewaybill.GetAuthToken;
import com.ats.adminpanel.model.ewaybill.ReqEwayBill;
import com.ats.adminpanel.model.ewaybill.ResponseCode;
import com.ats.adminpanel.model.franchisee.FranchiseeList;

@Controller
public class EwayBillController {

	@RequestMapping(value = "/checkToken", method = RequestMethod.GET)
	public ModelAndView checkIt(HttpServletRequest request, HttpServletResponse response) {

		RestTemplate restTemplate = new RestTemplate();
		try {
			ObjectMapper mapperObj = new ObjectMapper();
			String billList = new String();
			ResponseEntity<List<BillHeadEwayBill>> bRes = null;
			String[] selectedBills = request.getParameterValues("select_to_print");
String vehNo=request.getParameter("vehNo");
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

			//System.err.println("billHeaderList " + billHeaderList.toString());
			
			GetAuthToken tokenRes=null; //= restTemplate.getForObject(EwayConstants.getToken, GetAuthToken.class);
			ResponseEntity<String> tokRes = null;

			ParameterizedTypeReference<String> typeRef2 = new ParameterizedTypeReference<String>() {
			};
			try {
				tokRes = restTemplate.exchange(EwayConstants.getToken, HttpMethod.GET,
						new HttpEntity<>(map), typeRef2);
				try {
					tokenRes=mapperObj.readValue(tokRes.getBody(), GetAuthToken.class);
							//System.err.println("Token Res " +tokenRes.toString());
				}catch (Exception e) {
					System.err.println("Inner try for getToken"+e.getMessage());
				}
			} catch (HttpClientErrorException e) {
				System.err.println("/getToken Http Excep \n " + e.getResponseBodyAsString());
			}
			
			//System.err.println("tokenRes " + tokenRes.toString());
			
			
			Company company= restTemplate.getForObject(Constants.url+"/getCompany",Company.class);
System.err.println("company " +company.toString());

			for(int i=0;i<billHeaderList.size();i++) {
				
				BillHeadEwayBill bill=billHeaderList.get(i);
				
				FranchiseeList franchise = restTemplate.getForObject(Constants.url + "getFranchisee?frId={frId}",
						FranchiseeList.class, bill.getFrId());
				
				ReqEwayBill billReq = new ReqEwayBill();
				
				billReq.setActFromStateCode(company.getStateCode());
				billReq.setActToStateCode(company.getStateCode());

				billReq.setCessNonAdvolValue(00);
				billReq.setCessValue(0);
				
				billReq.setCgstValue(bill.getCgstSum());

				billReq.setDispatchFromGSTIN(company.getGstin());
				billReq.setDispatchFromTradeName(company.getCompName());

				billReq.setDocDate(bill.getBillDate());
				billReq.setDocNo(bill.getInvoiceNo());

				billReq.setFromAddr1(company.getFactAddress());
				billReq.setFromAddr2("");
				billReq.setFromGstin(company.getGstin());
				billReq.setFromPincode(company.getFromPinCode());
				billReq.setFromPlace(company.getFactAddress());
				billReq.setFromStateCode(company.getStateCode());
				billReq.setFromTrdName(company.getCompName());

				billReq.setIgstValue(bill.getIgstSum());
				billReq.setOtherValue(0);
	 			billReq.setSgstValue(bill.getSgstSum());
				
				//billReq.setShipToGSTIN("29ALSPR1722R1Z3");
				//billReq.setShipToTradeName("XYZ Traders");
				//billReq.setSubSupplyDesc("ppoo");
				
				billReq.setSupplyType("I"); //While Selling it is O-Outward
				
				if(franchise.getFrKg4()==1) {
					billReq.setSubSupplyType("1");//while selling to Other Fr -Supply(1)
					billReq.setDocType("INV");
				}else {
					billReq.setSubSupplyType("8");//while selling to Own Fr -Others(8)
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
				
				
				billReq.setTransMode("1");//Road/Rail/Air/Ship

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

				String jsonStr  = mapperObj.writeValueAsString(billReq);
				System.err.println("billReq " +billReq.toString());
				
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
					} catch (Exception e) {
						e.printStackTrace();
						System.err.println("Inner Try");
					}

				} catch (HttpClientErrorException e) {

					ewayErrRes = mapperObj.readValue(e.getResponseBodyAsString(), ResponseCode.class);
					System.err.println("ewayErrRes   " + ewayErrRes.toString());
				}

			}//End of Bill Header For Loop
			
			
			
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

		return null;

	}

}
