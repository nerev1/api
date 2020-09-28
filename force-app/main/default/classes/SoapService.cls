global class SoapService {
    webservice static void insertData(Id accountId, String sensorId, List<Integer> coordinates) {
        try {
            Sensor__c sensor = getSensor(accountId, sensorId);
            generateSensorEventList(sensor, coordinates);
        } catch (Exception error) {
            System.debug(error.getMessage());
        }
    }

    private static boolean isExistingAccount(Id accountId) {
        List<Account> account = [SELECT Id FROM Account WHERE Id = :accountId LIMIT 1];
        if (account.size() > 0) {
            return true;
        }
        return false;
    }

    private static Sensor__c getSensor(Id accountId, String sensorId) {
        if (!isExistingAccount(accountId)) {
            throw new QueryException('No such account');
        }

        List<Sensor__c> sensors = [SELECT Name 
                            FROM Sensor__c 
                            WHERE Name = :sensorId 
                            AND Account_Id__c = :accountId
                            LIMIT 1];
        Sensor__c sensor;
        if (sensors.size() > 0) {
            sensor = sensors[0];
        } else {
            sensor = new Sensor__c(Account_Id__c = accountId,
                                    Name = sensorId);
            insert sensor;
        }
        return sensor;
    }

    private static void generateSensorEventList(Sensor__c sensor, List<Integer> coordinates) {
        List<Sensor_Event__c> sensorEventList = new List<Sensor_Event__c>();
        Integer validCoordinatesNumber = coordinates.size();
        if (validCoordinatesNumber < 3) throw new ListException('Not enough coordinates');
        if (Math.mod(validCoordinatesNumber, 3) != 0) {
            validCoordinatesNumber = validCoordinatesNumber - Math.mod(validCoordinatesNumber, 3);
        }
        for (Integer i = 0; i < validCoordinatesNumber; i = i + 3) {
            Sensor_Event__c sensorEvent = new Sensor_Event__c();
            sensorEvent.Sensor__c = sensor.Id;
            sensorEvent.x__c = coordinates[i];
            sensorEvent.y__c = coordinates[i + 1];
            sensorEvent.z__c = coordinates[i + 2];
            sensorEventList.add(sensorEvent);
        }
        insert sensorEventList;
        for (Integer i = 1; i < sensorEventList.size(); i++) {
            sensorEventList[i].Previous_Event__c = sensorEventList[i - 1].Id;
        }
        update sensorEventList;
    }

}
