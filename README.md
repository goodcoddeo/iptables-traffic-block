# 🇰🇷 한국 IP만 허용하는 iptables 기반 해외망 차단 스크립트

마인크래프트 서버나 리눅스 서버를 운영할 때, 해외에서 들어오는 디도스 공격이나 불필요한 접근을 차단하고 싶은 경우가 많습니다.  
이 스크립트는 **한국 IP만 허용**하고, 나머지 해외 IP는 모두 차단하는 간단한 방화벽 도구입니다.

## 🧰 기능

- `iptables` + `ipset` 기반으로 **빠르고 효율적인 차단**
- 한국 IP 대역(CIDR)을 실시간으로 다운로드하여 최신 상태 유지
- 해외망 **차단 / 해제**를 명령어 한 줄로 제어
- `INPUT` 체인 기준 (원하면 포트 기준 변경도 가능)

## ❗ 방화벽
- 위 해외망 차단 스크립트는 `iptables` 방화벽만 사용할 수 있습니다!

## 🔧 설치 방법

### 1. 필요 패키지 설치

```bash
sudo apt update && sudo apt install ipset curl -y
```

### 2. 스크립트 다운로드
```
wget https://raw.githubusercontent.com/goodcoddeo/iptables-traffic-block/refs/heads/main/block-overseas-network.sh
sudo chmod +x firewall_country_block.sh
```

### 3. 해외망 차단 / 해제
- 해외망 차단 (한국만 허용):
```
sudo ./block-overseas-network.sh block
```

- 차단 해제 (전부 허용):
```
sudo ./block-overseas-network.sh unblock
```
