package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils;

import jakarta.servlet.http.HttpServletRequest;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.InputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

public class VNPayConfig {

    private static Properties vnpayConfig = new Properties();

    static {
        try (InputStream input = VNPayConfig.class.getClassLoader()
                .getResourceAsStream("vnpay.properties")) {
            if (input == null) {
                System.err.println("Không tìm thấy file vnpay.properties trong resources");
            } else {
                vnpayConfig.load(input);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String getTmnCode() {
        return vnpayConfig.getProperty("vnp.vnp_TmnCode");
    }

    public static String getHashSecret() {
        return vnpayConfig.getProperty("vnp.vnp_HashSecret");
    }

    public static String getVnpayUrl() {
        return vnpayConfig.getProperty("vnp.vnp_Url");
    }

    public static String getReturnUrl() {
        return vnpayConfig.getProperty("vnp.vnp_ReturnUrl");
    }

    public static String getVersion() {
        return vnpayConfig.getProperty("vnp.vnp_Version");
    }

    public static String getCommand() {
        return vnpayConfig.getProperty("vnp.vnp_Command");
    }

    public static String getCurrCode() {
        return vnpayConfig.getProperty("vnp.vnp_CurrCode");
    }

    public static String getLocale() {
        return vnpayConfig.getProperty("vnp.vnp_Locale");
    }

    public static String getOrderType() {
        return vnpayConfig.getProperty("vnp.vnp_OrderType");
    }

    public static String createPaymentUrl(int orderId, double amount, String orderInfo, HttpServletRequest request) {
        try {
            String vnp_Version = getVersion();
            String vnp_Command = getCommand();
            String vnp_TmnCode = getTmnCode();
            String vnp_CurrCode = getCurrCode();
            String vnp_Locale = getLocale();
            String vnp_OrderType = getOrderType();
            String vnp_ReturnUrl = getReturnUrl();

            long vnp_Amount = (long) (amount * 100);
            String vnp_TxnRef = orderId + "_" + System.currentTimeMillis();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            String vnp_CreateDate = sdf.format(new Date());
            String vnp_IpAddr = getClientIpAddress(request);

            Map<String, String> vnp_Params = new HashMap<>();
            vnp_Params.put("vnp_Version", vnp_Version);
            vnp_Params.put("vnp_Command", vnp_Command);
            vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
            vnp_Params.put("vnp_Amount", String.valueOf(vnp_Amount));
            vnp_Params.put("vnp_CurrCode", vnp_CurrCode);
            vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
            vnp_Params.put("vnp_OrderInfo", orderInfo);
            vnp_Params.put("vnp_OrderType", vnp_OrderType);
            vnp_Params.put("vnp_Locale", vnp_Locale);
            vnp_Params.put("vnp_ReturnUrl", vnp_ReturnUrl);
            vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
            vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

            List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
            Collections.sort(fieldNames);

            StringBuilder hashData = new StringBuilder();
            StringBuilder query = new StringBuilder();

            Iterator<String> itr = fieldNames.iterator();
            while (itr.hasNext()) {
                String fieldName = itr.next();
                String fieldValue = vnp_Params.get(fieldName);
                if ((fieldValue != null) && (fieldValue.length() > 0)) {

                    // Build hashData
                    hashData.append(fieldName);
                    hashData.append('=');
                    hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));

                    // Build query
                    query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                    query.append('=');
                    query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));

                    if (itr.hasNext()) {
                        query.append('&');
                        hashData.append('&');
                    }
                }
            }

            // Băm chuỗi dữ liệu đã được chuẩn hóa với Secret Key của bạn
            String vnp_SecureHash = hmacSHA512(getHashSecret(), hashData.toString());

            // Nối chữ ký vào chuỗi Query URL
            String queryUrl = query.toString() + "&vnp_SecureHash=" + vnp_SecureHash;

            // Trả về URL hoàn chỉnh để redirect
            return getVnpayUrl() + "?" + queryUrl;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean validateSignature(Map<String, String> fields, String signature) {
        try {
            // Loại bỏ các tham số không tham gia vào chuỗi băm kết quả
            Map<String, String> vnp_Params = new HashMap<>(fields);
            vnp_Params.remove("vnp_SecureHashType");
            vnp_Params.remove("vnp_SecureHash");

            // Sắp xếp danh sách tham số theo alphabet
            List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
            Collections.sort(fieldNames);

            StringBuilder hashData = new StringBuilder();
            Iterator<String> itr = fieldNames.iterator();
            while (itr.hasNext()) {
                String fieldName = itr.next();
                String fieldValue = vnp_Params.get(fieldName);
                if ((fieldValue != null) && (fieldValue.length() > 0)) {

                    // Giá trị khi băm kiểm tra PHẢI được mã hóa URL Encode
                    hashData.append(fieldName);
                    hashData.append('=');
                    hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));

                    if (itr.hasNext()) {
                        hashData.append('&');
                    }
                }
            }

            // Tiến hành băm lại chuỗi để đối chiếu
            String computedHash = hmacSHA512(getHashSecret(), hashData.toString());

            // So sánh chữ ký của bạn tự tính (computedHash) với chữ ký VNPay gửi về (signature)
            return computedHash.equalsIgnoreCase(signature);

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private static String hmacSHA512(String key, String data) throws Exception {
        Mac hmacSHA512 = Mac.getInstance("HmacSHA512");
        SecretKeySpec secretKeySpec = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
        hmacSHA512.init(secretKeySpec);
        byte[] result = hmacSHA512.doFinal(data.getBytes(StandardCharsets.UTF_8));

        StringBuilder sb = new StringBuilder();
        for (byte b : result) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }

    private static String getClientIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }
}