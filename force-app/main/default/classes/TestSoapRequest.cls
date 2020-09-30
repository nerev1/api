@isTest
public class TestSoapRequest {
    private static final String ACCOUNT_ID = '0011y00000AEbYUAA1';
    private static final String VECTOR_NAME = '1';
    private static final Integer[] COORDINATES = new Integer[]{1, 2, 3, 1, 2, 3, 7, 7, 7};
    @isTest
    public static void testRequest() {
        Test.setMock(WebServiceMock.class, new SoapMock());
        SoapRequest.makeRequest(ACCOUNT_ID, VECTOR_NAME, COORDINATES);
    }
}