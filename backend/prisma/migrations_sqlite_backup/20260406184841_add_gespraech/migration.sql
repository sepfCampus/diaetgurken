-- CreateTable
CREATE TABLE "Gespraech" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "klientenAkteId" INTEGER NOT NULL,
    "datum" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "notizen" TEXT,
    CONSTRAINT "Gespraech_klientenAkteId_fkey" FOREIGN KEY ("klientenAkteId") REFERENCES "KlientenAkte" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
