#!/bin/bash

# 2021 Dawson Della Valle <ddellavalle@45drives.com>

# curl -sSL https://repo.45drives.com/setup -o setup-repo.sh &&
#     sudo bash setup-repo.sh &&
#     rm setup-repo.sh

# curl -sSL https://repo.45drives.com/setup -o setup-repo.sh && sudo bash setup-repo.sh && rm setup-repo.sh

# curl -sSL https://repo.45drives.com/setup | sudo bash

function get_base_distro() {
    local distro=$(cat /etc/os-release | grep '^ID_LIKE=' | head -1 | sed 's/ID_LIKE=//' | sed 's/"//g' | awk '{print $1}')

    if [ -z "$distro" ]; then
	    distro=$(cat /etc/os-release | grep '^ID=' | head -1 | sed 's/ID=//' | sed 's/"//g' | awk '{print $1}')
	fi

    echo $distro
}

function get_distro() {
	local distro=$(cat /etc/os-release | grep '^ID=' | head -1 | sed 's/ID=//' | sed 's/"//g' | awk '{print $1}')
    
    echo $distro
}

function get_version_id() {
	local version_id=$(cat /etc/os-release | grep '^VERSION_ID=' | head -1 | sed 's/VERSION_ID=//' | sed 's/"//g' | awk '{print $1}' | awk 'BEGIN {FS="."} {print $1}')
    
    echo $version_id
}

euid=$(id -u)

if [ $euid -ne 0 ]; then
	echo -e '\nYou must be root to run this utility.\n'
fi

distro=$(get_base_distro)
custom_distro=$(get_distro)
distro_version=$(get_version_id)

if [ "$distro" == "rhel" ] || [ "$distro" == "fedora" ]; then
    echo "Detected RHEL-based distribution. Continuing..."

    items=$(find /etc/yum.repos.d -name '*45d*.repo')

    if [[ "X$items" == "X" ]]; then
        echo "There were no existing 45Drives repos found. Setting up the new repo..."
    else
        count=$(echo "$items" | wc -l)
        echo "There were $count 45Drives repo(s) found. Archiving..."

        mkdir -p /opt/45drives/archives/repos

        mv /etc/yum.repos.d/*45d*.repo /opt/45drives/archives/repos

        echo "The obsolete repos have been archived to '/opt/45drives/archives/repos'. Setting up the new repo..."
    fi

    curl -sSL https://repo.45drives.com/lists/45drives.repo -o /etc/yum.repos.d/45drives.repo

    res=$?

    if [ "$res" -ne "0" ]; then
        echo "Failed to download the new repo file. Please review the above error and try again."
        exit 1
    fi

    el_id="none"

    if [[ "$distro_version" == "7" ]] || [[ "$distro_version" == "8" ]]; then
        el_id=$distro_version
    fi

    if [[ "$custom_distro" == "fedora" ]]; then
        el_id=8
    fi

    if [[ "$el_id" == "none" ]]; then
        echo "Failed to detect the repo that would best suit your system. Please contact repo@45drives.com to get this issue rectified!"
        exit 1
    fi

    sed -i "s/el8/el$el_id/g;s/EL8/EL$el_id/g" /etc/yum.repos.d/45drives.repo

    res=$?

    if [ "$res" -ne "0" ]; then
        echo "Failed to update the new repo file. Please review the above error and try again."
        exit 1
    fi

    echo "The new repo file has been downloaded. Updating your package lists..."

    pm_bin=dnf

    command -v dnf > /dev/null 2>&1 || {
        pm_bin=yum
    }

    echo "Using the '$pm_bin' package manager..."

    $pm_bin clean all -y

    res=$?

    if [ "$res" -ne "0" ]; then
        echo "Failed to run '$pm_bin clean all -y'. Please review the above error and try again."
        exit 1
    fi

    echo "Success! Your repo has been updated to our new server!"
    exit 0
fi

if [ "$distro" == "debian" ]; then
    echo "Detected Debian-based distribution. Continuing..."

    items=$(find /etc/apt/sources.list.d -name '*45d*.list')

    if [[ "X$items" == "X" ]]; then
        echo "There were no existing 45Drives repos found. Setting up the new repo..."
    else
        count=$(echo "$items" | wc -l)
        echo "There were $count 45Drives repo(s) found. Archiving..."

        mkdir -p /opt/45drives/archives/repos

        mv /etc/apt/sources.list.d/*45d*.list /opt/45drives/archives/repos

        echo "The obsolete repos have been archived to '/opt/45drives/archives/repos'. Setting up the new repo..."
    fi

    wget -qO - https://repo.45drives.com/key/gpg.asc | gpg --pinentry-mode loopback --batch --yes --dearmor -o /usr/share/keyrings/45drives-archive-keyring.gpg

    res=$?

    if [ "$res" -ne "0" ]; then
        echo "Failed to add the gpg key to the apt keyring. Please review the above error and try again."
        exit 1
    fi

    curl -sSL https://repo.45drives.com/lists/45drives.sources -o /etc/apt/sources.list.d/45drives.sources

    res=$?

    if [ "$res" -ne "0" ]; then
        echo "Failed to download the new repo file. Please review the above error and try again."
        exit 1
    fi

    lsb_release_cs=$(lsb_release -cs)

    if [[ "$lsb_release_cs" == "" ]]; then
        echo "Failed to fetch the distribution codename. This is likely because the command, 'lsb_release' is not available. Please install the proper package and try again. (apt install -y lsb_core)"
        exit 1
    fi

    sed -i "s/focal/$lsb_release_cs/g" /etc/apt/sources.list.d/45drives.sources

    res=$?

    if [ "$res" -ne "0" ]; then
        echo "Failed to update the new repo file. Please review the above error and try again."
        exit 1
    fi

    echo "The new repo file has been downloaded. Updating your package lists..."

    pm_bin=apt

    $pm_bin update -y

    res=$?

    if [ "$res" -ne "0" ]; then
        echo "Failed to run '$pm_bin update -y'. Please review the above error and try again."
        exit 1
    fi

    echo "Success! Your repo has been updated to our new server!"
    exit 0
fi

echo -e "\nThis command has been run on a distribution that is not supported by the 45Drives Team.\n\nIf you believe this is a mistake, please contact our team at repo@45drives.com!\n"
exit 1