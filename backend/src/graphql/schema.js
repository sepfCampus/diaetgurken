const typeDefs = `#graphql
  scalar JSON

  type Gespraech {
    id: ID!
    klientenAkteId: Int!
    datum: String!
    formMetaData: JSON
    assessment: JSON
    diagnosen: JSON
    ziele: JSON
    outcome: JSON
    notizen: String
  }

  type Query {
    gespraeche(klientenAkteId: Int!): [Gespraech!]!
  }

  input CreateGespraechInput {
    klientenAkteId: Int!
    datum: String!
    formMetaData: JSON
    assessment: JSON
    diagnosen: JSON
    ziele: JSON
    outcome: JSON
    notizen: String
  }

  type Mutation {
    createGespraech(input: CreateGespraechInput!): Gespraech!
  }
`;

module.exports = { typeDefs };