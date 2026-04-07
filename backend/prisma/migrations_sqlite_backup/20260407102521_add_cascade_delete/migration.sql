-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Einstellungen" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "farbdarstellung" TEXT NOT NULL,
    "schriftgroesse" TEXT NOT NULL,
    CONSTRAINT "Einstellungen_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Einstellungen" ("farbdarstellung", "id", "schriftgroesse", "userId") SELECT "farbdarstellung", "id", "schriftgroesse", "userId" FROM "Einstellungen";
DROP TABLE "Einstellungen";
ALTER TABLE "new_Einstellungen" RENAME TO "Einstellungen";
CREATE UNIQUE INDEX "Einstellungen_userId_key" ON "Einstellungen"("userId");
CREATE TABLE "new_Gespraech" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "klientenAkteId" INTEGER NOT NULL,
    "datum" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "formMetaData" TEXT,
    "assessment" TEXT,
    "diagnosen" TEXT,
    "ziele" TEXT,
    "outcome" TEXT,
    "notizen" TEXT,
    CONSTRAINT "Gespraech_klientenAkteId_fkey" FOREIGN KEY ("klientenAkteId") REFERENCES "KlientenAkte" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Gespraech" ("assessment", "datum", "diagnosen", "formMetaData", "id", "klientenAkteId", "notizen", "outcome", "ziele") SELECT "assessment", "datum", "diagnosen", "formMetaData", "id", "klientenAkteId", "notizen", "outcome", "ziele" FROM "Gespraech";
DROP TABLE "Gespraech";
ALTER TABLE "new_Gespraech" RENAME TO "Gespraech";
CREATE TABLE "new_Klarname" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "klientenAkteId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    CONSTRAINT "Klarname_klientenAkteId_fkey" FOREIGN KEY ("klientenAkteId") REFERENCES "KlientenAkte" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Klarname" ("id", "klientenAkteId", "name") SELECT "id", "klientenAkteId", "name" FROM "Klarname";
DROP TABLE "Klarname";
ALTER TABLE "new_Klarname" RENAME TO "Klarname";
CREATE UNIQUE INDEX "Klarname_klientenAkteId_key" ON "Klarname"("klientenAkteId");
CREATE TABLE "new_KlientenAkte" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "KlientenAkte_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_KlientenAkte" ("id", "userId") SELECT "id", "userId" FROM "KlientenAkte";
DROP TABLE "KlientenAkte";
ALTER TABLE "new_KlientenAkte" RENAME TO "KlientenAkte";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
