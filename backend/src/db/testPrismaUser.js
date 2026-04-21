const prismaUserRepository = require("../repositories/prisma/userRepositoryPrisma");

async function main() {
    const createdUser = await prismaUserRepository.create({
        email: "prisma4@test.at",
        registerNr: "PRISMA004",
        passwordHash: "hashed-test-password",
    });

    console.log("User erstellt:", createdUser);

    const foundByEmail = await prismaUserRepository.findByEmail("prisma@test.at");
    console.log("Per Email gefunden:", foundByEmail);

    const foundById = await prismaUserRepository.findById(createdUser.id);
    console.log("Per ID gefunden:", foundById);
}

main()
    .catch((err) => {
        console.error("Fehler beim Prisma-Test:", err);
    })
    .finally(async () => {
        const prisma = require("./prismaClient");
        await prisma.$disconnect();
    });
