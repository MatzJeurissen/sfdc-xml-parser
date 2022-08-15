global class Charges {
    public String rate;
    public String stop;
    public String fuel;

    @AuraEnabled @InvocableVariable 
    public Decimal total;

    public Charges(Decimal total){
        this.total = total;
    }
}