#! /bin/bash

build_space="$PWD/catkin_ros_ws/"
install_space=/opt/ros/indigo/
pip_space=$HOME/Library/Python/2.7/lib/python/site-packages/

# setup target directory 
mkdir -pv $install_space
echo "Modifying the ownership of $install_space"
sudo chown -R `id -un` $install_space

# use the python/pip with system
sudo easy_install pip

# setup python package directory
mkdir -pv $pip_space

# setup dependencies
brew tap ros/deps
brew install tinyxml console_bridge boost lz4
pip install --user wstool rosinstall_generator catkin-pkg empy

export PATH=$PATH:$pip_space/../../../bin/

# get source and build to install space
mkdir -pv $build_space
cd $build_space

rosinstall_generator ros_comm --rosdistro indigo --deps --wet-only --tar > indigo-ros_comm-wet.rosinstall
wstool init -j2 src indigo-ros_comm-wet.rosinstall

./src/catkin/bin/catkin_make_isolated --install --install-space=$install_space -DCMAKE_BUILD_TYPE=Release

# setup .bashrc, enable ros, python package bins, and ros libs
cat >> ~/.bashrc << EOF
source $install_space/setup.bash 
PS1="(ros) \$PS1"
export PATH=\$PATH:$pip_space/../../../bin/
export DYLD_LIBRARY_PATH=\$DYLD_LIBRARY_PATH:$install_space/lib/
EOF
