@IsTest
public with sharing class TestRestRequest {
    private static String ACCOUNT_ID = '0012w00000MAglGAAT';
    private static String SENSOR_NAME = '3';
    private static Integer[] COORDINATES = new Integer[]{1,1,1,4,5,4};

    @IsTest
    public static void testRestRequest() {
        Test.setMock(HttpCalloutMock.class, new RestMock()); 
        HttpResponse response = RestRequest.makeRestRequest(ACCOUNT_ID, SENSOR_NAME, COORDINATES);
        System.assertEquals(200, response.getStatusCode());
    }
}
