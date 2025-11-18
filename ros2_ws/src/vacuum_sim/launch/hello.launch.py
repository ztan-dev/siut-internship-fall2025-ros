from launch import LaunchDescription
from launch_ros.actions import Node
from launch.actions import ExecuteProcess

def generate_launch_description():

    world_path = "/ros2_ws/src/sim/worlds/hello.world"

    return LaunchDescription([

        # Start Gazebo Harmonic
        ExecuteProcess(
            cmd=["gz", "sim", world_path, "-v", "4", "--headless-rendering"],
            output="screen"
        ),

        # Spawn TurtleBot4
        Node(
            package="ros_gz_sim",
            executable="create",
            arguments=[
                "-name", "turtlebot4",
                "-x", "0", "-y", "0", "-z", "0.15",
                "-file", "/opt/ros/jazzy/share/turtlebot4_description/urdf/turtlebot4.urdf.xacro"
            ],
            output="screen"
        ),

        # ROS–Gazebo bridge
        Node(
            package="ros_gz_bridge",
            executable="parameter_bridge",
            arguments=[
                "/scan@sensor_msgs/msg/LaserScan@gz.msgs.LaserScan",
                "/odom@nav_msgs/msg/Odometry@gz.msgs.Odometry",
                "/cmd_vel@geometry_msgs/msg/Twist@gz.msgs.Twist"
            ],
            output="screen"
        ),
    ])