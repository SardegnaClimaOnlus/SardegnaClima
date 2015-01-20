package com.app47.gravy;

import com.app47.embeddedagent.EmbeddedAgent;
import com.phonegap.DroidGap;

import android.os.Bundle;

public class GravyActivity extends DroidGap {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);        
        EmbeddedAgent.configureAgentWithAppID(this, "4e7f387d2ee5120001000003");        
        super.loadUrl("file:///android_asset/www/index.html");
    }

	@Override
	protected void onPause() {
		super.onPause();
		EmbeddedAgent.onPause(this);
	}

	@Override
	protected void onResume() {
		super.onResume();
		EmbeddedAgent.onResume(this);
	}
}