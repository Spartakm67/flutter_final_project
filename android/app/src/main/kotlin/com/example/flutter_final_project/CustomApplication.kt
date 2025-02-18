//package com.example.flutter_final_project
//
//import android.app.Application
//import androidx.lifecycle.lifecycleScope
//import com.google.android.recaptcha.Recaptcha
//import com.google.android.recaptcha.RecaptchaClient
//import com.google.android.recaptcha.RecaptchaException
//import kotlinx.coroutines.launch
//
//class CustomApplication : Application() {
//
//    private lateinit var recaptchaClient: RecaptchaClient
//
//    override fun onCreate() {
//        super.onCreate()
//        initializeRecaptchaClient()
//    }
//
//    private fun initializeRecaptchaClient() {
//        lifecycleScope.launch {
//            try {
//                recaptchaClient = Recaptcha.fetchClient(applicationContext, "YOUR_KEY_ID")
//            } catch (e: RecaptchaException) {
//                // Обробка помилки
//                e.printStackTrace()
//            }
//        }
//    }
//
//    fun executeRecaptchaAction(action: String, onSuccess: (String) -> Unit, onFailure: (Exception) -> Unit) {
//        lifecycleScope.launch {
//            try {
//                val token = recaptchaClient.execute(action)
//                onSuccess(token)
//            } catch (e: Exception) {
//                onFailure(e)
//            }
//        }
//    }
//}