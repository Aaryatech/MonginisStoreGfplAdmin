<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>


<body>
	<div class="container" id="main-container">
		<c:url value="/excelForMrnExcel" var="excelForMrnExcel" />

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
			<div class="page-title">
				<!-- <div>
					<h1>
						<i class="fa fa-file-o"></i>
					</h1>

				</div> -->
				<br>
			</div>
			<!-- END Page Title -->



			<!-- BEGIN Main Content -->
			<div class="row">
				<div class="col-md-12">
					<div class="box">
						<div class="box-title">
							<h3>
								<i class="fa fa-bars"></i>MRN List
							</h3>
							<%-- <div class="box-tool">
								<a href="${pageContext.request.contextPath}/showAddMrn"> Add
									MRN</a> <a data-action="collapse" href="#"><i
									class="fa fa-chevron-up"></i></a>
							</div> --%>

						</div>


						<div class="box-content">
							<form
								action="${pageContext.request.contextPath}/getMrnHeadersForERP"
								class="form-horizontal" id="validation-form" method="get">



								<input type="hidden" name="mode_add" id="mode_add"
									value="add_att">

								<div class="form-group">
									<div class="col-md-1">From Date</div>
									&nbsp;&nbsp;
									<div class="col-md-2 ">
										<input class="form-control date-picker" id="from_date"
											size="16" type="text" name="from_date" value="${fromDate}"
											required />
									</div>
									<!-- </div>


								<div class="form-group"> -->
									<div class="col-md-1">To Date</div>
									<div class="col-md-2 ">
										<input class="form-control date-picker" id="to_date" size="16"
											type="text" name="to_date" required value="${toDate}" />
									</div>

									<div class="col-md-1">MRN Status</div>
									<div class="col-md-2 ">
										<select name="status" id="status" class="form-control chosen"
											placeholder="Mrn status" data-rule-required="true">
											<c:choose>
												<c:when test="${status==1}">
													<option value="-1">Select MRN Type</option>
													<option value="1" selected>Gate Inward Done
														/Stores MRN Pending</option>
													<option value="2">Stores MRN Done/Director
														Approval Pending</option>
													<option value="3">Director Approved</option>
													<option value="4" >Account Approved</option>
												</c:when>
												<c:when test="${status==2}">
													<option value="-1">Select MRN Type</option>
													<option value="1">Gate Inward Done /Stores MRN
														Pending</option>
													<option value="2" selected>Stores MRN
														Done/Director Approval Pending</option>
													<option value="3">Director Approved</option>
													<option value="4" >Account Approved</option>
												</c:when>
												<c:when test="${status==3}">
													<option value="-1">Select MRN Type</option>
													<option value="1">Gate Inward Done /Stores MRN
														Pending</option>
													<option value="2">Stores MRN Done/Director
														Approval Pending</option>
													<option value="3" selected>Director Approved</option>
													<option value="4" >Account Approved</option>
												</c:when>
												<c:when test="${status==4}">
													<option value="-1">Select MRN Type</option>
													<option value="1">Gate Inward Done /Stores MRN
														Pending</option>
													<option value="2">Stores MRN Done/Director
														Approval Pending</option>
													<option value="3" >Director Approved</option>
													<option value="4" selected>Account Approved</option>
												</c:when>
												<c:otherwise>
													<option value="-1">Select MRN Type</option>
													<option value="1">Gate Inward Done /Stores MRN
														Pending</option>
													<option value="2">Stores MRN Done/Director
														Approval Pending</option>
													<option value="3">Director Approved</option>
													<option value="4">Account Approved</option>
												</c:otherwise>
											</c:choose>


										</select>
									</div>
									<div class="col-md-1">
										<input type="submit" width="20px;" value="Submit"
											class="btn btn-primary">
									</div>

									<c:set value="0" var="isEdit"></c:set>
									<c:set value="0" var="isDelete"></c:set>
									<c:forEach items="${sessionScope.newModuleList}"
										var="allModuleList">
										<c:choose>
											<c:when
												test="${allModuleList.moduleId==sessionScope.sessionModuleId}">
												<c:forEach items="${allModuleList.subModuleJsonList}"
													var="subModuleJsonList">
													<c:choose>
														<c:when
															test="${subModuleJsonList.subModuleId==sessionScope.sessionSubModuleId}">
															<c:choose>

																<c:when
																	test="${subModuleJsonList.editReject eq 'visible'}">
																	<c:set value="1" var="isEdit"></c:set>
																</c:when>
															</c:choose>
															<c:choose>
																<c:when
																	test="${subModuleJsonList.deleteRejectApprove eq 'visible'}">
																	<c:set value="1" var="isDelete"></c:set>
																</c:when>
															</c:choose>
														</c:when>
													</c:choose>
												</c:forEach>
											</c:when>
										</c:choose>

									</c:forEach>

								</div>
								<div class="col-md-8"></div>
								<!-- 			<label for="search" class="col-md-2" id="search">
    <i class="fa fa-search" style="font-size:15px"></i>
									<input type="text" value="" id="myInput" style="text-align: left; width: 240px;" class="form-control" onkeyup="myFunction()" placeholder="Search Mrn by Name or Vendor" title="Type in a name">
										</label>  -->
								<div class="input-group">
									<input type="text" id="myInput"
										style="text-align: left; color: green;" class="form-control"
										onkeyup="myFunction()"
										placeholder="Search Mrn by Name or Vendor" /> <span
										class="input-group-addon"> <i class="fa fa-search"></i>
									</span>
								</div>
								<br />

								<div class="clearfix"></div>
								<div id="table-scroll" class="table-scroll">

									<div id="faux-table" class="faux-table" aria="hidden">
										<table id="table2" class="main-table">
											<thead>
												<tr class="bgpink">
													<!-- <th width="180" style="width: 90px">Indent No</th>
													<th width="200" align="left">Date</th>
													<th width="358" align="left">Category</th>
													<th width="194" align="left">Type</th>
													<th width="102" align="left">Development</th>
													<th width="102" align="left">Monthly</th>

													<th width="88" align="left">Action</th> -->
												</tr>
											</thead>
										</table>

									</div>
									<div class="table-wrap">

										<table id="table1" class="table table-advance">
											<thead>
												<tr class="bgpink">
													<th style="width: 2%;"><input type="checkbox"
														name="name1" value="0" />All</th>
													<th class="col-md-1">Mrn No</th>
													<th class="col-md-1">Date</th>
													<th class="col-md-1">Bill No</th>
													<th class="col-md-1">Bill Date</th>
													<th class="col-md-1">Vendor Name</th>
													<th class="col-md-1">PO</th>
													<th class="col-md-1">MRN Status</th>
													<!-- <th class="col-md-1">Action</th> -->
												</tr>
											</thead>
											<!-- 	<div class="table-responsive" style="border: 0">
									<table width="100%" class="table table-advance" id="table1">
										<thead>
											<tr>
												<th width="180" style="width: 90px">Prod ID</th>
												<th width="200" align="left">Production Date</th>
												<th width="358" align="left">Category</th>
												<th width="194" align="left">Status</th>
												<th width="102" align="left">IsPlanned</th>
												<th width="88" align="left">Action</th>
											</tr>
										</thead> -->
											<tbody>
												<c:forEach items="${mrnHeaderList}" var="mrn">
													<tr>
														<td><c:if test="${mrn.vendorName != 'Opening'}">

																<input type="checkbox" name="name1" value="${mrn.mrnId}" />
															</c:if></td>
														<td><c:out value="${mrn.mrnNo}" /></td>
														<td><c:out value="${mrn.mrnDate}" /></td>
														<td><c:out value="${mrn.billNo}" /></td>
														<td><c:out value="${mrn.billdate}" /></td>
														
														<td><c:out value="${mrn.vendorName}" /></td>
