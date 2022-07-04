public with sharing class ShipLimaAPI {
    public String sendRequest() {

        System.HttpRequest request = new System.HttpRequest();
        request.setEndpoint('http://api1.limatechgroup.com/services/external/v2.0/order_rate.php'); 
        request.setHeader('Content-Type', 'application/xml'); 
        request.setMethod('POST');
        request.setBody(CreateXML.CreateXML()); 

        System.HttpResponse response = new System.Http().send(request); 
        String stringResponse = response.getBody();  

        Charges lowestShippingCostCarrier = ShipLimaRate.returnLowestShippingCostCarrier(stringResponse);

        System.debug(lowestShippingCostCarrier);

        return lowestShippingCostCarrier.total;
    }
}