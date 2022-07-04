public with sharing class CreateXML {
    public string xmlstring { get; set;}

    public CreateXML(){
        DOM.Document doc = new DOM.Document();

        dom.XmlNode shipment = doc.createRootElement('shipment', null, null);

        shipment.addChildElement('username', null, null).addTextNode('ocapg_api');
        shipment.addChildElement('userkey', null, null).addTextNode('6b60hofjo');
        shipment.addChildElement('accountid', null, null).addTextNode('2126856');


        dom.XmlNode stops = shipment.addChildElement('stops', null, null);
            dom.XmlNode stop = stops.addChildElement('stop', null, null);

            stop.addChildElement('city', null, null).addTextNode('ocapg_api');
            stop.addChildElement('state', null, null).addTextNode('6b60hofjo');
            stop.addChildElement('postal', null, null).addTextNode('2126856');
            stop.addChildElement('country', null, null).addTextNode('2126856');

            dom.XmlNode details= stops.addChildElement('details', null, null);
                dom.XmlNode detail = details.addChildElement('detail', null, null); 

                detail.addChildElement('cartons', null, null).addTextNode('ocapg_api');
                detail.addChildElement('pallets', null, null).addTextNode('6b60hofjo');
                detail.addChildElement('qty', null, null).addTextNode('2126856');
                detail.addChildElement('weight', null, null).addTextNode('16000');
                detail.addChildElement('length', null, null).addTextNode('40');
                detail.addChildElement('width', null, null).addTextNode('40');
                detail.addChildElement('height', null, null).addTextNode('40');
                detail.addChildElement('freightclass', null, null).addTextNode('2126856');

        xmlstring = doc.toXmlString();
    }

    public static String CreateXMLTest(){
        DOM.Document doc = new DOM.Document();

        dom.XmlNode shipment = doc.createRootElement('shipment', null, null);

        shipment.addChildElement('username', null, null).addTextNode('ocapg_api');
        shipment.addChildElement('userkey', null, null).addTextNode('6b60hofjo');
        shipment.addChildElement('accountid', null, null).addTextNode('2126856');
        shipment.addChildElement('carriercode', null, null).addTextNode('');



        dom.XmlNode stops = shipment.addChildElement('stops', null, null);
            dom.XmlNode stop = stops.addChildElement('stop', null, null);

                stop.addChildElement('city', null, null).addTextNode('MIAMI');
                stop.addChildElement('state', null, null).addTextNode('FL');
                stop.addChildElement('postal', null, null).addTextNode('33142');
                stop.addChildElement('country', null, null).addTextNode('USA');

                dom.XmlNode details= stop.addChildElement('details', null, null);
                    dom.XmlNode detail = details.addChildElement('detail', null, null); 

                        detail.addChildElement('cartons', null, null).addTextNode('');
                        detail.addChildElement('pallets', null, null).addTextNode('4');
                        detail.addChildElement('qty', null, null).addTextNode('');
                        detail.addChildElement('weight', null, null).addTextNode('16000');
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

                stop1.addChildElement('city', null, null).addTextNode('NEW PROVIDENCE');
                stop1.addChildElement('state', null, null).addTextNode('NJ');
                stop1.addChildElement('postal', null, null).addTextNode('07974');
                stop1.addChildElement('country', null, null).addTextNode('USA');

                dom.XmlNode accessorials1 = stop1.addChildElement('accessorials', null, null);

                    accessorials1.addChildElement('inside', null, null).addTextNode('1');
                    accessorials1.addChildElement('liftgate', null, null).addTextNode('');
                    accessorials1.addChildElement('notify', null, null).addTextNode('');
                    accessorials1.addChildElement('residence', null, null).addTextNode('');      
        String xmlstring = doc.toXmlString();

        return xmlstring;
    }
}
