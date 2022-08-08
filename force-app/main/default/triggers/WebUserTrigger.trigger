/**
* Created by jesus.cantero on 13/05/2021.
* @description Trigger validates Web_User__c field values before creating or updating records
**/

trigger WebUserTrigger on Web_User__c (before insert, before update) {
    try{
        if (Trigger.isBefore) {
            if (Trigger.isInsert || Trigger.isUpdate){
                map<string, Web_User__c> webUserMap =  new map<string, Web_User__c>();
                for(Web_User__c webUser : trigger.new)  
                {
                    if(webUser.Company__c == 'Considine-Lockman' || webUser.Company__c == 'Johns Group'){
                          /* Set to True when the Company equals to Considine-Lockman or Johns Group*/
                        webUser.IsPremium__c = true;
                    }
                    else{
                        /* Set to false when the Company not equals to Considine-Lockman or Johns Group*/
                        webUser.IsPremium__c = false;
                    }
                    /* Create a map of new Web Site Ids and Web User object*/
                    if(webUser.Web_Site_Id__c != null){
                        webUserMap.put(webUser.Web_Site_Id__c, webUser);
                    }
                } 
                /*Fetch existing Web User records from Web User object for same set of Web Site Ids*/
                List<Web_User__c> webUserKeys =  [SELECT Id, Web_Site_Id__c FROM Web_User__c WHERE Web_Site_Id__c IN: webUserMap.keyset()];
                if (webUserKeys.size()>0){
                    for(Web_User__c webUser1 : webUserKeys)
                    {
                        if(webUserMap.containsKey(webUser1.Web_Site_Id__c)){
                            /* Throw error if any new Web Site Id matches with existing records Web Site Id*/
                            webUserMap.get(webUser1.Web_Site_Id__c).adderror('There is already user with same Web Site Id');
                        }      
                    }
                }
            }
        }
    }
    catch (Exception ex){
        system.debug('Error Messge :' + ex.getMessage());
    }
    
}