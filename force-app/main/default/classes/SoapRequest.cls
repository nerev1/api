public with sharing class SoapRequest {

    public static void makeRequest(String accountId, String sensorName, Integer[] coordinates) {
        SensorData data = new SensorData(accountId, sensorName, coordinates);
        String dataJSON = JSON.serialize(data);
        SoapWSDLMethods.SoapService service = new SoapWSDLMethods.SoapService();
        service.addSensorData(dataJSON);

    }
}