# Dimipay App (2.0)

디미페이 2.0 모바일 앱

## Flutter & GetX

Flutter로 화면을 구성하고 GetX로 상태, 의존성 및 라우팅을 관리합니다. 공통 색상과 타이포그래피는 `dimipay_design_kit`을 사용합니다.

| Directory | Description |
| --- | --- |
| `lib/app/pages/` | 화면과 컨트롤러, 바인딩을 관리합니다. |
| `lib/app/services/` | 기능별 서비스와 데이터 접근 로직을 관리합니다. |
| `lib/app/provider/` | API 통신을 처리합니다. |
| `lib/app/routes/` | 페이지와 라우트를 정의합니다. |
| `lib/app/core/` | 초기화, 테마 및 공통 유틸리티를 관리합니다. |
| `lib/app/widgets/` | 공통 위젯을 관리합니다. |

## Setup

Flutter 버전은 `.fvmrc`와 `pubspec.yaml`에 지정된 `3.35.6`을 사용합니다.

실행 전 프로젝트에 맞는 Firebase 설정(`lib/firebase_options.dart` 및 플랫폼별 설정)을 준비합니다. API 주소 설정은 `lib/app/services/api_url/manager.dart`와 `env/.env`의 `API_URI`를 참고합니다.

> [!NOTE]
> 환경 설정값은 프로젝트 담당자에게 확인합니다. 실제 인증 정보와 비밀값은 저장소에 커밋하지 않습니다.

```sh
flutter pub get
flutter run
```

## Test

`test/localpay/local_pay_test.dart`에서 로컬 결제 로직을 테스트합니다. 개별 테스트는 `flutter test test/localpay/local_pay_test.dart`로 실행합니다.

`test/widget_test.dart`에는 기본 위젯 테스트가 있습니다.

## Scripts

### Start

| Script | Description |
| --- | --- |
| `flutter pub get` | 의존성을 설치합니다. |
| `flutter run` | 연결된 기기에서 애플리케이션을 실행합니다. |

### Lint

| Script | Description |
| --- | --- |
| `flutter analyze` | Dart 코드를 정적 분석합니다. |
| `dart format .` | Dart 코드 형식을 정리합니다. |

### Code generation

| Script | Description |
| --- | --- |
| `dart run build_runner build --delete-conflicting-outputs` | 모델의 생성 코드를 갱신합니다. |

### Test

| Script | Description |
| --- | --- |
| `flutter test` | 전체 테스트를 실행합니다. |
