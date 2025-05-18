---
applyTo: "**/*.dart"
---
# Image and Asset Handling Guidelines

## Image Standards
- **Max Resolution:** 2048 x 2048 pixels
- **Format:** JPEG
- **Quality:** 85%
- **Max File Size:** 4MB
- **Color Space:** sRGB

## Storage Structure
- **Temporary Files:** `AppStorage/.temp/`
- **Image Cache:** `AppStorage/.cache/`
- **Original Images:** `AppStorage/original/`
- **Processed Images:** `AppStorage/processed/`

## Firebase Storage Structure
- Follow the pattern: `/users/{userId}/images/{imageId}`
- Implement proper access control via security rules.

## Image Loading Best Practices
- Use `cached_network_image` for network images.
- Implement proper loading indicators and error placeholders.
- Consider using thumbnail previews for faster loading.
- Implement lazy loading for image lists.
- Use appropriate image resolution based on device screen density.

## Asset Organization
- Place static assets in the `assets/` directory.
- Organize assets logically (e.g., `assets/images/`, `assets/icons/`, `assets/fonts/`).
- Reference assets using the appropriate resolution for the device.
- Register all assets in `pubspec.yaml`.

## Image Processing
- Consider device capabilities when performing image processing.
- Offload heavy processing to background threads.
- Show progress indicators for long-running operations.
- Implement caching for processed images.
- Handle memory constraints appropriately.
