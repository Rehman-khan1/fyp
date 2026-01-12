# Smart Food Analyzer (FYP)

A full-stack project with a FastAPI backend and a Flutter frontend (mobile + web).

## Repository Structure

- `backend_fastapi/` — FastAPI backend (uvicorn)
  - `app/main.py` — FastAPI app and router registration
  - `app/routes/auth_routes.py` — authentication endpoints (`/auth/login`)
  - `requirements.txt` — Python dependencies

- `frontend_flutter/` — Flutter app (mobile, web, desktop)
  - `lib/main.dart` — Flutter app entry and route registration
  - `lib/screens/` — UI screens (`login_screen.dart`, `main_screen.dart`)
  - `lib/services/` — service classes (`auth_service.dart`)
  - `lib/utils/` — configuration helpers (`backend_config.dart`, ...)
  - `pubspec.yaml` — Flutter dependencies

## Overview

The Flutter app authenticates users against the FastAPI backend at `/auth/login`.
The frontend determines which backend URL to use based on platform with an optional override.

Key design choices:
- Platform-aware backend selection for web vs mobile: `lib/utils/backend_config.dart`.
- Runtime override via `--dart-define=API_BASE_URL="http://host:port"`.
- Backend exposes `/auth/login` (see `backend_fastapi/app/routes/auth_routes.py`).

## Prerequisites

- Python 3.8+ and pip (for backend)
- Node not required (Flutter handles web build)
- Flutter SDK installed (for web/mobile/desktop builds)
- A browser (Chrome/Edge) for web testing

## Backend: Run locally (development)

1. Open a terminal and install dependencies (recommended inside a venv):

```bash
cd backend_fastapi
python -m venv .venv
# On Windows
.\.venv\Scripts\activate
# On macOS/Linux
source .venv/bin/activate
pip install -r requirements.txt
```

2. Start the FastAPI server (development, auto-reload):

```bash
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

Notes:
- The backend in `app/main.py` adds CORS middleware with `allow_origins=["*"]` for development. For production, restrict allowed origins.
- The login endpoint is at `http://<host>:8000/auth/login`.

## Frontend: Run locally (Flutter)

1. From the project root:

```bash
cd frontend_flutter
```

2. (Optional) Enable web support (one-time):

```bash
flutter channel stable
flutter upgrade
flutter config --enable-web
```

3. Check available devices (should list `Chrome`, `Edge`, `web-server`, emulators, etc.):

```bash
flutter devices
```

4. Run the app targeting Chrome and point it at the backend (recommended):

```bash
flutter run -d chrome --dart-define=API_BASE_URL="http://localhost:8000"
```

Or run the app with the `web-server` target (serves files without opening a browser):

```bash
flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0 --dart-define=API_BASE_URL="http://<backend-host>:8000"
```

5. Run on Android emulator / device:

```bash
flutter run -d <device-id> --dart-define=API_BASE_URL="http://<backend-ip>:8000"
```

Platform URL notes:
- The app includes platform-aware defaults in `lib/utils/backend_config.dart`:
  - Web: derives backend from `window.location` (same origin) or `hostname:8000` if no port
  - Android emulator: `http://10.0.2.2:8000`
  - iOS simulator: `http://localhost:8000`
  - Desktop: `http://localhost:8000`
- To explicitly override detection, pass `--dart-define=API_BASE_URL="http://host:port"` as shown above.

## Files you may want to inspect / modify

- Frontend
  - `lib/utils/backend_config.dart` — primary place to change runtime URL logic
  - `lib/services/auth_service.dart` — uses `BackendConfig.baseUrl` to send POST to `/auth/login`
  - `lib/screens/login_screen.dart` — login UI and navigation to home screen
  - `lib/screens/main_screen.dart` — newly added polished home UI
  - `lib/main.dart` — app entry and route registration

- Backend
  - `backend_fastapi/app/routes/auth_routes.py` — endpoint logic; currently a simple verify_user check
  - `backend_fastapi/app/services/auth_service.py` — backend-side auth helpers

## Build for production (web)

```bash
flutter build web --dart-define=API_BASE_URL="https://api.example.com"
# Serve `build/web/` using any static file server (nginx, apache, python http.server, etc.)
```

## Troubleshooting

- Backend unreachable from web/browser: ensure the backend is running on the host and port specified; if running locally and accessing from a remote device, use the machine's IP (and open firewall ports if needed).
- Android emulator cannot reach `localhost` — use `10.0.2.2` or pass a dart-define with your machine IP.
- CORS errors: confirm backend CORS settings in `backend_fastapi/app/main.py`. For development `allow_origins=['*']` is permissive; tighten in production.
- If `flutter devices` does not list Chrome, make sure Chrome is installed and found in PATH.

## Recommended commands summary

Backend (development):

```bash
cd backend_fastapi
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

Frontend (web, dev):

```bash
cd frontend_flutter
flutter run -d chrome --dart-define=API_BASE_URL="http://localhost:8000"
```

Frontend (android emulator):

```bash
flutter run -d emulator-5554 --dart-define=API_BASE_URL="http://10.0.2.2:8000"
```

## Next steps / Improvements

- Persist authentication tokens (e.g., secure storage) and use them for authenticated requests.
- Replace `--dart-define` with `.env` using `flutter_dotenv` if you prefer file-based configuration.
- Add tests for backend routes and frontend widget tests.

---

If you want, I can:
- Add a short `CONTRIBUTING.md` and `DEV_SETUP.md` with more environment-specific tips.
- Integrate `flutter_dotenv` and a `.env.example` to simplify local development setup.

Let me know which of those you'd like next.
