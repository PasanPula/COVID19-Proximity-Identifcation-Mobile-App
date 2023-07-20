# Location-based Contact Tracing for COVID-19 Transmission Tracking

This repository contains the source code and documentation for a mobile application that implements a novel contact tracing system using geographic information data from Global Navigation Satellite System (GNSS) smartphone sensors. The system collects and analyzes the location coordinates of users every two minutes and evaluates their distance and duration of exposure to potential sources of infection. The system also notifies users who have been in contact with confirmed cases within the past 14 days and advises them to self-quarantine or get tested. The system is based on the research paper *Location-based Contact Tracing for COVID-19 Transmission Tracking* by [Pasan Pulasithi,
Sandunika Silva
Malki Rathnayake,
Iroshan Aberathne,
Chamara Liyanage,
Shamini Prathapan
](#)

## Features

- Privacy-preserving: The system does not consider any personal information of the users for proximity identification, only anonymized location coordinates and device IDs.
- Accurate: The system uses GNSS technology to provide precise location information, time-stamping, distance measurement, and exposure risk assessment.
- Scalable: The system can handle large-scale data collection and analysis using a centralized server architecture.
- User-friendly: The system provides a simple and intuitive user interface that displays the user’s current location, nearby devices, and exposure notifications.

## Screenshots

Here are some screenshots of the user interface of the mobile application:

1. The Onboarding screen: allows the user to create an account by entering their full name, contact number, and occupation in the university (optional).

![Onboard Screen.](/assets/screenshots/onboard.png)

2. Home Screen & Nearby Devices Screen: Shows the user’s current location on a map, as well as the number of nearby devices within a 10-meter radius.

![Home Screen.](/assets/screenshots/tracing.png)

3. Exposure Notification Screen: Shows a message that informs the user that they have been in contact with a confirmed case of COVID-19 within the past 14 days, as well as the date and time of contact.

![Exposure notification Screen.](/assets/screenshots/alert.png)

## Installation

To install and run the mobile application, follow these steps:

1. Clone this repository to your local machine using `git clone https://github.com/location-based-contact-tracing/location-based-contact-tracing.git`.
2. Install Flutter and Android Studio on your machine.
3. Open the project folder in Android Studio and run `flutter pub get` to install the dependencies.
4. Connect your Android device or emulator to your machine and run `flutter run` to launch the application.

## Usage

To use the mobile application, follow these steps:

1. Register your device by entering your full name, contact number, and occupation in the university (optional).
2. Grant permission for the application to access your location data.
3. Tap on the "Start Tracing" button to begin collecting and sending your location coordinates to the server every two minutes.
4. Check the "Nearby Devices" section to see if there are any devices in close proximity to you within a 10-meter radius.
5. If you test positive for COVID-19, report your status through the app by entering the date of your PCR test report.
6. If you receive an exposure notification from the app, follow the instructions to self-quarantine or get tested.

## License

This project is licensed under the MIT License - see the [LICENSE](/LICENSE) file for details.

## Acknowledgments

This project is based on the research paper *Location-based Contact Tracing for COVID-19 Transmission Tracking* by [Pasan Pulasithi,
Sandunika Silva
Malki Rathnayake,
Iroshan Aberathne,
Chamara Liyanage,
Shamini Prathapan
](#). We thank them for their valuable insights and contributions to this field. We also thank other contributors for their feedback and support.
