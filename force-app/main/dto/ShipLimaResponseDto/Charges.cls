global class Charges {
    public String rate;
    public String stop;

    @AuraEnabled @InvocableVariable 
    public String fuel;

    @AuraEnabled @InvocableVariable 
    public Decimal total;

    public Charges(Decimal total, String fuel){
        this.total = total;
        this.fuel = fuel;
    }
}