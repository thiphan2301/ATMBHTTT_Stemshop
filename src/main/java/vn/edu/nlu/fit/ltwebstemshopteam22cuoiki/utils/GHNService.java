package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils;

import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Order;
import java.io.OutputStream;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class GHNService {

    private static final String GHN_TOKEN = "c277cf3f-6968-11f1-a973-aee5264794df";
    private static final String GHN_SHOP_ID = "200731";
    private static final String API_CREATE_ORDER = "https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/create";

    // Hàm trả về Tracking Code (Mã vận đơn) nếu tạo thành công
    public static String createShippingOrder(Order order, int districtId, String wardCode) {
        try {
            URL url = new URL(API_CREATE_ORDER);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; utf-8");
            conn.setRequestProperty("Token", GHN_TOKEN);
            conn.setRequestProperty("ShopId", GHN_SHOP_ID);
            conn.setDoOutput(true);

            // 1: Shop trả phí ship. 2: Khách trả (COD)
            // Đã trả VNPAY thì Shop trả ship cho GHN. Nếu COD thì thu tiền khách.
            int paymentTypeId = ("unpaid".equals(order.getPaymentStatus())) ? 2 : 1;

            // Số tiền cần thu hộ (COD). Nếu thanh toán VNPAY rồi thì COD = 0.
            long codAmount = ("unpaid".equals(order.getPaymentStatus())) ? (long) order.getTotalAmount() : 0;

            // chuỗi JSON thông tin đơn hàng và người nhận đẩy sang GHN
            String jsonInputString = "{"
                    + "\"payment_type_id\": " + paymentTypeId + ","
                    + "\"note\": \"" + (order.getNote() != null ? order.getNote() : "") + "\","
                    + "\"required_note\": \"CHOXEMHANGKHONGTHU\","
                    + "\"to_name\": \"" + order.getReceiverName() + "\","
                    + "\"to_phone\": \"" + order.getReceiverPhone() + "\","
                    + "\"to_address\": \"" + order.getShippingAddress() + "\","
                    + "\"to_ward_code\": \"" + wardCode + "\","
                    + "\"to_district_id\": " + districtId + ","
                    + "\"cod_amount\": " + codAmount + ","
                    + "\"weight\": 1000,"
                    + "\"length\": 20,"
                    + "\"width\": 20,"
                    + "\"height\": 10,"
                    + "\"service_type_id\": 2," // 2 = Giao Hàng Chuẩn
                    + "\"items\": [{\"name\": \"Dụng cụ học tập STEM\", \"quantity\": 1, \"price\": 100000, \"weight\": 1000}]"
                    + "}";

            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = jsonInputString.getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            int responseCode = conn.getResponseCode();
            if (responseCode == 200) {
                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
                StringBuilder response = new StringBuilder();
                String responseLine;
                while ((responseLine = br.readLine()) != null) {
                    response.append(responseLine.trim());
                }

                // Trả về mã vận đơn
                String resStr = response.toString();
                if (resStr.contains("\"order_code\":\"")) {
                    int startIndex = resStr.indexOf("\"order_code\":\"") + 14;
                    int endIndex = resStr.indexOf("\"", startIndex);
                    return resStr.substring(startIndex, endIndex);
                }
            } else {
                System.out.println("GHN API ERROR: Code " + responseCode);
                try {
                    // GHN trả về chi tiết lỗi qua ErrorStream thay vì InputStream
                    BufferedReader br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "utf-8"));
                    StringBuilder errorResponse = new StringBuilder();
                    String errorLine;
                    while ((errorLine = br.readLine()) != null) {
                        errorResponse.append(errorLine.trim());
                    }
                    System.out.println("CHI TIẾT LỖI TỪ GHN: " + errorResponse.toString());
                    System.out.println("DỮ LIỆU ĐÃ GỬI ĐI: " + jsonInputString);
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}