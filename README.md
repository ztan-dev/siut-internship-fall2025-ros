# Usage

1. Clone this repository: 

    ```
    git clone https://github.com/ztan-dev/siut-internship-fall2025-ros.git
    ```

1. Navigate to the `siut-internship-fall2025-ros` directory

1. Build the image: 

    ```
    docker build -t image-ros2_gazebo_novnc .
    ```

1. Create and run a container from the image: 

    ```
    docker run -d --rm \
        -p 6080:6080 \
        -v ./workspace:/home/ubuntu/workspace \
        --name container-ros2_gazebo_novnc \
        image-ros2_gazebo_novnc
    ```

1. Navigate to this URL in your browser (the container may take a few seconds to fully start):

    ```
    http://localhost:6080/vnc.html
    ```
    The password is "honor-freethinking-humanism"

1. Open a terminal window and verify ROS 2 installation by running this command (output should show ROS variables):

    ```
    printenv | grep ROS
    ```

1. Verify that the `workspace` directory was correctly mounted (see directions in `workspace/hello.txt`)
