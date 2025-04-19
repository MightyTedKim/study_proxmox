#!/bin/bash
# ./terraform_start.sh --env .env
# ./terraform_start.sh --env .env.example

# 실행 중 오류 발생 시 즉시 중단
set -e

# 기본값 설정
ENV_FILE=".env"

# 명령줄 인자 파싱
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --env) ENV_FILE="$2"; shift ;;
        *) echo "알 수 없는 파라미터: $1"; exit 1 ;;
    esac
    shift
done

# .env 파일 로드
if [ -f "$ENV_FILE" ]; then
    echo "✅ $ENV_FILE 파일에서 환경변수를 불러옵니다..."
    export $(cat "$ENV_FILE" | grep -v '^#' | xargs)
    echo "✅ 환경변수 로드 완료"
else
    echo "❌ Error: $ENV_FILE 파일을 찾을 수 없습니다!"
    echo "사용법: $0 --env <환경변수_파일>"
    echo "예시:"
    echo "  $0 --env .env"
    echo "  $0 --env .env.example"
    exit 1
fi

# 필수 환경변수 체크
required_vars=(
    "PROXMOX_USER"
    "PROXMOX_TOKEN_NAME"
    "PROXMOX_TOKEN_SECRET"
    "PROXMOX_NODE1_HOST"
    "PROXMOX_NODE2_HOST"
)

for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ]; then
        echo "❌ Error: $var 환경변수가 설정되지 않았습니다. $ENV_FILE 파일을 확인해주세요."
        exit 1
    fi
done

echo "🚀 Terraform 초기화 시작..."
terraform -chdir=./terraform init

echo "📋 실행 계획 생성 중..."
terraform -chdir=./terraform plan -out=tf-plan

echo "🔨 계획 파일 기반으로 적용 중..."
terraform -chdir=./terraform apply tf-plan

echo "✅ 완료!"



