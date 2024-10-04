<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="customerAPI" value="/api/customer"/>
<html>
<head>
    <title>Thêm khách hàng</title>
</head>
<body>
    <div class="main-content">
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
                    <li class="active">Sửa hoặc thêm khách hàng</li>
                </ul><!-- /.breadcrumb -->
            </div>

            <div class="page-content">
                <div class="page-header">
                    <h1 style="font-family: 'Times New Roman', Times, serif;">
                        Sửa hoặc thêm khách hàng
                    </h1>
                </div><!-- /.page-header -->

                <div class="row" style="font-family: 'Times New Roman', Times, serif;">
                    <form:form modelAttribute="editCustomer" id="listForm" method="get">
                        <div class="col-xs-12 widget-container-col ui-sortable">
                            <form class="form-horizontal" role="form" id="form-edit">
                                <div class="form-group">
                                    <label class="col-xs-3">Tên khách hàng</label>
                                    <div class="col-xs-9">
                                        <form:input class="form-control" path="fullname"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-xs-3">Số điện thoại</label>
                                    <div class="col-xs-9">
<%--                                        <input type="text" name="ward" id="ward" class="form-control">--%>
                                        <form:input class="form-control" path="phone"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-xs-3">Email</label>
                                    <div class="col-xs-9">
<%--                                        <input type="text" name="street" id="street" class="form-control">--%>
                                        <form:input class="form-control" path="email"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-xs-3">Tên công ty</label>
                                    <div class="col-xs-9">
                                        <form:input class="form-control" path="companyName"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-xs-3">Nhu cầu</label>
                                    <div class="col-xs-9">
                                        <form:input class="form-control" path="demand"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-xs-3">Tình trạng</label>
                                    <div class="col-xs-9">
                                        <form:select class="form-control" path="status">
                                            <form:option value="">Chọn trạng thái</form:option>
                                            <form:options items="${listStatus}"/>
                                        </form:select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-xs-3"></label>
                                    <div class="col-xs-9">
                                        <c:if test="${not empty editCustomer.id}">
                                            <button type="button" class="btn btn-primary" title="Sửa khách hàng" id="btnAddOrUpdateCustomer">Sửa khách hàng</button>
                                            <button type="button" class="btn btn-primary" title="Hủy thao tác" id="btnCancel">Hủy thao tác</button>
                                        </c:if>
                                        <c:if test="${empty editCustomer.id}">
                                            <button type="button" class="btn btn-primary" title="Thêm khách hàng" id="btnAddOrUpdateCustomer">Thêm khách hàng</button>
                                            <button type="button" class="btn btn-primary" title="Hủy thao tác" id="btnCancel">Hủy thao tác</button>
                                        </c:if>
                                    </div>
                                </div>

<%--                                <c:if test="${not empty editCustomer.id}">--%>


<%--                                </c:if>--%>

                                <form:hidden path="id" id="customerId"/>
                            </form>
                        </div>
                    </form:form>
                </div>
            </div><!-- /.page-content -->

            <c:forEach var="item" items="${listTransactions}">
                <div class ="col-xs-12">
                    <div class ="col-sm-12">
                        <h3 class ="header smaller lighter blue">${item.value}</h3>
                        <button type="button" class="btn btn-info" title="Thêm thông tin giao dịch"
                                                        onclick="transactionType('${item.key}', ${editCustomer.id})">Add
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-send-plus-fill" viewBox="0 0 16 16">
                              <path d="M15.964.686a.5.5 0 0 0-.65-.65L.767 5.855H.766l-.452.18a.5.5 0 0 0-.082.887l.41.26.001.002 4.995 3.178 1.59 2.498C8 14 8 13 8 12.5a4.5 4.5 0 0 1 5.026-4.47zm-1.833 1.89L6.637 10.07l-.215-.338a.5.5 0 0 0-.154-.154l-.338-.215 7.494-7.494 1.178-.471z"/>
                              <path d="M16 12.5a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0m-3.5-2a.5.5 0 0 0-.5.5v1h-1a.5.5 0 0 0 0 1h1v1a.5.5 0 0 0 1 0v-1h1a.5.5 0 0 0 0-1h-1v-1a.5.5 0 0 0-.5-.5"/>
                            </svg>
                        </button>
                    </div>

                    <c:if test="${item.key == 'CSKH'}">
                        <!-- Bảng danh sách -->
                        <div class="col-xs-12">
                            <table id="simple-table" class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>Ngày tạo</th>
                                        <th>Người tạo</th>
                                        <th>Ngày sửa</th>
                                        <th>Người sửa</th>
                                        <th>Chi tiết giao dịch</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <c:forEach var="item_cskh" items="${listTransaction_CSKH}">
                                    <tr>
                                        <td>${item_cskh.createdDate}</td>
                                        <td>${item_cskh.createdBy}</td>
                                        <c:if test="${item_cskh.createdDate == item_cskh.modifiedDate}">
                                            <td></td>
                                            <td></td>
                                        </c:if>
                                        <c:if test="${item_cskh.createdDate != item_cskh.modifiedDate}">
                                            <td>${item_cskh.modifiedDate}</td>
                                            <td>${item_cskh.modifiedBy}</td>
                                        </c:if>
                                        <td>${item_cskh.note}</td>

                                        <td>
                                            <div class="hidden-sm hidden-xs btn-group">
                                            <security:authorize access="hasRole('MANAGER')">
                                                <button class="btn btn-xs btn-info" title="Sửa thông tin giao dịch"
                                                onclick="updateTransaction(${item_cskh.id},'${item.key}', ${editCustomer.id}, '${item_cskh.note}')">
                                                    <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                                                </button>
                                            </security:authorize>
                                            </div>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div><!-- /.span -->
                    </c:if>

                    <c:if test="${item.key == 'DDX'}">
                        <!-- Bảng danh sách -->
                        <div class="col-xs-12">
                            <table id="" class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>Ngày tạo</th>
                                        <th>Người tạo</th>
                                        <th>Ngày sửa</th>
                                        <th>Người sửa</th>
                                        <th>Chi tiết giao dịch</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>

                                <tbody>
                                <c:forEach var="item_ddx" items="${listTransaction_DDX}">
                                    <tr>
                                        <td>${item_ddx.createdDate}</td>
                                        <td>${item_ddx.createdBy}</td>
                                        <c:if test="${item_ddx.createdDate == item_ddx.modifiedDate}">
                                            <td></td>
                                            <td></td>
                                        </c:if>
                                        <c:if test="${item_ddx.createdDate != item_ddx.modifiedDate}">
                                            <td>${item_ddx.modifiedDate}</td>
                                            <td>${item_ddx.modifiedBy}</td>
                                        </c:if>
                                        <td>${item_ddx.note}</td>

                                        <td>
                                            <div class="hidden-sm hidden-xs btn-group">
                                            <security:authorize access="hasRole('MANAGER')">
                                                <button class="btn btn-xs btn-info" title="Sửa thông tin giao dịch"
                                                onclick="updateTransaction(${item_ddx.id},'${item.key}', ${editCustomer.id}, '${item_ddx.note}')">
                                                    <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                                                </button>
                                            </security:authorize>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div><!-- /.span -->
                    </c:if>

                </div>
            </c:forEach>
        </div>
    </div><!-- /.main-content -->

