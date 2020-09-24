package com.ats.tril.controller;

import java.text.DecimalFormat;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.tril.common.Constants;
import com.ats.tril.common.DateConvertor;
import com.ats.tril.model.AccLevelItemModel;
import com.ats.tril.model.BillBookDetail;
import com.ats.tril.model.BillBookHeader;
import com.ats.tril.model.GetBillHeader;
import com.ats.tril.model.Info;
import com.ats.tril.model.SettingValue;
import com.ats.tril.model.Vendor;
import com.ats.tril.model.mrn.GetMrnHeaderWithAmt;
import com.ats.tril.model.mrn.MrnDetailForBillBook;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@Scope("session")
public class BillBookController {
	RestTemplate rest = new RestTemplate();

	DecimalFormat df = new DecimalFormat("#.000");

	@RequestMapping(value = "/addBillBook", method = RequestMethod.GET)
	public ModelAndView addBillBook(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("billBook/addBillBook");
		try {
			Date date = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("dd-MM-yyyy");

			model.addObject("date", sf.format(date));

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("name", "add_PO_rate_editable");
			System.out.println("map " + map);
			SettingValue settingValue = rest.postForObject(Constants.url + "/getSettingValue", map, SettingValue.class);
			System.err.println("RATE EDITABLE --------- " + settingValue);
			if (settingValue != null) {
				model.addObject("rateEditable", settingValue.getValue());
			} else {
				model.addObject("rateEditable", 0);
			}

			Vendor[] vendorRes = rest.postForObject(Constants.url + "/getVendorForBillBook", map, Vendor[].class);
			List<Vendor> vendorList = new ArrayList<Vendor>();
			vendorList = new ArrayList<Vendor>(Arrays.asList(vendorRes));
			System.err.println("VENDOR LIST - " + vendorList);

			map = new LinkedMultiValueMap<>();
			Info info = rest.postForObject(Constants.url + "/getBillNoFoBillBook", map, Info.class);
			System.err.println("BILL NO ---------- " + info);

			model.addObject("vendorList", vendorList);
			model.addObject("quotationTemp", "-");
			model.addObject("remarkTemp", "-");
			model.addObject("quotationDateTemp", sf.format(date));
			model.addObject("isFromDashBoard", 0);
			model.addObject("orderValidityTemp", 1);

			model.addObject("billNo", info.getMessage());

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}
	
	List<GetMrnHeaderWithAmt> mrnHeaderList = new ArrayList<GetMrnHeaderWithAmt>();

	@RequestMapping(value = "/getAllMrnHeaderByVendor", method = RequestMethod.GET)
	@ResponseBody
	public List<GetMrnHeaderWithAmt> getMRNListByType(HttpServletRequest request, HttpServletResponse response) {

		mrnHeaderList = new ArrayList<GetMrnHeaderWithAmt>();

		try {

			int vendorId = Integer.parseInt(request.getParameter("vendorId"));
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("vendorId", vendorId);

			GetMrnHeaderWithAmt[] mrnHead = rest.postForObject(Constants.url + "/getAllMrnHeaderByVendor", map,
					GetMrnHeaderWithAmt[].class);

			mrnHeaderList = new ArrayList<GetMrnHeaderWithAmt>(Arrays.asList(mrnHead));

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mrnHeaderList;
	}
	
	ArrayList<MrnDetailForBillBook> mrnDetailList = new ArrayList<MrnDetailForBillBook>();

	@RequestMapping(value = "/geMRNDetailByMRNId", method = RequestMethod.GET)
	@ResponseBody
	public List<MrnDetailForBillBook> geMRNDetailByMRNId(HttpServletRequest request, HttpServletResponse response) {

		mrnDetailList = new ArrayList<MrnDetailForBillBook>();

		try {

			int mrnId = Integer.parseInt(request.getParameter("mrnId"));

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("mrnId", mrnId);

			MrnDetailForBillBook[] mrnDetail = rest.postForObject(Constants.url + "/getMrnDetailForBillBookByMrnId",
					map, MrnDetailForBillBook[].class);

			mrnDetailList = new ArrayList<MrnDetailForBillBook>(Arrays.asList(mrnDetail));

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mrnDetailList;
	}
	
	
	@RequestMapping(value = "/getCustBillNoFromMRN", method = RequestMethod.GET)
	@ResponseBody
	public Info getCustBillNoFromMRN(HttpServletRequest request, HttpServletResponse response) {

		String billNo = "";
		Info info = new Info();

		try {

			int mrnId = Integer.parseInt(request.getParameter("mrnId"));
			System.err.println("MRN ID = " + mrnId);

			if (mrnHeaderList != null) {
				for (int i = 0; i < mrnHeaderList.size(); i++) {
					if (mrnId == mrnHeaderList.get(i).getMrnId()) {
						billNo = "" + mrnHeaderList.get(i).getBillNo();
						info.setMessage(billNo);
						break;
					}
				}
			}
			System.err.println("BILL NO = " + billNo);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return info;
	}
	
	@RequestMapping(value = "/getMRNNoById", method = RequestMethod.GET)
	@ResponseBody
	public Info getMRNNoById(HttpServletRequest request, HttpServletResponse response) {

		String mrnNo = "";
		Info info = new Info();

		try {

			int mrnId = Integer.parseInt(request.getParameter("mrnId"));
			System.err.println("MRN ID = " + mrnId);

			if (mrnHeaderList != null) {
				for (int i = 0; i < mrnHeaderList.size(); i++) {
					if (mrnId == mrnHeaderList.get(i).getMrnId()) {
						mrnNo = "" + mrnHeaderList.get(i).getMrnNo();
						info.setMessage(mrnNo);
						break;
					}
				}
			}
			System.err.println("mrnNo  = " + mrnNo);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return info;
	}
	
	ArrayList<MrnDetailForBillBook> accLevelItemList = new ArrayList<MrnDetailForBillBook>();

	@RequestMapping(value = "/getAccLevelBillItemList", method = RequestMethod.GET)
	@ResponseBody
	public List<MrnDetailForBillBook> getAccLevelItemList(HttpServletRequest request, HttpServletResponse response) {

		accLevelItemList = new ArrayList<MrnDetailForBillBook>();

		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			MrnDetailForBillBook[] mrnDetail = rest.postForObject(Constants.url + "/getAccountLevelItemListForBill",
					map, MrnDetailForBillBook[].class);

			accLevelItemList = new ArrayList<MrnDetailForBillBook>(Arrays.asList(mrnDetail));

		} catch (Exception e) {
			e.printStackTrace();
		}

		return accLevelItemList;
	}
	
	
	@RequestMapping(value = "/geMRNDetailWithAccLevelItems", method = RequestMethod.GET)
	@ResponseBody
	public List<MrnDetailForBillBook> geMRNDetailWithAccLevelItems(HttpServletRequest request,
			HttpServletResponse response) {

		try {

			String jsonStr = request.getParameter("jsonStr");
			System.err.println("JSON - " + jsonStr);

			ObjectMapper mapper = new ObjectMapper();
			List<AccLevelItemModel> itemList = mapper.readValue(jsonStr, new TypeReference<List<AccLevelItemModel>>() {
			});

			System.err.println("LIST - " + itemList);

			if (accLevelItemList != null) {

				for (MrnDetailForBillBook model : accLevelItemList) {

					for (AccLevelItemModel item : itemList) {

						if (item.getId() == model.getItemId()) {

							model.setItemRate(item.getRate());
							// model.setCgst(0);
							// model.setSgst(0);

							Date date = new Date();
							SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
							model.setSchDate(sf.format(date));

							mrnDetailList.add(model);

						}
					}

				}

			}

			System.err.println("DETAIL LIST - " + mrnDetailList);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mrnDetailList;
	}
	
	// -----------------------------------------------------------------------------

		@RequestMapping(value = "/submitBillBook", method = RequestMethod.POST)
		public String submitBillBook(HttpServletRequest request, HttpServletResponse response) {

			try {

				int days = 0;

				int mrnId = Integer.parseInt(request.getParameter("mrnId"));
				int vendId = Integer.parseInt(request.getParameter("vendId"));
				String billDate = request.getParameter("billDate");
				String billNo = request.getParameter("billNo");
				String mrnNo = request.getParameter("mrnNo");
				String custBillNo = request.getParameter("custBillNo");

				String packRemark = request.getParameter("packRemark");
				String insuRemark = request.getParameter("insuRemark");
				String freightRemark = request.getParameter("freghtRemark");
				String otherRemark = request.getParameter("otherRemark");

				float packPer = Float.parseFloat(request.getParameter("packPer"));
				float packValue = Float.parseFloat(request.getParameter("packValue"));
				float insuPer = Float.parseFloat(request.getParameter("insuPer"));
				float insuValue = Float.parseFloat(request.getParameter("insuValue"));
				float freightPer = Float.parseFloat(request.getParameter("freightPer"));
				float freightValue = Float.parseFloat(request.getParameter("freightValue"));
				float otherPer = Float.parseFloat(request.getParameter("otherPer"));
				float otherValue = Float.parseFloat(request.getParameter("otherValue"));

				float totalBasicVal = Float.parseFloat(request.getParameter("mrnBasicValue"));
				float totalTaxVal = Float.parseFloat(request.getParameter("taxValue"));
				float finalValue = Float.parseFloat(request.getParameter("finalValue"));

				// -----------------------------------------------
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("vendId", vendId);

				Vendor vendor = rest.postForObject(Constants.url + "/getVendorById", map, Vendor.class);
				if (vendor != null) {
					days = vendor.getCreatedIn();
				}

				// -----------------------------------------------

				List<BillBookDetail> billDetailList = new ArrayList<>();

				float discValTotal = 0;

				if (mrnDetailList != null) {

					for (MrnDetailForBillBook mrnDetail : mrnDetailList) {

						float mrnQty = Float.parseFloat(request.getParameter("mrnQty" + mrnDetail.getMrnDetailId()));
						System.err.println(mrnDetail.getItemName() + "  MRN QTY = " + mrnQty);

						float rate = Float.parseFloat(request.getParameter("rate" + mrnDetail.getMrnDetailId()));

						// float basic=mrnQty*rate;
						float basic = Float.parseFloat(request.getParameter("taxable" + mrnDetail.getMrnDetailId()));

						float divFactor = (basic / totalBasicVal) * 100;

						float packVal = Float.parseFloat(df.format((divFactor * packValue) / 100));
						float inscVal = Float.parseFloat(df.format((divFactor * insuValue) / 100));
						float frVal = Float.parseFloat(df.format((divFactor * freightValue) / 100));
						float otherChargeAfter = Float.parseFloat(df.format((divFactor * otherValue) / 100));

						float taxVal = Float.parseFloat(request.getParameter("taxVal" + mrnDetail.getMrnDetailId()));

						float landingVal = basic - mrnDetail.getDiscValue() + packVal + inscVal + frVal + otherChargeAfter
								+ taxVal;

						int mrnDetailId = 0;
						if (mrnDetail.getMrnId() != 0) {
							mrnDetailId = mrnDetail.getMrnDetailId();
						}

						BillBookDetail billDetail = new BillBookDetail(0, 0, mrnDetailId, vendId, mrnDetail.getItemId(),
								mrnDetail.getItemName(), mrnDetail.getItemUom(), mrnDetail.getMrnQty(), rate, mrnQty,
								mrnQty, mrnDetail.getMrnQty(), mrnDetail.getDiscPer(), mrnDetail.getDiscValue(),
								mrnDetail.getSchDays(), mrnDetail.getSchDate(), "", 0, basic, packVal, inscVal, 0, taxVal,
								frVal, otherChargeAfter, landingVal, mrnDetail.getCgst(), mrnDetail.getSgst(),
								mrnDetail.getIgst());

						billDetailList.add(billDetail);

						discValTotal = discValTotal + mrnDetail.getDiscValue();
					}

				}

				BillBookHeader header = new BillBookHeader(0, 1, billNo, DateConvertor.convertToYMD(billDate), vendId, "",
						DateConvertor.convertToYMD(billDate), totalBasicVal, discValTotal, days, 0, totalTaxVal, packPer,
						packValue, packRemark, insuPer, insuValue, insuRemark, freightPer, freightValue, freightRemark, 0,
						"" + otherPer, otherValue, otherRemark, finalValue, 0, 0, 0, custBillNo, 0, 0, 0, mrnId, mrnNo, 0,
						1, 0, billDetailList);

				System.err.println("BILL HEADER - " + header);

				BillBookHeader save = rest.postForObject(Constants.url + "/saveBillBookHeaderAndDetail", header,
						BillBookHeader.class);
				System.out.println(save);

				System.err.println("SAVE -- " + save);

			} catch (Exception e) {
				e.printStackTrace();
			}

			return "redirect:/getBillBookList";
		}

		// -------------------------------------------------------------------------------------------------
		@RequestMapping(value = "/getBillBookList", method = RequestMethod.GET)
		public ModelAndView getBillBookList(HttpServletRequest request, HttpServletResponse response) {

			ModelAndView model = new ModelAndView("billBook/billBookList");
			try {

				Date date = new Date();
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
				SimpleDateFormat display = new SimpleDateFormat("dd-MM-yyyy");

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

				if (request.getParameter("fromDate") == null || request.getParameter("toDate") == null) {

					map.add("fromDate", sf.format(date));
					map.add("toDate", sf.format(date));

					model.addObject("fromDate", display.format(date));
					model.addObject("toDate", display.format(date));
				} else {

					String fromDate = request.getParameter("fromDate");
					String toDate = request.getParameter("toDate");

					map.add("fromDate", DateConvertor.convertToYMD(fromDate));
					map.add("toDate", DateConvertor.convertToYMD(toDate));

					model.addObject("fromDate", fromDate);
					model.addObject("toDate", toDate);
				}

				GetBillHeader[] list = rest.postForObject(Constants.url + "/getBillHeaderBetDate", map,
						GetBillHeader[].class);
				List<GetBillHeader> billList = new ArrayList<GetBillHeader>(Arrays.asList(list));

				model.addObject("billList", billList);

			} catch (Exception e) {
				e.printStackTrace();
			}

			return model;
		}
		
		// --------------------------------------------------------------------------------------------------

		BillBookHeader billHeader = new BillBookHeader();
		
		@RequestMapping(value = "/editBill/{billId}", method = RequestMethod.GET)
		public ModelAndView editPurchaseOrder(@PathVariable int billId, HttpServletRequest request,
				HttpServletResponse response) {

			ModelAndView model = new ModelAndView("billBook/editBillBook");
			try {

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("billId", billId);

				billHeader = rest.postForObject(Constants.url + "getBillHeaderById", map, BillBookHeader.class);
				System.err.println("BILL - " + billHeader);

				if (billHeader != null) {

					model.addObject("billHeader", billHeader);
					model.addObject("billDate", DateConvertor.convertToDMY(billHeader.getBillDate()));

				}

			} catch (Exception e) {
				e.printStackTrace();
			}

			return model;
		}
		
		@RequestMapping(value = "/submitEditBillBook", method = RequestMethod.POST)
		public String submitEditBillBook(HttpServletRequest request, HttpServletResponse response) {

			try {

				String packRemark = request.getParameter("packRemark");
				String insuRemark = request.getParameter("insuRemark");
				String freightRemark = request.getParameter("freghtRemark");
				String otherRemark = request.getParameter("otherRemark");

				float packPer = Float.parseFloat(request.getParameter("packPer"));
				float packValue = Float.parseFloat(request.getParameter("packValue"));
				float insuPer = Float.parseFloat(request.getParameter("insuPer"));
				float insuValue = Float.parseFloat(request.getParameter("insuValue"));
				float freightPer = Float.parseFloat(request.getParameter("freightPer"));
				float freightValue = Float.parseFloat(request.getParameter("freightValue"));
				float otherPer = Float.parseFloat(request.getParameter("otherPer"));
				float otherValue = Float.parseFloat(request.getParameter("otherValue"));

				float totalBasicVal = Float.parseFloat(request.getParameter("mrnBasicValue"));
				float totalTaxVal = Float.parseFloat(request.getParameter("taxValue"));
				float finalValue = Float.parseFloat(request.getParameter("finalValue"));

				List<BillBookDetail> billDetailList = new ArrayList<>();

				float discValTotal = 0;

				if (billHeader != null) {

					if (billHeader.getBillBookDetail() != null) {

						for (BillBookDetail detail : billHeader.getBillBookDetail()) {

							float mrnQty = Float.parseFloat(request.getParameter("mrnQty" + detail.getBillDetailId()));
							System.err.println(detail.getItemDesc() + "  MRN QTY = " + mrnQty);

							float rate = Float.parseFloat(request.getParameter("rate" + detail.getBillDetailId()));

							// float basic=mrnQty*rate;
							float basic = Float.parseFloat(request.getParameter("taxable" + detail.getBillDetailId()));

							float divFactor = (basic / totalBasicVal) * 100;

							float packVal = Float.parseFloat(df.format((divFactor * packValue) / 100));
							float inscVal = Float.parseFloat(df.format((divFactor * insuValue) / 100));
							float frVal = Float.parseFloat(df.format((divFactor * freightValue) / 100));
							float otherChargeAfter = Float.parseFloat(df.format((divFactor * otherValue) / 100));

							float taxVal = Float.parseFloat(request.getParameter("taxVal" + detail.getBillDetailId()));

							float landingVal = basic - detail.getBillDetailId() + packVal + inscVal + frVal
									+ otherChargeAfter + taxVal;

							BillBookDetail billDetail = new BillBookDetail(detail.getBillDetailId(), detail.getBillId(),
									detail.getMrnDetailId(), detail.getVendId(), detail.getItemId(), detail.getItemDesc(),
									detail.getItemUom(), mrnQty, rate, mrnQty, mrnQty, detail.getPoQty(),
									detail.getDiscPer(), detail.getDiscValue(), detail.getSchDays(), detail.getSchDate(),
									detail.getSchRemark(), detail.getStatus(), basic, packValue, inscVal, 0, taxVal, frVal,
									otherValue, landingVal, detail.getCgst(), detail.getSgst(), detail.getIgst());

							billDetailList.add(billDetail);

							discValTotal = discValTotal + detail.getDiscValue();

						}
					}
				}

				BillBookHeader header = new BillBookHeader(billHeader.getBillId(), billHeader.getBillType(),
						billHeader.getBillNo(), billHeader.getBillDate(), billHeader.getVendId(),
						billHeader.getVendQuation(), billHeader.getVendQuationDate(), totalBasicVal, discValTotal,
						billHeader.getBillTaxId(), 0, totalTaxVal, packPer, packValue, packRemark, insuPer, insuValue,
						insuRemark, freightPer, freightValue, freightRemark, 0, "" + otherPer, otherValue, otherRemark,
						finalValue, billHeader.getDeliveryId(), billHeader.getDispatchId(), billHeader.getPaymentTermId(),
						billHeader.getBillRemark(), billHeader.getBillStatus(), billHeader.getPrnStatus(),
						billHeader.getPrnCopies(), billHeader.getMrnId(), billHeader.getMrnNo(), billHeader.getUserId(),
						billHeader.getDelStatus(), billHeader.getApprovStatus(), billDetailList);

				System.err.println("BILL HEADER - " + header);

				BillBookHeader save = rest.postForObject(Constants.url + "/saveBillBookHeaderAndDetail", header,
						BillBookHeader.class);
				System.out.println(save);

				System.err.println("SAVE -- " + save);

			} catch (Exception e) {
				e.printStackTrace();
			}

			return "redirect:/getBillBookList";
		}

		
}
