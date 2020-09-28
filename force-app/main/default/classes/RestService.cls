@RestResource(urlMapping='/Sensor_Event__c/*')
global with sharing class RestService {
    @HttpDelete
    global static void doDelete() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String sensorEventId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        Sensor_Event__c sensorEvent = [SELECT Id FROM Sensor_Event__c WHERE Id = :sensorEventId];
        delete sensorEvent;
    }

    @HttpGet
    global static Sensor_Event__c doGet() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String sensorEventId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        Sensor_Event__c sensorEvent = [SELECT Id, Sensor__c, Modulus_difference_Vectors__c, 
                                                x__c, y__c, z__c, Previous_Event__c  
                                        FROM Sensor_Event__c 
                                        WHERE Id = :sensorEventId];
        return sensorEvent;
    }

    @HttpPost
    global static String doPost(String sensorId, Integer x, Integer y, Integer z) {
        Sensor_Event__c sensorEvent = new Sensor_Event__c();
        sensorEvent.sensor__c = sensorId;
        sensorEvent.x__c = x;
        sensorEvent.y__c = y;
        sensorEvent.z__c = z;
        insert sensorEvent;
        return sensorEvent.Id;
    }

}
