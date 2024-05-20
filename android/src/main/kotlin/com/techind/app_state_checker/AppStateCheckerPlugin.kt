package com.techind.app_state_checker

import android.app.Activity
import android.app.usage.UsageStats
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Context.ACTIVITY_SERVICE
import android.content.Context.USAGE_STATS_SERVICE
import android.os.Build
import android.util.Log
import androidx.annotation.NonNull
import androidx.core.content.ContextCompat.getSystemService
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.ProcessLifecycleOwner
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.*


/** AppStateCheckerPlugin */
class AppStateCheckerPlugin: FlutterPlugin, MethodCallHandler,ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private var activity: Activity? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "app_state_checker")
    context = flutterPluginBinding.applicationContext
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
     // checkAppState(result, call.argument<String>("packageName"))
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    }
    if (call.method == "getAppState") {
      checkAppState(result)
    } else {
      result.notImplemented()
    }
  }
  private fun checkAppState(@NonNull result: Result, packageName:String?){
    Log.d("checkAppState", "CheckBackground : ${ProcessLifecycleOwner.get().lifecycle.currentState}"  )
    Log.d("checkAppState", "CheckBackground : ${ProcessLifecycleOwner.get().lifecycle.currentState == Lifecycle.State.CREATED}"  )
    Log.d("checkAppState", "CheckBackground : ${ProcessLifecycleOwner.get().lifecycle.currentState.isAtLeast(Lifecycle.State.CREATED)}"  )
    Log.d("checkAppState", "CheckForeground : ${ProcessLifecycleOwner.get().lifecycle.currentState.isAtLeast(Lifecycle.State.STARTED)}"  )

    var isAppInForeground = ProcessLifecycleOwner.get().lifecycle.currentState.isAtLeast(Lifecycle.State.STARTED);
    var isAppInBackground = ProcessLifecycleOwner.get().lifecycle.currentState.isAtLeast(Lifecycle.State.CREATED);
    Log.d("checkAppState", "isAppInForeground : $isAppInForeground, isAppInBackground:$isAppInBackground"  )

    var isInBackground : Boolean = ProcessLifecycleOwner.get().lifecycle.currentState == Lifecycle.State.CREATED
    result.success(if(isInBackground) 1 else 0)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
  override fun onDetachedFromActivity() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity;
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity;
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }
}
