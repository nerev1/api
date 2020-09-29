@isTest
class TestSoapService {
    @isTest
    static void checkInsertionWithoutExistingSensor() {
        Account account = new Account(Name = 'Account 1');
        insert account;
        String accountId = account.Id;
        String sensorId = '5';
        Integer[] coordinates = new Integer[]{1,1,1,3,3,3,5,5,5};
        SensorData data = new SensorData(accountId, sensorId, coordinates);
        String jsonData = JSON.serialize(data);
        SoapService.addSensorData(jsonData);
        List<Sensor__c> sensors = [SELECT Account_Id__c, Name 
                                    FROM Sensor__c 
                                    WHERE Name = :sensorId 
                                    AND Account_Id__c = :account.Id
                                    LIMIT 1];
        System.assertEquals(1, sensors.size());
        List<Sensor_Event__c> sensorEventList = [SELECT Sensor__c
                                                FROM Sensor_Event__c
                                                WHERE Sensor__c = :sensors[0].Id];
        System.assertEquals(3, sensorEventList.size());
    }

    @isTest
    static void checkInsertionWithExistingSensor() {
        Account account = new Account(Name = 'Account 1');
        insert account;
        String accountId = account.Id;
        Sensor__c sensor = new Sensor__c(Name='5', Account_Id__c = account.Id);
        insert sensor;
        String sensorId = sensor.Name;
        Integer[] coordinates = new Integer[]{1,1,1,3,3,3,5,5,5};
        SensorData data = new SensorData(accountId, sensorId, coordinates);
        String jsonData = JSON.serialize(data);
        SoapService.addSensorData(jsonData);
        List<Sensor__c> sensors = [SELECT Id 
                                    FROM Sensor__c
                                    WHERE Id = :sensor.Id
                                    LIMIT 1];
        System.assertEquals(1, sensors.size());
        List<Sensor_Event__c> sensorEventList = [SELECT Sensor__c
                                                FROM Sensor_Event__c
                                                WHERE Sensor__c = :sensor.Id];
        System.assertEquals(3, sensorEventList.size());
    }

    @isTest
    static void checkInsertionWithWrongCoordinatesCount() {
        Account account = new Account(Name = 'Account 1');
        insert account;
        String accountId = account.Id;
        String sensorId = '5';
        Integer[] coordinates = new Integer[]{1,1,1,3,3,3,5};
        SensorData data = new SensorData(accountId, sensorId, coordinates);
        String jsonData = JSON.serialize(data);
        SoapService.addSensorData(jsonData);
        List<Sensor__c> sensors = [SELECT Account_Id__c, Name 
                                    FROM Sensor__c 
                                    WHERE Name = :sensorId 
                                    AND Account_Id__c = :account.Id
                                    LIMIT 1];
        System.assertEquals(1, sensors.size());
        List<Sensor_Event__c> sensorEventList = [SELECT Sensor__c
                                                FROM Sensor_Event__c
                                                WHERE Sensor__c = :sensors[0].Id];
        System.assertEquals(2, sensorEventList.size());
    }

    @isTest
    static void checkNonExistingAccount() {
        try {
            Account account = new Account(Name = 'Account 1');
            insert account;
            String accountId = account.Id;
            delete account;
            String sensorId = '5';
            Integer[] coordinates = new Integer[]{1,1,1,3,3,3,5,5,5};
            SensorData data = new SensorData(accountId, sensorId, coordinates);
            String jsonData = JSON.serialize(data);
            SoapService.addSensorData(jsonData);
        } catch(Exception error) {
            System.assertEquals(InsertSensorData.NO_SUCH_ACCOUNT, error.getMessage());
        }
    }
}
