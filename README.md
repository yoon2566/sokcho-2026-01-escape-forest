# escape forest

속초고 게임 수정 수업용 프로토타입입니다. 학생 번호 01의 게임입니다.

## 실행

저장소를 받은 뒤 `index.html`을 Chrome 또는 Edge로 엽니다. HTML에 모델과 실행 라이브러리가 포함되어 있어 별도 서버 없이 실행하도록 제작했습니다.

```powershell
git clone https://github.com/yoon2566/sokcho-2026-01-escape-forest.git
cd sokcho-2026-01-escape-forest
opencode
```

Git과 OpenCode는 미리 설치하고 OpenCode의 AI 모델 연결을 준비합니다.

## 수정

- `game.js`: 게임 규칙, 대사, 조작 코드
- `source.template.html`: 화면과 스타일
- `assets/`: 이 게임의 GLB 모델 17개
- `assets.json`: 모델 이름과 저장소 내 파일 경로
- `vendor/`: 실행 라이브러리와 Three.js 라이선스
- `index.html`: 최종 실행 파일

원본 코드나 모델을 수정한 뒤 프로젝트 폴더에서 다음 명령으로 실행 파일을 다시 만듭니다. PowerShell만 사용하며 Python 설치는 필요하지 않습니다.

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\build.ps1
```

OpenCode 요청 예시:

```text
game.js와 source.template.html을 읽고 이 게임의 구조를 설명해 줘.
내가 요청한 기능 하나를 수정한 뒤 build.ps1로 index.html을 다시 만들어 줘.
vendor의 라이브러리는 그대로 두고, 내가 직접 플레이하며 확인할 방법을 알려 줘.
```

## 조작

WASD/방향키 이동, Shift 달리기, E 조사, 마우스 선택, Space 공격, Esc 일시정지. 전투 중 하트는 방향키/WASD로 움직입니다.

두 숲과 네 만남을 담은 짧은 시제품입니다. 기존 HTML 프로토타입을 수업용으로 옮겼으며, 최신 훈위안 리깅 통합본은 아닙니다. 제출 주소는 수업 노션에서 안내합니다.

Three.js의 라이선스는 `vendor/THREE_LICENSE.txt`에 있습니다.



2026-10-10 업데이트: 학생 제출본의 최신 소스와 실행 파일을 반영했습니다.

[학생 게임 모음에서 실행](https://sokcho-game-prototypes-20261003.yoon2566.workers.dev/game-01.html)
