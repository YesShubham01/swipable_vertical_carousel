# Swipable Vertical Carousel  

### Media Links
Screen Recording : https://drive.google.com/file/d/1pCMya7Q6LZm3DBw15hwpT0j1a3DR3LpU/view?usp=sharing


### Problem Statement
Assignment was about 'swipeable vertical carousel' in flutter, which is powered by an API call. Animations were supposed to match the sample video with no frame drops. I also need to write unit tests and integration test for frame rate.

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






