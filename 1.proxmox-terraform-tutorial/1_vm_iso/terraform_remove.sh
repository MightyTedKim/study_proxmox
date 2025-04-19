#!/bin/bash

# 오류 발생 시 중단
set -e

# Load environment variables from .env file
if [ -f .env ]; then
    echo "Loading environment variables from .env file..."
    export $(cat .env | grep -v '^#' | xargs)
else
    echo "Error: .env file not found!"
    exit 1
fi

# terraform 경로
TERRAFORM_DIR="./terraform"

echo "✅ Terraform destroy 시작..."

# Terraform destroy (디렉토리 이동 없이)
terraform -chdir="$TERRAFORM_DIR" init
terraform -chdir="$TERRAFORM_DIR" destroy -auto-approve

echo "🧹 상태 파일 및 캐시 파일 정리 중..."

# 불필요한 파일 삭제
sudo rm -rf \
  "$TERRAFORM_DIR/.terraform" \
  "$TERRAFORM_DIR/.terraform.lock.hcl" \
  "$TERRAFORM_DIR/terraform.tfstate" \
  "$TERRAFORM_DIR/terraform.tfstate.backup" \
  "$TERRAFORM_DIR/tf-plan"

echo "✅ VM 삭제 및 상태 파일 정리 완료!"
