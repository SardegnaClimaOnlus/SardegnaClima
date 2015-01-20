# App47 PhoneGap plugin Android Example Project

Clone this repository (or download the tar ball) and then proceed to import the sample project (in the 2.x directory, for example) using Eclipse (or your favorite IDE). If you are using Eclipse, when you do import the sample code, make sure you import it as a 'Existing Android Code into Workspace'. 

## Getting started with PhoneGap Android and App47's Android Agent

1. Download the [App47 Android Agent](http://app47.com/wiki/doku.php?id=configure:androidapp) from the [App47 Dashboard](https://cirrus.app47.com)
2. Copy the AndroidAgent-x.x.x.jar file into your project's `libs` directory
3. In your project's `res` directory, copy the `EmbeddedAgentConfig.xml` file into the `values` directory
4. Inside the `EmbeddedAgentConfig.xml` file, put your target App's ID (as found in the App47 Dashboard) in the element dubbed `EmbeddedAgent_applicationID`
4. Update your project's `ManifestExample.xml` file and ensure that 3 services are added to the PhoneGap application
```
<service android:enabled="true" android:name="com.app47.embeddedagent.AgentConfigService" />
```
```
<service android:enabled="true" android:name="com.app47.embeddedagent.AgentSessionService" />
```
```
<service android:enabled="true" android:name="com.app47.embeddedagent.AgentEventService" />
```
5. Ensure that at a minimum the following permission is granted to the app:
```
<uses-permission android:name="android.permission.INTERNET" />
```
And if you wish to have GPS data associated with App47 events, then ensure:
```
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
```
is enabled. Note, by default, these permissions are enabled in PhoneGap applications.
5. Edit the PhoneGap `config.xml` file and white-list the following URL with subdomains set to true: https://app47.com, http://app47.mobi/, and https://app47.mobi/ 
6. Grab the [App47 Android Plugin](https://github.com/App47/phonegap-plugins) and configure it as a normal PhoneGap plugin. You will need to copy of the source and place it into your project and then add the following line to the PhoneGap `config.xml` file inside the plugins element:
```
<plugin name="App47" value="com.app47.pgplugin.App47PGPlugin" />
```
7. Next, add the `app47pg.js` file into your `assets` directory. You then must reference this JavaScript file inside your desired App. See the example code in this repository for how to interact with the plugin.
8. Lastly, you must edit your app's main `Activity` class -- you need to override the `onResume` and `onPause` lifecycle methods:
```
protected void onResume() {
	super.onResume();
	EmbeddedAgent.onResume(getApplicationContext());
}
```
```
protected void onPause() {
	super.onPause();
	EmbeddedAgent.onPause(getApplicationContext());
}
```
Then in your `onCreate` method add:
```
EmbeddedAgent.configureAgent(getApplicationContext());
```
These hook methods provide the means by which the App47 Agent works. If you do not do this step, you will not see analytics.

Fire up your app and watch for analytics to appear in your dashboard.

# License

The MIT License

Copyright (c) 2011 App47, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE