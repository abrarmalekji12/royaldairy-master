package com.undecided.flutter_app;

import android.media.AudioManager;
import android.widget.Toast;

import androidx.annotation.NonNull;

import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
    MethodChannel channel=new MethodChannel(flutterEngine.getDartExecutor(),"flutter://channel");
    channel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if(methodCall.method.equals("setToastShort"))
        {
          Toast.makeText(MainActivity.this, methodCall.arguments.toString(), Toast.LENGTH_SHORT).show();
        }
        else if(methodCall.method.equals("setToastLong"))
          Toast.makeText(MainActivity.this, methodCall.arguments.toString(), Toast.LENGTH_LONG).show();
      }
    });
  }
}
