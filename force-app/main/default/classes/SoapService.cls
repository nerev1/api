global class SoapService {
    webservice static void insertSensor(String data) {
        SensorData sensorData = (SensorData) JSON.deserialize(data, SensorData.class);
        InsertSoapSensor.insertData(sensorData.accountId, sensorData.sensorId, sensorData.coordinates);
    }
}
