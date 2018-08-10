'use strict';

/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
  const { router, controller } = app;
  router.get('/', controller.sourcemap.index);
  router.get('/parse', controller.sourcemap.parse);
};
