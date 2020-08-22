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

// zloy
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.ActivityManager;
import android.app.ActivityManager.RunningTaskInfo;
import android.app.ActivityManager.RunningAppProcessInfo;

import android.support.v4.app.NotificationCompat;
import android.os.Build;
import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.media.RingtoneManager;
import android.net.Uri;

import android.util.Log;

import java.util.Map;
import java.util.Map.*;

import java.util.List;
import java.util.ArrayList;

import org.json.*;


import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.iid.FirebaseInstanceId;
import com.google.firebase.messaging.RemoteMessage;

import org.success.isp.R;

import org.qtproject.qt5.android.bindings.QtActivity;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;


public class ListenerService extends FirebaseMessagingService
{
    private static final String TAG = "FirebaseMsgService";

    private static ArrayList<JSONObject> events = new ArrayList<>();



    static String sToken;
    static String sAction;
    static boolean isOldWayMsg = false;

    enum AppStatus {
            FOREGROUND,
            BACKGROUND,
            CLOSED
        }

    @Override
    public void onCreate()
    {
        super.onCreate();
    }


    @Override
       public void onMessageReceived(RemoteMessage remoteMessage)
       {
            final Map<String, String> data = remoteMessage.getData();

//            System.out.println("using entrySet and toString");
//                for (Entry<String, String> entry : data.entrySet())
//                {
//                    System.out.println(entry);
//                }


            if (getAppStatus("org.success.isp") == AppStatus.CLOSED && data.isEmpty())
            {
                System.out.println("Old way msg received");
                isOldWayMsg = true;
            }
            else
            {

                System.out.println("New way msg received");

                if(isAppRunning("org.success.isp"))
                {
                    final JSONObject json = new JSONObject(data);
                    signalMessage(json.toString());
                }
                else if (!data.isEmpty())
                {
                    sAction = "rec";
                    pushEvent(new JSONObject(data));
                    final String title = data.get("title");
                    final String body = data.get("body");

                    if (title != null && body != null)
                        if(!title.isEmpty() || !body.isEmpty())
                        {
                            sendNotification(title, body);
                        }
                }
            }

       }

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


    public static String getAction(int v)
    {
        String tmp_str = sAction;
        sAction = "";
        return tmp_str;
    }


    public void sendNotification(String title, String body)
    {
        Intent intent = new Intent(this, QtActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        PendingIntent pendingIntent = PendingIntent.getActivity(this, 0, intent,
                       PendingIntent.FLAG_ONE_SHOT);

        final String channelId = getString(R.string.default_notification_channel_id);
        Uri defaultSoundUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);
        final String appName = getString(R.string.app_name);
        final int color = getColor(R.color.blue);

        BitmapFactory.Options options = new BitmapFactory.Options();
        Bitmap bitmap = BitmapFactory.decodeResource(getResources(), R.drawable.logo_dark, options);

        NotificationCompat.Builder notificationBuilder =
                new NotificationCompat.Builder(this, channelId)
                        .setSmallIcon(R.drawable.ic_stat_ic_notification)
                        .setContentTitle(title)
           //             .setContentText(body)
                        .setAutoCancel(true)
                        .setSound(defaultSoundUri)
                        .setColor(color)
                        .setContentIntent(pendingIntent)
                        .setShowWhen(true)
                        .setLargeIcon(bitmap)
                        .setStyle(new NotificationCompat.BigTextStyle().bigText(body));

        NotificationManager notificationManager =
                            (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = new NotificationChannel(channelId,
                    "Channel human readable title",
                    NotificationManager.IMPORTANCE_DEFAULT);
            notificationManager.createNotificationChannel(channel);
        }
        notificationManager.notify(0,  notificationBuilder.build());
    }

    public void sendNotificationTest() {
        sendNotification("Test1", "Test2");
    }

    private void pushEvent(JSONObject event) {
         events.add(event);
    }


    public String getEvents() {
        String listString = "";
        for (JSONObject data : events)  {
            listString += data.toString() + ";";
        }
        return listString;
    }

    public void eventsClear() {
        events.clear();
    }

    private Boolean isAppRunningForeground(final String packageName) {
        final ActivityManager activityManager = (ActivityManager) getSystemService(Context.ACTIVITY_SERVICE);
        final List<RunningAppProcessInfo> appProcesses = activityManager.getRunningAppProcesses();
        if (appProcesses == null) {
            return false;
        }
        for (RunningAppProcessInfo appProcess : appProcesses) {
            if (appProcess.importance == RunningAppProcessInfo.IMPORTANCE_FOREGROUND && appProcess.processName.equals(packageName)) {
                return true;
            }
        }
        return false;
    }

    private Boolean isAppRunning(final String packageName) {
           final ActivityManager activityManager = (ActivityManager) getSystemService(Context.ACTIVITY_SERVICE);
           final List<RunningTaskInfo> activitys = activityManager.getRunningTasks(Integer.MAX_VALUE);
           for (int i = 0; i < activitys.size(); i++) {
               if (activitys.get(i).topActivity.toString().equalsIgnoreCase("ComponentInfo{" + packageName + "/org.qtproject.qt5.android.bindings.QtActivity}")) {
                   return true;
               }
           }
           return false;
    }

    private AppStatus getAppStatus(final String packageName) {
        final ActivityManager activityManager = (ActivityManager) getSystemService(Context.ACTIVITY_SERVICE);
        final List<RunningAppProcessInfo> appProcesses = activityManager.getRunningAppProcesses();
        if (appProcesses == null) {
            return AppStatus.CLOSED;
        }
        for (RunningAppProcessInfo appProcess : appProcesses) {
            Log.e(TAG + " importance", Integer.toString(appProcess.importance));
            if (appProcess.processName.equals(packageName)) {
                if(appProcess.importance == RunningAppProcessInfo.IMPORTANCE_FOREGROUND) {
                    return AppStatus.FOREGROUND;
                }
                if(appProcess.importance == RunningAppProcessInfo.IMPORTANCE_SERVICE) {
                    return AppStatus.BACKGROUND;
                }
                return AppStatus.CLOSED;
            }
        }
        return AppStatus.CLOSED;
    }

    public native void signalMessage(String data);
    public native void signalNewToken(String token);

}













