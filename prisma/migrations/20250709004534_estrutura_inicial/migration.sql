-- CreateEnum
CREATE TYPE "Types" AS ENUM ('credit', 'debit', 'money');

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "telegram_id" INTEGER NOT NULL,
    "nome" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Transactions" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "type" "Types" NOT NULL,
    "category" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isInstallment" BOOLEAN NOT NULL,
    "installment_id" INTEGER NOT NULL,

    CONSTRAINT "Transactions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Installment" (
    "id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "total" INTEGER NOT NULL,
    "amount" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "Installment_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_telegram_id_key" ON "User"("telegram_id");

-- CreateIndex
CREATE UNIQUE INDEX "Transactions_user_id_key" ON "Transactions"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "Installment_user_id_key" ON "Installment"("user_id");

-- AddForeignKey
ALTER TABLE "Transactions" ADD CONSTRAINT "Transactions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transactions" ADD CONSTRAINT "Transactions_installment_id_fkey" FOREIGN KEY ("installment_id") REFERENCES "Installment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Installment" ADD CONSTRAINT "Installment_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
