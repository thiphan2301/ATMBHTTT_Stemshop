package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.io.*;
import java.lang.reflect.Type;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OrderHistoryLogger {
    private static final String FILE_NAME = "order_change_history.json";

    public static class ChangeLog {
        private String field;
        private String oldValue;
        private String newValue;

        public ChangeLog(String field, String oldValue, String newValue) {
            this.field = field;
            this.oldValue = oldValue;
            this.newValue = newValue;
        }

        public String getField() { return field; }
        public String getOldValue() { return oldValue; }
        public String getNewValue() { return newValue; }
    }

    public static class OrderHistoryEntry {
        private int orderId;
        private String changeDate;
        private List<ChangeLog> changes;

        public OrderHistoryEntry(int orderId, List<ChangeLog> changes) {
            this.orderId = orderId;
            this.changeDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
            this.changes = changes;
        }

        public int getOrderId() { return orderId; }
        public String getChangeDate() { return changeDate; }
        public List<ChangeLog> getChanges() { return changes; }
    }

    private static File getLogFile() {
        String path = System.getProperty("user.home") + File.separator + FILE_NAME;
        return new File(path);
    }

    public static synchronized List<OrderHistoryEntry> readHistory() {
        File file = getLogFile();
        if (!file.exists()) {
            return new ArrayList<>();
        }
        try (Reader reader = new FileReader(file)) {
            Type listType = new TypeToken<ArrayList<OrderHistoryEntry>>() {}.getType();
            List<OrderHistoryEntry> list = new Gson().fromJson(reader, listType);
            return list != null ? list : new ArrayList<>();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public static synchronized void logChange(int orderId, List<ChangeLog> changes) {
        if (changes == null || changes.isEmpty()) {
            return;
        }
        List<OrderHistoryEntry> history = readHistory();
        history.add(0, new OrderHistoryEntry(orderId, changes));

        File file = getLogFile();
        try (Writer writer = new FileWriter(file)) {
            new Gson().toJson(history, writer);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
