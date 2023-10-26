module.exports = function () {
  const { faker } = require("@faker-js/faker");
  var _ = require("lodash");

  return {
    messages: _.times(100, function (n) {
      return {
        id: n,
        user_id: faker.number.int({ max: 100 }),
        user_message_received: faker.lorem.paragraph(),
        message_from_id: faker.number.int({ max: 100 }),
      };
    }),
  };
};
