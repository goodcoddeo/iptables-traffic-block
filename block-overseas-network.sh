#!/bin/bash

SET_NAME=kr_allow
IPTABLES_CHAIN=INPUT

KR_IP_LIST_URL="https://raw.githubusercontent.com/herrbischoff/country-ip-blocks/master/ipv4/kr.cidr"
KR_IP_LIST="/tmp/kr.cidr"

function block_foreign() {
    echo "[*] 해외 IP 차단 중..."
    ipset destroy $SET_NAME 2>/dev/null
    ipset create $SET_NAME hash:net
    curl -s $KR_IP_LIST_URL -o $KR_IP_LIST
    for ip in $(cat $KR_IP_LIST); do
        ipset add $SET_NAME $ip
    done
    iptables -I $IPTABLES_CHAIN -m set ! --match-set $SET_NAME src -j DROP
    echo "[+] 해외망 차단 완료. 한국 IP만 허용됩니다."
}

function unblock_foreign() {
    echo "[*] 해외 IP 차단 해제 중..."
    iptables -D $IPTABLES_CHAIN -m set ! --match-set $SET_NAME src -j DROP 2>/dev/null
    ipset destroy $SET_NAME 2>/dev/null
    echo "[+] 해외망 차단 해제 완료. 전세계 IP 허용됩니다."
}

case "$1" in
    block)
        block_foreign
        ;;
    unblock)
        unblock_foreign
        ;;
    *)
        echo "사용법: $0 {block|unblock}"
        ;;
esac
