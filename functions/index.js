const functions = require("firebase-functions");
const admin = require("firebase-admin");
const cors = require("cors")({ origin: true });

admin.initializeApp();
const db = admin.database();

// ─────────────────────────────────────────────────
// AUTH MIDDLEWARE (throws, never returns response)
// ─────────────────────────────────────────────────
async function verifyAuth(req) {
  const header = req.headers.authorization;
  if (!header || !header.startsWith("Bearer ")) {
    throw new Error("UNAUTHORIZED");
  }
  return await admin.auth().verifyIdToken(header.split("Bearer ")[1]);
}

function handleError(res, e) {
  console.error("API Error:", e.message, e.stack);
  if (e.message === "UNAUTHORIZED") {
    return res.status(401).json({ error: "Unauthorized", code: "UNAUTHORIZED" });
  }
  return res.status(500).json({ error: "Server error", code: "SERVER_ERROR" });
}

// ─────────────────────────────────────────────────
// GET /getProducts?limit=20&lastKey=
// ─────────────────────────────────────────────────
exports.getProducts = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    try {
      const decoded = await verifyAuth(req);
      const limit = parseInt(req.query.limit) || 20;
      const lastKey = req.query.lastKey || null;

      // Build paginated query (RTDB correct syntax)
      let query = db.ref("farmerProducts").orderByKey().limitToFirst(limit + 1);
      if (lastKey) query = query.startAt(lastKey);

      const snapshot = await query.once("value");
      const data = snapshot.val();

      if (!data) {
        return res.json({ products: [], lastKey: null, hasMore: false });
      }

      let entries = Object.entries(data);

      // Skip duplicate first item when paginating
      if (lastKey && entries.length > 0 && entries[0][0] === lastKey) {
        entries.shift();
      }

      const hasMore = entries.length > limit;
      if (hasMore) entries = entries.slice(0, limit);

      // Transform farmer data → consumer-friendly format
      const products = [];
      for (const [farmerId, farmerProducts] of entries) {
        // Get farmer profile for name/location
        let farmerName = "";
        let farmerLocation = "";
        try {
          const farmerSnap = await db.ref(`userProfiles/${farmerId}`).once("value");
          const farmerData = farmerSnap.val();
          if (farmerData) {
            farmerName = farmerData.name || "";
            farmerLocation = farmerData.location || farmerData.address || "";
          }
        } catch (_) {}

        // If farmerProducts is a map of products
        if (farmerProducts && typeof farmerProducts === "object") {
          for (const [productId, product] of Object.entries(farmerProducts)) {
            if (product && typeof product === "object") {
              products.push({
                id: productId,
                name: product.name || "",
                price: product.price || 0,
                unit: product.unit || "kg",
                category: product.category || "general",
                available: product.available !== false,
                stock: product.stock || 0,
                organic: product.organic || false,
                rating: product.rating || 0,
                imageUrl: product.imageUrl || product.image || "",
                farmerName: farmerName || product.farmerName || "",
                farmerId: farmerId,
                location: farmerLocation || product.location || "",
                description: product.description || "",
              });
            }
          }
        }
      }

      const newLastKey = entries.length > 0 ? entries[entries.length - 1][0] : null;

      return res.json({ products, lastKey: newLastKey, hasMore });
    } catch (e) {
      return handleError(res, e);
    }
  });
});

// ─────────────────────────────────────────────────
// POST /addToCart
// ─────────────────────────────────────────────────
exports.addToCart = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    try {
      const decoded = await verifyAuth(req);
      const uid = decoded.uid;
      const { productId, name, price, unit, farmName, quantity, imageUrl } = req.body;

      if (!productId || !quantity || quantity < 1) {
        return res.status(400).json({ error: "productId and quantity required", code: "BAD_REQUEST" });
      }

      if (!name || price === undefined) {
        return res.status(400).json({ error: "name and price required", code: "BAD_REQUEST" });
      }

      // Check for duplicate → merge quantity
      const cartRef = db.ref(`carts/${uid}/${productId}`);
      const existing = await cartRef.once("value");

      if (existing.exists()) {
        const currentQty = existing.val().quantity || 0;
        await cartRef.update({
          quantity: currentQty + quantity,
          price: price, // update to latest price snapshot
        });
      } else {
        await cartRef.set({
          productId,
          name,
          price,
          unit: unit || "kg",
          farmName: farmName || "",
          quantity,
          imageUrl: imageUrl || "",
          addedAt: admin.database.ServerValue.TIMESTAMP,
        });
      }

      return res.json({ success: true, message: "Added to cart" });
    } catch (e) {
      return handleError(res, e);
    }
  });
});

// ─────────────────────────────────────────────────
// GET /getCart
// ─────────────────────────────────────────────────
exports.getCart = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    try {
      const decoded = await verifyAuth(req);
      const uid = decoded.uid;

      const snapshot = await db.ref(`carts/${uid}`).once("value");
      const data = snapshot.val();

      // Handle empty cart
      if (!data) return res.json([]);

      const items = Object.values(data);
      return res.json(items);
    } catch (e) {
      return handleError(res, e);
    }
  });
});

