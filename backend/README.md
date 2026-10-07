# Gesprächszusammenfassung

`POST /api/users/klientenakten/:klientenAkteId/summary` verwendet die bestehende Anmeldung per Session-Cookie und prüft die Aktenzugehörigkeit. Die Antwort ist ein Vorschlag zur menschlichen Prüfung; sie wird nicht in der Patientenakte gespeichert.

## Provider

`LLM_PROVIDER=mock` ist der Standard. Der Mock meldet nur die Anzahl der Gespräche und führt keine medizinische Auswertung durch. `LLM_PROVIDER=ollama` aktiviert den lokalen Ollama-Provider. Dafür sind `OLLAMA_BASE_URL` (Basis-URL der vom **Backend** erreichbaren Ollama-API) und `OLLAMA_MODEL` erforderlich. `OLLAMA_TIMEOUT_MS` ist optional und beträgt standardmäßig 120000 Millisekunden. Der Testmodellname `ministral-3:3b` gehört in die Umgebungskonfiguration, nicht in den Anwendungscode.

`LLM_PROVIDER=mistral` verwendet die Mistral-Cloud-API über HTTPS. Dafür sind `MISTRAL_API_KEY` und `MISTRAL_MODEL` erforderlich; `MISTRAL_TIMEOUT_MS` ist optional und beträgt standardmäßig 120000 Millisekunden. Für den Vergleich mit dem lokalen Modell lautet die Modell-ID `ministral-3b-2512`. Prompt, JSON-Schema, Aktenprüfung und Summary-Endpunkt sind bei beiden Providern gleich. Ein SSH-Tunnel ist für den Cloud-Provider nicht nötig.

Für ein lokal gestartetes Backend die folgenden Werte in `backend/.env` eintragen und das Backend neu starten; eine vorhandene `DATABASE_URL` beibehalten:

```dotenv
LLM_PROVIDER=mistral
MISTRAL_MODEL=ministral-3b-2512
MISTRAL_API_KEY=DEIN_API_SCHLUESSEL
MISTRAL_TIMEOUT_MS=120000
```

Den API-Schlüssel in [Mistral Studio](https://docs.mistral.ai/getting-started/quickstarts/studio/activate-and-generate-api-key) erzeugen und ausschließlich in der lokalen Umgebung oder einem Secret-Manager speichern, nicht in Git oder im Flutter-Code. `backend/.env` ist von Git ausgeschlossen. Bereits in PowerShell gesetzte `$env:`-Werte haben Vorrang vor der Datei; für einen Providerwechsel gegebenenfalls ein neues Terminal verwenden. Der Cloud-Provider sendet ausschließlich die für die Zusammenfassung ausgewählten Gesprächsfelder. Für die aktuellen Tests werden nur synthetische Akten verwendet.

Docker Compose liest seine Variablen aus einer `.env` neben `docker-compose.yml` im Projektordner und reicht die Ollama- und Mistral-Werte an den Backend-Container weiter. `backend/.env` wird durch `.dockerignore` nicht ins Docker-Image kopiert. Eine Adresse wie `localhost` bezeichnet **innerhalb des Containers den Container selbst**. Verwende sie dort nur, wenn Ollama auch im selben Container läuft. Für einen ersten echten Test über einen SSH-Tunnel ist ein lokal gestartetes Backend einfacher.

Beispiel für einen Tunnel auf dem Backend-Rechner (SSH-Zugang und Servernamen selbst einsetzen):

```powershell
ssh -N -L 127.0.0.1:11435:127.0.0.1:11434 BENUTZER@KI-SERVER
```

Solange dieses Terminal geöffnet ist, kann ein **lokal gestartetes** Backend `OLLAMA_BASE_URL=http://127.0.0.1:11435` verwenden. Die Erreichbarkeit lässt sich mit `Invoke-RestMethod http://127.0.0.1:11435/api/tags` prüfen. Wenn das Backend in Docker bleibt, muss stattdessen ein vom Container erreichbarer, privat abgesicherter Netzwerkpfad eingerichtet werden. Ollama nicht öffentlich freigeben.

Für den lokalen Smoke-Test mit der bestehenden PostgreSQL-Datenbank in Docker in einem zweiten PowerShell-Terminal **im Projektverzeichnis**:

```powershell
docker compose stop backend
docker compose up -d postgres
cd backend
$env:LLM_PROVIDER = 'ollama'
$env:OLLAMA_BASE_URL = 'http://127.0.0.1:11435'
$env:OLLAMA_MODEL = 'ministral-3:3b'
npm start
```

Das Backend liest dabei `DATABASE_URL` aus `backend/.env`; diese URL muss auf die lokale PostgreSQL-Instanz zeigen. Die bisherige synthetische Akte kann anschließend über denselben Summary-Endpunkt getestet werden. Nach dem Backend-Neustart ist eine neue Anmeldung nötig, da Sessions im Arbeitsspeicher liegen. Nach dem Test den lokalen Backend-Prozess beenden und bei Bedarf `docker compose up -d backend` aus dem Projektordner ausführen.

Für Entwicklung und den ersten Ollama-Test ausschließlich synthetische Akten verwenden. Vor der Verarbeitung echter Patientendaten auf dem gemeinsam genutzten KI-Server müssen Zugriffsweg und organisatorische Datenschutzfreigabe geklärt sein. Prompts und Antworten werden nicht protokolliert.

## Ausgabe und Fehler

Die Antwort enthält `summary.summary` und `summary.development` als Texte sowie `summary.currentGoals` und `summary.openPoints` als Textlisten. `metadata` nennt Provider, Anzahl der Quellgespräche und Latenz; bei Ollama und Mistral zusätzlich Modell und Prompt-Version `summary-v2`. `reviewRequired` ist immer `true`. Der Prompt fordert die Trennung von Zielen und erreichten Ergebnissen, neutrale Personenbezeichnungen bei fehlender Geschlechtsangabe und ausschließlich ausdrücklich dokumentierte offene Punkte. Die Formatprüfung kann die fachliche Richtigkeit einer Modellantwort nicht garantieren.

Eine Akte ohne Gespräche ergibt `422`. Ungültige Provider-Antworten ergeben `502`; nicht erreichbare Server, fehlende Modelle, ungültige API-Schlüssel und Zeitüberschreitungen ergeben `503`. Fehlerantworten enthalten keine Dokumentation, API-Schlüssel oder Provider-Fehlerdetails.

## Tests

Die isolierten Tests verwenden erfundene Daten und benötigen weder PostgreSQL noch einen echten Ollama-Server:

```powershell
cd backend
./node_modules/.bin/jest tests/summary.test.js tests/summaryRepository.test.js tests/ollamaProvider.test.js --runInBand
```

Die bestehende Gesamttestsuite verwendet eine separate PostgreSQL-Testdatenbank und löscht bei der Testvorbereitung Benutzer. Die Datenbank muss vor `npm test` existieren; Migrationen und Prisma-Client müssen zum aktuellen Schema passen. Veraltete API-Felder und -Pfade in den bestehenden Tests wurden berichtigt.
