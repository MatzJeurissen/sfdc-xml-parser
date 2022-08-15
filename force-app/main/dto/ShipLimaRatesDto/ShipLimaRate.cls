public with sharing class ShipLimaRate {

    // public static Charges returnLowestShippingCostCarrier(String stringResponse) {
    //     //Parse XML to Object
    //     Rates rates = (Rates) XML.deserialize(stringResponse).setType(Rates.class).toObject();

    //     Charges charges = new Charges();
        
    //     //Set initial totalAmount so we can compare to new totalAmount
    //     Decimal totalAmount = Decimal.valueOf(rates.rate[0].charges.total);
    //     for (Rate rate : rates.rate) {

    //         if (totalAmount >= Decimal.valueOf(rate.charges.total)) {
    //             totalAmount = Decimal.valueOf(rate.charges.total);
    //             charges = rate.charges;
    //         }
    //     }
    //     return charges;
    // }

    public static List<Charges> returnLowestShippingCostCarrier(String stringResponse) {
        //Parse XML to Object
        Rates rates = (Rates) XML.deserialize(stringResponse).setType(Rates.class).toObject();

        List<Charges> charges = new List<Charges>();
        
        //Set initial totalAmount so we can compare to new totalAmount
        Decimal totalAmount = rates.rate[0].charges.total;
        for (Rate rate : rates.rate) {

            if (totalAmount >= rate.charges.total) {
                totalAmount = rate.charges.total;
                charges.clear();

                charges.add(rate.charges);
            }
        }
        return charges;
    }
    
    // public static List<Charges> returnLowestShippingCostCarrier(String stringResponse) {
    //     //Parse XML to Object
    //     Rates rates = (Rates) XML.deserialize(stringResponse).setType(Rates.class).toObject();

    //     List<Charges> charges = new List<Charges>();
        
    //     //Set initial totalAmount so we can compare to new totalAmount
    //     Decimal totalAmount = Decimal.valueOf(rates.rate[0].charges.total);
    //     for (Rate rate : rates.rate) {

    //         if (totalAmount >= Decimal.valueOf(rate.charges.total)) {
    //             totalAmount = Decimal.valueOf(rate.charges.total);
    //             charges.add(rate.charges);
    //         }
    //     }
    //     return charges;
    // }
}
