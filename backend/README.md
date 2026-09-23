# Zusammenfassung: Phase 1

Der Endpunkt `POST /api/users/klientenakten/:klientenAkteId/summary` erzeugt zurzeit nur eine **Testausgabe**. Er benötigt die bestehende Anmeldung per Session-Cookie und prüft, ob die Akte dem angemeldeten Benutzer gehört. Es werden keine Zusammenfassungen gespeichert und keine Daten an einen externen KI-Dienst gesendet.

`LLM_PROVIDER=mock` aktiviert den Mock-Provider; `mock` ist auch der Standardwert, solange die Variable fehlt. Andere Werte liefern `503 Zusammenfassungsdienst nicht verfügbar`. Der Mock meldet nur die Anzahl der dokumentierten Gespräche und macht keine medizinischen Aussagen.

Der Provider-Vertrag besteht aus `name` und `summarize(documentation, options)`. Der Summary-Service kennt nur diesen Vertrag. Weitere Provider können später über die Factory ausgewählt werden, ohne den Controller zu ändern.

Die Antwort enthält `summary.summary` und `summary.development` als Texte sowie `summary.currentGoals` und `summary.openPoints` als Textlisten. `metadata.provider` kennzeichnet den Mock, `metadata.sourceCount` nennt die Anzahl der Gespräche, und `reviewRequired` ist `true`. Für eine Akte ohne Gespräche wird `422` zurückgegeben.

Die isolierten Tests benötigen weder PostgreSQL noch Ollama:

```powershell
cd backend
./node_modules/.bin/jest tests/summary.test.js tests/summaryRepository.test.js --runInBand
```

Die bestehende Gesamttestsuite hat derzeit einen Syntaxfehler in `tests/gespraeche.test.js` und wird durch diese Phase nicht geändert.
