# CRED Assignment — Swipable Vertical Carousel  

### Introduction
Hi Cred Team, My name is Shubham Puhal. I am a final year student pursuing Computer Engineering at J.C Bose University, YMCA, Faridabad.

I am really excited for the flutter intern role at CRED and I believe I am a strong fit for this role because of my background.

Recently, I completed my Summer Internship at Google, where I got to work on large-scale, high-impact projects.

And before that I also have interned at 3 different startups as flutter developer. 
This mix of experience of Google's big scale and multiple flutter startups makes me a very strong fit for this role.


### Problem Statement
Assignment was about 'swipeable vertical carousel' in flutter, which is powered by an API call. Animations were supposed to match the sample video with no frame drops. I also need to write unit tests and integration test for frame rate.


### Architecture
Since, this assignment was suppose to present my skills to work at big scale flutter project and it include fetching data from network, using state management, and animated UI. 

I decided the best fit to present my work would be in CLEAN Architecture.
which is a popular flutter architecture for big-scale projects and is based on principle of sepration of concern.

According to CLEAN Architecture, we divide our project into three layers,
- Data layer which handle all the network calls.
- Domain layer which has all the busineer logic for the app.
- Presentation layer which has all the widgets to display UI.

Goal for following this Architecture is that changes in one layer's functionality doesn't require changes in other layer.

But when I started to work on the project, I realised for this specific project which doesn't has a lot of business logic and multiple pages. Adding Domain layer which was supposed to be handle the business layer was a overhead. And would make the code unnecessarily complex.
So i decided to pivot by modifying the earlier architecture.

The new architecture I decided would be best for this project has again threee layers.
- Data layer :  for network related operations.
- State management layer (Provider was my choice)
- Presentation layer : to display all the widgets and UI.

Here, Data layer deals with everything network related, and Presentation layer holds all the UI widgets. And provider acts as a bridge between both layers.

So the flow goes like this :
Provider request data from the Data layer.
Data layer makes all the network calls store the response in a model and return to provider.
Provider provides all the requested data to presentation layer (widgets).
If Presentation layer need new data it request provider which requests data layer.

Data layer ← → State management layer (Provider)  ← → Presentation layer


### Problems & Progress
Since the main goal was to build the carousel, I designed a single-page app with an AppBar and a “Swipable Vertical Carousel” widget. To showcase its dynamic behavior, I added a toggle button that switches between 2-item and 9-item responses demonstrating that the carousel can handle multiple states seamlessly.

According to the decided architecture, I used this folder structure :
lib/
    core/
    data/
    provider/
    presentation/
    integration test/
    test/

- I kept the code clean, modular, and maintainable by ensuring all controllers and UI interactions are managed through Provider, keeping the Presentation layer focused solely on UI and maintaining a clear separation of concerns.
- I replaced the circular loading indicator with a shimmer effect to enhance the app’s presentation. I also added swipe buttons alongside the toggle response button on the home screen to make the layout feel more complete. Additionally, I paid close attention to UI details like button shadows, click animations, and disabling buttons when scrolling isn’t possible.


### Results & Testing
- The biggest challenge for me was writing widget/UI tests because I haven't wrote frontend tests before. So, I went through Flutter’s documentation to learn widget testing and integration testing for detecting frame drops and ensuring smooth performance.

- I tested the app on four devices with different screen sizes to ensure the UI remained fully responsive across all displays.

- Tested the frame rate using multiple methods:
    - Flutter integration tests to monitor performance programmatically.
    - A custom FPS overlay widget that displays real-time frame rates on top of the app (similar to the  method used by Google’s Flutter team).
    - Enabling the device’s built-in frame rate display from developer settings for direct observation.

The final app maintains consistent 60 FPS, shows zero dropped frames, and delivers buttery-smooth animations that match the provided sample video.






