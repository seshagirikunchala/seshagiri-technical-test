@isTest
public class TestUsersDataFactory {
    public static void createWebUser( String CompanyName) {
        Web_User__c webUser = new Web_User__c();
        webUser.Name='Test1';
        webUser.UserName__c='test1@test.user.ks';
        webUser.Email__c='Test1@test.user.ks';
        webUser.Name='Test1';
        webUser.Company__c = CompanyName;
        webUser.Web_Site_Id__c ='test.sk.com';
        insert webUser;
    }
    
    public static void createDuplicateWebUser(String CompanyName) {
        Web_User__c webUser = new Web_User__c();
        webUser.Name='Test2';
        webUser.UserName__c='test2@test.user.ks';
        webUser.Email__c='Test2@test.user.ks';
        webUser.Name='Test2';
        webUser.Company__c = CompanyName;
        webUser.Web_Site_Id__c ='test.sk.com';
        insert webUser;
    }
}