<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

<style>
/* .th {
	text-align: center;
	position: sticky;
	top: 0;
	z-index: 5;
	background: #f95d64;
	color: white !important;
} */

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


<body>

	<c:url var="getSettledBillsByBillId" value="/getSettledBillsByBillId"></c:url>
	<c:url value="/excelForBillBookExcel" var="excelForBillBookExcel" />

	<!-- <div class="container" id="main-container"> -->

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
			<!-- BEGIN Page Title -->
			<!-- <div class="page-title">
				<div>
					<h1> 

						<i class="fa fa-file-o"></i>PO List

					</h1>
				</div>
			</div> -->
			<br>
			<!-- END Page Title -->
			<div class="box">
			<!-- <div class="row">
				<div class="col-md-12"> -->

					<div class="box" id="todayslist">
						<div class="box-title">
							<h3>
								<i class="fa fa-table"></i>Bill Book List
							</h3>
							<div class="box-tool">
								<a href="${pageContext.request.contextPath}/addBillBook">
									Add Bill</a> <a data-action="collapse" href="#"><i
									class="fa fa-chevron-up"></i></a>
							</div>

						</div>
						<div class=" box-content">
						<form action="${pageContext.request.contextPath}/getBillBookList"
							class="form-horizontal" id="validation-form" method="get">
							<div class="box-content">

								<div class="box-content">

									<div class="col-md-2">From Date</div>
									<div class="col-md-3">
										<input id="fromDate" class="form-control date-picker"
											placeholder="From Date" value="${fromDate}" name="fromDate"
											type="text" required>


									</div>
									<div class="col-md-1"></div>
									<div class="col-md-2">To Date</div>
									<div class="col-md-3">
										<input id="toDate" class="form-control date-picker"
											placeholder="To Date" value="${toDate}" name="toDate"
											type="text" required>


									</div>


								</div>
								<br>
								<div class="box-content">
								<div class="form-group">
									<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-5">
										<input type="submit" class="btn btn-primary" value="Submit">
									</div>
								</div>
								<br>

								<div align="center" id="loader" style="display: none">

									<span>
										<h4>
											<font color="#343690">Loading</font>
										</h4>
									</span> <span class="l-1"></span> <span class="l-2"></span> <span
										class="l-3"></span> <span class="l-4"></span> <span
										class="l-5"></span> <span class="l-6"></span>
								</div>
								<div class="col-md-9"></div>
								<label for="search" class="col-md-3" id="search"> <i
									class="fa fa-search" style="font-size: 20px"></i> <input
									type="text" id="myInput" onkeyup="myFunction()"
									placeholder="Search.." title="Type in a name">
								</label> <br /> <br />
								<div class="clearfix"></div>
								<div class="table-responsive" style="border: 0">
							
									<table class="table table-advance" id="table1">
										<thead>
											<tr class="bgpink">
												<!-- <th style="width: 2%;"
													style="text-align: left; padding: 0px; align-items: left;"
													width="10%"><input type="checkbox" name="name1"
													value="0" />All</th> -->

												<th style="width: 2%;"><input type="checkbox"
														name="name1" value="0" />All</th>
												<th class="th">Date</th>
												<th style="width: 10%;" class="th">Bill No</th>
												<th class="th">Vendor Name</th>
												<th style="width: 10%;" class="th">MRN No</th>
												<th class="th">Total</th>
												<th class="th">Action</th>
											</tr>
										</thead>
										<tbody>

											<c:forEach items="${billList}" var="billList"
												varStatus="count">
												<tr>

													<%-- <td style="width: 2%;"
														style="text-align: left; padding: 0px; align-items: center; align-content: center;"
														width="10%">&nbsp;&nbsp;<input type="checkbox"
														name="name1" value="${billList.billId}" /></td> --%>

													<td style="width: 2%;"><input type="checkbox" name="name1" value="${billList.mrnId}" /></td>


													<td class="col-md-1" style="text-align: center;"><c:out
															value="${billList.billDate}" /></td>

													<td style="width: 10%;" style="text-align:center;"><c:out
															value="${billList.billNo}" /></td>

													<td class="col-md-3"><c:out
															value="${billList.vendorName}" /></td>

													<td style="width: 10%;" style="text-align:center;"><c:out
															value="${billList.mrnNo}" /></td>


													<td class="col-md-1" style="text-align: right;"><c:out
															value="${billList.totalValue}" /></td>

													<c:choose>

														<c:when
															test="${billList.billStatus == 1 || billList.billStatus == 2}">
															<td class="col-md-1" style="text-align: center;"><a
																href="${pageContext.request.contextPath}/editBill/${billList.billId}"><abbr
																	title="Edit"><i class="fa fa-edit"></i></abbr></a>
																&nbsp;&nbsp; <%-- <a onclick="openModal(${billList.billId})"><abbr
																	title="View Bill Receipt"><i class="fa fa-inr"></i></abbr></a> --%></td>
														</c:when>

														<c:otherwise>
															<td class="col-md-1" style="text-align: center;"><a
																href="${pageContext.request.contextPath}/editBill/${billList.billId}"><abbr
																	title="Edit"><i class="fa fa-edit"></i></abbr></a></td>
														</c:otherwise>

													</c:choose>





												</tr>
											</c:forEach>

										</tbody>

									</table>
									
										<div class="col-sm-2">
											<input type="button" id="expExcel" class="btn btn-primary"
												value="Export To Excel" onclick="createBillBookExcel();">
										</div>
									</div>

								</div>
								<br>
							</div>
	
						</form>

						</div>
						<!------------------- ACCOUNT LEVEL ITEMS MODAL-------------------- -->



						<div id="myModal" class="modal">

							<div class="modal-content" style="color: black;">
								<span class="close" id="close" onclick="closeModal()">&times;</span>
								<h3 style="text-align: center;">Bill Receipt List</h3>
								<div class=" box-content">
									<div class="row">
										<div
											style="overflow: scroll; height: 70%; width: 100%; overflow: auto">
											<table width="100%" border="0"
												class="table table-bordered table-striped fill-head "
												style="width: 100%; font-size: 14px;" id="table_grid1">
												<thead>
													<tr>

														<th width="2%"
															style="text-align: center; position: sticky; top: 0; z-index: 5; background: #f95d64; color: white;">SR</th>
														<th
															style="text-align: center; position: sticky; top: 0; z-index: 5; background: #f95d64; color: white;">Bill
															Receipt No</th>
														<th
															style="text-align: center; position: sticky; top: 0; z-index: 5; background: #f95d64; color: white;">Date</th>
														<th
															style="text-align: center; position: sticky; top: 0; z-index: 5; background: #f95d64; color: white;">Bill
															Settled Amount</th>
													</tr>
												</thead>
												<tbody>

												</tbody>
											</table>
										</div>
									</div>

								</div>
								<br>

							</div>

						</div>



						<!------------------- ACCOUNT LEVEL ITEMS MODAL-------------------- -->



					</div>

				<!-- </div>
				</div> -->
			</div>		
		</div>


	<!-- </div> -->

	<!-- END Content -->

	<!-- END Container -->



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

			getBillSettledList(id);
			
			var modal = document.getElementById('myModal');
			modal.style.display = "block";
		}

		function closeModal() {

			var modal = document.getElementById('myModal');
			modal.style.display = "none";
		}
	</script>


	<script type="text/javascript">
		function genPdf(id) {

			window.open('pdfForReport?url=/pdf/poPdf/' + id);

		}
		/* function genPdf(id) {
			//alert(id);
		
			window.open('poPdf/'
					+ id );

		} */

		function commonPdf() {

			var list = [];

			$("input:checkbox[name=name1]:checked").each(function() {
				list.push($(this).val());
			});

			window.open('pdfForReport?url=/pdf/poPdf/' + list);

		}
	</script>

	<script>
		function myFunction() {
			var input, filter, table, tr, td, td1, td2, i;
			input = document.getElementById("myInput");
			filter = input.value.toUpperCase();
			table = document.getElementById("table1");
			tr = table.getElementsByTagName("tr");
			for (i = 0; i < tr.length; i++) {
				td = tr[i].getElementsByTagName("td")[5];
				td1 = tr[i].getElementsByTagName("td")[3];
				td2 = tr[i].getElementsByTagName("td")[4];
				if (td || td1 || td2) {

					if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
						tr[i].style.display = "";
					} else if (td1.innerHTML.toUpperCase().indexOf(filter) > -1) {
						tr[i].style.display = "";
					} else if (td2.innerHTML.toUpperCase().indexOf(filter) > -1) {
						tr[i].style.display = "";
					} else {
						tr[i].style.display = "none";
					}

				}

			}
		}
	</script>


	<script type="text/javascript">
		function getBillSettledList(id) {

			$.getJSON('${getSettledBillsByBillId}', {
				billId : id,
				ajax : 'true'
			}, function(data) {

				$('#table_grid1 td').remove();
				$('#loader').hide();

				if (data == "") {
					alert("No records found !!");

				}

				$.each(data, function(key, billReceipt) {

					var tr = $('<tr></tr>');

					tr.append($('<td></td>').html(key + 1));

					tr.append($('<td style="text-align : center;"></td>').html(billReceipt.brNo));

					tr.append($('<td style="text-align : center;"></td>').html(billReceipt.brDate));

					tr.append($('<td style="text-align : right;"></td>').html(billReceipt.billPaid));

					$('#table_grid1 tbody').append(tr);

				})

			});

		}
	</script>
	<script type="text/javascript">
	function exportToExcel() {
		window.open("${pageContext.request.contextPath}/exportToExcel");
	}
	function createBillBookExcel() {

		var select_to_print = document.forms[0];
		var txt = "";
		var i;
		var flag = 0;
		var all = 0;
		for (i = 0; i < select_to_print.length; i++) {
			if (select_to_print[i].checked
					&& select_to_print[i].value != "on") {
				txt = txt + select_to_print[i].value + ",";
				flag = 1;
			}
		}
		if (flag == 1) {
			
			$.getJSON('${excelForBillBookExcel}', {
				checkboxes : txt,

				ajax : 'true'
			}, function(data) {
				//alert(JSON.stringify(data))
				if(data!=null){
					//exportToExcel();					
					window.open("${pageContext.request.contextPath}/exportToExcel");
				}

			});
		} else {
			alert("Please select minimum 1 Bill ");
		}

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
	<script
		src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.resize.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.pie.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.stack.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.crosshair.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.tooltip.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/sparkline/jquery.sparkline.min.js"></script>

	<!--page specific plugin scripts-->
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/jquery-validation/dist/jquery.validate.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/jquery-validation/dist/additional-methods.min.js"></script>

	<!--flaty scripts-->
	<script src="${pageContext.request.contextPath}/resources/js/flaty.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/flaty-demo-codes.js"></script>
	<!--page specific plugin scripts-->
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-fileupload/bootstrap-fileupload.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/chosen-bootstrap/chosen.jquery.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/clockface/js/clockface.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-daterangepicker/date.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-daterangepicker/daterangepicker.js"></script>

</body>
</html>