// ─────────────────────────────────────────────────
// POST /removeFromCart
// ─────────────────────────────────────────────────
exports.removeFromCart = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    try {
      const decoded = await verifyAuth(req);
      const uid = decoded.uid;
      const { productId } = req.body;

      if (!productId) {
        return res.status(400).json({ error: "productId required", code: "BAD_REQUEST" });
      }

      await db.ref(`carts/${uid}/${productId}`).remove();
      return res.json({ success: true, message: "Removed from cart" });
    } catch (e) {
      return handleError(res, e);
    }
  });
});

// ─────────────────────────────────────────────────
// POST /clearCart
// ─────────────────────────────────────────────────
exports.clearCart = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    try {
      const decoded = await verifyAuth(req);
      const uid = decoded.uid;

      await db.ref(`carts/${uid}`).remove();
      return res.json({ success: true, message: "Cart cleared" });
    } catch (e) {
      return handleError(res, e);
    }
  });
});

// ─────────────────────────────────────────────────
// POST /createOrder
// ─────────────────────────────────────────────────
exports.createOrder = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    try {
      const decoded = await verifyAuth(req);
      const uid = decoded.uid;
      const { items, deliveryAddress, paymentMethod } = req.body;

      if (!items || !Array.isArray(items) || items.length === 0) {
        return res.status(400).json({ error: "Order must contain items", code: "BAD_REQUEST" });
      }

      if (!deliveryAddress) {
        return res.status(400).json({ error: "Delivery address required", code: "BAD_REQUEST" });
      }

      // Server-side total calculation (NEVER trust client)
      const subtotal = items.reduce((sum, item) => {
        return sum + (item.price || 0) * (item.quantity || 0);
      }, 0);

      const deliveryFee = 2.50;
      const serviceFee = 1.00;
      const totalAmount = subtotal + deliveryFee + serviceFee;

      // Generate orderId via push().key
      const orderRef = db.ref("orders").push();

      await orderRef.set({
        orderId: orderRef.key,
        userId: uid,
        items: items.map((i) => ({
          productId: i.productId,
          name: i.name,
          price: i.price,
          quantity: i.quantity,
          unit: i.unit || "kg",
          farmName: i.farmName || "",
        })),
        subtotal,
        deliveryFee,
        serviceFee,
        totalAmount,
        deliveryAddress,
        paymentMethod: paymentMethod || "COD",
        status: "PLACED",
        createdAt: admin.database.ServerValue.TIMESTAMP,
      });

      // Auto-clear cart after successful order
      await db.ref(`carts/${uid}`).remove();

      return res.json({
        success: true,
        orderId: orderRef.key,
        totalAmount,
        message: "Order placed successfully",
      });
    } catch (e) {
      return handleError(res, e);
    }
  });
});

// ─────────────────────────────────────────────────
// GET /getOrders
// ─────────────────────────────────────────────────
exports.getOrders = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    try {
      const decoded = await verifyAuth(req);
      const uid = decoded.uid;

      const snapshot = await db
        .ref("orders")
        .orderByChild("userId")
        .equalTo(uid)
        .once("value");

      const data = snapshot.val();
      if (!data) return res.json([]);

      // Sort descending by createdAt (RTDB can't sort descending)
      const orders = Object.values(data).sort(
        (a, b) => (b.createdAt || 0) - (a.createdAt || 0)
      );

      return res.json(orders);
    } catch (e) {
      return handleError(res, e);
    }
  });
});

// ─────────────────────────────────────────────────
// GET /getProfile
// ─────────────────────────────────────────────────
exports.getProfile = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    try {
      const decoded = await verifyAuth(req);
      const uid = decoded.uid;

      const snapshot = await db.ref(`userProfiles/${uid}`).once("value");
      const data = snapshot.val();

      if (!data) {
        return res.json({ exists: false });
      }

      return res.json({ exists: true, profile: data });
    } catch (e) {
      return handleError(res, e);
    }
  });
});

// ─────────────────────────────────────────────────
// POST /createProfile
// ─────────────────────────────────────────────────
exports.createProfile = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    try {
      const decoded = await verifyAuth(req);
      const uid = decoded.uid;
      const { name, phone, email, language } = req.body;

      if (!name || !phone) {
        return res.status(400).json({ error: "name and phone required", code: "BAD_REQUEST" });
      }

      await db.ref(`userProfiles/${uid}`).set({
        name,
        phone,
        email: email || "",
        role: "consumer",
        language: language || "English",
        createdAt: admin.database.ServerValue.TIMESTAMP,
      });

      return res.json({ success: true, message: "Profile created" });
    } catch (e) {
      return handleError(res, e);
    }
  });
});
