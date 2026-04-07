-- CreateTable
CREATE TABLE "Einstellungen" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "farbdarstellung" TEXT NOT NULL,
    "schriftgroesse" TEXT NOT NULL,
    CONSTRAINT "Einstellungen_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Einstellungen_userId_key" ON "Einstellungen"("userId");
