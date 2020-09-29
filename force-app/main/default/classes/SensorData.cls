public with sharing class SensorData {
    public String accountId {get; set;}
    public String sensorName {get; set;}
    public Integer[] coordinates {get; set;}

    public SensorData(String accountId, String sensorName, Integer[] coordinates) {
        this.accountId = accountId;
        this.sensorName = sensorName;
        this.coordinates = coordinates;
    }
}
