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
<body>

	<c:url var="getAllVendorListAjax" value="/getAllVendorListAjax" />
	<c:url var="getSettledBillReceiptList"
		value="/getSettledBillReceiptList" />



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
					<i class="fa fa-bars"></i>Bill Receipt List
				</h3>
			</div>

			<div class=" box-content">



				<div class="box-content">


					<div class="col-md-2">From Date</div>

					<div class="col-md-4">
						<input type="text" id="fromDate" name="fromDate" value="${date}"
							class="form-control date-picker" required>
					</div>

					<div class="col-md-2">To Date</div>

					<div class="col-md-4">
						<input type="text" id="toDate" name="toDate" value="${date}"
							class="form-control date-picker" required>
					</div>

				</div>

				<br> <br>

				<div class="box-content">

					<div class="col-md-2">Vendor</div>
					<div class="col-md-8">
						<select name="vendId" id="vendId" class="form-control chosen"
							multiple="multiple" onchange="setAllVendorSelected(this.value)">

							<option value="-1">All</option>
							<c:forEach items="${vendorList}" var="vendorList">
								<option value="${vendorList.vendorId}">${vendorList.vendorName}</option>
							</c:forEach>

						</select>
					</div>


					<div class="col-md-2">
						<input type="button" class="btn btn-info" value="Search"
							onclick="getBills()">
					</div>

				</div>



				<div align="center" id="loader" style="display: none;">
					<br> <span>
						<h4>
							<font color="#343690">Loading</font>
						</h4>
					</span> <span class="l-1"></span> <span class="l-2"></span> <span
						class="l-3"></span> <span class="l-4"></span> <span class="l-5"></span>
					<span class="l-6"></span>
				</div>

				<br> <br>

				<!-- ******************************************************** -->



				<div class=" box-content">
					<div class="row">
						<div style="overflow: scroll; width: 100%; overflow: auto">
							<table width="100%" border="0"
								class="table table-bordered table-striped fill-head "
								style="width: 100%; font-size: 14px;" id="table_grid2">
								<thead>
									<tr>

										<th class="th" width="2%">SR</th>
										<th class="col-md-1 th">Vendor</th>
										<th class="col-md-1 th">Date</th>
										<th class="col-md-1 th">Bill Receipt No</th>
										<th class="col-md-1 th">Amount</th>
										<th class="col-md-1 th">Payment Mode</th>
										<th class="col-md-1 th">Action</th>


									</tr>
								</thead>
								<tbody>

									<c:forEach items="${billRecList}" var="br" varStatus="count">

										<tr>

											<td style="width: 2%;"><c:out value="${count.index+1}" /></td>
											<td>${br.vendorName}</td>
											<td style="text-align: center;">${br.brDate}</td>
											<td style="text-align: center;">${br.brNo}</td>
											<td style="text-align: right;">${br.amt}</td>

											<c:set value="" var="payMode"></c:set>
											<c:choose>

												<c:when test="${br.payMode==1}">
													<c:set value="Cash" var="payMode"></c:set>
												</c:when>

												<c:when test="${br.payMode==2}">
													<c:set value="Cheque" var="payMode"></c:set>
												</c:when>

												<c:when test="${br.payMode==3}">
													<c:set value="Bank Transfer" var="payMode"></c:set>
												</c:when>

												<c:when test="${br.payMode==4}">
													<c:set value="E-Payment" var="payMode"></c:set>
												</c:when>

											</c:choose>

											<td>${payMode}</td>

											<td style="text-align: center;"><a href="javascript:genPdf(${ br.brId});" title="PDF"><i
													class="fa fa-file" style="font-size: 20px"></a></td>

										</tr>

									</c:forEach>

								</tbody>
							</table>
						</div>
					</div>

				</div>







				<!-- ******************************************************** -->


			</div>
		</div>
	</div>
	<!-- END Main Content -->



	<a id="btn-scrollup" class="btn btn-circle btn-lg" href="#"><i
		class="fa fa-chevron-up"></i></a>






	<!-----------------------SCRIPT-------------------------  -->

	<script type="text/javascript">
		function check() {

			var vendId = $("#vendId").val();
			var settleAmt = $("#enteredAmt").val();
			var payMode = $("#payMode").val();
			var notSettleAmt = $("#notSettleAmt").val();

			if (vendId == '' || vendId == null) {
				alert("Please Select Vendor");
				return false;
			} else if (settleAmt == '' || settleAmt == 0) {
				alert("Please Enter the Amount to be Settled!");
				document.getElementById("enteredAmt").focus();
				return false;
			} else if (notSettleAmt == '' || notSettleAmt == null
					|| notSettleAmt > 0) {
				alert("Amount is not Settled!");
				return false;
			} else if (payMode == '' || payMode == null) {
				alert("Please Select Payment Mode");
				return false;
			}

		}
	</script>


	<script type="text/javascript">
		function getBills() {

			var vendId = $("#vendId").val();
			var fromDate = $("#fromDate").val();
			var toDate = $("#toDate").val();

			if (vendId == '' || vendId == null) {
				alert("Please Select Vendor");
			} else {

				$('#loader').show();

				$.getJSON('${getSettledBillReceiptList}', {
					vendId : JSON.stringify(vendId),
					fromDate : fromDate,
					toDate : toDate,
					ajax : 'true'

				}, function(data) {

					setTableData(data);

				});
			}

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
							function(key, br) {

								var tr = $('<tr></tr>');

								tr.append($('<td></td>').html(key + 1));

								tr.append($('<td></td>').html(br.vendorName));

								tr.append($(
										'<td style="text-align:center;"></td>')
										.html(br.brDate));

								tr.append($(
										'<td style="text-align:center;"></td>')
										.html(br.brNo));

								tr.append($(
										'<td style="text-align:right;"></td>')
										.html(br.amt));

								var payMode = "";
								if (br.payMode == 1) {
									payMode = "Cash";
								} else if (br.payMode == 2) {
									payMode = "Cheque";
								} else if (br.payMode == 3) {
									payMode = "Bank Transfer";
								} else if (br.payMode == 4) {
									payMode = "E-Payment";
								}

								tr.append($('<td></td>').html(payMode));

								tr
										.append($(
												'<td style="text-align:center;"></td>')
												.html(
														'<a href="javascript:genPdf('+br.brId+');" title="PDF"><i class="fa fa-file" style="font-size: 20px"></a>'));

								$('#table_grid2 tbody').append(tr);

							})

		}
	</script>



	<script>
		function setAllVendorSelected(vendId) {

			if (vendId == -1) {

				$.getJSON('${getAllVendorListAjax}', {

					ajax : 'true'
				}, function(data) {

					var len = data.length;

					//alert(len);

					$('#vendId').find('option').remove().end()
					$("#vendId").append($("<option value='-1'>All</option>"));
					for (var i = 0; i < len; i++) {
						$("#vendId").append(
								$("<option selected ></option>").attr("value",
										data[i].vendorId).text(
										data[i].vendorName));
					}
					$("#vendId").trigger("chosen:updated");
				});
			}
		}
	</script>


	<script type="text/javascript">
		function genPdf(id) {

			window.open('pdfForReport?url=/pdf/billReceiptPdf/' + id);

		}
	</script>


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



</body>
</html>