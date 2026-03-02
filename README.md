# ReVanced YouTube Auto Builder (GitHub Actions)

This repository automatically:

- Downloads a YouTube APK
- Extracts the real version from the APK
- Downloads latest ReVanced CLI
- Downloads latest ReVanced patches
- Patches the APK
- Generates a versioned output file
- Publishes it as a GitHub Release

---

# How It Works

The workflow:

1. Takes a direct `.apk` download link (non-split APK only)
2. Uses `aapt` to extract the real `versionName`
3. Downloads:
   - ReVanced CLI
   - ReVanced Patches
4. Patches the APK
5. Generates output file like:

```
revanced_youtube_<yt-version>_rv<cli-version>_p<patch-version>.apk
```

Example:

```
revanced_youtube_20.14.43_rv5.0.1_p5.50.2.apk
```

---

# How To Run

## 1️⃣ Fork this repository

Click **Fork** on GitHub.

---

## 2️⃣ Enable GitHub Actions permissions

Go to:

Settings → Actions → General

Under **Workflow permissions**, select:

Read and write permissions

Then click **Save**.

This is required so the workflow can create releases.

---

## 3️⃣ Run the workflow manually

Go to:

Actions → Build ReVanced YouTube → Run workflow

Paste a direct YouTube APK link (must end in `.apk`).

---

# How To Find Compatible YouTube Version

Before downloading APK, you MUST check compatibility.

Visit:

https://revanced.app/patches?pkg=com.google.android.youtube

You will see:

- Supported versions
- Recommended version
- Compatible patch list

Always download a supported version.

If you use an unsupported version, patching may fail.

---

# How To Download YouTube APK (APKMirror)

⚠️ Only use **non-bundle**, **single APK**, **no split APK**.

Steps:

1. Go to APKMirror
2. Search for **YouTube**
3. Select a version that matches the supported version list
4. Choose:
   - Architecture: `arm64-v8a`
   - Variant: `APK`
   - NOT "Bundle"
5. Download the APK file to your computer

Do NOT use the APKMirror webpage URL directly — it may fail in CI.

---

# How To Upload APK To Dropbox (Recommended Method)

If you don’t have a direct `.apk` URL, use Dropbox.

## 1️⃣ Upload APK

Upload the downloaded YouTube APK to Dropbox.

---

## 2️⃣ Create Share Link

- Right-click file
- Click **Share**
- Click **Copy link**

You will get something like:

```
https://www.dropbox.com/s/abcd1234/youtube.apk?dl=0
```
---

## 4️⃣ Use That Link In Workflow

Paste the link into:

Run workflow → youtube_apk_url

GitHub Actions will download it automatically.

---

# Output

After successful build:

- A GitHub Release will be created
- The patched APK will be attached
- Tag will include YouTube version and ReVanced version

---

# Common Errors

## ❌ Patch fails

Reasons:
- Unsupported YouTube version
- Split APK used
- Corrupted download

Fix:
- Recheck supported version
- Ensure you downloaded a single APK file

---

## ❌ Release not created

Reason:
- Workflow permission not set to "Read and write"

Fix:
- Enable write permission in Actions settings

---

# Notes

- This repository does NOT distribute YouTube APK.
- You must supply the APK link yourself.
- You are responsible for complying with YouTube’s terms.

---

If you want advanced features like:

- Automatic APKMirror scraping
- Automatic compatibility validation
- APK signing
- Multi-architecture build
- Cache for faster CI

You can extend the workflow further.