<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/bootstrap-datepicker/css/datepicker.css" />
<style>
.tooltip {
	position: relative;
	display: inline-block;
	border-bottom: 1px dotted black;
}

.tooltip .tooltiptext {
	visibility: hidden;
	width: 120px;
	background-color: black;
	color: #fff;
	text-align: center;
	border-radius: 6px;
	padding: 5px 0;
	/* Position the tooltip */
	position: absolute;
	z-index: 1;
}

.tooltip:hover .tooltiptext {
	visibility: visible;
}
</style>
<style>
body {
	font-family: Arial, Helvetica, sans-serif;
}

/* The Modal (background) */
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	padding-top: 20px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
	background-color: #fefefe;
	margin: auto;
	padding: 20px;
	border: 1px solid #888;
	width: 100%;
	height: 100%;
}

/* The Close Button */
.close {
	color: #aaaaaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

#overlay {
	position: fixed;
	display: none;
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: rgba(101, 113, 119, 0.5);
	z-index: 2;
	cursor: pointer;
}

#text {
	position: absolute;
	top: 50%;
	left: 50%;
	font-size: 25px;
	color: white;
	transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
}

.bg-overlay {
	background: linear-gradient(rgba(0, 0, 0, .7), rgba(0, 0, 0, .7)),
		url("${pageContext.request.contextPath}/resources/images/smart.jpeg");
	background-repeat: no-repeat;
	background-size: cover;
	background-position: center center;
	color: #fff;
	height: auto;
	width: auto;
	padding-top: 10px;
	padding-left: 20px;
}
</style>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body>




	<c:url var="getAllMrnHeaderByVendor" value="/getAllMrnHeaderByVendor" />
	<c:url var="geMRNDetailByMRNId" value="/geMRNDetailByMRNId" />
	<c:url var="getCustBillNoFromMRN" value="/getCustBillNoFromMRN" />
	<c:url var="getMRNNoById" value="/getMRNNoById" />
	<c:url var="getAccLevelItemList" value="/getAccLevelBillItemList" />
	<c:url var="geMRNDetailWithAccLevelItems"
		value="/geMRNDetailWithAccLevelItems" />





	<!-- BEGIN Sidebar -->
	<div id="sidebar" class="navbar-collapse collapse">

		<jsp:include page="/WEB-INF/views/include/navigation.jsp"></jsp:include>

		<div id="sidebar-collapse" class="visible-lg">
			<i class="fa fa-angle-double-left"></i>
		</div>
		<!-- END Sidebar Collapse Button -->
	</div>
	<!-- END Sidebar -->



	<!-- BEGIN Content -->
	<div id="main-content">

		<!-- BEGIN Main Content -->
		<div class="box">
			<div class="box-title">
				<h3>
					<i class="fa fa-bars"></i>Bill Book
				</h3>
				<div class="box-tool">
					<a style="display: none;" href="${pageContext.request.contextPath}/addBillBook"> ADD
						Bill </a> <a href="${pageContext.request.contextPath}/getBillBookList">
						Bill List</a> <a data-action="collapse" href="#"><i
						class="fa fa-chevron-up"></i></a>
				</div>

			</div>

			<div class=" box-content">

				<div>
					<form id="submitForm" onsubmit="return check()"
						action="${pageContext.request.contextPath}/submitBillBook"
						method="post">


						<div class="box-content">

							<div class="col-md-2">Bill No.</div>
							<div class="col-md-4">
								<input type="text" id="billNo" name="billNo" value="${billNo}"
									readonly class="form-control">
							</div>
							<div class="col-md-2">Bill Date</div>
							<div class="col-md-4">
								<input type="text" id="billDate" name="billDate" value="${date}"
									class="form-control date-picker" required>

							</div>

						</div>
						<br />

						<c:set var="indentDate" value="-"></c:set>
						<div class="box-content">



							<div class="col-md-2">Vendor Name</div>
							<div class="col-md-4">

								<select name="vendId" id="vendId" class="form-control chosen"
									onchange="getMRNList(this.value)" required>

									<option value="" selected="selected">Select Vendor</option>
									<c:forEach items="${vendorList}" var="vendorList">
										<option value="${vendorList.vendorId}">${vendorList.vendorName}&nbsp;&nbsp;
											${vendorList.vendorCode}</option>
									</c:forEach>


								</select>


							</div>

							<div class="col-md-2">Select MRN No.</div>
							<div class="col-md-4">

								<select name="mrnId" id="mrnId" class="form-control chosen"
									onchange="getCustBillNo(this.value);" required>
								</select> <input type="hidden" id="mrnNo" name="mrnNo">

							</div>


							<div class="col-md-2" style="display: none;">
								<input type="button" class="btn btn-info"
									value="Get Item From MRN " id="myBtn">
							</div>





						</div>
						<br />

						<div class="box-content">
							<div class="col-md-2">Customer Bill No.</div>
							<div class="col-md-4">
								<input type="text" placeholder="Enter Customer Bill No" value="" readonly="readonly"
									name="custBillNo" id="custBillNo" class="form-control" required>
							</div>

							<div class="col-md-2">Add Account Level Item</div>
							<div class="col-md-2">
								<input type="button" class="btn btn-info"
									value="Get Account Level Items" id="myBtn"
									onclick="openModal()">
							</div>


						</div>
						<br />

						<div align="center" id="loader" style="display: none;">
							<br> <span>
								<h4>
									<font color="#343690">Loading</font>
								</h4>
							</span> <span class="l-1"></span> <span class="l-2"></span> <span
								class="l-3"></span> <span class="l-4"></span> <span class="l-5"></span>
							<span class="l-6"></span>
						</div>


						<hr />

						<div class=" box-content">
							<div class="row">
								<div
									style="overflow: scroll; height: 50%; width: 100%; overflow: auto">
									<table width="100%" border="0"
										class="table table-bordered table-striped fill-head "
										style="width: 100%; font-size: 14px;" id="table_grid2">
										<thead>
											<tr>

												<th
													style="position: sticky; top: 0; z-index: 5;  width="2%">SR</th>
												<th
													style="text-align: center; position: sticky; top: 0; z-index: 5;">Item
													Name</th>
												<th class="col-md-1"
													style="text-align: center; position: sticky; top: 0; z-index: 5;">Uom</th>
												<th class="col-md-1"
													style="text-align: center; position: sticky; top: 0; z-index: 5;">MRN
													Qty</th>
												<th class="col-md-1"
													style="text-align: center; position: sticky; top: 0; z-index: 5;">PO
													Rate</th>

												<th class="col-md-1"
													style="text-align: center; position: sticky; top: 0; z-index: 5;">Bill
													Rate</th>
												<th class="col-md-1"
													style="text-align: center; position: sticky; top: 0; z-index: 5;">Total</th>
												<th class="col-md-1"
													style="text-align: center; position: sticky; top: 0; z-index: 5;">Additional
													Charges</th>
												<th class="col-md-1"
													style="text-align: center; position: sticky; top: 0; z-index: 5;">Taxable</th>
												<th class="col-md-1"
													style="text-align: center; position: sticky; top: 0; z-index: 5;">Tax
													Per</th>
												<th class="col-md-1"
													style="text-align: center; position: sticky; top: 0; z-index: 5;">Tax
													Value</th>
												<th class="col-md-1"
													style="text-align: center; position: sticky; top: 0; z-index: 5;">Grand
													Total</th>




											</tr>
										</thead>
										<tbody>

										</tbody>
									</table>
								</div>
							</div>

						</div>
						<br />
						<hr />
						<div class="box-content">

							<div class="col-md-2">Basic value</div>
							<div class="col-md-2">
								<input style="text-align: right; width: 150px" type="text"
									value="" pattern="[+-]?([0-9]*[.])?[0-9]+" name="mrnBasicValue"
									id="mrnBasicValue" class="form-control" readonly>
							</div>
							<div class="col-md-2"></div>



						</div>
						<br>
						<div class="box-content">

							<div class="col-md-2">Packing Charges %</div>
							<div class="col-md-2">
								<input style="text-align: right; width: 150px"
									oninput="checkPackPerValue()" type="text" value="0"
									pattern="[+-]?([0-9]*[.])?[0-9]+" name="packPer" id="packPer"
									class="form-control" required>
							</div>
							<div class="col-md-2">
								Packing Charges Value <i class="fa fa-inr"
									style="font-size: 13px"></i>
							</div>
							<div class="col-md-2">
								<input style="text-align: right; width: 150px" type="text"
									name="packValue" id="packValue" class="form-control" value="0"
									pattern="[+-]?([0-9]*[.])?[0-9]+" required
									oninput="calculateOtherValues()">
							</div>
							<div class="col-md-2">Remark</div>
							<div class="col-md-2">
								<input type="text" name="packRemark" id="packRemark"
									class="form-control" value="NA">
							</div>


						</div>
						<br>
						<div class="box-content">
							<div class="col-md-2">Insurance Charges %</div>
							<div class="col-md-2">
								<input style="text-align: right; width: 150px"
									oninput="checkInscPerValue()" type="text" value="0"
									pattern="[+-]?([0-9]*[.])?[0-9]+" name="insuPer" id="insuPer"
									class="form-control" required>
							</div>
							<div class="col-md-2">
								Insurance Charges Value <i class="fa fa-inr"
									style="font-size: 13px"></i>
							</div>
							<div class="col-md-2">
								<input style="text-align: right; width: 150px" type="text"
									name="insuValue" id="insuValue" class="form-control" value="0"
									pattern="[+-]?([0-9]*[.])?[0-9]+" required
									oninput="calculateOtherValues()">
							</div>
							<div class="col-md-2">Remark</div>
							<div class="col-md-2">
								<input type="text" name="insuRemark" id="insuRemark"
									class="form-control" value="NA">
							</div>

						</div>
						<br>

						<div class="box-content">

							<div class="col-md-2">Freight Charges %</div>
							<div class="col-md-2">
								<input style="text-align: right; width: 150px"
									oninput="checkFreightPerValue()" type="text" value="0"
									pattern="[+-]?([0-9]*[.])?[0-9]+" name="freightPer"
									id="freightPer" class="form-control" required>
							</div>
							<div class="col-md-2">
								Freight Charges Value <i class="fa fa-inr"
									style="font-size: 13px"></i>
							</div>
							<div class="col-md-2">
								<input style="text-align: right; width: 150px" type="text"
									name="freightValue" id="freightValue" class="form-control"
									value="0" pattern="[+-]?([0-9]*[.])?[0-9]+" required
									oninput="calculateOtherValues()">
							</div>
							<div class="col-md-2">Remark</div>
							<div class="col-md-2">
								<input type="text" name="freghtRemark" id="freghtRemark"
									class="form-control" value="NA">
							</div>
						</div>
						<br>

						<div class="box-content">

							<div class="col-md-2"></div>
							<div class="col-md-2"></div>
							<div class="col-md-2">
								Tax Value <i class="fa fa-inr" style="font-size: 13px"></i>
							</div>
							<div class="col-md-2">
								<input style="text-align: right; width: 150px" type="text"
									name="taxValue" id="taxValue" class="form-control" value=""
									pattern="[+-]?([0-9]*[.])?[0-9]+" readonly>
							</div>
							<div class="col-md-2"></div>
							<div class="col-md-2">
								<input type="hidden" name="taxRemark" id="taxRemark"
									class="form-control" value="NA">
							</div>

						</div>
						<br>

						<div class="box-content">

							<div class="col-md-2">Other Charges %</div>
							<div class="col-md-2">
								<input style="text-align: right; width: 150px" type="text"
									oninput="checkOtherPerValue()" value="0"
									pattern="[+-]?([0-9]*[.])?[0-9]+" name="otherPer" id="otherPer"
									class="form-control" required>
							</div>
							<div class="col-md-2">
								Other Charges Value <i class="fa fa-inr" style="font-size: 13px"></i>
							</div>
							<div class="col-md-2">
								<input style="text-align: right; width: 150px" type="text"
									name="otherValue" id="otherValue" class="form-control"
									value="0" pattern="[+-]?([0-9]*[.])?[0-9]+" required
									oninput="calculateOtherValues()">
							</div>
							<div class="col-md-2">Remark</div>
							<div class="col-md-2">
								<input type="text" name="otherRemark" id="otherRemark"
									class="form-control" value="NA">
							</div>

						</div>
						<br>

						<div class="box-content">

							<div class="col-md-2"></div>
							<div class="col-md-2"></div>

							<div class="col-md-2">
								Taxable Total <i class="fa fa-inr" style="font-size: 13px"></i>
							</div>
							<div class="col-md-2">
								<input style="text-align: right; width: 150px" type="text"
									name="taxableTot" id="taxableTot" class="form-control" value=""
									pattern="[+-]?([0-9]*[.])?[0-9]+" readonly>
							</div>

							<div class="col-md-2">
								Final Value <i class="fa fa-inr" style="font-size: 13px"></i>
							</div>
							<div class="col-md-2">
								<input style="text-align: right; width: 150px" type="text"
									value="<fmt:formatNumber type = "number"  maxFractionDigits = "2" minFractionDigits="2" value =""/>"
									name="finalValue" id="finalValue" class="form-control"
									value="0" pattern="[+-]?([0-9]*[.])?[0-9]+" readonly>
							</div>



						</div>
						<br> <br>

						<div class="row">
							<div class="col-md-12" style="text-align: center">

								<input type="submit" class="btn btn-info" value="Submit">

							</div>
						</div>

					</form>


					<!------------------- ACCOUNT LEVEL ITEMS MODAL-------------------- -->



					<div id="myModal" class="modal">

						<div class="modal-content" style="color: black;">
							<span class="close" id="close">&times;</span>
							<h3 style="text-align: center;">Select Account Level Item</h3>
							<div class=" box-content">
								<div class="row">
									<div
										style="overflow: scroll; height: 70%; width: 100%; overflow: auto">
										<table width="100%" border="0"
											class="table table-bordered table-striped fill-head "
											style="width: 100%; font-size: 14px;" id="table_grid1">
											<thead>
												<tr>
													<th style="text-align: center; position: sticky; top: 0; z-index: 5;" align="left" width="1%"><input type="checkbox"
														id="allCheck" />All</th>
													<th width="2%" style="text-align: center; position: sticky; top: 0; z-index: 5;">SR</th>
													<th class="col-md-5" style="text-align: center; position: sticky; top: 0; z-index: 5;">Item Name</th>
													<th class="col-md-1" style="text-align: center; position: sticky; top: 0; z-index: 5;">Uom</th>
													<th class="col-md-1" style="text-align: center; position: sticky; top: 0; z-index: 5;">Qty</th>
													<th class="col-md-1" style="text-align: center; position: sticky; top: 0; z-index: 5;">Rate</th>
													<th class="col-md-1" style="text-align: center; position: sticky; top: 0; z-index: 5;">Taxable</th>
													<th class="col-md-1" style="text-align: center; position: sticky; top: 0; z-index: 5;">Tax Per</th>
													<th class="col-md-1" style="text-align: center; position: sticky; top: 0; z-index: 5;">Tax Value</th>
													<th class="col-md-1" style="text-align: center; position: sticky; top: 0; z-index: 5;">Total</th>
												</tr>
											</thead>
											<tbody>

											</tbody>
										</table>
									</div>
								</div>

							</div>
							<br>
							<div class="row">
								<div class="col-md-12" style="text-align: center">

									<input type="button" class="btn btn-info" value="Submit"
										onclick="setAccLvlItemToDetailList()">
								</div>
							</div>

						</div>

					</div>



					<!------------------- ACCOUNT LEVEL ITEMS MODAL-------------------- -->




				</div>
			</div>
		</div>		
	</div>
	<!-- END Main Content -->



	<a id="btn-scrollup" class="btn btn-circle btn-lg" href="#"><i
		class="fa fa-chevron-up"></i></a>




	<!--basic scripts-->
	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
	<script>
		window.jQuery
				|| document
						.write('<script src="${pageContext.request.contextPath}/resources/assets/jquery/jquery-2.0.3.min.js"><\/script>')
	</script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/bootstrap/js/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/jquery-slimscroll/jquery.slimscroll.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/jquery-cookie/jquery.cookie.js"></script>

	<!--page specific plugin scripts-->
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/chosen-bootstrap/chosen.jquery.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-inputmask/bootstrap-inputmask.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/jquery-tags-input/jquery.tagsinput.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/jquery-pwstrength/jquery.pwstrength.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-fileupload/bootstrap-fileupload.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-duallistbox/duallistbox/bootstrap-duallistbox.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/dropzone/downloads/dropzone.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/clockface/js/clockface.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-daterangepicker/date.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-daterangepicker/daterangepicker.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-switch/static/js/bootstrap-switch.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-wysihtml5/bootstrap-wysihtml5.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/ckeditor/ckeditor.js"></script>

	<!--flaty scripts-->
	<script src="${pageContext.request.contextPath}/resources/js/flaty.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/flaty-demo-codes.js"></script>



	<script type="text/javascript">
		document.getElementById('submitForm').onsubmit = function() {
			return check();
		};
	</script>


	<script type="text/javascript">
		function check() {

			var vendId = $("#vendId").val();
			var mrnId = $("#mrnId").val();
			var basicVal = document.getElementById('mrnBasicValue').value;

			if (vendId == null || vendId == "") {
				alert("Select Vendor");
				return false;
			} else if (mrnId == null || mrnId == "") {
				alert("Select MRN ");
				return false;
			} else if (basicVal == null || basicVal == "" || basicVal <= 0) {
				alert("Bill Amount is Zero! ");
				return false;
			}
		}
	</script>



	<script type="text/javascript">
		var specialKeys = new Array();
		specialKeys.push(8); //Backspace
		function IsNumeric(e) {
			var keyCode = e.which ? e.which : e.keyCode
			var ret = ((keyCode >= 48 && keyCode <= 57)
					|| specialKeys.indexOf(keyCode) != -1 || keyCode == 9);
			// document.getElementById("error").style.display = ret ? "none" : "inline";
			return ret;
		}
	</script>



	<script type="text/javascript">
		function getMRNList(vendorId) {

			$.getJSON('${getAllMrnHeaderByVendor}', {

				vendorId : vendorId,
				ajax : 'true',

			}, function(data) {

				var html = '<option value="">Select MRN</option>';

				var len = data.length;
				for (var i = 0; i < len; i++) {
					html += '<option value="' + data[i].mrnId + '">'
							+ data[i].mrnNo + '&nbsp;&nbsp;&nbsp;'
							+ data[i].mrnDate + '</option>';
				}
				html += '</option>';
				$('#mrnId').html(html);
				$("#mrnId").trigger("chosen:updated");

			});

		}
	</script>

	<script type="text/javascript">
		function getCustBillNo(mrnId) {
			//alert(mrnId);

			$.getJSON('${getCustBillNoFromMRN}', {
				mrnId : mrnId,
				ajax : 'true',
			}, function(data) {
				//alert("0"+data);

				document.getElementById('custBillNo').value = data.message;

			});

			getMRNNo(mrnId);
			itemByIntendId(mrnId);

		}

		function getMRNNo(mrnId) {

			$.getJSON('${getMRNNoById}', {
				mrnId : mrnId,
				ajax : 'true',
			}, function(data) {
				//alert(JSON.stringify(data));

				document.getElementById('mrnNo').value = data.message;

			});

		}
	</script>


	<script type="text/javascript">
		function itemByIntendId(mrnId) {

			$('#loader').show();

			$.getJSON('${geMRNDetailByMRNId}', {

				mrnId : mrnId,
				ajax : 'true'

			}, function(data) {

				setTableData(data);

			});

			//calculateOtherValues();

			setTimeout(calculateOtherValues, 1000);

		}
	</script>


	<!--  -->

	<script type="text/javascript">
		function getAccLevelItems() {

			$('#loader').show();

			$
					.getJSON(
							'${getAccLevelItemList}',
							{
								ajax : 'true'
							},
							function(data) {

								$('#table_grid1 td').remove();
								$('#loader').hide();

								if (data == "") {
									alert("No records found !!");
								}

								$
										.each(
												data,
												function(key, itemList) {

													var tr = $('<tr></tr>');

													tr
															.append($(
																	'<td></td>')
																	.html(
																			'<input type="checkbox" class="item-checkbox" name="select_to_approve"'
																					+ 'id="select_to_approve'
																					+ itemList.mrnDetailId
																					+ '" onchange="requiredField('
																					+ itemList.mrnDetailId
																					+ ')" value="'
																					+ itemList.mrnDetailId
																					+ '" >'));

													tr
															.append($(
																	'<td></td>')
																	.html(
																			key + 1));

													tr
															.append($(
																	'<td style="text-align:right; display:none;"></td>')
																	.html(
																			'<input style="text-align:right; width:50px" type="text" id="itemId'
																			+ itemList.mrnDetailId
																			+ '" name="itemId'
																			+ itemList.mrnDetailId
																			+ '" value="'
																			+ itemList.itemId
																			+ '" class="form-control item-id" readonly>'));

													tr
															.append($(
																	'<td style="text-align:right; display:none;"></td>')
																	.html(
																			'<input style="text-align:right; width:50px" type="text" id="itemId'
																	+ itemList.mrnDetailId
																	+ '" name="itemId'
																	+ itemList.mrnDetailId
																	+ '" value="'
																	+ itemList.mrnDetailId
																	+ '" class="form-control item-mrn-id" readonly>'));

													tr
															.append($(
																	'<td></td>')
																	.html(
																			itemList.itemName));

													tr
															.append($(
																	'<td></td>')
																	.html(
																			itemList.itemUom));

													tr
															.append($(
																	'<td style="text-align:right;"></td>')
																	.html(
																			'<input style="text-align:right; width:120px" type="text" id="itemMrnQty'
																					+ itemList.mrnDetailId
																					+ '" name="itemMrnQty'
																					+ itemList.mrnDetailId
																					+ '" value="'
																					+ itemList.mrnQty
																					+ '" oninput="calValues('
																					+ itemList.mrnDetailId
																					+ ')"  class="form-control"  pattern="[+-]?([0-9]*[.])?[0-9]+"  readonly>'));

													tr
															.append($(
																	'<td style="text-align:right;"></td>')
																	.html(
																			'<input style="text-align:right; width:120px" type="text" id="itemRate'
																					+ itemList.mrnDetailId
																					+ '" name="itemRate'
																					+ itemList.mrnDetailId
																					+ '" value="'
																					+ itemList.itemRate
																					+ '" oninput="checkAccLevelItem()"  class="form-control item-rate-value"  pattern="[+-]?([0-9]*[.])?[0-9]+"  required>'));

													tr
															.append($(
																	'<td style="text-align:right;"></td>')
																	.html(
																			'<input style="text-align:right; width:120px" type="text" id="itemTaxable'
																					+ itemList.mrnDetailId
																					+ '" name="itemTaxable'
																					+ itemList.mrnDetailId
																					+ '" value="'
																					+ (itemList.itemRate * itemList.mrnQty)
																					+ '"  class="form-control item-taxable-value"  readonly>'));

													tr
															.append($(
																	'<td style="text-align:right;"></td>')
																	.html(
																			'<input style="text-align:right; width:120px" type="text" id="itemTaxPer'
																					+ itemList.mrnDetailId
																					+ '" name="itemTaxPer'
																					+ itemList.mrnDetailId
																					+ '" value="'
																					+ (itemList.cgst + itemList.sgst)
																					+ '" class="form-control item-tax-per"  readonly>'));

													tr
															.append($(
																	'<td style="text-align:right;"></td>')
																	.html(
																			'<input style="text-align:right; width:120px" type="text" id="itemTaxVal'
																					+ itemList.mrnDetailId
																					+ '" name="itemTaxVal'
																					+ itemList.mrnDetailId
																					+ '" value="'
																					+ (itemList.itemRate * itemList.mrnQty)
																					* ((itemList.cgst + itemList.sgst) / 100)
																					+ '" class="form-control item-tax-value"  readonly>'));

													var tot = ((itemList.itemRate * itemList.mrnQty) + ((itemList.itemRate * itemList.mrnQty) * ((itemList.cgst + itemList.sgst) / 100)));

													tr
															.append($(
																	'<td style="text-align:right;"></td>')
																	.html(
																			'<input style="text-align:right; width:120px" type="text" id="itemTot'
																					+ itemList.mrnDetailId
																					+ '" name="itemTot'
																					+ itemList.mrnDetailId
																					+ '" value="'
																					+ tot
																					+ '" class="form-control item-tot-value"  readonly>'));

													$('#table_grid1 tbody')
															.append(tr);

												})

							});

			//calculateOtherValues();

			//setTimeout(calculateOtherValues, 1000);

		}
	</script>

	<!--  -->


	<script type="text/javascript">
		function calValues(id) {

			var qty = document.getElementById('mrnQty' + id).value;
			var rate = document.getElementById('rate' + id).value;
			var taxPer = document.getElementById('taxPer' + id).value;

			var taxable = qty * rate;
			document.getElementById('taxable' + id).value = taxable;

			var taxVal = taxable * (taxPer / 100);
			document.getElementById('taxVal' + id).value = taxVal;

			var tot = taxable + taxVal;
			document.getElementById('tot' + id).value = tot;

			//var t = document.getElementsByClassName("taxable-value")[0].value;
			//alert(t);

			calculateOtherValues();

		}
	</script>


	<script type="text/javascript">
		function checkPackPerValue() {

			var packPer = $("#packPer").val();

			if (packPer <= 0) {
				document.getElementById('packValue').value = 0;
			}

			calculateOtherValues();

		}
	</script>

	<script type="text/javascript">
		function checkInscPerValue() {

			var inscPer = $("#insuPer").val();

			if (inscPer <= 0) {
				document.getElementById('insuValue').value = 0;
			}

			calculateOtherValues();

		}
	</script>

	<script type="text/javascript">
		function checkFreightPerValue() {

			var freightPer = $("#freightPer").val();

			if (freightPer <= 0) {
				document.getElementById('freightValue').value = 0;
			}

			calculateOtherValues();

		}
	</script>

	<script type="text/javascript">
		function checkOtherPerValue() {

			var otherPer = $("#otherPer").val();

			if (otherPer <= 0) {
				document.getElementById('otherValue').value = 0;
			}

			calculateOtherValues();

		}
	</script>


	<script type="text/javascript">
		function calculateOtherValues() {

			var packPer = $("#packPer").val();
			var insuPer = $("#insuPer").val();
			var freightPer = $("#freightPer").val();
			var otherPer = $("#otherPer").val();

			var basicVal = 0;
			var taxableTotalVal = 0;

			$(".taxable-value")
					.each(
							function(counter) {
								//alert(counter);
								basicVal = parseFloat(basicVal)
										+ parseFloat(document
												.getElementsByClassName("taxable-value")[counter].value);
							});
			document.getElementById('mrnBasicValue').value = basicVal;

			//------------------PACK VALUE--------------------------------------------------------

			var packValue = 0;

			if (parseFloat(packPer) > 0) {

				packValue = (parseFloat(packPer) / 100) * parseFloat(basicVal);

				document.getElementById('packValue').value = packValue
						.toFixed(2);

			} else {
				document.getElementById('packPer').value = 0;

				packValue = parseFloat(document.getElementById('packValue').value);

			}

			//------------------INSURANCE VALUE--------------------------------------------------------

			var insValue = 0;

			if (parseFloat(insuPer) > 0) {

				insValue = (parseFloat(insuPer) / 100) * parseFloat(basicVal);

				document.getElementById('insuValue').value = insValue
						.toFixed(2);

			} else {
				document.getElementById('insuPer').value = 0;

				insValue = parseFloat(document.getElementById('insuValue').value);

			}

			//------------------FREIGHT VALUE--------------------------------------------------------

			var frValue = 0;

			if (parseFloat(freightPer) > 0) {

				frValue = (parseFloat(freightPer) / 100) * parseFloat(basicVal);

				document.getElementById('freightValue').value = frValue
						.toFixed(2);

			} else {
				document.getElementById('freightPer').value = 0;

				frValue = parseFloat(document.getElementById('freightValue').value);

			}

			//-------------------------------------------------------------------

			var taxVal = 0;
			var discVal = 0;
			$(".tax-value")
					.each(
							function(counter) {
								//alert(counter);

								var taxableVal = document
										.getElementsByClassName("taxable-value")[counter].value;

								var divFactor = ((parseFloat(taxableVal) / parseFloat(basicVal)) * 100);

								var addPack = ((parseFloat(divFactor) * parseFloat(packValue)) / 100);
								var addInsc = ((parseFloat(divFactor) * parseFloat(insValue)) / 100);
								var addFreight = ((parseFloat(divFactor) * parseFloat(frValue)) / 100);

								var addTot = parseFloat(addPack)
										+ parseFloat(addInsc)
										+ parseFloat(addFreight);

								var taxableTot = parseFloat(taxableVal)
										+ parseFloat(addTot);

								document.getElementsByClassName("add-value")[counter].value = addTot
										.toFixed(2);

								document
										.getElementsByClassName("taxable-add-value")[counter].value = taxableTot
										.toFixed(2);

								var taxPer = document
										.getElementsByClassName("tax-per")[counter].value;

								var tax = (parseFloat(taxPer / 100) * taxableTot);

								document.getElementsByClassName("tax-value")[counter].value = tax
										.toFixed(2);

								var tot = parseFloat(taxableTot)
										+ parseFloat(tax);

								document.getElementsByClassName("tot-value")[counter].value = tot
										.toFixed(2);

								taxVal = parseFloat(taxVal) + parseFloat(tax);

								discVal = parseFloat(discVal)
										+ parseFloat(document
												.getElementsByClassName("disc-value")[counter].value);

								taxableTotalVal = parseFloat(taxableTotalVal)
										+ parseFloat(taxableTot);

							});

			document.getElementById('taxValue').value = taxVal.toFixed(2);
			document.getElementById('taxableTot').value = taxableTotalVal
					.toFixed(2);

			//--------------------------------------------------------------------------

			var tempVal = parseFloat(basicVal) + parseFloat(packValue)
					+ parseFloat(insValue) + parseFloat(frValue)
					+ parseFloat(taxVal) - parseFloat(discVal);
			//alert(tempVal);

			//------------------OTHER VALUE--------------------------------------------------------

			var otherValue = 0;

			if (parseFloat(otherPer) > 0) {

				otherValue = ((parseFloat(otherPer) / 100) * parseFloat(tempVal))
						.toFixed(2);

				document.getElementById('otherValue').value = otherValue
						.toFixed(2);

			} else {
				document.getElementById('otherPer').value = 0;

				otherValue = parseFloat(document.getElementById('otherValue').value);

			}

			//-----------FINAL TOTAL------------------------------

			var finTotal = parseFloat(tempVal) + parseFloat(otherValue);
			document.getElementById('finalValue').value = finTotal.toFixed(2);

		}
	</script>

	<script type="text/javascript">
		function openModal() {

			var vendId = $("#vendId").val();
			var mrnId = $("#mrnId").val();

			if (vendId == null || vendId == "") {
				alert("Select Vendor");
			} else if (mrnId == null || mrnId == "") {
				alert("Select MRN ");
			} else {

				var modal = document.getElementById('myModal');
				modal.style.display = "block";
				getAccLevelItems();
			}
		}
	</script>


	<script>
		var modal = document.getElementById('myModal');
		var btn = document.getElementById("myBtn");

		var span = document.getElementById("close");

		btn.onclick = function() {
			modal.style.display = "block";
		}

		span.onclick = function() {
			modal.style.display = "none";
		}

		window.onclick = function(event) {
			if (event.target == modal) {
				modal.style.display = "none";
			}
		}
	</script>

	<script type="text/javascript">
		function checkAccLevelItem() {

			$(".item-taxable-value")
					.each(
							function(counter) {

								if (document
										.getElementsByClassName("item-rate-value")[counter].value > 0) {
									document
											.getElementsByClassName("item-checkbox")[counter].checked = true;

									var rate = parseFloat(document
											.getElementsByClassName("item-rate-value")[counter].value);
									document
											.getElementsByClassName("item-taxable-value")[counter].value = rate;

									var taxPer = parseFloat(document
											.getElementsByClassName("item-tax-per")[counter].value);

									var taxVal = (taxPer / 100) * rate;
									document
											.getElementsByClassName("item-tax-value")[counter].value = taxVal
											.toFixed(2);

									var tot = rate + taxVal;
									document
											.getElementsByClassName("item-tot-value")[counter].value = tot;

								} else {
									document
											.getElementsByClassName("item-checkbox")[counter].checked = false;

									document
											.getElementsByClassName("item-taxable-value")[counter].value = 0;

									document
											.getElementsByClassName("item-tax-value")[counter].value = 0;

									document
											.getElementsByClassName("item-tot-value")[counter].value = 0;

								}

							});

		}
	</script>


	<script type="text/javascript">
		function setAccLvlItemToDetailList() {

			var itemList = [];

			$(".item-taxable-value")
					.each(
							function(counter) {

								if (document
										.getElementsByClassName("item-rate-value")[counter].value > 0) {

									var itemId = document
											.getElementsByClassName("item-id")[counter].value;
									var itemRate = document
											.getElementsByClassName("item-rate-value")[counter].value;

									var item = {
										id : itemId,
										rate : itemRate
									}

									itemList.push(item);
								}

							});

			//alert(JSON.stringify(itemList));

			$.getJSON('${geMRNDetailWithAccLevelItems}', {
				jsonStr : JSON.stringify(itemList),
				ajax : 'true'
			}, function(data) {

				setTableData(data);

				var modal = document.getElementById('myModal');
				modal.style.display = "none";

			});

		}
	</script>


	<script type="text/javascript">
		function setTableData(data) {

			$('#table_grid2 td').remove();
			$('#loader').hide();

			if (data == "") {
				alert("No records found !!");

			}

			$
					.each(
							data,
							function(key, itemList) {

								var tr = $('<tr></tr>');

								tr.append($('<td></td>').html(
										key + 1));

								tr.append($('<td style="width: 20%;"></td>').html(
										itemList.itemName));

								tr.append($('<td style="text-align:right; width:80px"></td>').html(
										itemList.itemUom));

								tr
										.append($(
												'<td style="text-align:right;"></td>')
												.html(
														'<input style="text-align:right; width:70px" type="text" id="mrnQty'
																+ itemList.mrnDetailId
																+ '" name="mrnQty'
																+ itemList.mrnDetailId
																+ '" value="'
																+ itemList.approveQty.toFixed(2)
																+ '" oninput="calValues('
																+ itemList.mrnDetailId
																+ ')"  class="form-control"  pattern="[+-]?([0-9]*[.])?[0-9]+"  required>'));

								tr
										.append($(
												'<td style="text-align:right;"></td>')
												.html(itemList.itemRate));

								tr
										.append($(
												'<td style="text-align:right;"></td>')
												.html(
														'<input style="text-align:right; width:80px" type="text" id="rate'
																+ itemList.mrnDetailId
																+ '" name="rate'
																+ itemList.mrnDetailId
																+ '" value="'
																+ itemList.itemRate.toFixed(2)
																+ '" oninput="calValues('
																+ itemList.mrnDetailId
																+ ')"  class="form-control"  pattern="[+-]?([0-9]*[.])?[0-9]+"  required>'));

								tr
										.append($(
												'<td style="text-align:right;"></td>')
												.html(
														'<input style="text-align:right; width:90px" type="text" id="taxable'
																+ itemList.mrnDetailId
																+ '" name="taxable'
																+ itemList.mrnDetailId
																+ '" value="'
																+ (itemList.itemRate * itemList.mrnQty).toFixed(2)
																+ '"  class="form-control taxable-value"  readonly>'));

								tr
										.append($(
												'<td style="text-align:right;"></td>')
												.html(
														'<input style="text-align:right; width:80px" type="text" id="add'
													+ itemList.mrnDetailId
													+ '" name="add'
													+ itemList.mrnDetailId
													+ '" value="0"  class="form-control add-value"  readonly>'));

								tr
										.append($(
												'<td style="text-align:right;"></td>')
												.html(
														'<input style="text-align:right; width:90px" type="text" id="taxableAdd'
																+ itemList.mrnDetailId
																+ '" name="taxableAdd'
																+ itemList.mrnDetailId
																+ '" value="'
																+ (itemList.itemRate * itemList.mrnQty).toFixed(2)
																+ '"  class="form-control taxable-add-value"  readonly>'));

								var tot = 0;

								if (itemList.mrnId == 0) {
									tr
											.append($(
													'<td style="text-align:right;"></td>')
													.html(
															'<input style="text-align:right; width:60px" type="text" id="taxPer'
																	+ itemList.mrnDetailId
																	+ '" name="taxPer'
																	+ itemList.mrnDetailId
																	+ '" value="'
																	+ itemList.igst
																	+ '" class="form-control tax-per"  readonly>'));

									tr
											.append($(
													'<td style="text-align:right;"></td>')
													.html(
															'<input style="text-align:right; width:60px" type="text" id="taxVal'
																	+ itemList.mrnDetailId
																	+ '" name="taxVal'
																	+ itemList.mrnDetailId
																	+ '" value="'
																	+ (itemList.itemRate * itemList.mrnQty)
																	* (itemList.igst / 100).toFixed(2)
																	+ '" class="form-control tax-value"  readonly>'));

									tot = ((itemList.itemRate * itemList.mrnQty) + ((itemList.itemRate * itemList.mrnQty) * (itemList.igst / 100)));

								} else {
									tr
											.append($(
													'<td style="text-align:right;"></td>')
													.html(
															'<input style="text-align:right; width:90px" type="text" id="taxPer'
																	+ itemList.mrnDetailId
																	+ '" name="taxPer'
																	+ itemList.mrnDetailId
																	+ '" value="'
																	+ (itemList.cgst
																			+ itemList.sgst + itemList.igst).toFixed(2)
																	+ '" class="form-control tax-per"  readonly>'));

									tr
											.append($(
													'<td style="text-align:right;"></td>')
													.html(
															'<input style="text-align:right; width:90px" type="text" id="taxVal'
																	+ itemList.mrnDetailId
																	+ '" name="taxVal'
																	+ itemList.mrnDetailId
																	+ '" value="'
																	+ (itemList.itemRate * itemList.mrnQty)
																	* ((itemList.cgst
																			+ itemList.sgst + itemList.igst) / 100).toFixed(2)
																	+ '" class="form-control tax-value"  readonly>'));

									tot = ((itemList.itemRate * itemList.mrnQty) + ((itemList.itemRate * itemList.mrnQty) * ((itemList.cgst
											+ itemList.sgst + itemList.igst) / 100)));

								}

								tr
										.append($(
												'<td style="text-align:right;"></td>')
												.html(
														'<input style="text-align:right; width:90px" type="text" id="tot'
															+ itemList.mrnDetailId
															+ '" name="tot'
															+ itemList.mrnDetailId
															+ '" value="'
															+ tot.toFixed(2)
															+ '" class="form-control tot-value"  readonly>'));

								tr
										.append($(
												'<td style="text-align:right; display:none;"></td>')
												.html(
														'<input style="text-align:right; width:90px" type="text" id="disc'
													+ itemList.mrnDetailId
													+ '" name="disc'
													+ itemList.mrnDetailId
													+ '" value="'
													+ itemList.discValue.toFixed(2)
													+ '" class="form-control disc-value"  readonly>'));

								$('#table_grid2 tbody').append(tr);

							})

			setTimeout(calculateOtherValues, 1000);

		}
	</script>




</body>
</html>