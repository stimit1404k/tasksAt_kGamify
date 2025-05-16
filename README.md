# Mobile App Development Internship @ kGamify

Hi! I'm **Stimit Keluskar**, currently working as a **Mobile App Development Intern** at **kGamify**. This document keeps track of the tasks, features, and contributions I’ve made during my internship, along with key learnings and technologies used.

---

## 📅 Internship Duration

**Start Date:** Feb 2025  
**End Date:** ongoing...

---

## 🧩 Tasks & Contributions

### ✅ **Task 1: Implementing a Shareable Card Feature for Social Media**

**🗓️ Date:** April 16, 2025

**Objective:**  
Design and implement a card component within a Flutter app that can be shared as an image on social platforms like WhatsApp, Instagram, etc.

**How I Handled It:**

- ✅ Designed a visually appealing `Card` widget using Flutter’s `Container`, `Card`, and `Text` widgets.
- ✅ Wrapped the card inside a `RepaintBoundary` to capture it as an image.
- ✅ Used `RenderRepaintBoundary` and `toImage()` to convert the widget to a `Uint8List`.
- ✅ Saved the image using the `path_provider` package.
- ✅ Shared the image using the `share_plus` package.

**Technologies & Packages Used:**

- `Flutter`
- `path_provider`
- `share_plus`

> 📝 **Note:** Don't forget to run `flutter pub get` after adding these dependencies!

**Outcome:**  
Successfully created a shareable card that works seamlessly across multiple platforms, enhancing the social reach and user engagement of the app.

---

### ✅ **Task 2: Implementing Avatar Customization with DiceBear API**

**🗓️ Date:** May 14, 2025

**Objective:**  
Build an interactive avatar customization feature using the **DiceBear API** in a Flutter application, enabling users to randomly generate avatars or customize them with initials.

**How I Handled It:**

- ✅ Integrated the `dice_bear` package to fetch avatars based on random seeds or user-defined initials.
- ✅ Created a `Dropdown` for users to select different avatar styles.
- ✅ Added a `TextField` for entering initials, which dynamically updates the avatar if "Initials" is selected.
- ✅ Designed a "Randomize Your Avatar" button to fetch new avatars with each click.
- ✅ Implemented smooth UI transitions and state management using `StatefulWidget`.

**Technologies & Packages Used:**

- `Flutter`
- `dice_bear` — for avatar generation
- `Material UI` for styling and layout

> 📝 **Note:** Don't forget to run `flutter pub get` after adding these dependencies!

**Outcome:**  
Delivered a fully interactive avatar customization screen with options for both randomly generated avatars and personalized initials, enhancing the user experience.

---

### ✅ **Task 3: Designing a Leaderboard with Custom Podium and Rank Indicators**

**🗓️ Date:** May 16, 2025

**Objective:**  
Create a visually distinct leaderboard screen in Flutter featuring a podium layout for the top 3 positions, with custom avatars and SVG-based crown icons.

**How I Handled It:**

- ✅ Built a flexible `_buildPodiumPosition` widget supporting both rank text and SVG crown widgets.
- ✅ Used `Stack` and `Positioned` widgets to arrange podium positions with correct layering and alignment.
- ✅ Integrated the `flutter_svg` package to display crown icons above the first-place avatar.
- ✅ Implemented responsive layout using `SizedBox`, `Container`, and `Positioned` to ensure proper spacing and visibility.
- ✅ Displayed ranks 4th to 6th in a scrollable `ListView` with avatar placeholders and score/time info.

**Technologies & Packages Used:**

- `Flutter`
- `flutter_svg` — for scalable vector graphics
- Custom widget composition with `Stack` and `Positioned`

> 📝 **Note:** Don't forget to run `flutter pub get` after adding these dependencies!

**Outcome:**  
Delivered a polished, user-friendly leaderboard interface with clear rank distinction, improving user engagement and visual hierarchy.

---

## 📚 Learnings So Far

- Widget-to-image conversion in Flutter
- Using native sharing features with `share_plus`
- Managing Flutter dependencies and stateful widgets
- Structuring clean, reusable code
- Integrating third-party APIs like **DiceBear** for avatar generation
- Building dynamic UIs with `Dropdown` and `TextField`
- Advanced widget layout techniques using `Stack` and `Positioned`
- Incorporating SVG assets with `flutter_svg` for crisp, scalable icons

---

## 🛠️ Tools & Tech Stack

- Flutter (Dart)
- Visual Studio Code
- DiceBear API
- path_provider
- share_plus
- flutter_svg
- Material UI

---

## 🚀 To Be Updated

I'll keep adding more tasks and achievements as the internship progresses!

---

_Feel free to connect with me on [LinkedIn](https://www.linkedin.com/in/stimitk) or check out my projects on [GitHub](https://github.com/stimit1404k)._
