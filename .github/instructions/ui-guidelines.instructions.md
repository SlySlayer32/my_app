---
applyTo: "**/*.dart"
---
# UI/UX Guidelines & Theming

## Widget Best Practices
- Organize widgets into small, reusable components.
- Place widgets in the `presentation/` layer of their respective feature, or in `core/widgets/` if shared.
- Use `const` constructors when possible to improve performance.
- Extract repeated UI patterns into reusable widgets.

## Theme Usage
- Consistently use the application's theme for styling.
- Access theme properties via `Theme.of(context)`:
  - Colors: `Theme.of(context).colorScheme.primary`
  - Typography: `Theme.of(context).textTheme.headlineSmall`
  - Spacing: Use theme-defined spacing constants if available
- Avoid hardcoded colors, text styles, or dimensions.

## Responsiveness
- Design UIs to be responsive across different screen sizes and orientations.
- Use `LayoutBuilder`, `MediaQuery`, or responsive frameworks to adapt to screen dimensions.
- Consider using different layouts for different form factors (phone, tablet, desktop).
- Test layouts on various device sizes.

## Accessibility (a11y)
- Provide semantic labels for interactive elements:
  - Use `Semantics` widget where appropriate
  - Add `tooltip` property to `IconButton` and similar widgets
- Ensure sufficient color contrast for text and UI elements.
- Test for keyboard navigation and screen reader compatibility.
- Support system text scaling.

## Performance Considerations
- Minimize widget rebuilds by using `const` constructors and extracting widgets appropriately.
- Use `ListView.builder` instead of `ListView` for long or infinite lists.
- Implement pagination for large data sets.
- Optimize image loading and caching.
- Consider using `RepaintBoundary` for complex animations.

## Flutter Widgets
- Prefer Flutter's built-in widgets when possible.
- Follow Material Design guidelines for Android/cross-platform or Cupertino for iOS-specific interfaces.
- Maintain consistent UI patterns throughout the application.
- Use appropriate widget types for their intended purposes.
