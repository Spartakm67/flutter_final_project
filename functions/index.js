const {logger} = require("firebase-functions");
const {onRequest} = require("firebase-functions/v2/https");
const {onDocumentCreated} = require("firebase-functions/v2/firestore");
const { defineSecret } = require('firebase-functions/params');
const {initializeApp} = require("firebase-admin/app");
const {getFirestore} = require("firebase-admin/firestore");

initializeApp();

exports.getFirebaseConfig = onRequest((req, res) => {
  try {
    const config = {
      webApiKey: process.env.WEB_API_KEY || 'default_value',
      androidApiKey: process.env.ANDROID_API_KEY || 'default_value',
      iosApiKey: process.env.IOS_API_KEY || 'default_value',
      appId: {
        web: process.env.WEB_APP_ID || 'default_value',
        android: process.env.ANDROID_APP_ID || 'default_value',
        ios: process.env.IOS_APP_ID || 'default_value',
      },
      messagingSenderId: process.env.MESSAGING_SENDER_ID || 'default_value',
      authDomain: process.env.AUTH_DOMAIN || 'default_value',
      storageBucket: process.env.STORAGE_BUCKET || 'default_value',
      measurementId: process.env.MEASUREMENT_ID || 'default_value',
      projectId: process.env.PROJECT_ID || 'default_value',
      poster: {
        apiGetCategories: process.env.API_GET_CATEGORIES || 'default_value',
        baseUrl: process.env.BASE_URL || 'default_value',
        token: process.env.TOKEN || 'default_value',
      },
      recaptcha: {
        key: process.env.RECAPTCHA_KEY || 'default_value',
      },
    };

    console.log('Loaded config:', config);
    res.status(200).json(config);
  } catch (error) {
    console.error('Failed to load Firebase config:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

