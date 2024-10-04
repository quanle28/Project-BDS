<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="customerListURL" value="/admin/customer-list"/>
<c:url var="customerAPI" value="/api/customer"/>
<html>
<head>
    <title>Danh sách khách hàng</title>
</head>
<body>
      <div class="main-content">
        <div class="main-content-inner">
            <div class="breadcrumbs" id="breadcrumbs">
                <script type="text/javascript">
                    try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
                </script>

                <ul class="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-home home-icon"></i>
                        <a href="#">Trang chủ</a>
                    </li>
                    <li class="active">Quản lý khách hàng</li>
                </ul><!-- /.breadcrumb -->
            </div>

            <div class="page-content">
                <div class="row">
                    <div class="col-xs-12 widget-container-col ui-sortable">
                        <div class="widget-box ui-sortable-handle">
                            <div class="widget-header">
                                <h5 class="widget-title">Tìm kiếm</h5>

                                <div class="widget-toolbar">

                                    <a href="#" data-action="fullscreen" class="orange2">
                                        <i class="ace-icon fa fa-expand"></i>
                                    </a>

                                    <a href="#" data-action="collapse">
                                        <i class="ace-icon fa fa-chevron-up"></i>
                                    </a>

                                    <a href="#" data-action="close">
                                        <i class="ace-icon fa fa-times"></i>
                                    </a>
                                </div>
                            </div>

                            <div class="widget-body" style="font-family: 'Times New Roman', Times, serif;">
                                <div class="widget-main">
                                    <form:form id="listForm" modelAttribute="customerDTO" action="${customerListURL}" method="get">
                                        <div class="row">
                                            <div class="form-group">
                                                <div class="col-xs-12">
                                                    <div class="col-xs-4">
                                                        <label class="name">Tên khách hàng</label>
    <%--                                                    <input type="text" class="form-control" name="name" value="${searchBuilding.name}"/>--%>
                                                        <form:input class="form-control" path="fullname"/>
                                                    </div>
                                                    <div class="col-xs-4">
                                                        <label class="name">Di động</label>
    <%--                                                    <input type="number" class="form-control" name="floorarea" value="${searchBuilding.floorArea}"/>--%>
                                                        <form:input class="form-control" path="phone"/>
                                                    </div>
                                                    <div class="col-xs-4">
                                                        <label class="name">Email</label>
    <%--                                                    <input type="number" class="form-control" name="floorarea" value="${searchBuilding.floorArea}"/>--%>
                                                        <form:input class="form-control" path="email"/>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <div class="col-xs-12">
                                                    <div class="col-xs-4">
                                                    <security:authorize access="hasRole('MANAGER')">
                                                            <label class="name">Nhân viên</label>
                                                            <form:select class="form-control" path="staffId">
                                                                <form:option value="">---Chọn Nhân Viên---</form:option>
                                                                <form:options items="${listStaffs}" class="form-control"/>
                                                            </form:select>
                                                    </security:authorize>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <div class="col-xs-12">
                                                    <div class="col-xs-6">
                                                        <button type="button" class="btn btn-danger" title="Tìm kiếm" id="btnSearchCustomer">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                                                <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"></path>
                                                            </svg>
                                                            Tìm kiếm
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form:form>
                                </div>
                            </div>

                            <div class="pull-right">
                                <security:authorize access="hasRole('MANAGER')">
                                <a href="/admin/customer-edit">
                                    <button class="btn btn-info" title="Thêm khách hàng">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-add" viewBox="0 0 16 16">
                                          <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0m-2-6a3 3 0 1 1-6 0 3 3 0 0 1 6 0M8 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4"/>
                                          <path d="M8.256 14a4.5 4.5 0 0 1-.229-1.004H3c.001-.246.154-.986.832-1.664C4.484 10.68 5.711 10 8 10q.39 0 .74.025c.226-.341.496-.65.804-.918Q8.844 9.002 8 9c-5 0-6 3-6 4s1 1 1 1z"/>
                                        </svg>
                                    </button>
                                </a>
                                </security:authorize>

                                <security:authorize access="hasRole('MANAGER')">
                                <button class="btn btn-danger" title="Xóa khách hàng" id="btnDeleteCustomer">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-dash" viewBox="0 0 16 16">
                                      <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7M11 12h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1 0-1m0-7a3 3 0 1 1-6 0 3 3 0 0 1 6 0M8 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4"/>
                                      <path d="M8.256 14a4.5 4.5 0 0 1-.229-1.004H3c.001-.246.154-.986.832-1.664C4.484 10.68 5.711 10 8 10q.39 0 .74.025c.226-.341.496-.65.804-.918Q8.844 9.002 8 9c-5 0-6 3-6 4s1 1 1 1z"/>
                                    </svg>
                                </button>
                                </security:authorize>
                            </div>

                        </div>
                    </div>
                </div>

                <hr>

                <!-- Bảng danh sách -->
                <div class="row">
                    <div class="col-xs-12">
                        <table id="deleteListCustomer" class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <th class="center">
                                    <label class="pos-rel">
                                        <input type="checkbox" value="" class="ace">
                                        <span class="lbl"></span>
                                    </label>
                                </th>
                                <th>Tên khách hàng</th>
                                <th>Di động</th>
                                <th>Email</th>
                                <th>Nhu cầu</th>
                                <th>Người thêm</th>
                                <th>Ngày thêm</th>
                                <th>Tình trạng</th>
                                <th>Thao tác</th>
                            </tr>
                            </thead>

                            <tbody>
                            <c:forEach var="item" items="${searchResponses}">
                            <tr>
                                <td class="center">
                                    <label class="pos-rel">
