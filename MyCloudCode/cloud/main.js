
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:


var twilio = require("twilio");
twilio.initialize("ACa487f77d5d6ec4fb067d295004015f5b ","77dd0ff2e1173163ec8ed2bcf61f2661");

Parse.Cloud.define("inviteWithTwilio", function(request, response) {
  twilio.sendSMS({
    From: "+15102300714",
    To: request.params.number,
    Body: request.params.message
  }, {
    success: function(httpResponse) {
      console.log(httpResponse);
      response.success("SMS sent!");
    },
    error: function(httpResponse) {
      console.error(httpResponse);
      response.error("Uh oh, something went wrong");
    }
  });
});
