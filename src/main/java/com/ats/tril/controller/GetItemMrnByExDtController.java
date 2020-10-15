package com.ats.tril.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLConnection;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.tril.common.Constants;
import com.ats.tril.common.DateConvertor;
import com.ats.tril.model.ExportToExcel;
import com.ats.tril.model.GetItemMrnByExp;
import com.ats.tril.model.mrn.MrnReport;
import com.ats.tril.util.ItextPageEvent;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.TabStop.Alignment;
import com.itextpdf.text.Font.FontFamily;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;

@Controller
public class GetItemMrnByExDtController {

	List<GetItemMrnByExp> itemMrnReoprtList;
	
	
	@RequestMapping(value="/SearchItmRnByExdt",method=RequestMethod.GET)
	public ModelAndView getSearchPage(HttpServletRequest request,HttpServletResponse response) {
		
		ModelAndView model=new ModelAndView("mrn/akhilesh/serchMrnItem");
		return model;
	}
	
	@RequestMapping(value="/getItemMrnbyExList" ,method=RequestMethod.GET)
	@ResponseBody
	public List<GetItemMrnByExp> getItemMrnByExpDtList(HttpServletRequest request,HttpServletResponse response){
		System.err.println("In getItemMrnbyExList ");
		
		try {
			
			MultiValueMap<String, Object> map=new LinkedMultiValueMap<String, Object>();
			RestTemplate restTemplate=new RestTemplate();
			itemMrnReoprtList=new ArrayList<GetItemMrnByExp>();
			String toDate=request.getParameter("toDate");
			  //String toDate= addDaystoCurrentDate(30);
			  //System.err.println("To Date By Function"+toDate);
			map.add("fromDt", "2020-08-31");
			map.add("toDt", DateConvertor.convertToYMD(toDate));
			
			GetItemMrnByExp[] ItemMrnReportResp=restTemplate.postForObject(Constants.url+"GetItemMrnDetailsByExpDt", map, GetItemMrnByExp[].class);
			itemMrnReoprtList=new ArrayList<GetItemMrnByExp>(Arrays.asList(ItemMrnReportResp));
			System.err.println("Report Is= "+itemMrnReoprtList.toString());
			
			
			List<ExportToExcel> exportToExcelList=new ArrayList<ExportToExcel>();
			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();
			rowData.add("Sr.No");
			//rowData.add("MRN Detail Id");
			rowData.add("Batch No.");
			rowData.add("Item Desc");
			rowData.add("UOM");
			rowData.add("Remaining Qty");
			rowData.add("Exp.Date");
			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);
			int cnt = 1;
			
			
			for(int i=0;i<itemMrnReoprtList.size();i++) {
				GetItemMrnByExp  report=itemMrnReoprtList.get(i);
				expoExcel=new ExportToExcel();
				rowData=new ArrayList<String>();
				cnt =  i+1;
				rowData.add("" + (cnt));
				//rowData.add("" + report.getMrnDetailId());
				rowData.add("" + report.getBatchNo());
				rowData.add("" + report.getItemDesc());
				rowData.add("" + report.getItemUom());
				rowData.add("" + report.getRemainingQty());
				rowData.add("" + report.getExpDate());
				
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				
				
			}
			
			
			HttpSession session=request.getSession();
			session.setAttribute("exportExcelList", exportToExcelList);
			session.setAttribute("excelName", "mrnReport");
			
			
			
		} catch (Exception e) {
			// TODO: handle exception
			System.err.println("Exception in Item Mrn Exp Details Report List  " + e.getMessage());

			e.printStackTrace();
		}
		
