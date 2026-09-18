#!/usr/bin/env bash
# 배포 전 콘텐츠 안전 검증 — 이 저장소는 데이터 파일에서 빌드된 정적 사이트다.
# 빌드 스크립트가 필드 값을 이스케이프해 만들지만, 발송 직전 마지막 방어선으로
# 위험 패턴이 하나라도 있으면 배포를 막는다. 여기서 걸리면 deploy 잡이 실행되지
# 않아 Pages에 반영되지 않는다.
set -euo pipefail

TARGETS=(board.html index.html items/*.html)
FOUND=0

check_pattern() {
  local label="$1" pattern="$2"
  local hits
  hits=$(grep -lriE "$pattern" "${TARGETS[@]}" 2>/dev/null || true)
  if [ -n "$hits" ]; then
    echo "[FATAL] ${label} 발견:"
    echo "$hits" | sed 's/^/  - /'
    FOUND=1
  fi
}

check_pattern "<script> 태그"                              '<script[[:space:]>]'
check_pattern "인라인 이벤트 핸들러(on*=)"                  '[[:space:]]on[a-zA-Z0-9]+[[:space:]]*='
check_pattern "javascript:/data:/vbscript: 링크"            '(href|src)[[:space:]]*=[[:space:]]*"[[:space:]]*(javascript|data|vbscript):'
check_pattern "<iframe>/<object>/<embed>"                    '<(iframe|object|embed)[[:space:]>]'

if [ "$FOUND" -ne 0 ]; then
  echo ""
  echo "콘텐츠 안전 검증 실패 — 배포를 중단합니다."
  exit 1
fi

echo "콘텐츠 안전 검증 통과 (${#TARGETS[@]}개 파일 스캔, 상세 페이지 $(ls items/*.html 2>/dev/null | wc -l | tr -d ' ')개 포함)."
