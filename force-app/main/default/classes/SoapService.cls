global with sharing class SoapService {
    webservice static void addSensorData(String data) {
        SensorData sensorData = (SensorData) JSON.deserialize(data, SensorData.class);
        InsertSensorData.insertData(sensorData.accountId, sensorData.sensorName, sensorData.coordinates);
    }
}