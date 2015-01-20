/**
  
 App47 Plugin for PhoneGap Android, created by the team @ App47, Inc.

 
  The plugin's JavaScript functions are under the global "window.plugins.App47" object. 
  See <sample project> for Plugin usage in sample iOS project.
 
 */

if (!PhoneGap.hasResource("App47")) {
	PhoneGap.addResource("App47");

    App47 = function() {
        this.serviceName = "App47";
    };         
    
    App47.prototype.sendGenericEvent = function(message, success, fail) {
        return PhoneGap.exec(success, fail, this.serviceName, "sendGenericEvent", message);
    };
    
    App47.prototype.startTimedEvent = function(name, success, fail) {
        return PhoneGap.exec(success, fail, this.serviceName, "startTimedEvent", name);
    };
    
    App47.prototype.endTimedEvent = function(name, success, fail) {
        return PhoneGap.exec(success, fail, this.serviceName, "endTimedEvent", name);
    };
    
    App47.prototype.debug = function(message, success, fail) {
        return PhoneGap.exec(success, fail, this.serviceName, "log", [{type:"debug", msg:message}]);
    };
    
    App47.prototype.info = function(message, success, fail) {
        return PhoneGap.exec(success, fail, this.serviceName, "log", [{type:"info", msg:message}]);
    };
    
    App47.prototype.warn = function(message, success, fail) {
        return PhoneGap.exec(success, fail, this.serviceName, "log", [{type:"warn", msg:message}]);
    };
    
    App47.prototype.error = function(message, success, fail) {
        return PhoneGap.exec(success, fail, this.serviceName, "log", [{type:"error", msg:message}]);
    };
    
    App47.prototype.getValue = function(grp, ky, success, fail) {
        return PhoneGap.exec(success, fail, this.serviceName, "configurationValue", [{group:grp, key:ky}]);
    };
    
    App47.install = function(){
		if (typeof window.plugins == "undefined") window.plugins = {};
        if (typeof window.plugins.App47 == "undefined") window.plugins.App47 = new App47();
        return window.plugins.App47;
    };
    
    PhoneGap.addConstructor(function () {  	
    		PhoneGap.addPlugin("App47", new App47());
    		PluginManager.addService("App47", "com.app47.pgplugin.App47PGPlugin");
       }
    );
} 