</div><!-- /.main-container -->

<div class="modal fade" id="transactionTypeModal" role="dialog" style="font-family: 'Times New Roman', Times, serif;">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Nhập giao dịch</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group has-success">
                        <label for="transactionDetail" class="col-xs-12 col-sm-3 control-label no-padding-right">Chi tiết giao dịch</label>
                        <div class="col-xs-12 col-sm-9">
                            <span class="block input-icon input-icon-right">
                                <input type="text" id="transactionDetail" class="width-100">
                            </span>
                        </div>
                    </div>
                    <input type="hidden" id="customerId" name="customerId" value="">
                    <input type="hidden" id="code" name="code" value="">
                    <input type="hidden" id="ids" name="id" value="">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-info" id="btnAddOrUpdateTransaction">Thêm giao dịch</button>
                    <button type="button" class="btn btn-info" data-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>

<script>
    function transactionType(code, customerId){
        $('#transactionTypeModal').modal();
        $('#customerId').val(customerId);
        $('#code').val(code);
    }

    function updateTransaction(id, code, customerId, note){
        $('#transactionTypeModal').modal();
        $('#ids').val(id);
        $('#customerId').val(customerId);
        $('#code').val(code);
        //Lấy thẻ input bằng id
        var myInput = document.getElementById("transactionDetail");

        // Đặt giá trị mặc định cho ô input
        myInput.value = note;
    }

    $('#btnAddOrUpdateTransaction').click(function (e){
        e.preventDefault();
        var data = {};
        data['id'] = $('#ids').val();
        data['customerId'] = $('#customerId').val();
        data['code'] = $('#code').val();
        data['transactionDetail'] = $('#transactionDetail').val();
        // customerId + code + transactionDetail
        addTransaction(data);
    });

    function addTransaction(data){
        $.ajax({
            type: "POST",
            url: "${customerAPI}/transaction",
            data: JSON.stringify(data),
            contentType: "application/json",
            success: function(response){
                alert("LƯU GIAO DỊCH THÀNH CÔNG!");
                location.reload();
            },
            error: function(response){
                window.location.href = "<c:url  value ="/admin/customer-edit?message=error"/>";
            }
        });
    }


    $('#btnAddOrUpdateCustomer').click(function(){
        var data = {};
        var formData = $('#listForm').serializeArray();
        $.each(formData, function(i, v){
            if('' !== v.value && null != v.value){
                data[""+v.name+""] = v.value;
            }
        });
        if (data['fullname'] !== '' && data['phone'] !== ''){
            addOrUpdateCustomer(data);
        }else{
            window.location.href = "<c:url value="/admin/customer-edit?name=required"/>";
        }
    });

    function addOrUpdateCustomer(data){
        $.ajax({
            type: "POST",
            url: "${customerAPI}",
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: "JSON",
            success: function(response){
                confirm("LƯU KHÁCH HÀNG THÀNH CÔNG!")
                window.location.href = "<c:url  value ="/admin/customer-list"/>";
            },
            error: function(response){
                window.location.href = "<c:url  value ="/admin/customer-edit?message=error"/>";            }
        });
    }

    $('#btnCancel').click(function (){
        window.location.href = "<c:url value="/admin/customer-list"/>";
    });

</script>
</body>
</html>
