public with sharing class SensorEventData {
    private String sensorId;
    private Integer x;
    private Integer y;
    private Integer z;
    
    public SensorEventData(String sensorId, Integer x, Integer y, Integer z) {
        this.sensorId = sensorId;
        this.x = x;
        this.y = y;
        this.z = z;
    }
}