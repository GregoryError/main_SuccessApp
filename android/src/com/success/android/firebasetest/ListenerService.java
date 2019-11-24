package com.success.android.firebasetest;

import com.success.android.firebasetest.ListenerService;
import org.qtproject.qt5.android.bindings.QtApplication;
import org.qtproject.qt5.android.bindings.QtActivity;
import android.util.Log;
import android.support.v7.app.AppCompatActivity;
import android.view.WindowManager;

// Messaging support
import android.os.Bundle;
import android.content.Intent;
import com.google.firebase.messaging.MessageForwardingService;
//import com.success.android.firebasetest.Main;
import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;


public class ListenerService extends FirebaseMessagingService
{
    static String sToken;

    @Override
    public void onNewToken(String mToken)
    {
        super.onNewToken(mToken);
        Log.e("TOKEN: ", mToken);
        sToken = mToken;
    }

    public static String getToken(int v)
    {
         return sToken;
    }
}



