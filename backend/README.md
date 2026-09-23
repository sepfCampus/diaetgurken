# Gesprächszusammenfassung

`POST /api/users/klientenakten/:klientenAkteId/summary` verwendet die bestehende Anmeldung per Session-Cookie und prüft die Aktenzugehörigkeit. Die Antwort ist ein Vorschlag zur menschlichen Prüfung; sie wird nicht in der Patientenakte gespeichert.

## Provider

`LLM_PROVIDER=mock` ist der Standard. Der Mock meldet nur die Anzahl der Gespräche und führt keine medizinische Auswertung durch. `LLM_PROVIDER=ollama` aktiviert den lokalen Ollama-Provider. Dafür sind `OLLAMA_BASE_URL` (Basis-URL der vom **Backend** erreichbaren Ollama-API) und `OLLAMA_MODEL` erforderlich. `OLLAMA_TIMEOUT_MS` ist optional und beträgt standardmäßig 120000 Millisekunden. Der Testmodellname `ministral-3:3b` gehört in die Umgebungskonfiguration, nicht in den Anwendungscode.

Die Docker-Compose-Konfiguration reicht diese vier Variablen an den Backend-Container weiter. Eine Adresse wie `localhost` bezeichnet **innerhalb des Containers den Container selbst**. Verwende sie dort nur, wenn Ollama auch im selben Container läuft. Für einen ersten echten Test über einen SSH-Tunnel ist ein lokal gestartetes Backend einfacher.

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

Die Antwort enthält `summary.summary` und `summary.development` als Texte sowie `summary.currentGoals` und `summary.openPoints` als Textlisten. `metadata` nennt Provider, Anzahl der Quellgespräche und Latenz; bei Ollama zusätzlich Modell und Prompt-Version `summary-v1`. `reviewRequired` ist immer `true`. Der Prompt fordert die Trennung von Zielen und erreichten Ergebnissen und untersagt erfundene Fakten. Die Formatprüfung kann die fachliche Richtigkeit einer Modellantwort nicht garantieren.

Eine Akte ohne Gespräche ergibt `422`. Ungültige Ollama-Antworten ergeben `502`; nicht erreichbare Server, fehlende Modelle und Zeitüberschreitungen ergeben `503`. Fehlerantworten enthalten keine Dokumentation oder Provider-Fehlerdetails.

## Tests

Die isolierten Tests verwenden erfundene Daten und benötigen weder PostgreSQL noch einen echten Ollama-Server:

```powershell
cd backend
./node_modules/.bin/jest tests/summary.test.js tests/summaryRepository.test.js tests/ollamaProvider.test.js --runInBand
```

Die bestehende Gesamttestsuite verwendet eine separate PostgreSQL-Testdatenbank und löscht bei der Testvorbereitung Benutzer. Die Datenbank muss vor `npm test` existieren; Migrationen und Prisma-Client müssen zum aktuellen Schema passen. Veraltete API-Felder und -Pfade in den bestehenden Tests wurden berichtigt.
