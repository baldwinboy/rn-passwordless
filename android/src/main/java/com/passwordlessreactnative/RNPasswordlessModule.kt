package com.passwordlessreactnative

import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.lifecycleScope
import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.module.annotations.ReactModule
import dev.passwordless.android.PasswordlessClient
import dev.passwordless.android.rest.PasswordlessOptions
import dev.passwordless.android.utils.PasswordlessUtils.Companion.getPasskeyFailureMessage
import kotlinx.coroutines.CoroutineScope

@ReactModule(name = RNPasswordlessModule.NAME)
class RNPasswordlessModule(reactContext: ReactApplicationContext) :
  NativeRNPasswordlessSpec(reactContext) {

  private var client: PasswordlessClient? = null

  override fun getName(): String {
    return NAME
  }

  @ReactMethod
  override fun configure(options: ReadableMap) {
    val apiKey = options.getString("apiKey") ?: ""
    val rpId = options.getString("rpId") ?: ""
    val apiUrl = options.getString("apiUrl") ?: "https://v4.passwordless.dev"
    val opts = PasswordlessOptions(apiKey, rpId, apiUrl)
    val activity = (reactApplicationContext.currentActivity ?: return) as AppCompatActivity?
    val scope: CoroutineScope = activity?.lifecycleScope ?: return
    client = PasswordlessClient(opts, reactApplicationContext, scope)
  }

  @ReactMethod
  override fun register(token: String, nickname: String?, promise: Promise) {
    val passwordlessClient = client ?: run {
      promise.reject("not_configured", "PasswordlessClient not configured")
      return
    }
    val mNickname = nickname ?: ""
    passwordlessClient.register(token, mNickname) { success, exception, result ->
      if (success) {
        promise.resolve(Arguments.createMap().apply {
          putBoolean("success", true)
          putString("result",  result?.toString())
        })
      } else {
        promise.resolve(Arguments.createMap().apply {
          putBoolean("success", false)
          putString("error", getPasskeyFailureMessage(exception as Exception))
        })
      }
    }
  }

  @ReactMethod
  override fun signIn(alias: String?, promise: Promise) {
    val passwordlessClient = client ?: run {
      promise.reject("not_configured", "PasswordlessClient not configured")
      return
    }
    val mAlias = alias ?: ""
    passwordlessClient.login(mAlias) { success, exception, result ->
      if (success) {
        promise.resolve(Arguments.createMap().apply {
          putBoolean("success", true)
          putString("result", result?.toString())
        })
      } else {
        promise.resolve(Arguments.createMap().apply {
          putBoolean("success", false)
          putString("error", getPasskeyFailureMessage(exception as Exception))
        })
      }
    }
  }

  companion object {
    const val NAME = "RNPasswordless"
  }
}
