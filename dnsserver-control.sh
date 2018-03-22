#!/bin/bash

project=`cd $(dirname $0);pwd`
working_dir="/etc/dnsserver"
tamplate="$project/tamplate"

Usage() {
    echo "Usage: $0 { install | uninstall | restart | status }"
    exit 1
}

Parameter_judge() {
    correct_num="$1"
    real_num="$2"
    if [ "$correct_num" != "$real_num" ];then
        Usage
    fi
}

Config() {
    wan="$1"
    dns_port="$2"

    sudo mkdir -p $working_dir

    cp $tamplate/dns-port-forward.tamplate dns-port-forward
    sed -i "s/interface/$wan/g" dns-port-forward
    chmod +x dns-port-forward
    sudo mv dns-port-forward $working_dir/

    cp $tamplate/dns.service.tamplate dns.service
    sed -i "s/PORT/$dns_port/g" dns.service
    sudo mv dns.service /etc/systemd/system/
}

Restore() {
    sudo rm -r $working_dir
    sudo rm /etc/systemd/system/dns.service
}

Start() {
    for cmd in "enable" "start" "status"
    do
        sudo systemctl $cmd dns.service
    done
}

Stop() {
    for cmd in "disable" "stop" "status"
    do 
        sudo systemctl $cmd dns.service
    done
}

Status() {
    echo "iptables nat"
    sudo iptables -t nat -S
    echo -e "\niptables filter"
    sudo iptables -t filter -S
}

case "$1" in 
    install)
        Parameter_judge 3 $# 
        Config $2 $3
        Start 
        ;;

    uninstall)
        Parameter_judge 1 $#
        Stop
        Restore
        ;;

    restart)
        Parameter_judge 1 $#
        Stop
        Start
        ;;

    status)
        Parameter_judge 1 $#
        Status
        ;;

    *)
        Usage
        ;;
esac