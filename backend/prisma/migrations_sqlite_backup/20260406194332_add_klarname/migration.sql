-- CreateTable
CREATE TABLE "Klarname" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "klientenAkteId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    CONSTRAINT "Klarname_klientenAkteId_fkey" FOREIGN KEY ("klientenAkteId") REFERENCES "KlientenAkte" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Klarname_klientenAkteId_key" ON "Klarname"("klientenAkteId");
