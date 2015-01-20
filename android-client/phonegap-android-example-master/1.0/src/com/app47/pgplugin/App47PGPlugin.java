package com.app47.pgplugin;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.app47.embeddedagent.EmbeddedAgent;
import com.app47.embeddedagent.EmbeddedAgentLogger;
import com.phonegap.api.Plugin;
import com.phonegap.api.PluginResult;

public class App47PGPlugin extends Plugin {

	public PluginResult execute(String methodToInvoke, JSONArray data, String callbackId) {
		
		System.out.println("action is " + methodToInvoke + " data is " + data + " and callback is " + callbackId);

		PluginResult result = null;
		try {
			if (methodToInvoke.equals("sendGenericEvent")) {
				result = handleGenericEvent(data);
			} else if (methodToInvoke.equals("startTimedEvent")) {
				result = handleStartTimedEvent(data);
			} else if (methodToInvoke.equals("endTimedEvent")) {
				result = handleEndTimedEvent(data);
			} else if (methodToInvoke.equals("log")) {
				result = handleLog(data);
			} else { // configurationValue
				result = handleConfigurationValue(data);
			}
			return result;
		} catch (JSONException e) {
			return new PluginResult(PluginResult.Status.ERROR, e.getMessage());
		}
	}

	private PluginResult handleConfigurationValue(JSONArray data) throws JSONException {
		JSONObject values = data.getJSONObject(0);
		String group = values.getString("group");
		String key = values.getString("key");
		Object value = EmbeddedAgent.configurationObjectForKey(key, group);
		return new PluginResult(PluginResult.Status.OK, value.toString());
	}

	private PluginResult handleEndTimedEvent(JSONArray data) throws JSONException {
		String eventId = data.getString(0);
		EmbeddedAgent.endTimedEvent(eventId);
		return getSuccessPluginResult();
	}

	private PluginResult handleStartTimedEvent(JSONArray data) throws JSONException {
		String eventName = data.getString(0);
		String udid = EmbeddedAgent.startTimedEvent(eventName);
		return new PluginResult(PluginResult.Status.OK, udid);
	}

	private PluginResult handleLog(JSONArray data) throws JSONException {
		JSONObject values = data.getJSONObject(0);
		String logLevel = values.getString("type");
		String message = values.getString("msg");

		if (logLevel.equals("info")) {
			EmbeddedAgentLogger.info(message);
		} else if (logLevel.equals("warn")) {
			EmbeddedAgentLogger.warn(message);
		} else if (logLevel.equals("error")) {
			EmbeddedAgentLogger.error(message);
		} else { // debug
			EmbeddedAgentLogger.debug(message);
		}
		return getSuccessPluginResult();
	}

	private PluginResult handleGenericEvent(JSONArray data) throws JSONException {
		EmbeddedAgent.sendEvent(data.getString(0));
		return getSuccessPluginResult();
	}

	private PluginResult getSuccessPluginResult() {
		return new PluginResult(PluginResult.Status.OK, "success");
	}

}
