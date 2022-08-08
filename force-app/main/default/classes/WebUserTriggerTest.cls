@isTest
public class WebUserTriggerTest {
    
    @isTest
    public static Void WebUserTriggerDuplicateCheck()
    {
        Boolean expectedError = false;   
        try{
            Test.startTest();
            TestUsersDataFactory.createWebUser('Johns Group');
            TestUsersDataFactory.createDuplicateWebUser('Johns Group');
            Test.stopTest();
        }catch(DmlException dmlExc){ 
            expectedError =  dmlExc.getMessage().contains('There is already user with same Web Site Id') ? true : false;
        }
        System.assertEquals(expectedError, true);
    }
    
    @isTest
    public static Void WebUserTriggerIsPremiumTrue() {
        try{
            Test.startTest();
            TestUsersDataFactory.createWebUser('Johns Group');
            Web_User__c webUser = [SELECT Id, IsPremium__c FROM Web_User__c WHERE Web_Site_Id__c ='test.sk.com' LIMIT 1];
            Test.stopTest();
            System.assertEquals(webUser.IsPremium__c, true);
        }catch(Exception exc){ 
            System.debug('Error Message :' + exc.getMessage());
        }
    }
    
    @isTest
    public static Void WebUserTriggerIsPremiumFalse() {
        try{
            Test.startTest();
            TestUsersDataFactory.createWebUser('Zopa');
            Web_User__c webUser = [SELECT Id, IsPremium__c FROM Web_User__c WHERE Web_Site_Id__c ='test.sk.com' LIMIT 1];
            Test.stopTest();
            System.assertEquals(webUser.IsPremium__c, false);
        }catch(Exception exc){ 
            System.debug('Error Message :' + exc.getMessage());
        }
    }
}