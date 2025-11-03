# Usage

1. Clone this repository: 
    ```git clone https://github.com/ztan-dev/siut-internship-fall2025-ros.git```
1. Navigate to the `siut-internship-fall2025-ros` directory
1. Build the image: 
    ```docker build -t novnc-gui .```
1. Create and run a container from the image: 
    ```docker run -d -p 6080:6080 --name gui-container novnc-gui```
