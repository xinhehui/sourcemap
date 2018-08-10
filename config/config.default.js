'use strict';

module.exports = appInfo => {
  const config = exports = {};

  // use for cookie sign key, should change to your own and keep security
  config.keys = appInfo.name + '_1533633241337_7345';

  // add your config here
  config.middleware = [];


  config.view = {
    mapping: {
      '.tpl': 'nunjucks',
    },
  };


  return config;
};
