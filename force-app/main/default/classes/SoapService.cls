global class SoapService {
    webservice static void addSensorData(SensorData data) {
        SensorData sensorData = (SensorData) JSON.deserialize(data, SensorData.class);
        InsertSensorData.insertData(sensorData.accountId, sensorData.sensorName, sensorData.coordinates);
    }
}
