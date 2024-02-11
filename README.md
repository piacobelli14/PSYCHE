# PSYCHE
**P**sychiatric **S**ystem for **Y**ielding **C**omprehensive **H**ealth **E**valuations

This is an application built for the data collection and wearable device management, specifically designed for use in a psychiatric hospital. It is currently copatible with the Fitbit Sense, although future versions will aim to integrate various other watches including the Fitbit Versa and several variations of Actigraph. 

Raw 3-axis accelerometer and gyroscope, heart rate, battery life, and body presence are collected with the Fitbit Sense in real time and sent to a [Flask-Vercel backend](https://github.com/piacobelli14/PSYCHE-API). In the app, this data can be exported by simply selecting the available session for an enrolled patient and exporting the raw data as a CSV. 

**Ongoing Challenges:**
- Device Battery Life:
  - Streaming data from the device in real time significantly reduces the battery life.
- Device Configuration:
  - One of the primary challenges of using the Fitbit Sense for this project is the inability to stream from multiple devices without having seperate developer        accounts. Currently an individual Fitbit developer account is required for each device that is concurrently streaming. Additionally, when sideloading the          psyche_fitbit app onto the watch, a unique device ID must be specified within the app/index.js script to differentiate data streams.

**Future Goals:**
- Add in automatic and customizeable data processing and interpretation within the application to allow for easy analytics.
- Stream additional biometric data including motion/orientation data with quaternions while minimizing battery expenditure.
- Automatically derive other meaningful biometrics from the available watch data such as actigraphy data, heart rate variability and other heart rate features,      and activity/fatigue data.

**Installing The Psyche Fitbit App On Watch**
1. Navigate to the 'psyche_fitbit' directory.
2. Connect to the Fitbit CLI using 'npx fitbit' (assuming you have a Fitbit developer account and already have it configured).
3. Specify your 'deviceID' in the 'app/index.js' file.
4. Run 'npm build' and 'npm install' to sideload the app onto your watch or the Fitbit simulator.



![Image](PatientDashboard)


![Image](PatientDashboard)


![Image](PatientDashboard)


![Image](PatientDashboard)
