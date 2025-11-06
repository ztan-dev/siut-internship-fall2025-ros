# Usage

1. Clone this repository: 
    ```git clone https://github.com/ztan-dev/siut-internship-fall2025-ros.git```
1. Navigate to the `siut-internship-fall2025-ros` directory
1. Build the image: 
    ```docker build -t novnc-gui .```
1. Create and run a container from the image: 
    ```docker run -d -p 6080:6080 --name gui-container novnc-gui```
1. Navigate to this URL in your browser:
    ```http://localhost:6080/vnc.html```
1. Open a terminal window and verify ROS 2 installation by running this command (output should NOT be empty):
    ```printenv | grep ROS```
