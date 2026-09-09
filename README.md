# AI 보안 컴플라이언스 모니터링 보드

NIST · MITRE · OWASP · ISO/IEC 등 AI 보안·프라이버시 규격/프레임워크 40여 종을
발행 주체별 8개 모듈로 나눠 매일 재확인하는 보드. 각 기준마다 **요약 · 전문 링크 ·
변동 이력(누적)** 을 담는다.

- **웹**: https://elishajey.github.io/ai-compliance-board/
- 이 저장소의 `index.html` 은 자동 생성물이다. 소스는 비공개 저장소
  `elishajey/Test` 의 `분석/컴플라이언스_데이터.json`, 빌드는 `분석/_build_compliance.py`,
  매일 오전 10:00 KST 클라우드 루틴이 갱신·푸시한다.
- 변동 이력의 감사 추적은 그 JSON 의 git 커밋 로그.
- `board.html` = 이메일·아티팩트용 보드-only 버전.

법령·구속력 있는 규제는 이 보드 범위 밖이며 별도로 추적한다.
