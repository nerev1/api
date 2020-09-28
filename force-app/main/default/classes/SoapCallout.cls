public with sharing class SoapCallout {
    public static void makeSoapCallout(Id accountId, String sensorName, List<Integer> coordinates) {

        SoapClient.SoapService service = new SoapClient.SoapService();
        service.endpoint_x = 'callout:Service_SOAP_API/services/Soap/class/SoapService';
        service.SessionHeader = new SoapClient.SessionHeader_element();
        service.insertSensor(sensorName, accountId, coordinates);
    }
}
