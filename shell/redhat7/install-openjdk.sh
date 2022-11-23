#!/usr/bin/env bash
JAVA_VERSION="11"
BUILD_TOOL="gradle" # or "maven"

sudo yum install wget -y
sudo yum repolist all
sudo yum-config-manager --enable rhel-7-server-optional-rpms

if [ ${JAVA_VERSION} == "11" ]; then
    sudo yum install java-11-openjdk-devel -y
elif [ ${JAVA_VERSION} == "1.8" ]; then
    sudo yum install java-1.8.0-openjdk -y
else
    echo "please check java version"
fi

# Java version check
java -version

# Gradle Install
wget https://services.gradle.org/distributions/gradle-5.0-bin.zip -P /tmp
sudo unzip -d /opt/gradle /tmp/gradle-5.0-bin.zip
ls /opt/gradle/gradle-5.0
sudo touch /etc/profile.d/gradle.sh


export GRADLE_HOME=/opt/gradle/gradle-5.0
export PATH=${GRADLE_HOME}/bin:${PATH}

sudo chmod +x /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh
gradle -v