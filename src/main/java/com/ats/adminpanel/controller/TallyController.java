package com.ats.adminpanel.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Calendar;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.commons.DateConvertor;
import com.ats.adminpanel.model.Info;
import com.ats.adminpanel.model.storetally.TallyPurchaseGroupByInvoices;
import com.ats.adminpanel.model.tally.TallyCrnInvoicesGroupByBills;
import com.ats.adminpanel.model.tally.TallySalesInvoiceListGroupByBills;

@Controller
@Scope("session")
public class TallyController {

	@RequestMapping(value = "/getTallyFile")
	public ModelAndView getTallyFile(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = null;

//		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
//		Info view = AccessControll.checkAccess("getTallyFile", "getTallyFile", "1", "0", "0", "0",
//				newModuleList);
//
//		if (view.getError() == true) {
//
//			model = new ModelAndView("accessDenied");
//
//		} else {

		model = new ModelAndView("tally/tallyFileDownload");
		try {

			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
			model.addObject("todaysDate", sdf.format(cal.getTime()));

		} catch (Exception e) {

			System.out.println("Exc in getTallyFile " + e.getMessage());
			e.printStackTrace();
		}

		// }

		return model;
	}

	@RequestMapping(value = "/getTallyData", method = RequestMethod.GET)
	public @ResponseBody Info getTallyData(HttpServletRequest request, HttpServletResponse response) {

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		RestTemplate restTemplate = new RestTemplate();

		Info info = new Info();

		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		int type = Integer.parseInt(request.getParameter("type"));

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
		LocalDate firstDate = LocalDate.parse(fromDate, formatter);
		LocalDate secondDate = LocalDate.parse(toDate, formatter);
		long days = ChronoUnit.DAYS.between(firstDate, secondDate);
		System.out.println("Days between: " + days);

		if (days > 5) {
			info.setError(true);
			info.setMessage("Date range exceeds!");
		} else {

			String dispFromDate = fromDate;
			String dispToDate = toDate;

			map.add("fromDate", fromDate);
			map.add("toDate", toDate);

			fromDate = DateConvertor.convertToYMD(fromDate);
			toDate = DateConvertor.convertToYMD(toDate);
			System.err.println("DATE - " + fromDate + "  -  " + toDate);

			if (type == 1) {
				TallySalesInvoiceListGroupByBills res = restTemplate.getForObject(
						Constants.url + "tally/getBillsForTallySyncGroupBy?fromDate=" + fromDate + "&toDate=" + toDate,
						TallySalesInvoiceListGroupByBills.class);

				ObjectMapper Obj = new ObjectMapper();
				String json = "";
				try {
					json = Obj.writeValueAsString(res);
				} catch (JsonGenerationException e1) {
					e1.printStackTrace();
				} catch (JsonMappingException e1) {
					e1.printStackTrace();
				} catch (IOException e1) {
					e1.printStackTrace();
				}
				// System.out.println("RESULT - " + json);

				if (json != null) {

					try {
						Writer output = null;
						File file = new File(
								Constants.TALLY_SAVE + "Sales_" + dispFromDate + "-" + dispToDate + ".json");
						output = new BufferedWriter(new FileWriter(file));
						output.write(json.toString());
						output.close();

						String data = Constants.TALLY_VIEW + "Sales_" + dispFromDate + "-" + dispToDate + ".zip";

						String fileName = Constants.TALLY_SAVE + "Sales_" + dispFromDate + "-" + dispToDate + ".zip";

						String sourceFile = Constants.TALLY_SAVE + "Sales_" + dispFromDate + "-" + dispToDate + ".json";
						FileOutputStream fos = new FileOutputStream(fileName);
						ZipOutputStream zipOut = new ZipOutputStream(fos);
						File fileToZip = new File(sourceFile);
						FileInputStream fis = new FileInputStream(fileToZip);
						ZipEntry zipEntry = new ZipEntry(fileToZip.getName());

						// System.err.println(fileToZip.getName());

						zipOut.putNextEntry(zipEntry);
						byte[] bytes = new byte[1024];
						int length;
						while ((length = fis.read(bytes)) >= 0) {
							zipOut.write(bytes, 0, length);
						}
						zipOut.close();
						fis.close();
						fos.close();

						info.setError(false);
						info.setMessage(data);

					} catch (FileNotFoundException e) {
						e.printStackTrace();
						info.setError(true);
						info.setMessage("Download Failed!");

					} catch (Exception e) {
						e.printStackTrace();

						info.setError(true);
						info.setMessage("Download Failed!");
					}

				}

			} else if (type == 2) {

				TallyCrnInvoicesGroupByBills res = restTemplate.getForObject(Constants.url
						+ "tally/getCreditNoteForTallySyncGroupBy?fromDate=" + fromDate + "&toDate=" + toDate,
						TallyCrnInvoicesGroupByBills.class);

				ObjectMapper Obj = new ObjectMapper();
				String json = "";
				try {
					json = Obj.writeValueAsString(res);
				} catch (JsonGenerationException e1) {
					e1.printStackTrace();
				} catch (JsonMappingException e1) {
					e1.printStackTrace();
				} catch (IOException e1) {
					e1.printStackTrace();
				}
				// System.out.println("RESULT - " + json);

				if (json != null) {

					try {
						Writer output = null;
						File file = new File(Constants.TALLY_SAVE + "CRN_" + dispFromDate + "-" + dispToDate + ".json");
						output = new BufferedWriter(new FileWriter(file));
						output.write(json.toString());
						output.close();

						String data = Constants.TALLY_VIEW + "CRN_" + dispFromDate + "-" + dispToDate + ".zip";

						String fileName = Constants.TALLY_SAVE + "CRN_" + dispFromDate + "-" + dispToDate + ".zip";

						String sourceFile = Constants.TALLY_SAVE + "CRN_" + dispFromDate + "-" + dispToDate + ".json";
						FileOutputStream fos = new FileOutputStream(fileName);
						ZipOutputStream zipOut = new ZipOutputStream(fos);
						File fileToZip = new File(sourceFile);
						FileInputStream fis = new FileInputStream(fileToZip);
						ZipEntry zipEntry = new ZipEntry(fileToZip.getName());

						// System.err.println(fileToZip.getName());

						zipOut.putNextEntry(zipEntry);
						byte[] bytes = new byte[1024];
						int length;
						while ((length = fis.read(bytes)) >= 0) {
							zipOut.write(bytes, 0, length);
						}
						zipOut.close();
						fis.close();
						fos.close();

						info.setError(false);
						info.setMessage(data);

					} catch (FileNotFoundException e) {
						e.printStackTrace();
						info.setError(true);
						info.setMessage("Download Failed!");

					} catch (Exception e) {
						e.printStackTrace();

						info.setError(true);
						info.setMessage("Download Failed!");
					}

				}

			} else if (type == 3) {

				TallyPurchaseGroupByInvoices res = restTemplate.getForObject(
						Constants.STORE_URL + "getPurchaseTallySyncGroupBy?fromDate=" + fromDate + "&toDate=" + toDate,
						TallyPurchaseGroupByInvoices.class);

				ObjectMapper Obj = new ObjectMapper();
				String json = "";
				try {
					json = Obj.writeValueAsString(res);
				} catch (JsonGenerationException e1) {
					e1.printStackTrace();
				} catch (JsonMappingException e1) {
					e1.printStackTrace();
				} catch (IOException e1) {
					e1.printStackTrace();
				}
				// System.out.println("RESULT - " + json);

				if (json != null) {

					try {
						Writer output = null;
						File file = new File(
								Constants.TALLY_SAVE + "Purchase_" + dispFromDate + "-" + dispToDate + ".json");
						output = new BufferedWriter(new FileWriter(file));
						output.write(json.toString());
						output.close();

						String data = Constants.TALLY_VIEW + "Purchase_" + dispFromDate + "-" + dispToDate + ".zip";

						String fileName = Constants.TALLY_SAVE + "Purchase_" + dispFromDate + "-" + dispToDate + ".zip";

						String sourceFile = Constants.TALLY_SAVE + "Purchase_" + dispFromDate + "-" + dispToDate
								+ ".json";
						FileOutputStream fos = new FileOutputStream(fileName);
						ZipOutputStream zipOut = new ZipOutputStream(fos);
						File fileToZip = new File(sourceFile);
						FileInputStream fis = new FileInputStream(fileToZip);
						ZipEntry zipEntry = new ZipEntry(fileToZip.getName());

						// System.err.println(fileToZip.getName());

						zipOut.putNextEntry(zipEntry);
						byte[] bytes = new byte[1024];
						int length;
						while ((length = fis.read(bytes)) >= 0) {
							zipOut.write(bytes, 0, length);
						}
						zipOut.close();
						fis.close();
						fos.close();

						info.setError(false);
						info.setMessage(data);

					} catch (FileNotFoundException e) {
						e.printStackTrace();
						info.setError(true);
						info.setMessage("Download Failed!");

					} catch (Exception e) {
						e.printStackTrace();

						info.setError(true);
						info.setMessage("Download Failed!");
					}

				}

			}

		}

		return info;

	}

}
