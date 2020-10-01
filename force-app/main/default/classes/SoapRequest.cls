public with sharing class SoapRequest {

    public static void makeRequest(String accountId, String sensorName, Integer[] coordinates) {
        SensorData data = new SensorData(accountId, sensorName, coordinates);
        String dataJSON = JSON.serialize(data);
        SoapWSDLMethods.SoapService service = new SoapWSDLMethods.SoapService();
        service.SessionHeader = new SoapWsdlMethods.SessionHeader_element();
        service.endpoint_x = 'callout:SalesforceSensorAPI/service/Soap/class/SoapService';
        service.SessionHeader.sessionId = '{!$Credential.OAuthToken}';
        service.addSensorData(dataJSON);
    }
}