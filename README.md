# file_to_md

Docling으로 PDF와 지원 문서를 Markdown으로 변환합니다.

## 실행 방법

Windows에 Python 3.14 (64-bit)를 설치한 뒤 프로젝트를 다운로드하세요. Python의 `py` 또는 `python` 명령을 사용할 수 있어야 합니다.

PowerShell에서 프로젝트 폴더로 이동하고 실행합니다.

```powershell
.\run.ps1 "C:\Documents\example.pdf"
.\run.ps1 "C:\Documents\example.docx"
```

첫 실행 시 `.venv`를 만들고 `requirements.txt`의 라이브러리를 자동 설치합니다. 별도로 가상환경을 활성화할 필요는 없습니다. 이후 실행은 기존 환경을 재사용합니다.

처음에는 라이브러리와 Docling 모델 다운로드를 위해 인터넷 연결 및 충분한 저장 공간이 필요합니다. 모델은 `.cache`에 보관됩니다. 현재 확인한 모델 캐시는 약 1.5GB이며 라이브러리 설치 공간은 별도입니다.

PowerShell 실행 정책 때문에 스크립트가 차단되면 신뢰하는 프로젝트 코드인지 확인한 뒤 현재 터미널에서만 허용하세요.

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
.\run.ps1 "C:\Documents\example.pdf"
```

다운로드된 파일의 인터넷 차단 표시가 원인이라면 확인한 스크립트에 한해 `Unblock-File .\run.ps1`을 실행하세요.

## 결과

`result/example.md`에 UTF-8로 저장합니다. 같은 이름이 있으면 `example1.md`, `example2.md` 순서로 첫 빈 이름을 사용하며 기존 파일은 보존합니다.

PDF와 DOCX 변환은 검증했습니다. Docling이 지원하지 않는 형식은 변환할 수 없으며, PDF의 줄 경계에서 단어가 분리되는 문제는 남을 수 있습니다.
