---
mode: 'agent'
description: 'Generate a new Flutter widget adhering to project standards.'
# tools: ['codebase']
---
Generate a new Flutter widget.

**Widget Name:** ${input:widgetName}
**Widget Type:** (StatelessWidget / StatefulWidget) ${input:widgetType}
**Feature:** (e.g., auth, camera, image_marking, processing, core) ${input:featureName}
**Purpose/Description:** ${input:widgetPurpose}

**Requirements:**
1.  Place the widget in the `lib/features/${input:featureName}/presentation/widgets/` directory if feature-specific, or `lib/core/widgets/` if a shared core widget.
2.  If it's a screen/page, place it in `lib/features/${input:featureName}/presentation/view/`.
3.  Use `const` constructors where possible.
4.  Mark fields as `final` if they are not reassigned after construction.
5.  Add a Dartdoc comment explaining the widget's purpose and parameters.
6.  If the widget requires state, use a `StatefulWidget` and manage state locally or via a BLoC/Cubit if complex.
7.  Follow all relevant guidelines from `../instructions/flutter-dart.instructions.md`.
8.  Import necessary packages and other project files using relative paths or package imports as appropriate.
9.  Ensure the widget is responsive and handles different screen sizes if applicable.
10. If the widget interacts with a BLoC, use `BlocBuilder`, `BlocListener`, or `BlocConsumer` as appropriate.
