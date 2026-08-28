sudo rm -rf /usr/lib/android-sdk/licenses
rm -rf /home/jan/.android/licenses
sudo mkdir -p /usr/lib/android-sdk/licenses
mkdir -p /home/jan/.android/licenses
echo -e "8933bad161ad4178b1185d1a37fdd41ea6b68355\n24333f1a50b3bfa3d6505567588a1b001d902ffd\nd56f5187479451eabf01fb7431302450f3543564\n8451675a666d3a4048386574747737d6e67cf7c1" | sudo tee /usr/lib/android-sdk/licenses/android-sdk-licenses > /dev/null
echo -e "8933bad161ad4178b1185d1a37fdd41ea6b68355\n24333f1a50b3bfa3d6505567588a1b001d902ffd\nd56f5187479451eabf01fb7431302450f3543564\n8451675a666d3a4048386574747737d6e67cf7c1" | tee /home/jan/.android/licenses/android-sdk-licenses > /dev/null
sudo chmod -R 755 /usr/lib/android-sdk/licenses
sudo chown -R jan:jan /home/jan/.android/licenses
chmod -R 755 /home/jan/.android/licenses

