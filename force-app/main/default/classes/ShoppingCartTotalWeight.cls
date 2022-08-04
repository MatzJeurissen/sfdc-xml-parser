public with sharing class ShoppingCartTotalWeight {
    @AuraEnabled(cacheable=true)
    public static List<welisacommerce__Shopping_Cart__c> GetTotalWeight() {
        // List<welisacommerce__Shopping_Cart__c> cartList = [SELECT Id, Total_Weight__c FROM welisacommerce__Shopping_Cart__c WHERE id = :cartId];
        String userId = UserInfo.getUserId();
        List<AggregateResult> cartWithHighestLastModifiedDate = [SELECT max(LastModifiedDate)maxDateTime FROM welisacommerce__Shopping_Cart__c WHERE of_Products__c != null AND createdbyid = :userId];
        Datetime highestDateTime = Datetime.valueOf(cartWithHighestLastModifiedDate[0].get('maxDateTime'));

        List<welisacommerce__Shopping_Cart__c> cartList = [SELECT Id, Name FROM welisacommerce__Shopping_Cart__c WHERE CreatedById = :userId AND of_Products__c != null AND LastModifiedDate = :highestDateTime LIMIT 1];
        Id itemId = cartList[0].Id;
        List<welisacommerce__Shopping_Cart_Item__c> itemList = [SELECT Id, Total_Weight__c, welisacommerce__Quantity__c FROM welisacommerce__Shopping_Cart_Item__c WHERE welisacommerce__Shopping_Cart__c = :itemId];

        Decimal totalWeight = 0;
        Integer numberOfProducts = 0;

        for (welisacommerce__Shopping_Cart_Item__c shoppingCartItem : itemList) {
            totalWeight = totalWeight + Decimal.valueOf(shoppingCartItem.Total_Weight__c);
            numberOfProducts = numberOfProducts + Integer.valueOf(shoppingCartItem.welisacommerce__Quantity__c);
        }

        cartList[0].Total_Weight__c = totalWeight;
        cartList[0].Number_of_Products__c = numberOfProducts;

        return cartList;
    }

    @AuraEnabled(cacheable=true)
    public static String getIdShoppingCart() {
        String userId = UserInfo.getUserId();
        List<AggregateResult> cartWithHighestLastModifiedDate = [SELECT max(LastModifiedDate)maxDateTime FROM welisacommerce__Shopping_Cart__c WHERE of_Products__c != null AND createdbyid = :userId];
        Datetime highestDateTime = Datetime.valueOf(cartWithHighestLastModifiedDate[0].get('maxDateTime'));

        List<welisacommerce__Shopping_Cart__c> cartList = [SELECT Id, Name FROM welisacommerce__Shopping_Cart__c WHERE CreatedById = :userId AND of_Products__c != null AND LastModifiedDate = :highestDateTime LIMIT 1];
        String itemId = cartList[0].Id;
        return itemId;
    }
}