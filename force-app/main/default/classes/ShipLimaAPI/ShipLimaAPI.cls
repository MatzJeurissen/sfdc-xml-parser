public with sharing class ShipLimaAPI {
    public void sendRequest() {
        // Get the list of accounts for which we need the updated values from the external system
        List < Account > accountList = new List <Account>([Select Id from Account limit 2]);
    
        // Start preparing the XML
        XmlStreamWriter w = new XmlStreamWriter();
        w.writeStartDocument(null, '1.0'); //Start the XML document
        w.writeStartElement(null, 'accounts', null); //this will start with <accounts> in XML
    
        //Loop through the accounts we queried earlier and put the values into XML
        for (Account a: accountList) {
            // This will write <account> in the XML file
            w.writeStartElement(null, 'account', null);
            // Open the tag <accountID> that will be identified by the external system
            w.writeStartElement(null, 'accountid', null); 
            // Write the value of externalID to be send
            w.writeCharacters(a.id); 
            //close </accountid>
            w.writeEndElement(); 
            //close </account>
            w.writeEndElement(); 
        }
    
        //close </accounts>
        w.writeEndElement(); 
        w.writeEndDocument();
    
        // String xmlOutput = w.getXmlString();

        CreateXML xml = new CreateXML();
        System.debug(CreateXML.CreateXMLTest());

        String xmlOutput = '<?xml version="1.0" encoding="ISO-8859-1"?> <shipment> <username>ocapg_api</username> Authentication Block <userkey>6b60hofjo</userkey> Authentication Block <accountid>2126856</accountid> Authentication Block <carriercode/> Leave empty or pass carrier SCAC to get single SCAC Rate <stops> <stop> <city>MIAMI</city> Ship From / Origin <state>FL</state> Ship From / Origin <postal>33142</postal> Ship From / Origin <country>USA</country> Ship From / Origin <details> <detail> <cartons/> Freight details / enter cartons for non-palletized freight <pallets>4</pallets> Freight details / number of pallets <qty/> optional / number of items contained within pallets <weight>16000</weight> Freight details / total weight of pallets within this block <length>40</length> Freight details / each pallet or carton dimension <width>40</width> Freight details / each pallet or carton dimension <height>40</height> Freight details / each pallet or carton dimension <freightclass>65</freightclass> Freight details / freight NMFC class </detail> </details> <accessorials> <inside>1</inside> Ship From / Pickup accessorial <liftgate/> Ship From / Pickup accessorial <notify/> Ship From / Pickup accessorial <residence/> Ship From / Pickup accessorial </accessorials> </stop> <stop> <city>NEW PROVIDENCE</city> Ship To / Delivering to <state>NJ</state> Ship To / Delivering to <postal>07974</postal> Ship To / Delivering to <country>USA</country> Ship To / Delivering to <accessorials> <inside/> Ship To / Destination accessorial <liftgate/> Ship To / Destination accessorial <notify/> Ship To / Destination accessorial <residential/> Ship To / Destination accessorial </accessorials> </stop> </stops> </shipment>';
        
        Shipment shipment = new Shipment(
            // 'ocapg_api',
            // '6b60hofjo',
            // '2126856',
            // new Stops(
            //     new Stop(
            //         'MIAMI',
            //         'FL',
            //         '33142',
            //         'USA',
                    // new Details(
                    //     new Detail(
                    //         '',
                    //         '',
                    //         '4',
                    //         '16000',
                    //         '40',
                    //         '40',
                    //         '40',
                    //         '65'
                    //     )
                    // ),
            //         new Accessorials(
            //             '1',
            //             '',
            //             '',
            //             ''
            //         )
            //     )
            // )
        );
        //Stops
        // Stops stops = new Stops();
        // Stop stop = new Stop();
        // stop.city = 'MIAMI';
        // stop.country = 'USA';
        // stop.postal = '33142';
        // stop.state = 'FL';

        // //Details
        // Details details = new Details();
        // Detail detail = new Detail();
        // detail.cartons = '';
        // detail.freightclass = '65';
        // detail.height = '40';
        // detail.length = '40';
        // detail.pallets = '4';
        // detail.qty = '';
        // detail.weight = '16000';
        // detail.width = '40';

        // //Accessorials
        // Accessorials accessorials = new Accessorials();
        // accessorials.inside = '1';
        // accessorials.liftgate = '';
        // accessorials.notify = '';
        // accessorials.residence = '';

        // //fill Stop
        // stop.details = details;
        // stop.accessorials = accessorials;

        // //fill Stops
        // stops.stop = stop;
        // details.detail = detail;

        // shipment.userName = 'ocapg_api';
        // shipment.userKey = '6b60hofjo';
        // shipment.accountId = '2126856';
        // shipment.stops = stops;
        // shipment.carrierCode = '';
        // // shipment.stops.stop.city = 'MIAMI';

        // xmlShipment xmlShipment = new xmlShipment();
        // xmlShipment.shipment = shipment;

        // System.debug(shipment);

        // String xmlString = XML.serialize(xmlShipment).setRootTag('shipment').beautify().toString();

        w.close();
    
        //Now that we have XML we will pass this to external system using HttpRequest
        System.HttpRequest request = new System.HttpRequest();
    
        // Set the endpoint URL previously decided that will know how to handle the XML 
        // we send them. Basically it will contain the code to read the values we are 
        // sending and send the data back.
        request.setEndpoint('http://api1.limatechgroup.com/services/external/v2.0/order_rate.php'); 
        // This line is important to tell the server you are passing XML input.
        request.setHeader('Content-Type', 'application/xml'); 
        request.setMethod('POST');
        // Set the XMLOutput we have created in the class above
        request.setBody(CreateXML.CreateXMLTest()); 

        // System.debug(xmlSt);
    
        //This is like dialing on a telephone, we send the data and wait for the response.
        System.HttpResponse response = new System.Http().send(request); 
        String stringResponse = response.getBody();

        System.debug(stringResponse);
        //And here we read the response. We will then process the response
        // XmlStreamReader reader = new XmlStreamReader(stringResponse); 
        // readResponse(reader);
    }

    public void readResponse(XmlStreamReader reader) {
        // Account record we will be looping
        Account accountRecord; 
        // List of accounts to store the value
        List < Account > accountList = new list < Account > (); 
        // Is there any element next?
        while (reader.hasNext()) {  
            // Is the next element an opening tag?
            if (reader.getEventType() == XmlTag.START_ELEMENT) { 
                // Check if the first element is Account
                if ('Account' == reader.getLocalName()) {
                    // if opening tag of account is found initialize AccountRecord
                    accountRecord = new Account();
                } else if ('Type' == reader.getLocalName()) {
                    // If you find any other opening tag, extract the string value
                    accountRecord.type = getValueFromTag(reader);
                } else if ('Industry' == reader.getLocalName()) {
                    // If you find any other opening tag, extract the string value
                    accountRecord.industry = getValueFromTag(reader);
                } 

            } else if (reader.getEventType() == XmlTag.END_ELEMENT) {
                // Is the next element an end tag? If yes is it an Account or an Accounts tag?
                if ('Account' == reader.getLocalName()) {
                    // If you find end tag called account, push the account record in list
                    accountList.add(accountRecord);
                } else if ('Accounts' == reader.getLocalName()) {
                    // We have reached end of file, just exit
                    break;
                }
            }
        }
    }
    
    // This is an extra function to read data between opening and closing tag. 
    // It will return the string of value from between tags
    public string getValueFromTag(XMLStreamReader reader) {
        String DataValue;
    
        while (reader.hasNext()) {
            if (reader.getEventType() == XmlTag.END_ELEMENT) {
                break;
            } else if (reader.getEventType() == XmlTag.CHARACTERS) {
                DataValue = reader.getText();
            }
            reader.next();
        }
    
        return DataValue;
    }
}