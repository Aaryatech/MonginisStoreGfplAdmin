package com.ats.tril.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.tril.common.Constants;
import com.ats.tril.common.DateConvertor;
import com.ats.tril.model.AccountHead;
import com.ats.tril.model.Category;
import com.ats.tril.model.OpeningStockModel;
import com.ats.tril.model.StockHeader;
import com.ats.tril.model.Type;
import com.ats.tril.model.Vendor;
import com.ats.tril.model.doc.DocumentBean;
import com.ats.tril.model.doc.SubDocument;
import com.ats.tril.model.indent.Indent;
import com.ats.tril.model.indent.IndentTrans;
import com.ats.tril.model.indent.TempIndentDetail;
@Controller
@Scope("session")
public class OpeningUtilityController {
	RestTemplate rest = new RestTemplate();
	@RequestMapping(value = "/AddOPeningstockutility", method = RequestMethod.GET)
	public ModelAndView AddOPeningstockutility(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("stock/openingStockUtility");
		try {
		 
			Category[] category = rest.getForObject(Constants.url + "/getAllCategoryByIsUsed", Category[].class);
			List<Category> categoryList = new ArrayList<Category>(Arrays.asList(category)); 
			model.addObject("categoryList", categoryList);

			AccountHead[] accountHead = rest.getForObject(Constants.url + "/getAllAccountHeadByIsUsed",
					AccountHead[].class);
			List<AccountHead> accountHeadList = new ArrayList<AccountHead>(Arrays.asList(accountHead)); 
			model.addObject("accountHeadList", accountHeadList);
			
			Vendor[] vendorRes = rest.getForObject(Constants.url + "/getAllVendorByIsUsed", Vendor[].class);
			List<Vendor> vendorList = new ArrayList<Vendor>(Arrays.asList(vendorRes));
			model.addObject("vendorList", vendorList);
			/*Dept[] Dept = rest.getForObject(Constants.url + "/getAllDeptByIsUsed", Dept[].class);
			List<Dept> deparmentList = new ArrayList<Dept>(Arrays.asList(Dept)); 
			model.addObject("deparmentList", deparmentList);*/
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("cat_id", 1);
			OpeningStockModel[] itemRes = rest.postForObject(Constants.url + "/getAllitemOpeningStock",map, OpeningStockModel[].class);
			List<OpeningStockModel> itemList = new ArrayList<OpeningStockModel>(Arrays.asList(itemRes));
			//model.addObject("itemList", itemList);
			System.out.println("itemList111111"+itemList);
			
			DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
			Date date = new Date();
			model.addObject("date", dateFormat.format(date));

			StockHeader stockHeader = rest.getForObject(Constants.url + "/getCurrentRunningMonthAndYear",
					StockHeader.class);

			date = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

			String fromDateForStock;
			String toDateForStock;
			fromDateForStock = stockHeader.getYear() + "-" + stockHeader.getMonth() + "-" + "01";
			toDateForStock = sf.format(date);
			 
			Type[] type = rest.getForObject(Constants.url + "/getAlltype", Type[].class);
			List<Type> typeList = new ArrayList<Type>(Arrays.asList(type));
			model.addObject("typeList", typeList);
			
			
			  
		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}
	
	@RequestMapping(value = "GetAllitemOpeningStock", method = RequestMethod.GET)
	public List<OpeningStockModel> GetAllitemOpeningStock(HttpServletRequest request, HttpServletResponse response)
	{
	MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
	map.add("cat_id", 1);
	OpeningStockModel[] itemRes = rest.postForObject(Constants.url + "/getAllitemOpeningStock",map, OpeningStockModel[].class);
	List<OpeningStockModel> itemList = new ArrayList<OpeningStockModel>(Arrays.asList(itemRes));
	
	System.out.println("itemList2222"+itemList);
	
	return itemList;
	}
}
