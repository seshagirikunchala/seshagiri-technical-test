/**
 * Created by jesus.cantero on 13/05/2021.
 */
({
    init: function(component, event, helper) {
        component.set("v.columns", [
            { label: "Id", fieldName: "Id", type: "text" },
            { label: "Name", fieldName: "Name", type: "text" },
            { label: "User Name", fieldName: "Username", type: "text" },
            { label: "Email", fieldName: "Email", type: "Email" },
            //{label: 'Company Name', fieldName: 'company.name', type: 'text'}
            { label: "Company Name", fieldName: "companyName", type: "text" }
        ]);
        
        let action = component.get("c.getWebUsers");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let newResponse = response.getReturnValue().map(webUser => {
                    return Object.assign({ companyName: webUser.company.name }, webUser);
            });
            component.set("v.data", newResponse);
        } else if (state === "ERROR") {
            let errors = response.getError();
            console.error(errors);
        }
    });
    $A.enqueueAction(action);
},
 
 doSave: function(component, event, helper) {
    helper.saveUsersData(component, event, helper);
}
});