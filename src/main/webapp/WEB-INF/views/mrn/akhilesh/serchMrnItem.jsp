<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:url var="getItemMrnbyExList" value="/getItemMrnbyExList"></c:url>
		
		
		<div class="container" id="main-container">
			
				
				
				
				<!-- BEGIN Sidebar -->
					<div id="sidebar" class="navbar-collapse collapse">

							<jsp:include page="/WEB-INF/views/include/navigation.jsp"></jsp:include>

							<div id="sidebar-collapse" class="visible-lg">
								<i class="fa fa-angle-double-left"></i>
							</div>
				<!-- END Sidebar Collapse Button -->
					</div>
					
					
					
					
					<!-- BEGIN Content -->
					<div id="main-content">
						
						<!-- BEGIN Page Title -->
					<!-- <div class="page-title">
						<div>
							<h1>
								<i class="fa fa-file-o"></i>MRN Report
							</h1>
						</div>
						</div>-->
						<!-- END Page Title -->
						
						
						<div class="row">
							<div class="col-md-12">
								<div class="box" id="todayslist">
									
									
									
									
									<div class="box-title">
										<h3>
											<i class="fa fa-table"></i>MRN Expiry List
										</h3>
										<div class="box-tool">
											<a href="${pageContext.request.contextPath}/"> </a> <a
											data-action="collapse" href="#"><i class="fa fa-chevron-up"></i></a>
										</div>

									</div>
									
									
									
									
										<div class="box-content">
										
										
												<div class="box-content">
													
													<div class="col-md-1"></div>
													<div class="col-md-2">Select Expiry Date*</div>
													<div class="col-md-4">
													<input id="toDate" class="form-control date-picker"
													placeholder="To Date" name="toDate"
														type="text" autocomplete="off" required>
													</div>
												
												</div>
												<br> <br>
												
								<div class="box-content">
														
														
										<div class="form-group">
											<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-5">
											<input type="button" class="btn btn-primary" value="Search"
											onclick="search()">
										
											<button class="btn btn-primary" value="PDF" id="PDFButton"
											disabled="disabled" onclick="genPdf()">PDF</button>
									
											<input type="button" id="expExcel" class="btn btn-primary"
											disabled="disabled" value="EXPORT TO Excel"
											onclick="exportToExcel();">
											</div>
										</div>
										<br>

										<div align="center" id="loader" style="display: none">
										<span>
											<h4>
												<font color="#343690">Loading</font>
											</h4>
										</span> 
										<span class="l-1"></span> 
										<span class="l-2"></span> 
										<span class="l-3"></span> 
										<span class="l-4"></span> 
										<span class="l-5"></span>
										<span class="l-6"></span>
									</div>
									
									<br /> <br />
									
									<div class="clearfix"></div>
										<div class="table-responsive" style="border: 0">
											<table class="table table-advance" id="table1">
												<thead>
													<tr class="bgpink">
														<th class="col-sm-1">Sr no.</th>
														<!--<th class="col-md-1">MRN Detail Id</th> -->
														<th class="col-md-2">Batch No.</th>
														<th class="col-md-2">Item Desc.</th>
														<th class="col-md-1">UOM</th>
														<th class="col-md-1">Remaining Qty.</th>
														<th class="col-md-1">Exp.Date</th>
													</tr>
												</thead>
												<tbody>
												
												
												
												
												
												
												</tbody>
											</table>
										</div>
										
								</div>
										
										
										
										
										
										</div>
									
									
									
						
								</div>
							</div>
						</div>
						<footer>
							<p>2019 © MONGINIS</p>
						</footer>
						
					
					
					
					</div>
		
		</div>
			<script
		src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js">
	</script>
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
		




<script type="text/javascript">
function  search() {
	//alert("Ok")
	var toDate = $("#toDate").val();

	$('#loader').show();
	
	$.getJSON(
				'${getItemMrnbyExList}',
				{
					toDate : toDate,
					ajax:'true',
				},
				function(data){
					//alert(data)
					$('#table1 td').remove();
					$('#loader').hide();
					
					if(data==""){
						alert("No Record Found");
						document.getElementById("PDFButton").disabled = true;
						document.getElementById("expExcel").disabled = true;
					}
					document.getElementById("PDFButton").disabled = false;
					document.getElementById("expExcel").disabled = false;
					
				
					$ .each(data,
							function(key,itemMrnList) {
						
								var tr=$('<tr></tr>');
									
									tr.append($('<td></td>').html(key+1));
								/*	tr.append($('<td></td>').html(itemMrnList.mrnDetailId));*/
									tr.append($('<td></td>').html(itemMrnList.batchNo));
									tr.append($('<td></td>').html(itemMrnList.itemDesc));
									tr.append($('<td></td>').html(itemMrnList.itemUom));
									tr.append($('<td></td>').html(itemMrnList.remainingQty));
									tr.append($('<td></td>').html(itemMrnList.expDate));
									$('#table1 tbody').append(tr);
									
								
							}) 
					
				});
	
	
	
}

</script>
<script type="text/javascript">
		function exportToExcel() {
			window.open("${pageContext.request.contextPath}/exportToExcel");
			document.getElementById("expExcel").disabled = true;
		}
</script>
	<script type="text/javascript">
		function genPdf() {
			window.open('${pageContext.request.contextPath}/getPdfReoprt/');
			document.getElementById("PDFButton").disabled = true;
		}
	</script>







</body>
</html>