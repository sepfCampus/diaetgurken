/*
  Warnings:

  - The `assessment` column on the `Gespraech` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `diagnosen` column on the `Gespraech` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `ziele` column on the `Gespraech` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `outcome` column on the `Gespraech` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "Gespraech" DROP COLUMN "assessment",
ADD COLUMN     "assessment" JSONB,
DROP COLUMN "diagnosen",
ADD COLUMN     "diagnosen" JSONB,
DROP COLUMN "ziele",
ADD COLUMN     "ziele" JSONB,
DROP COLUMN "outcome",
ADD COLUMN     "outcome" JSONB;
