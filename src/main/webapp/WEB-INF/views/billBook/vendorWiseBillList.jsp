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

.pointer-link { 
            cursor: pointer; 
        } 
        
</style>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body onload="getBills(${vendId},${status})">

	<c:url var="getBillsForSettle" value="/getBillsForSettle" />

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
					<i class="fa fa-bars"></i>Generate Bill Receipt
				</h3>
			</div>

			<div class=" box-content">

				<form id="submitForm" onsubmit="return check()"
					action="${pageContext.request.contextPath}/submitBillReceipt"
					method="post">

					<div class="box-content">

						<div class="col-md-1">Vendor</div>
						<div class="col-md-4">
							<select name="vendId" id="vendId" class="form-control chosen">

								<option value="" selected="selected">Select Vendor</option>

								<c:forEach items="${vendorList}" var="vendorList">

									<c:choose>

										<c:when test="${vendId==vendorList.vendorId}">
											<option value="${vendorList.vendorId}" selected="selected">${vendorList.vendorName}</option>
										</c:when>

										<c:otherwise>
											<option value="${vendorList.vendorId}">${vendorList.vendorName}</option>
										</c:otherwise>

									</c:choose>

								</c:forEach>

							</select>
						</div>


						<div class="col-md-7">
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
											<th class="col-md-1 th">Bill No</th>
											<th class="col-md-1 th">Bill Book No</th>
											<th class="col-md-1 th">Bill Amount</th>
											<th class="col-md-1 th">Expiry Date</th>
											<th class="col-md-1 th">Remaining Days</th>
											<th class="col-md-1 th">Pending Amount</th>
											<th class="col-md-1 th">Paid Amount</th>
											<th class="col-md-1 th">Settle Amount</th>


										</tr>
									</thead>
									<tbody>

									</tbody>
								</table>
							</div>
						</div>

					</div>

					<hr>


					<div class=" box-content">
						<div class="row">

							<div class="col-md-2">Amount to be Settled</div>
							<div class="col-md-2">
								<input style="text-align: right; width: 150px" type="text"
									value="" pattern="[+-]?([0-9]*[.])?[0-9]+" name="enteredAmt"
									id="enteredAmt" class="form-control"
									oninput="checkBillsForSettle()">
							</div>

							<div class="col-md-2" style="text-align: right;">Settled</div>
							<div class="col-md-2">
								<input style="text-align: right; width: 150px" type="text"
									value="" pattern="[+-]?([0-9]*[.])?[0-9]+" name="settleAmt"
									id="settleAmt" class="form-control" readonly="readonly">
							</div>


							<div class="col-md-2" style="text-align: right;">Not
								Settled</div>
							<div class="col-md-2">
								<input style="text-align: right; width: 150px" type="text"
									value="" pattern="[+-]?([0-9]*[.])?[0-9]+" name="notSettleAmt"
									id="notSettleAmt" class="form-control" readonly="readonly">
							</div>


						</div>
					</div>


					<br />

					<div class="box-content">
						<div class="row">
							<div class="col-md-2">Payment Mode</div>
							<div class="col-md-3">
								<select name="payMode" id="payMode" class="form-control chosen">

									<option value="" selected="selected">Select Payment
										Mode</option>
									<option value="1">Cash</option>
									<option value="2">Cheque</option>
									<option value="3">Bank Transfer</option>
									<option value="4">E-Payment</option>


								</select>
							</div>
							<div class="col-md-2" style="text-align: right;">Payment
								Description</div>
							<div class="col-md-5">

								<input type="text" value="" name="payDesc" id="payDesc"
									class="form-control">

							</div>
						</div>
					</div>

					<hr>

					<div class="box-content">
						<div class="row">
							<div class="col-md-2">Remark</div>

							<div class="col-md-10">

								<input type="text" value="" name="remark" id=""
									remark""
									class="form-control">

							</div>
						</div>
					</div>


					<div class=" box-content">
						<div class="row" style="text-align: center;">
							<input type="submit" class="btn btn-info" value="submit">

						</div>
					</div>

				</form>
				<!-- ******************************************************** -->



				<!------------------- ACCOUNT LEVEL ITEMS MODAL-------------------- -->



				<div id="myModal" class="modal">

					<div class="modal-content" style="color: black;">
						<span class="close" id="close" onclick="closeModal()">&times;</span>
						<h3 style="text-align: center;">Bill Details</h3>
						<div class=" box-content" id="showJsp">
							<div align="center" id="loader1" style="display: none;">
								<br> <span>
									<h4>
										<font color="#343690">Loading</font>
									</h4>
								</span> <span class="l-1"></span> <span class="l-2"></span> <span
									class="l-3"></span> <span class="l-4"></span> <span class="l-5"></span>
								<span class="l-6"></span>
							</div>
							<iframe id="myIframe" src="" style="width: 100%; height: 90%"></iframe>
						</div>
						<!-- <div class="row">
							<div class="col-md-12" style="text-align: center">

								<input type="button" class="btn btn-info" value="Submit">
							</div>
						</div> -->

					</div>

				</div>



				<!------------------- ACCOUNT LEVEL ITEMS MODAL-------------------- -->


			</div>
		</div>
	</div>
	<!-- END Main Content -->



	<a id="btn-scrollup" class="btn btn-circle btn-lg" href="#"><i
		class="fa fa-chevron-up"></i></a>






	<!-----------------------SCRIPT-------------------------  -->

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
		function openModal(id) {

			var modal = document.getElementById('myModal');
			modal.style.display = "block";
			
			//$("#showJsp").load(${pageContext.request.contextPath}+'/addBillBook');
			
			$('#loader1').show();
			$('#myIframe').hide();
			
			
			 var url="${pageContext.request.contextPath}/viewBillDetail/"+id;
			
			
			 $("#myIframe").attr("src",url).load(function(){
				 $('#myIframe').show();
				 $('#loader1').hide();
			 }); 
			
		}
		
		function closeModal(){
			var modal = document.getElementById('myModal');
			modal.style.display = "none";
			 $("#myIframe").attr("src",""); 
		}
	</script>




	<script type="text/javascript">

		function check() {
			
			var vendId = $("#vendId").val();
			var settleAmt = $("#enteredAmt").val();
			var payMode = $("#payMode").val();
			var notSettleAmt = $("#notSettleAmt").val();

			if (vendId == '' || vendId == null) {
				alert("Please Select Vendor");
				return false;
			}else if( settleAmt == '' || settleAmt ==0){
				alert("Please Enter the Amount to be Settled!");
				document.getElementById("enteredAmt").focus(); 
				return false;
			}else if(notSettleAmt == '' || notSettleAmt == null || notSettleAmt>0){
				alert("Amount is not Settled!");
				return false;
			}else if(payMode == '' || payMode == null){
				alert("Please Select Payment Mode");
				return false;
			}else{
				return confirm('Do you really want to submit?\nIf you continue, this can not be changed.');
			}
			
			
		}

	</script>


	<script type="text/javascript">
		function getBills(vendId) {

			$('#loader').show();

			$.getJSON('${getBillsForSettle}', {
				vendId : vendId,
				ajax : 'true'

			}, function(data) {

				setTableData(data);

			});

		}
	</script>


	<script type="text/javascript">
		function getBills() {

			var vendId = $("#vendId").val();

			if (vendId == '' || vendId == null) {
				alert("Please Select Vendor");
			} else {

				$('#loader').show();

				$.getJSON('${getBillsForSettle}', {
					vendId : vendId,
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

			$.each(data, function(key, billList) {

				var tr = $('<tr></tr>');

				tr.append($('<td></td>').html(key + 1));

				tr.append($('<td></td>').html(
						"<a class=pointer-link onclick='openModal("+billList.billId+")' title='View Detail'><b>" + billList.billDate + "</b><br>"
								+ billList.billNo+"</a>"));

				tr.append($('<td></td>').html(billList.billBookNo));

				tr.append($('<td style="text-align:right;" class="bill-total" id="billTotal'+billList.billId+'" name="billTotal'+billList.billId+'"></td>').html(
						billList.totalValue));

				tr.append($('<td style="text-align:center;"></td>').html(
						billList.expiryDate));

				tr.append($('<td style="text-align:right;"></td>').html(
						billList.days));

				var pendingAmt = billList.totalValue - billList.paidAmt;

				tr.append($('<td style="text-align:right;" class="pending-amt"></td>').html(
						parseFloat(pendingAmt).toFixed(2)));

				tr.append($('<td style="text-align:right;" class="paid-amt" id="paidAmt'+billList.billId+'" name="paidAmt'+billList.billId+'"></td>').html(
						billList.paidAmt));

				tr
				.append($(
						'<td style="text-align:center;"></td>')
						.html(
								'<input style="text-align:right; type="text" id="amt'
										+ billList.billId
										+ '" name="amt'
										+ billList.billId
										+ '" value="0" oninput="checkBillsForSettleByAmount('
										+ billList.billId
										+ ')"  class="form-control amount"  pattern="[+-]?([0-9]*[.])?[0-9]+"  required>'));


				$('#table_grid2 tbody').append(tr);

			})

		}
	</script>



	<script type="text/javascript">


	function checkBillsForSettle() {
		
		var enteredAmt=document.getElementById('enteredAmt').value;
		var fixedEnteredAmt=document.getElementById('enteredAmt').value;

		
		if(enteredAmt == ''){
			enteredAmt=0;
			fixedEnteredAmt=0;
		}
		
		
		var settledAmt=0;
		var notSettledAmt=0;
		
		$(".amount")
		.each(
				function(counter) {
					
					 var billTotal=parseFloat(document.getElementsByClassName("bill-total")[counter].innerHTML);
					var paid=parseFloat(document.getElementsByClassName("paid-amt")[counter].innerHTML);
					
					var bal=parseFloat(billTotal)-parseFloat(paid);
					console.log(bal+"   --   "+enteredAmt);
					
					var amt=document.getElementsByClassName("amount")[counter].value;

						var setAmt=0; 
						

						if(enteredAmt >= bal){
							setAmt=parseFloat(bal);
							
						}else if(enteredAmt < bal){
							setAmt=parseFloat(enteredAmt);
							
						}
						
						enteredAmt=enteredAmt-setAmt;
						
						settledAmt=parseFloat(settledAmt)+parseFloat(setAmt);
						notSettledAmt=parseFloat(fixedEnteredAmt)-parseFloat(settledAmt);

						document.getElementsByClassName("amount")[counter].value=setAmt.toFixed(2);
						document.getElementById("settleAmt").value=settledAmt.toFixed(2);
					
				});
		
		notSettledAmt=parseFloat(fixedEnteredAmt)-parseFloat(settledAmt);
		document.getElementById("notSettleAmt").value=notSettledAmt.toFixed(2);
		
		
	}

	</script>


	<script type="text/javascript">

		function checkBillsForSettleByAmount(id) {
		
			var enteredAmt=document.getElementById('enteredAmt').value;
			
			var settledAmt=0;
			
			var notSettledAmt=0;
					
					var billTotal=parseFloat(document.getElementById("billTotal"+id).innerHTML);
					var paid=parseFloat(document.getElementById("paidAmt"+id).innerHTML);
					
					var bal=parseFloat(billTotal)-parseFloat(paid);
					console.log(bal);
					
					var amt=document.getElementById("amt"+id).value;
					
					var setAmt=0;
					
					if(amt<=bal){
						
						
						//var tempSettleAmt=parseFloat(document.getElementById('settleAmt').value);
						
						var tempSettleAmt=0;
						
						$(".amount")
						.each(
								function(counter) {
									var amt=document.getElementsByClassName("amount")[counter].value;
									if(amt==''){
										amt=0
									}
									tempSettleAmt=parseFloat(tempSettleAmt)+parseFloat(amt);
										
								});
						
						//alert(tempSettleAmt);
						if((tempSettleAmt)>enteredAmt){
							
							setAmt=0;
							document.getElementById("amt"+id).value=setAmt.toFixed(2);
							
						}else  if(notSettledAmt >= amt){
							setAmt=parseFloat(amt);
							
						}else if(notSettledAmt < amt){
							setAmt=parseFloat(notSettledAmt);
							
						}
						
					}else{
						
							setAmt=0;
							document.getElementById("amt"+id).value=setAmt.toFixed(2);
					}
				

						
						//settledAmt=parseFloat(settledAmt)+parseFloat(setAmt);

					//	document.getElementsByClassName("amt"+id).value=setAmt.toFixed(2);
						
						$(".amount")
						.each(
								function(counter) {
									var amt=document.getElementsByClassName("amount")[counter].value;
									if(amt==''){
										amt=0
									}
									settledAmt=parseFloat(settledAmt)+parseFloat(amt);
										
								});
						
						notSettledAmt=parseFloat(enteredAmt)-parseFloat(settledAmt);
					 
						document.getElementById("settleAmt").value=settledAmt.toFixed(2);
						document.getElementById("notSettleAmt").value=notSettledAmt.toFixed(2);
		
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