# WebDigi iOS — ana uygulama + App Clip

Xcode projesi repoda YOK; Codemagic build sırasında XcodeGen ile `project.yml`'den üretir.
Mac gerekmez.

## GitHub'a koyma (Windows, Git yüklüyse)
    cd webdigi-ios
    git init
    git add .
    git commit -m "ilk sürüm"
    git branch -M main
    git remote add origin https://github.com/<kullanici>/webdigi-ios.git
    git push -u origin main

Git yoksa: GitHub'da yeni depo aç → "uploading an existing file" → klasörü sürükle-bırak.

## Codemagic'te
1. Sihirbaz → GitHub → depo seç → codemagic.yaml → Finish
2. Teams → Personal Account → Integrations → Developer Portal → Add key
   Ad: WebDigi ASC Key (yaml ile aynı), Issuer ID, Key ID, .p8
3. Uygulama → Environment variables → DEVELOPMENT_TEAM = <Apple Team ID> (Secure)
   ve APP_STORE_APPLE_ID = <App Store Connect'teki Apple ID numarası>
4. Start new build

## Apple'da (build'den önce)
- developer.apple.com → Identifiers: com.webdigistore.kur (Associated Domains açık)
  ve com.webdigistore.kur.Clip (App Clip, ebeveyn: ilki)
- appstoreconnect.apple.com → New App: WebDigi, bundle com.webdigistore.kur
- webdigistore.com/.well-known/apple-app-site-association içindeki TEAMID'yi doldur
