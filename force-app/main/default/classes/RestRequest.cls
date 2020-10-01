public with sharing class RestRequest {
    public static HttpResponse makeRestRequest(String accountId,String sensorName, Integer[] coordinates) {
        SensorData sensorData = new SensorData(accountId, sensorName, coordinates);

        Http http = new Http();
        HttpRequest request = new HttpRequest();  
        request.setEndpoint('callout:SensorSoapClient/services/apexrest/sensorEvent');  
        request.setMethod('PUT');    
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(JSON.serialize(sensorData));    

        HttpResponse responce = http.send(request);
        return responce;
    }
}
