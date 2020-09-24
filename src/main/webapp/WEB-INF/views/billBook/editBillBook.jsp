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

.th {
	text-align: center;
	position: sticky;
	top: 0;
	z-index: 5;
	background: #f95d64;
	color: white !important;
}
</style>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body onload="calculateOtherValues()">

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
					<i class="fa fa-bars"></i>Edit Bill Book
				</h3>
				<div class="box-tool">
					<a href="${pageContext.request.contextPath}/addBillBook"> ADD
						Bill </a> <a href="${pageContext.request.contextPath}/getBillBookList">
						Bill List</a> <a data-action="collapse" href="#"><i
						class="fa fa-chevron-up"></i></a>
				</div>

			</div>

			<div class=" box-content">

				<div>
					<form id="submitForm"
						action="${pageContext.request.contextPath}/submitEditBillBook"
						method="post">


						<div class="box-content">

							<div class="col-md-2">Bill No.</div>
							<div class="col-md-4">
								<input type="text" id="billNo" name="billNo"
									value="${billHeader.billNo}" readonly class="form-control">
								<input type="hidden" id="billId" name="billId"
									value="${billHeader.billId}" readonly class="form-control">
							</div>
							<div class="col-md-2">Bill Date</div>
							<div class="col-md-4">
								<input type="text" id="billDate" name="billDate"
									value="${billDate}" class="form-control date-picker" readonly>

							</div>

						</div>
						<br />

						<c:set var="indentDate" value="-"></c:set>
						<div class="box-content">



							<div class="col-md-2">Vendor Name</div>
							<div class="col-md-4">

								<input type="text" id="vendName" name="vendName"
									value="${billHeader.vendQuation}" readonly class="form-control">

							</div>

							<div class="col-md-2">Select MRN No.</div>
							<div class="col-md-4">

								<input type="text" id="mrnNo" name="mrnNo"
									value="${billHeader.mrnNo}" readonly class="form-control">

							</div>


						</div>
						<br />

						<div class="box-content">
							<div class="col-md-2">Customer Bill No.</div>
							<div class="col-md-4">
								<input type="text" placeholder="Customer Bill No"
									value="${billHeader.billRemark}" name="custBillNo"
									id="custBillNo" class="form-control" readonly="readonly">
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

												<th width="2%" class="th">SR</th>
												<th class="col-md-3 th" style="text-align: center;">Item
													Name</th>
												<th class="col-md-1 th" style="text-align: center;">Uom</th>
												<th class="col-md-1 th" style="text-align: center;">MRN
													Qty</th>
												<th class="col-md-1 th" style="text-align: center;">Bill
													Rate</th>

												<th class="col-md-1 th" style="text-align: center;">Total</th>

												<th class="col-md-1 th" style="text-align: center;">Additional
													Charges</th>

												<th class="col-md-1 th" style="text-align: center;">Taxable
												</th>
												<th class="col-md-1 th" style="text-align: center;">Tax
													Per</th>
												<th class="col-md-1 th" style="text-align: center;">Tax
													Value</th>
												<th class="col-md-1 th" style="text-align: center;">Grand
													Total</th>

											</tr>
										</thead>
										<tbody>

											<c:forEach items="${billHeader.billBookDetail}"
												var="billDetail" varStatus="count">

												<tr>

													<td style="width: 2%;"><c:out value="${count.index+1}" /></td>
													<td>${billDetail.itemDesc}</td>
													<td>${billDetail.itemUom}</td>

													<td><input style="text-align: right; width: 120px"
														type="text" id="mrnQty${billDetail.billDetailId}"
														name="mrnQty${billDetail.billDetailId}"
														oninput="calValues(${billDetail.billDetailId})"
														value="${billDetail.mrnQty}" class="form-control"
														pattern="[+-]?([0-9]*[.])?[0-9]+"></td>

													<td><input style="text-align: right; width: 120px"
														type="text" id="rate${billDetail.billDetailId}"
														name="rate${billDetail.billDetailId}"
														oninput="calValues(${billDetail.billDetailId})"
														value="${billDetail.itemRate}" class="form-control"
														pattern="[+-]?([0-9]*[.])?[0-9]+"></td>

													<td><input style="text-align: right; width: 120px"
														type="text" id="taxable${billDetail.billDetailId}"
														name="taxable${billDetail.billDetailId}"
														value="${billDetail.basicValue}"
														class="form-control taxable-value"
														pattern="[+-]?([0-9]*[.])?[0-9]+" readonly="readonly"></td>

													<td><input style="text-align: right; width: 120px"
														type="text" id="add${billDetail.billDetailId}"
														name="add${billDetail.billDetailId}"
														value="${billDetail.basicValue}"
														class="form-control add-value"
														pattern="[+-]?([0-9]*[.])?[0-9]+" readonly="readonly"></td>

													<td><input style="text-align: right; width: 120px"
														type="text" id="taxableAdd${billDetail.billDetailId}"
														name="taxableAdd${billDetail.billDetailId}"
														value="${billDetail.basicValue}"
														class="form-control taxable-add-value"
														pattern="[+-]?([0-9]*[.])?[0-9]+" readonly="readonly"></td>


													<c:choose>

														<c:when test="${billDetail.mrnDetailId==0}">
															<td><input style="text-align: right; width: 120px"
																type="text" id="taxPer${billDetail.billDetailId}"
																name="taxPer${billDetail.billDetailId}"
																value="${billDetail.igst}" class="form-control tax-per"
																pattern="[+-]?([0-9]*[.])?[0-9]+" readonly="readonly"></td>
														</c:when>

														<c:otherwise>
															<td><input style="text-align: right; width: 120px"
																type="text" id="taxPer${billDetail.billDetailId}"
																name="taxPer${billDetail.billDetailId}"
																value="${billDetail.cgst+billDetail.sgst+billDetail.igst}"
																class="form-control tax-per"
																pattern="[+-]?([0-9]*[.])?[0-9]+" readonly="readonly"></td>
														</c:otherwise>

													</c:choose>

													<td><input style="text-align: right; width: 120px"
														type="text" id="taxVal${billDetail.billDetailId}"
														name="taxVal${billDetail.billDetailId}"
														value="${billDetail.taxValue}"
														class="form-control tax-value"
														pattern="[+-]?([0-9]*[.])?[0-9]+" readonly="readonly"></td>

													<td><input style="text-align: right; width: 120px"
														type="text" id="tot${billDetail.billDetailId}"
														name="tot${billDetail.billDetailId}"
														value="${billDetail.landingCost}"
														class="form-control tot-value"
														pattern="[+-]?([0-9]*[.])?[0-9]+" readonly="readonly"></td>

													<td style="display: none;"><input
														style="text-align: right; width: 120px" type="text"
														id="disc${billDetail.billDetailId}"
														name="disc${billDetail.billDetailId}"
														value="${billDetail.discValue}"
														class="form-control disc-value" readonly="readonly"></td>

												</tr>

											</c:forEach>

										</tbody>
									</table>
								</div>
							</div>

						</div>
						<br />
						<hr />
						<br>


						<!-- --------------------------------------- -->

						<div class="box-content">

							<div class="col-md-2">Basic value</div>
							<div class="col-md-2">
								<input style="text-align: right; width: 150px" type="text"
									value="${billHeader.billBasicValue}"
									pattern="[+-]?([0-9]*[.])?[0-9]+" name="mrnBasicValue"
									id="mrnBasicValue" class="form-control" readonly>
							</div>
							<div class="col-md-2"></div>



						</div>
						<br>
						<div class="box-content">

							<div class="col-md-2">Packing Charges %</div>
							<div class="col-md-2">
								<input style="text-align: right; width: 150px"
									oninput="checkPackPerValue()" type="text"
									value="${billHeader.billPackPer}"
									pattern="[+-]?([0-9]*[.])?[0-9]+" name="packPer" id="packPer"
									class="form-control" required>
							</div>
							<div class="col-md-2">
								Packing Charges Value <i class="fa fa-inr"
									style="font-size: 13px"></i>
							</div>
							<div class="col-md-2">
								<input style="text-align: right; width: 150px" type="text"
									name="packValue" id="packValue" class="form-control"
									value="${billHeader.billPackVal}"
									pattern="[+-]?([0-9]*[.])?[0-9]+" required
									oninput="calculateOtherValues()">
							</div>
							<div class="col-md-2">Remark</div>
							<div class="col-md-2">
								<input type="text" name="packRemark" id="packRemark"
									class="form-control" value="${billHeader.billPackRemark}">
							</div>


						</div>
						<br>
						<div class="box-content">
							<div class="col-md-2">Insurance Charges %</div>
							<div class="col-md-2">
								<input style="text-align: right; width: 150px"
									oninput="checkInscPerValue()" type="text"
									value="${billHeader.billInsuPer}"
									pattern="[+-]?([0-9]*[.])?[0-9]+" name="insuPer" id="insuPer"
									class="form-control" required>
							</div>
							<div class="col-md-2">
								Insurance Charges Value <i class="fa fa-inr"
									style="font-size: 13px"></i>
							</div>
							<div class="col-md-2">
								<input style="text-align: right; width: 150px" type="text"
									name="insuValue" id="insuValue" class="form-control"
									value="${billHeader.billInsuVal}"
									pattern="[+-]?([0-9]*[.])?[0-9]+" required
									oninput="calculateOtherValues()">
							</div>
							<div class="col-md-2">Remark</div>
							<div class="col-md-2">
								<input type="text" name="insuRemark" id="insuRemark"
									class="form-control" value="${billHeader.billInsuRemark}">
							</div>

						</div>
						<br>

						<div class="box-content">

							<div class="col-md-2">Freight Charges %</div>
							<div class="col-md-2">
								<input style="text-align: right; width: 150px"
									oninput="checkFreightPerValue()" type="text"
									value="${billHeader.billFrtPer}"
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
									value="${billHeader.billFrtVal}"
									pattern="[+-]?([0-9]*[.])?[0-9]+" required
									oninput="calculateOtherValues()">
							</div>
							<div class="col-md-2">Remark</div>
							<div class="col-md-2">
								<input type="text" name="freghtRemark" id="freghtRemark"
									class="form-control" value="${billHeader.billFrtRemark}">
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
									name="taxValue" id="taxValue" class="form-control"
									value="${billHeader.billTaxValue}"
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
									oninput="checkOtherPerValue()"
									value="${billHeader.otherChargeBefore}"
									pattern="[+-]?([0-9]*[.])?[0-9]+" name="otherPer" id="otherPer"
									class="form-control" required>
							</div>
							<div class="col-md-2">
								Other Charges Value <i class="fa fa-inr" style="font-size: 13px"></i>
							</div>
							<div class="col-md-2">
								<input style="text-align: right; width: 150px" type="text"
									name="otherValue" id="otherValue" class="form-control"
									value="${billHeader.otherChargeAfter}"
									pattern="[+-]?([0-9]*[.])?[0-9]+" required
									oninput="calculateOtherValues()">
							</div>
							<div class="col-md-2">Remark</div>
							<div class="col-md-2">
								<input type="text" name="otherRemark" id="otherRemark"
									class="form-control"
									value="${billHeader.otherChargeAfterRemark}">
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
									value="${billHeader.totalValue}"
									pattern="[+-]?([0-9]*[.])?[0-9]+" readonly>
							</div>



						</div>

						<!-- --------------------------------------- -->



						<br> <br>

						<div class="row">
							<div class="col-md-12" style="text-align: center">

								<input type="submit" class="btn btn-info" value="Submit">

							</div>
						</div>

					</form>




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
		var modal = document.getElementById('myModal');

		var btn = document.getElementById("myBtn");

		var span = document.getElementById("close");

		btn.onclick = function() {

			var mrnId = $("#mrnId").val();
			var vendId = $("#vendId").val();

			if (vendId == "" || vendId == null) {
				alert("select Vendor ");

			} else if (mrnId == "" || mrnId == null) {
				alert("select MRN No. ");

			} else {
				modal.style.display = "block";
				itemByIntendId(mrnId);
				getValue();
			}

		}

		span.onclick = function() {
			modal.style.display = "none";
		}

		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
			if (event.target == modal) {
				modal.style.display = "none";
			}
		}
	</script>







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


</body>
</html>