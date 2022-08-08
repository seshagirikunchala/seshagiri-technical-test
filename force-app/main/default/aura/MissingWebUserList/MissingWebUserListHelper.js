({
  saveUsersData: function(component, event, helper) {
    let  webUserRecords = component.get("v.data");
    console.log('webUserRecords', webUserRecords);
    let action = component.get("c.createWebUsers");
    //Passing data object to create web user apex controller method 
    action.setParams({
      webUserObject: webUserRecords
    });
    action.setCallback(this, function(response) {
      var state = response.getState();
      if (state === "SUCCESS") {
        //if update is successful
        if (response.getReturnValue() === true) {
          helper.showToast({
            title: "Success",
            type: "success",
            message: "Missing Web Users Inserted Successfully"
          });
          helper.refreshDataTable();
        } else {
          //if update got failed
          helper.showToast({
            title: "Error!!",
            type: "error",
            message: "Error in update"
          });
        }
      }
    });
    $A.enqueueAction(action);
  },

  showToast: function(params) {
    var toastEvent = $A.get("e.force:showToast");
    if (toastEvent) {
      toastEvent.setParams(params);
      toastEvent.fire();
    } else {
      alert(params.message);
    }
  },

  refreshDataTable: function() {
    var refreshEvent = $A.get("e.force:refreshView");
    if (refreshEvent) {
      refreshEvent.fire();
    }
  }
});