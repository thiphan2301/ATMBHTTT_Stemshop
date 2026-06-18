<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống Kê</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/statistic.css">
<body>

<div class="container-fluid mt-4">

    <div class="row g-3">
        <div class="col-lg-8 col-md-12">
            <div class="box-card">
                <div class="box-header d-flex justify-content-between align-items-center">
                    <h3 class="box-title m-0">Biểu đồ doanh thu</h3>
                    <input type="month" id="monthPicker" class="form-control" style="width: 200px;">
                </div>
                <div class="chart-placeholder" id="revenueChart"></div>
            </div>
        </div>

        <div class="col-lg-4 col-md-12">
            <div class="box-card">
                <div class="box-header text-center">
                    <h3 class="box-title">Thống kê trạng thái đơn hàng</h3>
                </div>
                <div class="chart-placeholder" id="statusChart"></div>
            </div>
        </div>
    </div>


</div>

<%--lấy link từ trang https://www.highcharts.com/demo--%>
<%--https://cdnjs.com/--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/highcharts/11.3.0/highcharts.min.js"></script>

<script>
    // 1. chọn tháng
    let monthPicker = document.getElementById('monthPicker');

    // 2. biểu đồ theo tháng
    monthPicker.addEventListener('change', function(event) {
        let selectedValue = event.target.value;
        if (!selectedValue) return;

        let year = selectedValue.split('-')[0];
        let month = selectedValue.split('-')[1];

        // Tạo link API có gắn tháng và năm
        let newApiUrl = '${pageContext.request.contextPath}/api-admin/statistical?month=' + month + '&year=' + year;

        fetch(newApiUrl)
            .then(res => res.json())
            .then(data => {
                let daysInMonth = data.revenue.length;

                // Vẽ đè biểu đồ doanh thu
                Highcharts.chart('revenueChart', {
                    chart: { type: 'line' },
                    title: { text: 'Doanh thu tháng ' + month + '/' + year }, // <-- Hiện rõ tháng trên biểu đồ
                    xAxis: { categories: Array.from({length: daysInMonth}, (_, i) => i + 1) },
                    yAxis: { title: { text: 'VNĐ' }, min: 0 },
                    series: [{ name: 'Doanh thu', data: data.revenue, color: '#3498db' }]
                });

                // Vẽ đè biểu đồ trạng thái
                Highcharts.chart('statusChart', {
                    chart: { type: 'pie' },
                    title: { text: 'Trạng thái đơn hàng tháng ' + month + '/' + year }, // <-- Hiện rõ tháng
                    series: [{
                        name: 'Số lượng',
                        data: Object.entries(data.status).map(([name, y]) => ({name, y}))
                    }]
                });
            })
            .catch(err => console.error("Lỗi khi tải lại biểu đồ:", err));
    });
    let today = new Date();
    let currentMonthStr = today.getFullYear() + '-' + String(today.getMonth() + 1).padStart(2, '0');
    monthPicker.value = currentMonthStr;
    monthPicker.dispatchEvent(new Event('change'));
</script>

</body>
</html>