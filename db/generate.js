module.exports = function () {
  const { faker } = require("@faker-js/faker");
  var _ = require("lodash");

  return {
    users: _.times(100, function (n) {
      return {
        id: n,
        user_name: faker.person.fullName(),
        user_password: faker.internet.password(),
        user_avatar: faker.image.avatar(),
      };
    }),
  };
};
