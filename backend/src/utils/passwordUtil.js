const bcrypt = require("bcrypt");

async function hashPassword(passwort) {
  return bcrypt.hash(passwort, 10);
}

async function comparePassword(passwort, passwortHash) {
  return bcrypt.compare(passwort, passwortHash);
}

module.exports = {
  hashPassword,
  comparePassword,
};