# PetroleumPredictor

PetroleumPredictor is an iOS-based application that uses image recognition software to estimate the volume of an oil spill based on sheen detection and color recognition. The app currently identifies and calculates the volume of oil spills with the following sheen types:

- Dark brown/crude sheen
- Rainbow sheen
- Metallic sheen
- Silver sheen

## Features

- **Image-based Detection**: Upload an image of the oil spill, and the app will detect the sheen type.
- **Volume Estimation**: Enter the dimensions (height and width in meters) of the spill, and the app will calculate the estimated volume in cubic meters.
- **Sheen Types Supported**: Dark brown/crude, rainbow, metallic, and silver sheens.

## How It Works

1. **Upload an Image**: The user uploads an image of the oil spill from their library.
2. **Enter Dimensions**: The user is prompted to enter the height and width of the spill in meters.
3. **Calculate**: Upon pressing the "Calculate" button, PetroleumPredictor will output an estimated volume of the oil spill in cubic meters.

## Usage

The app is designed to be used for estimating oil spill volumes for any spill that contains oils with the sheens mentioned above. It’s an effective tool for environmental agencies, researchers, or anyone working in oil spill management.

To use the app:

1. **Step 1**: Upload an image from your library that shows the oil spill.
2. **Step 2**: Enter the height and width of the spill in meters.
3. **Step 3**: Press the calculate button to estimate the oil spill volume.

## File Structure

```bash
.github/workflows/
    └── Create swift.yml               # GitHub actions configuration for Swift builds
AppDelegate.swift                      # App's delegate class
Contents.json                          # Metadata for app icons
Icon-App-*.png                         # App icons in various sizes
Info.plist                             # iOS app information property list
LaunchScreen.storyboard                # Launch screen storyboard
Main.storyboard                        # Main app storyboard
OSTest.xcodeproj.zip                   # Xcode project zip file
README.md                              # Project readme file
SceneDelegate.swift                    # Scene delegate class for managing app's scenes
ViewController.swift                   # Main view controller logic
exxonvaldezmetallic.jpg                # Test image for metallic sheen detection
exxonvaldezsilver.jpg                  # Test image for silver sheen detection
mauritiuscrudeoil.jpg                  # Test image for crude sheen detection
tayloroilrainbow.jpg                   # Test image for rainbow sheen detection
LICENSE                                # License file for the project
```

## Installation

To install and run the app on your local machine, follow these steps:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/PetroleumPredictor.git
   cd PetroleumPredictor
2. Build the app in Xcode by selecting your target device or simulator and clicking the "Run" button or using the shortcut Cmd + R.

3. Test the app on a simulator or a connected iOS device.

## Contributing

Contributions are welcome! If you find any bugs or have ideas for improvements, feel free to:

1. Fork the repository
2. Create a new branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -m 'Add new feature'`)
4. Push to the branch (`git push origin feature-branch`)
5. Open a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
