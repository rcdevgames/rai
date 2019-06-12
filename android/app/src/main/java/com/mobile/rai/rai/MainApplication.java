package com.mobile.rai.rai;

import com.instabug.instabugflutter.InstabugFlutterPlugin;

import java.util.ArrayList;

public class MainApplication extends io.flutter.app.FlutterApplication {

    @Override
    public void onCreate() {
        super.onCreate();

        ArrayList<String> invocationEvents = new ArrayList<>();
        invocationEvents.add(InstabugFlutterPlugin.INVOCATION_EVENT_SHAKE);
        new InstabugFlutterPlugin().start(MainApplication.this, "e8f6cfd41f9811f23a37e102bba7fcc6", invocationEvents);
    }
}
