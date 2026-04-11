/*
  Warnings:

  - The `formMetaData` column on the `Gespraech` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "Gespraech" DROP COLUMN "formMetaData",
ADD COLUMN     "formMetaData" JSONB;
