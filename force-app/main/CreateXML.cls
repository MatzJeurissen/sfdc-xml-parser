public with sharing class CreateXML {

    public static String CreateXML(){
        List<welisacommerce__Shopping_Cart__c> listShoppingCarts = ShoppingCartTotalWeight.GetTotalWeight();

        welisacommerce__Shopping_Cart__c shoppingCart = listShoppingCarts[0];

        // String userId = UserInfo.getUserId();

        String userId = shoppingCart.welisacommerce__Account__c;

        // String userId = '0015Y00002wzLu1QAE';

        List<Account> userAccount = [SELECT BillingAddress, ShippingAddress, welisacommerce__Price_Book__r.isActive, welisacommerce__Price_Book__r.Location__r.Address__c, welisacommerce__Price_Book__r.Location__r.City__c,
        welisacommerce__Price_Book__r.Location__r.State_Province__c, welisacommerce__Price_Book__r.Location__r.Zip_Postal_Code__c,
        welisacommerce__Price_Book__r.Location__r.Country__c FROM Account WHERE Id = :userId];

        //Shipping Address
        String shippingAddress = userAccount[0].welisacommerce__Price_Book__r.Location__r.Address__c;
        String shippingCity = userAccount[0].welisacommerce__Price_Book__r.Location__r.City__c;
        String shippingState = userAccount[0].welisacommerce__Price_Book__r.Location__r.State_Province__c;
        String shippingZip = userAccount[0].welisacommerce__Price_Book__r.Location__r.Zip_Postal_Code__c;
        String shippingCountry = userAccount[0].welisacommerce__Price_Book__r.Location__r.Country__c;

        Boolean pricebook = userAccount[0].welisacommerce__Price_Book__r.isActive;

        String shoppingCartTotalWeight = String.valueOf(shoppingCart.Total_Weight__c);
        Address billingAddress = userAccount[0].BillingAddress;

        System.debug('shippingAddress : ' + shippingAddress);
        System.debug('shippingCity : ' + shippingCity);
        System.debug('shippingState : ' + shippingState);
        System.debug('shippingZip : ' + shippingZip);
        System.debug('shippingCountry : ' + shippingCountry);
        System.debug('billingAddress : ' + billingAddress);
        System.debug('pricebook : ' + pricebook);
        System.debug(shoppingCartTotalWeight);

        DOM.Document doc = new DOM.Document();

        dom.XmlNode shipment = doc.createRootElement('shipment', null, null);

        shipment.addChildElement('username', null, null).addTextNode('ocapg_api');
        shipment.addChildElement('userkey', null, null).addTextNode('6b60hofjo');
        shipment.addChildElement('accountid', null, null).addTextNode('2126856');
        shipment.addChildElement('carriercode', null, null).addTextNode('');



        dom.XmlNode stops = shipment.addChildElement('stops', null, null);
            dom.XmlNode stop = stops.addChildElement('stop', null, null);

            // stop.addChildElement('city', null, null).addTextNode(shippingCity);
            // stop.addChildElement('state', null, null).addTextNode('FL');
            // stop.addChildElement('postal', null, null).addTextNode('33142');
            // stop.addChildElement('country', null, null).addTextNode('USA');

                stop.addChildElement('city', null, null).addTextNode('Fort Dix');
                stop.addChildElement('state', null, null).addTextNode(shippingState);
                stop.addChildElement('postal', null, null).addTextNode(shippingZip);
                stop.addChildElement('country', null, null).addTextNode('USA');

                dom.XmlNode details= stop.addChildElement('details', null, null);
                    dom.XmlNode detail = details.addChildElement('detail', null, null); 

                        detail.addChildElement('cartons', null, null).addTextNode('');
                        detail.addChildElement('pallets', null, null).addTextNode('4');
                        detail.addChildElement('qty', null, null).addTextNode('');
                        detail.addChildElement('weight', null, null).addTextNode(shoppingCartTotalWeight);
                        detail.addChildElement('length', null, null).addTextNode('40');
                        detail.addChildElement('width', null, null).addTextNode('40');
                        detail.addChildElement('height', null, null).addTextNode('40');
                        detail.addChildElement('freightclass', null, null).addTextNode('65');

                dom.XmlNode accessorials = stop.addChildElement('accessorials', null, null);

                    accessorials.addChildElement('inside', null, null).addTextNode('1');
                    accessorials.addChildElement('liftgate', null, null).addTextNode('');
                    accessorials.addChildElement('notify', null, null).addTextNode('');
                    accessorials.addChildElement('residence', null, null).addTextNode('');    


            dom.XmlNode stop1 = stops.addChildElement('stop', null, null);

                stop1.addChildElement('city', null, null).addTextNode(billingAddress.city);
                stop1.addChildElement('state', null, null).addTextNode(billingAddress.state);
                stop1.addChildElement('postal', null, null).addTextNode(billingAddress.postalCode);
                stop1.addChildElement('country', null, null).addTextNode('USA');

                dom.XmlNode accessorials1 = stop1.addChildElement('accessorials', null, null);

                    accessorials1.addChildElement('inside', null, null).addTextNode('1');
                    accessorials1.addChildElement('liftgate', null, null).addTextNode('');
                    accessorials1.addChildElement('notify', null, null).addTextNode('');
                    accessorials1.addChildElement('residence', null, null).addTextNode('');      
        String xmlstring = doc.toXmlString();

        return xmlstring;
    }

    //     public static String CreateXML(){
    //     // List<welisacommerce__Shopping_Cart__c> listShoppingCarts = ShoppingCartTotalWeight.GetTotalWeight();

    //     // welisacommerce__Shopping_Cart__c shoppingCart = listShoppingCarts[0];

        
    //     DOM.Document doc = new DOM.Document();

    //     dom.XmlNode shipment = doc.createRootElement('shipment', null, null);

    //     shipment.addChildElement('username', null, null).addTextNode('ocapg_api');
    //     shipment.addChildElement('userkey', null, null).addTextNode('6b60hofjo');
    //     shipment.addChildElement('accountid', null, null).addTextNode('2126856');
    //     shipment.addChildElement('carriercode', null, null).addTextNode('');



    //     dom.XmlNode stops = shipment.addChildElement('stops', null, null);
    //         dom.XmlNode stop = stops.addChildElement('stop', null, null);

    //             stop.addChildElement('city', null, null).addTextNode('MIAMI');
    //             stop.addChildElement('state', null, null).addTextNode('FL');
    //             stop.addChildElement('postal', null, null).addTextNode('33142');
    //             stop.addChildElement('country', null, null).addTextNode('USA');

    //             dom.XmlNode details= stop.addChildElement('details', null, null);
    //                 dom.XmlNode detail = details.addChildElement('detail', null, null); 

    //                     detail.addChildElement('cartons', null, null).addTextNode('');
    //                     detail.addChildElement('pallets', null, null).addTextNode('4');
    //                     detail.addChildElement('qty', null, null).addTextNode('');
    //                     detail.addChildElement('weight', null, null).addTextNode('16000');
    //                     detail.addChildElement('length', null, null).addTextNode('40');
    //                     detail.addChildElement('width', null, null).addTextNode('40');
    //                     detail.addChildElement('height', null, null).addTextNode('40');
    //                     detail.addChildElement('freightclass', null, null).addTextNode('65');

    //             dom.XmlNode accessorials = stop.addChildElement('accessorials', null, null);

    //                 accessorials.addChildElement('inside', null, null).addTextNode('1');
    //                 accessorials.addChildElement('liftgate', null, null).addTextNode('');
    //                 accessorials.addChildElement('notify', null, null).addTextNode('');
    //                 accessorials.addChildElement('residence', null, null).addTextNode('');    


    //         dom.XmlNode stop1 = stops.addChildElement('stop', null, null);

    //             stop1.addChildElement('city', null, null).addTextNode('NEW PROVIDENCE');
    //             stop1.addChildElement('state', null, null).addTextNode('NJ');
    //             stop1.addChildElement('postal', null, null).addTextNode('07974');
    //             stop1.addChildElement('country', null, null).addTextNode('USA');

    //             dom.XmlNode accessorials1 = stop1.addChildElement('accessorials', null, null);

    //                 accessorials1.addChildElement('inside', null, null).addTextNode('1');
    //                 accessorials1.addChildElement('liftgate', null, null).addTextNode('');
    //                 accessorials1.addChildElement('notify', null, null).addTextNode('');
    //                 accessorials1.addChildElement('residence', null, null).addTextNode('');      
    //     String xmlstring = doc.toXmlString();

    //     return xmlstring;
    // }

    // public static String CreateXML(){
    //     // List<welisacommerce__Shopping_Cart__c> listShoppingCarts = ShoppingCartTotalWeight.GetTotalWeight();

    //     // welisacommerce__Shopping_Cart__c shoppingCart = listShoppingCarts[0];

        
    //     DOM.Document doc = new DOM.Document();

    //     dom.XmlNode shipment = doc.createRootElement('shipment', null, null);

    //     shipment.addChildElement('username', null, null).addTextNode('ocapg_api');
    //     shipment.addChildElement('userkey', null, null).addTextNode('6b60hofjo');
    //     shipment.addChildElement('accountid', null, null).addTextNode('2126856');
    //     shipment.addChildElement('carriercode', null, null).addTextNode('');



    //     dom.XmlNode stops = shipment.addChildElement('stops', null, null);
    //         dom.XmlNode stop = stops.addChildElement('stop', null, null);

    //             stop.addChildElement('city', null, null).addTextNode('MIAMI');
    //             stop.addChildElement('state', null, null).addTextNode('FL');
    //             stop.addChildElement('postal', null, null).addTextNode('33142');
    //             stop.addChildElement('country', null, null).addTextNode('USA');

    //             dom.XmlNode details= stop.addChildElement('details', null, null);
    //                 dom.XmlNode detail = details.addChildElement('detail', null, null); 

    //                     detail.addChildElement('cartons', null, null).addTextNode('');
    //                     detail.addChildElement('pallets', null, null).addTextNode('4');
    //                     detail.addChildElement('qty', null, null).addTextNode('');
    //                     detail.addChildElement('weight', null, null).addTextNode('16000');
    //                     detail.addChildElement('length', null, null).addTextNode('40');
    //                     detail.addChildElement('width', null, null).addTextNode('40');
    //                     detail.addChildElement('height', null, null).addTextNode('40');
    //                     detail.addChildElement('freightclass', null, null).addTextNode('65');

    //             dom.XmlNode accessorials = stop.addChildElement('accessorials', null, null);

    //                 accessorials.addChildElement('inside', null, null).addTextNode('1');
    //                 accessorials.addChildElement('liftgate', null, null).addTextNode('');
    //                 accessorials.addChildElement('notify', null, null).addTextNode('');
    //                 accessorials.addChildElement('residence', null, null).addTextNode('');    


    //         dom.XmlNode stop1 = stops.addChildElement('stop', null, null);

    //             stop1.addChildElement('city', null, null).addTextNode('NEW PROVIDENCE');
    //             stop1.addChildElement('state', null, null).addTextNode('NJ');
    //             stop1.addChildElement('postal', null, null).addTextNode('07974');
    //             stop1.addChildElement('country', null, null).addTextNode('USA');

    //             dom.XmlNode accessorials1 = stop1.addChildElement('accessorials', null, null);

    //                 accessorials1.addChildElement('inside', null, null).addTextNode('1');
    //                 accessorials1.addChildElement('liftgate', null, null).addTextNode('');
    //                 accessorials1.addChildElement('notify', null, null).addTextNode('');
    //                 accessorials1.addChildElement('residence', null, null).addTextNode('');      
    //     String xmlstring = doc.toXmlString();

    //     return xmlstring;
    // }

    public welisacommerce__Shopping_Cart__c getIdShoppingCart() {
        String userId = UserInfo.getUserId();
        List<welisacommerce__Shopping_Cart__c> shoppingCart = [SELECT Id, Name FROM welisacommerce__Shopping_Cart__c WHERE CreatedById = :userId];
        


        return shoppingCart[0];
    }
}
