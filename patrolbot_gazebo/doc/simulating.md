# simulate an empty world
In order to simulate an empty world, source your ROS environment and catkin workspace, and then launch gazebo.launch.

```console
foo@bar:~$ source /opt/ros/melodic/setup.bash
foo@bar:~$ source /path/to/catkin_ws/devel/setup.bash
foo@bar:~$ roslaunch patrolbot_gazebo gazebo.launch
```