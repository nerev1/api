public with sharing class SensorData {
    public String accountId;
    public String sensorId;
    public Integer[] coordinates;

    public SensorData(String accountId, String sensorId, Integer[] coordinates) {
        this.accountId = accountId;
        this.sensorId = sensorId;
        this.coordinates = coordinates;
    }
}