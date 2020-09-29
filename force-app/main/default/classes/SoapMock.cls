@isTest
global class SoapMock implements WebServiceMock {
    global void doInvoke(
        Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType) {
            SoapWsdlMethods.addSensorDataResponse_element response_x = new SoapWsdlMethods.addSensorDataResponse_element();
            response.put('response_x', response_x);
        }
}