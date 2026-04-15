const GraphQLJSON = require("graphql-type-json");
const gespraechService = require("../services/gespraechService");

const resolvers = {
    JSON: GraphQLJSON,

    Query: {
        gespraeche: async (_, { klientenAkteId }, context) => {
            return await gespraechService.getAllForKlientenAkte(
                klientenAkteId,
                context.session
            );
        },
    },

    Mutation: {
        createGespraech: async (_, { input }, context) => {
            return await gespraechService.createForCurrentUser(
                input,
                context.session
            );
        },
    },
};

module.exports = { resolvers };