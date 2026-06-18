document.addEventListener("DOMContentLoaded", function() {
    // ------------------------------------------
    // 1. TÌM KIẾM VÀ LỌC ĐƠN HÀNG (Giữ nguyên)
    // ------------------------------------------
    const searchInput = document.getElementById('searchInput');
    const statusFilter = document.getElementById('statusFilter');
    const sortFilter = document.getElementById('sortFilter');
    const tableBody = document.getElementById('orderTableBody');

    if (searchInput && statusFilter && sortFilter) {
        searchInput.addEventListener('input', applyFilters);
        statusFilter.addEventListener('change', applyFilters);
        sortFilter.addEventListener('change', applyFilters);
        applyFilters();
    }

    function applyFilters() {
        const searchValue = searchInput.value.toLowerCase();
        const statusValue = statusFilter.value;
        const sortValue = sortFilter.value;
        let rows = Array.from(tableBody.querySelectorAll('tr'));

        rows.forEach(row => {
            const idText = row.cells[0].textContent.toLowerCase();
            const nameText = row.cells[1].textContent.toLowerCase();
            const statusText = row.cells[3].textContent.trim();

            const matchSearch = idText.includes(searchValue) || nameText.includes(searchValue);
            let matchStatus = false;
            if (statusValue === 'ALL') matchStatus = true;
            else if (statusValue === 'PENDING' && statusText.includes('Chờ xác nhận')) matchStatus = true;
            else if (statusValue === 'SHIPPING' && statusText.includes('Đang giao')) matchStatus = true;
            else if (statusValue === 'DELIVERED' && statusText.includes('Đã giao')) matchStatus = true;
            else if (statusValue === 'CANCELLED' && statusText.includes('Đã hủy')) matchStatus = true;

            row.style.display = (matchSearch && matchStatus) ? '' : 'none';
        });

        rows.sort((a, b) => {
            const idA = parseInt(a.cells[0].textContent.replace('#', '').trim());
            const idB = parseInt(b.cells[0].textContent.replace('#', '').trim());
            return sortValue === 'asc' ? (idA - idB) : (idB - idA);
        });

        rows.forEach(row => tableBody.appendChild(row));
    }

    // ------------------------------------------
    // 2. XỬ LÝ AJAX TUYỆT ĐỐI AN TOÀN CHO SERVLET
    // ------------------------------------------
    const actionForms = document.querySelectorAll('.admin-table form');

    actionForms.forEach(form => {
        form.addEventListener('submit', function(e) {
            e.preventDefault(); // Chặn hành vi tải lại trang mặc định của Form

            // Lấy chính xác phần tử input bên trong form vừa click
            const orderIdInput = this.querySelector('input[name="orderId"]');
            const actionInput = this.querySelector('input[name="action"]');

            if (!orderIdInput || !actionInput) {
                alert("Lỗi: Không tìm thấy thuộc tính orderId hoặc action trong form HTML.");
                return;
            }

            const orderId = orderIdInput.value;
            const action = actionInput.value;
            const url = this.getAttribute('action') || window.location.href;

            // Ép định dạng chuỗi thuần túy dạng key=value&key=value
            // Đây là cách an toàn nhất giúp request.getParameter() trong Java không bao giờ bị null
            const requestBody = `orderId=${encodeURIComponent(orderId)}&action=${encodeURIComponent(action)}`;

            fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: requestBody
            })
                .then(response => {
                    // response.ok nhận biết các trạng thái thành công (200-299)
                    if (response.ok) {
                        alert('Thành công! Đã xử lý ' + (action === 'confirm' ? 'XÁC NHẬN' : 'HỦY') + ' đơn hàng #' + orderId);

                        // Ẩn form (nút bấm) vừa thao tác thành công
                        this.style.display = 'none';

                        // Cập nhật giao diện của cột trạng thái mà không reload trang
                        const row = this.closest('tr');
                        if (row) {
                            const statusCell = row.cells[3]; // Cột trạng thái đơn hàng
                            if (action === 'confirm') {
                                statusCell.innerHTML = '<i class="fa-solid fa-truck-arrow-right"></i> Đang giao';
                                // Ẩn luôn nút Hủy đi kèm (nếu có)
                                const cancelForm = row.querySelector('input[value="cancel"]')?.closest('form');
                                if (cancelForm) cancelForm.style.display = 'none';
                            } else if (action === 'cancel') {
                                statusCell.innerHTML = '<i class="fa-regular fa-circle-xmark"></i> Đã hủy';
                                // Ẩn luôn nút Xác nhận đi kèm (nếu có)
                                const confirmForm = row.querySelector('input[value="confirm"]')?.closest('form');
                                if (confirmForm) confirmForm.style.display = 'none';
                            }
                        }
                    } else {
                        // Nếu lỗi (ví dụ 404, 500), hiện mã lỗi cụ thể để dễ sửa bài
                        alert('Lỗi từ Server! Mã phản hồi: ' + response.status + '. Vui lòng kiểm tra Console/Log của Server.');
                    }
                })
                .catch(error => {
                    console.error('Fetch Error:', error);
                    alert('Lỗi kết nối mạng hoặc lỗi JavaScript. Vui lòng bấm F12 xem mục Console.');
                });
        });
    });
});