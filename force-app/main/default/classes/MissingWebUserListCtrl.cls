/**
* Created by jesus.cantero on 13/05/2021.
* This  method fetchMissingUsers() to fetech missing web users from external endpoint
* returns List<WebUsers> holds missing Web Users
**/

public with sharing class MissingWebUserListCtrl {
    
    @AuraEnabled
    public static List<WebUsers> getWebUsers(){
        try{
            HttpRequest request = new HttpRequest();
            //Getting Endpoint details from Named Credentials    
            request.setEndpoint('callout:MissingUsers');
            request.setMethod('GET');
            Http http = new Http();
            HttpResponse response = http.send(request);
            
            // Deserialize the response JSON and retuns object of type MissingWebUsers
            return  (List<WebUsers>) System.JSON.deserialize(response.getBody(), List<WebUsers>.class);
        }
        catch (Exception exc) {
            throw new AuraHandledException(exc.getMessage());
        }
    }
    
/**
* This method createWebUsers creates missing web users from external endpoint
* @param webUserObject Object of missing web users from the Data table data 
* returns bloolean true/false 
**/
    
    @AuraEnabled    
    public static boolean createWebUsers(List<sObject> webUserObject){
        try{
            List<Web_User__c> webUser = (List<Web_User__c>) webUserObject;
            insert webUser;
            return true;
        }
        catch(Exception e){
            return false;
        }
    }
    
    /*Wrapper Class that holds format of the fields to be returned from the endpoint*/
    public class WebUsers {
        @AuraEnabled
        public String Id { get; set; }
        @AuraEnabled
        public String Name { get; set; }
        @AuraEnabled
        public String Username { get; set; }
        @AuraEnabled
        public String Email { get; set; }
        @AuraEnabled
        public cls_company company  { get; set; }    
    }
    public class cls_company {
        @AuraEnabled
        public String name {get; set;} 
        @AuraEnabled
        public String catchPhrase  {get; set;} 
        @AuraEnabled
        public String bs {get; set;} 
    }
}