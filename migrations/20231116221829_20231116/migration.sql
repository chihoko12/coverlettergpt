/*
  Warnings:

  - The primary key for the `CoverLetter` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `id` column on the `CoverLetter` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `Job` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `id` column on the `Job` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the column `checkoutSessionId` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `credits` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `datePaid` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `email` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `gptModel` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `hasPaid` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `isUsingLn` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `notifyPaymentExpires` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `stripeId` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `subscriptionStatus` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `LnData` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `LnPayment` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `SocialLogin` table. If the table is not empty, all the data it contains will be lost.
  - Changed the type of `jobId` on the `CoverLetter` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Made the column `userId` on table `CoverLetter` required. This step will fail if there are existing NULL values in that column.
  - Made the column `userId` on table `Job` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "CoverLetter" DROP CONSTRAINT "CoverLetter_jobId_fkey";

-- DropForeignKey
ALTER TABLE "CoverLetter" DROP CONSTRAINT "CoverLetter_userId_fkey";

-- DropForeignKey
ALTER TABLE "Job" DROP CONSTRAINT "Job_userId_fkey";

-- DropForeignKey
ALTER TABLE "LnData" DROP CONSTRAINT "LnData_userId_fkey";

-- DropForeignKey
ALTER TABLE "LnPayment" DROP CONSTRAINT "LnPayment_userId_fkey";

-- DropForeignKey
ALTER TABLE "SocialLogin" DROP CONSTRAINT "SocialLogin_userId_fkey";

-- AlterTable
ALTER TABLE "CoverLetter" DROP CONSTRAINT "CoverLetter_pkey",
DROP COLUMN "id",
ADD COLUMN     "id" SERIAL NOT NULL,
DROP COLUMN "jobId",
ADD COLUMN     "jobId" INTEGER NOT NULL,
ALTER COLUMN "userId" SET NOT NULL,
ADD CONSTRAINT "CoverLetter_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Job" DROP CONSTRAINT "Job_pkey",
ADD COLUMN     "shareableURL" TEXT,
ADD COLUMN     "shares" INTEGER NOT NULL DEFAULT 0,
DROP COLUMN "id",
ADD COLUMN     "id" SERIAL NOT NULL,
ALTER COLUMN "userId" SET NOT NULL,
ADD CONSTRAINT "Job_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "User" DROP COLUMN "checkoutSessionId",
DROP COLUMN "credits",
DROP COLUMN "datePaid",
DROP COLUMN "email",
DROP COLUMN "gptModel",
DROP COLUMN "hasPaid",
DROP COLUMN "isUsingLn",
DROP COLUMN "notifyPaymentExpires",
DROP COLUMN "stripeId",
DROP COLUMN "subscriptionStatus";

-- DropTable
DROP TABLE "LnData";

-- DropTable
DROP TABLE "LnPayment";

-- DropTable
DROP TABLE "SocialLogin";

-- CreateTable
CREATE TABLE "Resume" (
    "id" SERIAL NOT NULL,
    "content" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Resume_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "CoverLetter" ADD CONSTRAINT "CoverLetter_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CoverLetter" ADD CONSTRAINT "CoverLetter_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Job" ADD CONSTRAINT "Job_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Resume" ADD CONSTRAINT "Resume_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
