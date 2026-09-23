jest.mock("../src/db/prismaClient", () => ({
    klientenAkte: { findUnique: jest.fn() },
    gespraech: { findMany: jest.fn() },
}));

const prisma = require("../src/db/prismaClient");
const aktenRepository = require("../src/repositories/prisma/klientenAkteRepositoryPrisma");
const gespraecheRepository = require("../src/repositories/prisma/gespraechRepositoryPrisma");

test("die Zusammenfassung liest weder Klarname noch unnötige Gesprächsfelder", async () => {
    await aktenRepository.findOwnerById(3);
    await gespraecheRepository.findForSummaryByAkteId(3);

    expect(prisma.klientenAkte.findUnique).toHaveBeenCalledWith({
        where: { id: 3 },
        select: { id: true, userId: true },
    });
    expect(prisma.gespraech.findMany).toHaveBeenCalledWith({
        where: { klientenAkteId: 3 },
        orderBy: [{ datum: "asc" }, { id: "asc" }],
        select: {
            id: true,
            datum: true,
            assessment: true,
            diagnosen: true,
            ziele: true,
            outcome: true,
            notizen: true,
        },
    });
});