	return itemMrnReoprtList;
	}
	
	
	
	
	@RequestMapping(value="/getPdfReoprt",method=RequestMethod.GET)
	public void getPdfReoprt(HttpServletRequest request,HttpServletResponse response) throws FileNotFoundException {
		
		BufferedOutputStream outStream=null;
		System.err.println("In Get PDF Report");
		Document doc=new Document();
		Document document=new Document(PageSize.A4, 20, 40, 95, 70);
		DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		System.out.println("time in Gen Bill PDF ==" + dateFormat.format(cal.getTime()));
		String timeStamp = dateFormat.format(cal.getTime());
		String FILE_PATH =Constants.REPORT_SAVE;
 //Constants.REPORT_SAVE;
		File file = new File(FILE_PATH);
		
		

		PdfWriter writer = null;

		FileOutputStream out = new FileOutputStream(FILE_PATH);
		
		
		
		try {
			
			
			
			String header = "Item MRN EXP Date Report";
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");
			String reportDate = DF.format(new Date());
			String title = "Report-For MRN Item Exp";
		
			writer = PdfWriter.getInstance(document, out);

			
			
			
			ItextPageEvent event = new ItextPageEvent(header, title, reportDate);
		
			writer.setPageEvent(event);
		
		

		} catch (DocumentException e) {

			e.printStackTrace();
		}
		PdfPTable table = new PdfPTable(6);
		try {
			System.out.println("Inside PDF Table try");
			table.setWidthPercentage(100);
			table.setWidths(new float[] { 0.4f, 1.9f, 1.7f, 0.5f, 1.0f,0.8f });
			Font headFont = new Font(FontFamily.HELVETICA, 8, Font.NORMAL, BaseColor.BLACK);
			Font headFont1 = new Font(FontFamily.HELVETICA, 8, Font.BOLD, BaseColor.WHITE);
			Font f = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLUE);
			PdfPCell hcell;
			hcell = new PdfPCell(new Phrase("Sr.No.", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(BaseColor.PINK);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Batch No.", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(BaseColor.PINK);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Item Desc.", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(BaseColor.PINK);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("UOM", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(BaseColor.PINK);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Remaining Qty.", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(BaseColor.PINK);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Exp.Date", headFont1));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(BaseColor.PINK);

			table.addCell(hcell);



			int index = 0;
			for (GetItemMrnByExp report : itemMrnReoprtList) {
				index++;
				PdfPCell cell;

				cell = new PdfPCell(new Phrase(String.valueOf(index), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(report.getBatchNo(), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setPaddingRight(4);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(report.getItemDesc(), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPaddingRight(4);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(report.getItemUom(), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPaddingRight(4);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(String.valueOf(report.getRemainingQty()), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPaddingRight(4);
				table.addCell(cell);
				//

				cell = new PdfPCell(new Phrase(report.getExpDate(), headFont));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(cell);



				// FooterTable footerEvent = new FooterTable(table);
				// writer.setPageEvent(footerEvent);
			}

			document.open();
			 

			// document.add(new Paragraph(" "));
			document.add(table);
			// int totalPages=writer.getPageNumber();
			/*
			 * com.ats.adminpanel.model.itextpdf.Header event; // = new
			 * com.ats.adminpanel.model.itextpdf.Header(); for(int i=1;i<totalPages;i++) {
			 * event = new com.ats.adminpanel.model.itextpdf.Header(); event.setHeader(new
			 * Phrase(String.format("page %s", i)));
			 * 
			 * writer.setPageEvent(event); } FooterTable footerEvent = new
			 * FooterTable(table);
			 */

			// document.add(new
			// Paragraph(""+document.setPageCount(document.getPageNumber()));

			// sSystem.out.println("Page no "+totalPages);

			// document.addHeader("Page" ,String.valueOf(totalPages));
			// writer.setPageEvent((PdfPageEvent) new Phrase());

			document.close();

			// Atul Sir code to open a Pdf File
			if (file != null) {

				String mimeType = URLConnection.guessContentTypeFromName(file.getName());

				if (mimeType == null) {

					mimeType = "application/pdf";

				}

				response.setContentType(mimeType);

				response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

				// response.setHeader("Content-Disposition", String.format("attachment;
				// filename=\"%s\"", file.getName()));

				response.setContentLength((int) file.length());

				InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

				try {
					FileCopyUtils.copy(inputStream, response.getOutputStream());
				} catch (IOException e) {
					System.out.println("Excep in Opening a Pdf File for mrn report");
					e.printStackTrace();
				}
			}

			/*
			 * Desktop d=Desktop.getDesktop();
			 * 
			 * if(file.exists()) { try { d.open(file); } catch (IOException e) { // TODO
			 * Auto-generated catch block e.printStackTrace(); } }
			 */

		} catch (DocumentException ex) {

			System.out.println("Pdf Generation Error: Prod From Orders" + ex.getMessage());

			ex.printStackTrace();

		}
		
	}
	
	
	
	
	@RequestMapping(value="/getItemMrnbyExListForStoreDashboard" ,method=RequestMethod.GET)
	@ResponseBody
	public List<GetItemMrnByExp> getItemMrnByExpDtListForStoredDashboard(HttpServletRequest request,HttpServletResponse response){
		System.err.println("In getItemMrnbyExListForStoreDashboard ");
		
		try {
			
			MultiValueMap<String, Object> map=new LinkedMultiValueMap<String, Object>();
			RestTemplate restTemplate=new RestTemplate();
			itemMrnReoprtList=new ArrayList<GetItemMrnByExp>();
			String toDate=request.getParameter("toDate");
			 // String toDate= addDaystoCurrentDate(30);
			  System.err.println("To Date By Function"+toDate);
			map.add("fromDt", "2020-08-31");
			map.add("toDt", DateConvertor.convertToYMD(toDate));
			
			GetItemMrnByExp[] ItemMrnReportResp=restTemplate.postForObject(Constants.url+"GetItemMrnDetailsByExpDt", map, GetItemMrnByExp[].class);
			itemMrnReoprtList=new ArrayList<GetItemMrnByExp>(Arrays.asList(ItemMrnReportResp));
			System.err.println("Report Is= "+itemMrnReoprtList.toString());
			
			
			List<ExportToExcel> exportToExcelList=new ArrayList<ExportToExcel>();
			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();
			rowData.add("Sr.No");
			//rowData.add("MRN Detail Id");
			rowData.add("Batch No.");
			rowData.add("Item Desc");
			rowData.add("UOM");
			rowData.add("Remaining Qty");
			rowData.add("Exp.Date");
			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);
			int cnt = 1;
			
			
			for(int i=0;i<itemMrnReoprtList.size();i++) {
				GetItemMrnByExp  report=itemMrnReoprtList.get(i);
				expoExcel=new ExportToExcel();
				rowData=new ArrayList<String>();
				cnt =  i+1;
				rowData.add("" + (cnt));
				//rowData.add("" + report.getMrnDetailId());
				rowData.add("" + report.getBatchNo());
				rowData.add("" + report.getItemDesc());
				rowData.add("" + report.getItemUom());
				rowData.add("" + report.getRemainingQty());
				rowData.add("" + report.getExpDate());
				
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				
				
			}
			
			
			HttpSession session=request.getSession();
			session.setAttribute("exportExcelList", exportToExcelList);
			session.setAttribute("excelName", "mrnReport");
			
			
			
		} catch (Exception e) {
			// TODO: handle exception
			System.err.println("Exception in Item Mrn Exp Details Report List  " + e.getMessage());

			e.printStackTrace();
		}
		
	return itemMrnReoprtList;
	}
	
	
	
	
	
	
	// #8
		// Adding noOfDays to Current Date and return that date
		public static String addDaystoCurrentDate(int noOfDays) {
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
			Calendar c = Calendar.getInstance();
			c.setTime(new Date()); // Now use today date.
			c.add(Calendar.DATE, noOfDays); // Adding 5 days
			String output = sdf.format(c.getTime());
			System.out.println(output);
			return output;
		}
	
	
	
	
	
	
	
}
