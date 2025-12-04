#!/bin/bash

echo "🚀 Deploying Cash Flow App to Firebase..."
echo ""

echo "📦 Building Flutter web app..."
flutter build web --release

if [ $? -ne 0 ]; then
    echo "❌ Build failed! Please check errors above."
    exit 1
fi

echo ""
echo "✅ Build successful!"
echo ""
echo "📤 Deploying to Firebase Hosting..."
firebase deploy --only hosting

if [ $? -eq 0 ]; then
    echo ""
    echo "🎉 Deployment successful!"
    echo ""
    echo "Your app is live at:"
    echo "  https://cashflow-app-123.web.app"
    echo "  https://cashflow-app-123.firebaseapp.com"
    echo ""
    echo "Changes will be visible in Telegram in a few seconds!"
else
    echo ""
    echo "❌ Deployment failed. Please check errors above."
fi