<td >
													<c:forEach items="${mrn.poNosList}" var="po">
													<a href="${pageContext.request.contextPath}/editPurchaseOrder/${po.poId}/${mrn.mrnId}" target="_blank">${po.poNo}</a>&nbsp;
													</c:forEach>
													</td>

														<td><c:set var="mrnStatus" value="" /> <c:choose>
																<c:when test="${mrn.mrnStatus==0}">
																	<c:set var="mrnStatus"
																		value="Gate Inward Done /Stores MRN Pending"></c:set>
																</c:when>
																<c:when test="${mrn.mrnStatus==1 or mrn.mrnStatus==2}">
																	<c:set var="mrnStatus"
																		value="Stores MRN Done/Director Approval Pending"></c:set>
																</c:when>
																<c:when test="${mrn.mrnStatus==3 or mrn.mrnStatus==4 or mrn.mrnStatus==5 }">
																	<c:set var="mrnStatus" value="Director Approved"></c:set>
																</c:when>
																<c:when test="${mrn.mrnStatus==6 }">
																	<c:set var="mrnStatus" value="Account Approved"></c:set>
																</c:when>
															</c:choose> <c:out value="${mrnStatus}" /></td>
														<%-- <td >
														
														<a href="javascript:genPdf(${mrn.mrnId});" title="PDF"><i
															class="glyphicon glyphicon glyphicon-file"></i></a>
													
														&nbsp;&nbsp;&nbsp; --%>
														<%-- 	<c:choose>
																<c:when test="${isEdit==1}"><a
															href="${pageContext.request.contextPath}/showEditViewMrnDetail/${mrn.mrnId}" title="View/Edit"><span
																class="glyphicon glyphicon-info-sign"></span></a>&nbsp;&nbsp;&nbsp;&nbsp;</c:when></c:choose>
														 --%>
														<%-- 	<a
															href="${pageContext.request.contextPath}/editIndent/${mrn.mrnId}"><span
											 					class="glyphicon glyphicon-info-sign"></span></a> --%>
														<%-- 	<c:choose>
											 					<c:when test="${isDelete==1}">
											 					<c:choose>
											 						<c:when test="${mrn.mrnStatus<3}">
											 						<a href="${pageContext.request.contextPath}/deleteMrn/${mrn.mrnId}" title="Delete" onClick="return confirm('Are you sure want to delete this record');"><span
																class="fa fa-trash-o"></span></a>
											 						</c:when> 
											 					</c:choose>
											 					</c:when>
											 					</c:choose>
																
														</td> --%>
													</tr>
												</c:forEach>

											</tbody>
										</table>

										<br> <br>
										<div class="col-sm-2 col-lg-2 controls">
											<input type="button" id="expExcel" class="btn btn-primary"
												value="Export To Excel" onclick="createMrnExcel();">
										</div>
										<div class="col-sm-2 col-lg-2 controls">
											<input type="button" id="expExcel1" class="btn btn-primary"
												value="Export To Excel for Item" onclick="exportToExcel1();">
										</div>

										<div class="col-sm-2 col-lg-2 controls">
											<input type="button" id="expExcel1" class="btn btn-primary"
												value="Export To Excel for Vendor"
												onclick="exportToExcel2();">
										</div>
										<br> <br>

									</div>

								</div>
							</form>
						</div>
					</div>

				</div>

			</div>
			<!-- END Main Content -->
			<footer>
			<p>2019 © MONGINIS</p>
			</footer>

			<a id="btn-scrollup" class="btn btn-circle btn-lg" href="#"><i
				class="fa fa-chevron-up"></i></a>
		</div>
		<!-- END Content -->
	</div>
	<!-- END Container -->

	<!--basic scripts-->
	<script type="text/javascript">
		function exportToExcel() {
			window.open("${pageContext.request.contextPath}/exportToExcel");
		}
		function createMrnExcel() {

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
				$.getJSON('${excelForMrnExcel}', {
					checkboxes : txt,

					ajax : 'true'
				}, function(data) {

					exportToExcel();

				});
			} else {
				alert("Please select minimum 1 Mrn ");
			}

		}

		function exportToExcel1() {

			window.open("${pageContext.request.contextPath}/exportToExcel1");

		}

		function exportToExcel2() {

			window.open("${pageContext.request.contextPath}/exportToExcel2");

		}
	</script>

	<script type="text/javascript">
		function genPdf(id) {

			window.open('pdfForReport?url=pdf/grnPdf/' + id);

		}

		function commonPdf() {

			var list = [];

			$("input:checkbox[name=name1]:checked").each(function() {
				list.push($(this).val());
			});

			window.open('pdfForReport?url=pdf/grnPdf/' + list);

		}
	</script>


	<script>
		function myFunction() {
			var input, filter, table, tr, td, td1, i;
			input = document.getElementById("myInput");
			filter = input.value.toUpperCase();
			table = document.getElementById("table1");
			tr = table.getElementsByTagName("tr");
			for (i = 0; i < tr.length; i++) {
				td = tr[i].getElementsByTagName("td")[3];
				td1 = tr[i].getElementsByTagName("td")[1];
				td2 = tr[i].getElementsByTagName("td")[5];
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
			}//end of for

		}
	</script>

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