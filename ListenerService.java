package com.blackgrain.android.firebasetest;

import org.qtproject.qt5.android.bindings.QtApplication;
import org.qtproject.qt5.android.bindings.QtActivity;

import android.util.Log;
import android.support.v7.app.AppCompatActivity;

import android.view.WindowManager;

// Messaging support
import android.os.Bundle;
import android.content.Intent;
import com.google.firebase.messaging.MessageForwardingService;
import com.blackgrain.android.firebasetest.Main;

public class ListenerService extends Main {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my);


        SharedPreferences prefs = getSharedPreferences("TOKEN_PREF", MODE_PRIVATE);
        String token = prefs.getString("token", "");

        Log.e("NEW_INACTIVITY_TOKEN", token);

        if (TextUtils.isEmpty(token)) {
            FirebaseInstanceId.getInstance().getInstanceId().addOnSuccessListener(ListenerService.this, new OnSuccessListener<InstanceIdResult>() {

                @Override
                public void onSuccess(InstanceIdResult instanceIdResult) {
                    String newToken = instanceIdResult.getToken();
                    Log.e("newToken", newToken);
                    SharedPreferences.Editor editor = getSharedPreferences("TOKEN_PREF", MODE_PRIVATE).edit();
                    if (token!=null){
                       editor.putString("token", newToken);
                       editor.apply();
                    }

                }
            });
        }

    }


}

