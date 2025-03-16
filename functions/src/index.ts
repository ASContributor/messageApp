/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// import {onRequest} from "firebase-functions/v2/https";
// import * as logger from "firebase-functions/logger";
import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

const db = admin.firestore();

export const onNewPost = functions.firestore
  .document('posts/{postId}')
  .onCreate(async (snapshot, context) => {
    const newValue = snapshot.data();
    console.log('New post added:', newValue);

    // Define the notification content
    const payload = {
      notification: {
        title: 'New Post Added',
        body: `New post by ${newValue.username}: ${newValue.message}`,
      },
    };

    // Get the list of device tokens
    const tokensSnapshot = await db.collection('deviceTokens').get();
    const tokens = tokensSnapshot.docs.map(doc => doc.id);

    if (tokens.length > 0) {
      // Send notifications to all tokens
      const response = await admin.messaging().sendToDevice(tokens, payload);
      console.log('Notifications sent:', response);
    } else {
      console.log('No device tokens found');
    }

    return null;
  });


