#! /bin/bash

PS1="(ros) \e[32m\u#\h@\@\e[0m \e[34m\w\e[0m\n\$"

export ROS_MASTER_URI="http://10.4.74.102:11311"
echo "ROS_MASTER_URI: $ROS_MASTER_URI"

SELF_IP=10.177.56.67
echo "SELF IP: ${SELF_IP}"
export ROS_IP=$SELF_IP

source /opt/ros/indigo/setup.bash