<%--                                        <input type="checkbox" class="ace" value="${item.id}">--%>
                                        <input type="checkbox" class="ace" value="${item.id}">
                                        <span class="lbl"></span>
                                    </label>
                                </td>

                                <td>${item.fullname}</td>
                                <td>${item.phone}</td>
                                <td>${item.email}</td>
                                <td>${item.demand}</td>
                                <td>${item.createdBy}</td>
                                <td>${item.createdDate}</td>
                                <td>${item.status}</td>

                                <td>
                                    <div class="hidden-sm hidden-xs btn-group">
                                    <security:authorize access="hasRole('MANAGER')">
<%--                                        <button class="btn btn-xs btn-success" title="Giao khách hàng" onclick="assignmentBuilding(${item.id})">--%>
                                        <button class="btn btn-xs btn-success" title="Giao khách hàng" onclick="assignmentCustomer(${item.id})">
                                            <i class="ace-icon glyphicon glyphicon-list"></i>
                                        </button>
                                    </security:authorize>
<%--                                        <a href="/admin/customer-edit-${item.id}" class="btn btn-xs btn-info" title="Sửa tòa nhà">--%>
                                        <a href="/admin/customer-edit-${item.id}" class="btn btn-xs btn-info" title="Sửa khách hàng">
                                            <i class="ace-icon fa fa-pencil bigger-120"></i>
                                        </a>
                                    <security:authorize access="hasRole('MANAGER')">
<%--                                        <button class="btn btn-xs btn-danger" onclick="deleteBuilding(${item.id})" title="Xóa tòa nhà" id="deleteId-${item.id}">--%>
                                        <button class="btn btn-xs btn-danger" onclick="deleteCustomer(${item.id})" title="Xóa khách hàng" id="deleteId-${item.id}">
                                            <i class="ace-icon fa fa-trash-o bigger-120"></i>
                                        </button>
                                    </security:authorize>
                                    </div>
                                </td>
                            </tr>

                            </c:forEach>

                            </tbody>
                        </table>
                    </div><!-- /.span -->
                </div>
            </div><!-- /.page-content -->
        </div>

        <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
            <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
        </a>
    </div>

    <!-- /.main-container -->
    <div class="modal fade" id="assignmentCustomerModal" role="dialog" style="font-family: 'Times New Roman', Times, serif;">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Danh sách nhân viên</h4>
                </div>
                <div class="modal-body">
                    <table id="staffList" class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr>
                            <th class="text-center">Chọn</th>
                            <th class="text-center">Tên nhân viên</th>
                        </tr>
                        </thead>

                        <tbody>

                        </tbody>
                    </table>
                    <input type="hidden" id="customerId" name="customerId">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-info" id="btnassignmentCustomer">Giao khách hàng</button>
                    <button type="button" class="btn btn-info" data-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function assignmentCustomer(customerId){
            $('#assignmentCustomerModal').modal();
            loadStaff(customerId);
            $('#customerId').val(customerId);
        }

        function loadStaff(customerId){
            $.ajax({
            url: "${customerAPI}/" + customerId + '/staffs',
            type: "GET",
            dataType: "json",
            success: function(response){
                var row = '';
                $.each(response.data, function (index,item){
                    row += '<tr>';
                    row += '<td class="center"><input type="checkbox" value=' + item.staffId + ' id="checkbox_'+ item.staffId +'" class="check-box-element"' + item.checked + '/></td>'
                    row += '<td class="text-center">' +item.fullName + '</td>';
                    row += '</tr>';
                });
                $('#staffList tbody').html(row);
                console.log("Success");
            },
            error: function(response){
                console.log("failed");
                window.location.href = "<c:url value="/admin/customer-list?message=error"/>";
                console.log(response);
            }
            });
        }

        $('#btnassignmentCustomer').click(function(e){
            e.preventDefault();
            var data = {};
            data['customerId'] = $('#customerId').val();
            var staffs = $('#staffList').find('tbody input[type = checkbox]:checked').map(function(){
                return $(this).val();
            }).get();
            data['staffs'] = staffs;
            if (data['staffs'] !== ""){
                assignment(data);
            }
        });

        function assignment(data){
            $.ajax({
            type: "POST",
            url: "${customerAPI}/" + 'assignment',
            data: JSON.stringify(data),
            contentType: "application/json",
            success: function(response){
                console.log("Success");
                confirm("GIAO THÀNH CÔNG!");
                window.location.href = "<c:url  value ="/admin/customer-list"/>";
            },
            error: function(response){
                console.info("Giao không thành công");
                confirm("GIAO KHÔNG THÀNH CÔNG!");
                console.log(response.status);
            }
        });
        }

        $('#btnSearchCustomer').click(function (e) {
           e.preventDefault();
           $('#listForm').submit();
        });

        function deleteCustomer(id){
            var customerId = [id];
            deleteCustomers(customerId);
        }

        $('#btnDeleteCustomer').click(function (e){
            e.preventDefault();
            var customerIds = $('#deleteListCustomer').find('tbody input[type = checkbox]:checked').map(function (){
                return $(this).val();
            }).get();

            if (customerIds.length > 0) {
                deleteCustomers(customerIds);
            } else {
                alert("Xóa chưa thành công");
            }
        });

        function deleteCustomers(data){
            $.ajax({
            type: "DELETE",
            url: "${customerAPI}/" + data,
            data: JSON.stringify(data),
            contentType: "application/json",
            success: function(response){
                if (data.length > 1) {
                    $.each(data, function (index, id) {
                    $('#deleteId-' + id).closest('tr').remove();
                });
                } else {
                    $('#deleteId-' + data[0]).closest('tr').remove();
                }
                confirm("Xoá thành công");
                console.log("Success");
                console.log(response);
            },
            error: function(response){
                console.log("OK");
                console.log(response);
                console.log("OK");
            }
            });
        }
    </script>
</body>
</html>
