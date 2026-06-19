<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử thay đổi đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            padding: 15px;
        }
        .header-top {
            background-color: #fff;
            padding: 15px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 1.2rem;
            font-weight: 600;
            border-bottom: 1px solid #eaeaea;
            margin-bottom: 20px;
            border-radius: 6px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.02);
        }
        .history-card {
            background-color: #fff;
            border: 1px solid #e3e6f0;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.02);
            margin-bottom: 20px;
            overflow: hidden;
            transition: transform 0.2s;
        }
        .history-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.05);
        }
        .card-header-custom {
            background-color: #f8f9fc;
            border-bottom: 1px solid #e3e6f0;
            padding: 12px 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .order-badge {
            background-color: #4e73df;
            color: white;
            font-weight: bold;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 0.9rem;
        }
        .date-badge {
            color: #858796;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .change-table {
            margin-bottom: 0;
        }
        .change-table th {
            font-weight: 600;
            font-size: 0.85rem;
            color: #4e73df;
            background-color: #fcfcff;
        }
        .change-table td {
            font-size: 0.9rem;
            vertical-align: middle;
        }
        .badge-old {
            background-color: #f8d7da;
            color: #721c24;
            padding: 4px 8px;
            border-radius: 4px;
            display: inline-block;
            max-width: 100%;
            word-break: break-all;
        }
        .badge-new {
            background-color: #d4edda;
            color: #155724;
            padding: 4px 8px;
            border-radius: 4px;
            display: inline-block;
            max-width: 100%;
            word-break: break-all;
        }
        .empty-history {
            text-align: center;
            padding: 50px 20px;
            color: #858796;
            background: #fff;
            border-radius: 8px;
            border: 1px dashed #e3e6f0;
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="header-top">
        <i class="fa-solid fa-history text-primary me-2"></i>
        <span>Lịch sử thay đổi thông tin đơn hàng</span>
    </div>

    <c:choose>
        <c:when test="${empty history}">
            <div class="empty-history">
                <i class="fa-regular fa-folder-open mb-3" style="font-size: 3rem; color: #dddfeb;"></i>
                <h5>Chưa có lịch sử thay đổi nào</h5>
                <p class="text-muted mb-0">Các hoạt động chỉnh sửa thông tin đơn hàng của Admin sẽ được lưu giữ tại đây.</p>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="entry" items="${history}">
                <div class="history-card">
                    <div class="card-header-custom">
                        <span class="order-badge">
                            <i class="fa-solid fa-file-invoice-dollar me-1"></i> Đơn hàng #${entry.orderId}
                        </span>
                        <span class="date-badge">
                            <i class="fa-regular fa-clock"></i> ${entry.changeDate}
                        </span>
                    </div>
                    <div class="table-responsive">
                        <table class="table change-table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th style="width: 25%">Thông tin thay đổi</th>
                                    <th style="width: 37.5%">Giá trị cũ</th>
                                    <th style="width: 37.5%">Giá trị mới</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="change" items="${entry.changes}">
                                    <tr>
                                        <td class="fw-semibold text-secondary">
                                            <i class="fa-solid fa-circle-chevron-right text-primary me-1" style="font-size: 0.75rem;"></i>
                                            ${change.field}
                                        </td>
                                        <td>
                                            <span class="badge-old">${change.oldValue}</span>
                                        </td>
                                        <td>
                                            <span class="badge-new">${change.newValue}</span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
