/**
 * Import function triggers from their respective submodules:
 */
const {onDocumentCreated, onDocumentDeleted} =
  require("firebase-functions/v2/firestore");
const {setGlobalOptions} = require("firebase-functions/v2");
const admin = require("firebase-admin");

admin.initializeApp();
const db = admin.firestore();

// Set global options for all functions
setGlobalOptions({maxInstances: 10});

/**
 * Triggered when a new product is created.
 * Increments the productCount on the corresponding brand document.
 */
exports.onProductCreated = onDocumentCreated(
    "Products/{productId}", (event) => {
      // 1. Get the new product data
      const snapshot = event.data;
      if (!snapshot) {
        console.log("No data associated with the event, exiting.");
        return null;
      }
      const productData = snapshot.data();

      // 2. Get the brandId
      if (!productData.brand || !productData.brand.id) {
        console.log("No brandId found, exiting function.");
        return null;
      }
      const brandId = productData.brand.id;

      // 3. Find the brand in the 'Brands' collection
      const brandRef = db.collection("Brands").doc(brandId);

      // 4. Atomically increment the 'productCount' field by 1
      return brandRef.update({
        productCount: admin.firestore.FieldValue.increment(1),
      });
    });

/**
 * Triggered when a product is deleted.
 * Decrements the productCount on the corresponding brand document.
 */
exports.onProductDeleted = onDocumentDeleted(
    "Products/{productId}", (event) => {
      // 1. Get the deleted product data
      const snapshot = event.data;
      if (!snapshot) {
        console.log("No data associated with the event, exiting.");
        return null;
      }
      const productData = snapshot.data();

      // 2. Get the brandId
      if (!productData.brand || !productData.brand.id) {
        console.log("No brandId found, exiting function.");
        return null;
      }
      const brandId = productData.brand.id;

      // 3. Find the brand
      const brandRef = db.collection("Brands").doc(brandId);

      // 4. Atomically decrement the 'productCount' field by 1
      return brandRef.update({
        productCount: admin.firestore.FieldValue.increment(-1),
      });
    });

