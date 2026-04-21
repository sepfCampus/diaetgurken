-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "registerNr" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "KlientenAkte" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "KlientenAkte_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Gespraech" (
    "id" SERIAL NOT NULL,
    "klientenAkteId" INTEGER NOT NULL,
    "datum" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "formMetaData" TEXT,
    "assessment" TEXT,
    "diagnosen" TEXT,
    "ziele" TEXT,
    "outcome" TEXT,
    "notizen" TEXT,

    CONSTRAINT "Gespraech_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Klarname" (
    "id" SERIAL NOT NULL,
    "klientenAkteId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Klarname_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Einstellungen" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "farbdarstellung" TEXT NOT NULL,
    "schriftgroesse" TEXT NOT NULL,

    CONSTRAINT "Einstellungen_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_registerNr_key" ON "User"("registerNr");

-- CreateIndex
CREATE UNIQUE INDEX "Klarname_klientenAkteId_key" ON "Klarname"("klientenAkteId");

-- CreateIndex
CREATE UNIQUE INDEX "Einstellungen_userId_key" ON "Einstellungen"("userId");

-- AddForeignKey
ALTER TABLE "KlientenAkte" ADD CONSTRAINT "KlientenAkte_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Gespraech" ADD CONSTRAINT "Gespraech_klientenAkteId_fkey" FOREIGN KEY ("klientenAkteId") REFERENCES "KlientenAkte"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Klarname" ADD CONSTRAINT "Klarname_klientenAkteId_fkey" FOREIGN KEY ("klientenAkteId") REFERENCES "KlientenAkte"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Einstellungen" ADD CONSTRAINT "Einstellungen_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
