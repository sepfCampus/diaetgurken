const { ApolloServer } = require("@apollo/server");
const { expressMiddleware } = require("@as-integrations/express5");
const { typeDefs } = require("./schema");
const { resolvers } = require("./resolvers");
const { buildContext } = require("./context");

async function startGraphQL(app) {
    const server = new ApolloServer({
        typeDefs,
        resolvers,
    });

    await server.start();

    app.use(
        "/graphql",
        expressMiddleware(server, {
            context: async ({ req }) => buildContext(req),
        })
    );

    console.log("GraphQL läuft unter /graphql");
}

module.exports = { startGraphQL };