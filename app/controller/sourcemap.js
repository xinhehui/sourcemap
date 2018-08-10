'use strict';

const sourceMap = require('source-map');

const Controller = require('egg').Controller;

class HomeController extends Controller {
  async index() {
    await this.ctx.render('sourcemap/index.tpl');
  }
  async parse() {
    const url = this.ctx.request.query.url,
      line = this.ctx.request.query.line,
      column = this.ctx.request.query.column;

    const result = await this.ctx.curl(url, {
      dataType: 'json',
    });

    if (result.status === 200) {
      const rawSourceMap = result.data;
      if (Object.prototype.toString.call(rawSourceMap) === '[object Object]') {
        const { file, mappings } = rawSourceMap;

        if (file && mappings) {
          const consumer = await new sourceMap.SourceMapConsumer(rawSourceMap);

          // consumer.eachMapping(function(m) { console.log(m); });

          const sm = consumer.originalPositionFor({
            line: parseInt(line), // 压缩后的行数
            column: parseInt(column), // 压缩后的列数
          });

          const sources = consumer.sources;
          const smIndex = sources.indexOf(sm.source);
          const smContent = consumer.sourcesContent[smIndex];
          // const rawLines = smContent.split(/\r?\n/g);

          // console.log(rawLines[sm.line - 1]);
          // console.log(smContent);

          this.ctx.body = {
            success: true,
            data: {
              source: sm.source,
              line: sm.line,
              column: sm.column,
              content: smContent,
            },
          };
          return true;
        }
      }
    }

    this.ctx.body = {
      success: false,
      data: {},
      message: '解析错误',
    };
  }
}

module.exports = HomeController;
