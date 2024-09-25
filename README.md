# Lohos - Flutter Project

A new Flutter project called **Lohos**, designed to manage student information and integrate CSV handling with features like image picking, file management, and more.

## About

**Lohos** is a versatile Flutter project aimed at managing student data using various tools and dependencies. It supports importing and exporting student information through CSV files, allows picking and managing images, and integrates Excel functionality for easy handling of records. The project leverages popular Flutter packages to ensure a smooth and efficient user experience across Android and iOS platforms.

## Features

- **CSV Handling:** Import and export student data via CSV files.
- **Image Picker:** Add student images from the device’s gallery or camera.
- **File Management:** Easily manage files using path provider and file picker packages.
- **Excel Integration:** Generate and read Excel files for record-keeping.
- **Permission Handling:** Ensures that necessary permissions are requested and granted before accessing sensitive resources.
- **Launcher Icon Customization:** Custom app icons for both Android and iOS platforms.

## Things to Fix / Known Issues

### Minor Issues:
- **Permission Handling on iOS:** Some permissions may require additional configuration in iOS-specific settings (Info.plist).
- **Cross-platform Consistency:** There are minor UI inconsistencies between Android and iOS devices.
- **CSV File Import:** Currently, only a specific format for CSV files is supported. Future updates should include more flexible import/export options.
- **Excel File Compatibility:** Certain Excel files may not conform to the expected format, requiring manual adjustments.

### Major Issues:
- **Excel File Export:** The project is designed to save student attendance in an Excel file on the device. For each day, a single Excel file should be created with attendance data for all rooms, with each room having its own sheet in that file. However, currently, the attendance data is being saved in multiple files instead of a single file. This needs to be fixed so that all room attendance data for a day is stored in one file, with separate sheets for each room.
- **Saving to Local Device Storage:** Despite the code being correct, the Excel file is not being stored locally on the device as expected. This issue needs to be addressed.
- **Attendance Option Issues:** Apart from marking students as "Present," other attendance options are not functioning correctly. This is a minor issue and can be fixed easily.

## Dependencies

The project uses the following Flutter dependencies:
- `path_provider`: To access file system directories.
- `csv`: For CSV file operations.
- `image_picker`: For picking images from the device.
- `excel`: For managing Excel files.
- `permission_handler`: For handling permissions.
- `file_picker`: For picking files from the local storage.
- `path`: To work with file paths.
- `intl`: For internationalization support.
- `cupertino_icons`: For iOS style icons.

## Getting Started

1. **Clone the repository:**
   If you haven’t already, clone the repository to your local machine and navigate into it.
   ```bash
   git clone https://github.com/your-repo/lohos.git
   cd lohos
   ```

2. **Create a new Flutter project:**
   Since the repository contains only the `lib` folder and the `pubspec.yaml` file, you’ll need to create a new Flutter project first.
   ```bash
   flutter create lohos
   cd lohos
   ```

3. **Replace the `lib` folder:**
   After creating the project, replace the newly generated `lib` folder with the `lib` folder from the repository.
   ```bash
   rm -rf lib
   cp -r path-to-repo/lib ./lib
   ```

4. **Update the `pubspec.yaml` file:**
   Replace the generated `pubspec.yaml` file with the one from the repository:
   ```bash
   rm pubspec.yaml
   cp path-to-repo/pubspec.yaml ./pubspec.yaml
   ```

5. **Install the dependencies:**
   Run the following command to install all the necessary dependencies as specified in the `pubspec.yaml` file:
   ```bash
   flutter pub get
   ```

6. **Run the app:**
   Once the setup is complete, you can run the app:
   ```bash
   flutter run
   ```

7. **Customize the app icon (optional):**
   You can customize the app icon by adding your desired icon image at `assets/icon/icon.png`. Then, run the following command to generate the new app icon:
   ```bash
   flutter pub run flutter_launcher_icons:main
   ```

## Contact Us

For any inquiries or if you need further assistance, please contact me at:

- **Email**: [sanand03072005@gmail.com](mailto:sanand03072005@gmail.com?subject=Enquiry%20about%20Lohos%20Project&body=Dear%20Anand,%0A%0A%20I%20have%20an%20enquiry%20about%20the%20Lohos%20Project.%20Please%20provide%20the%20necessary%20details.%0A%0A%20Thank%20you.%0A%0A%20Best%20regards,%0A%20[Your%20Name])
- **LinkedIn**: [Anand S](https://www.linkedin.com/in/anands37/)

---

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
