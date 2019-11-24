package com.success.android.firebasetest;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;

public class Share {
    public static void sendText(Activity context, String text) {
        Intent sendIntent = new Intent();
        sendIntent.setAction(Intent.ACTION_SEND);
        sendIntent.putExtra(Intent.EXTRA_TEXT, text);
        sendIntent.setType("text/plain");
        context.startActivity(Intent.createChooser(sendIntent, text));
    }
}
