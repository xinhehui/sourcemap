<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <!-- import CSS -->
  <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
  <style>
    .el-row {
    margin-bottom: 20px;
  }
  </style>
</head>

<body>
  <div id="app">
    <el-row style="display: none;" :style="{display: visible ? 'block' : 'none'}">
      <el-row>
        url示例：http://xhhfe.xinhehui.com:8001/static/js/0/0.e5c9f1c0aee5dd700e20.js.map
      </el-row>

      <el-row>
        <el-col :span="12" :offset="6">

          <el-card class="box-card">
            <div slot="header" class="clearfix">
              <span>sourcemap匹配表单</span>
            </div>
            <el-form :model="form" ref="form" label-width="100px" class="demo-dynamic">
              <el-form-item prop="url" label="地址" :rules="[
                      { required: true, pattern: /http(s?):\/\/\S+(\.map)$/, message: '请输入.map结尾的http或https的url', trigger: 'blur' },
                    ]">
                <el-input v-model="form.url" placeholder="类似http://wap.xinhehui.com/static/js/21/21.40cca96c5ae196560388.js.map"></el-input>
              </el-form-item>
              <el-form-item prop="line" label="行号" :rules="[
                      { required: true, pattern: /^\d+$/, message: '请输入行号', trigger: 'blur' },
                    ]">
                <el-input v-model="form.line"></el-input>
              </el-form-item>
              <el-form-item prop="column" label="列号" :rules="[
                      { required: true, pattern: /^\d+$/, message: '列号为数字', trigger: 'blur' },
                    ]">
                <el-input v-model="form.column"></el-input>
              </el-form-item>
              <el-form-item>
                <el-button type="primary" @click="submitForm('form')">提交</el-button>
                <el-button @click="resetForm('form')">重置</el-button>
              </el-form-item>
            </el-form>
          </el-card>
        </el-col>

      </el-row>

      <el-row>
        <el-col :span="12" :offset="6">
          <el-card class="box-card">
            <div slot="header" class="clearfix">
              <span>匹配结果</span>
            </div>
            <el-row>
              <el-tag>文件</el-tag>
              <span v-html="ret.source">
              </span>
              <!-- {{ret.source}} 不可以 -->
            </el-row>
            <el-row>
              <el-tag>行号</el-tag>
              <span v-html="ret.line">
              </span>
            </el-row>
            <el-row>
              <el-tag>列号</el-tag>
              <span v-html="ret.column">
              </span>
            </el-row>
            <el-row>
              <el-tag>文件内容</el-tag>
              <div v-html="ret.content" style="word-break:break-all;">
              </div>
            </el-row>
          </el-card>
        </el-col>
      </el-row>
    </el-row>
  </div>
</body>
<script src="https://unpkg.com/vue/dist/vue.js"></script>
<script src="https://unpkg.com/element-ui/lib/index.js"></script>
<script>
  var message = ELEMENT.Message

  new Vue({
    el: '#app',
    data() {
      return {
        msg: 'xxxxxxxxxefasdfa',
        visible: false,
        ret: {},
        // url: 'http://wap.xinhehui.com/static/js/21/21.40cca96c5ae196560388.js.map',
        form: {
          url: '',
          line: '',
          column: ''
        }
      }
    },
    mounted() {
      this.visible = true
    },
    methods: {
      submitForm(formName) {
        this.$refs[formName].validate(valid => {
          if (!valid) return false
          var url = '/parse?url=' + this.form.url + '&line=' + this.form.line + '&column=' + this.form.column

          fetch(url)
            .then(function (response) {
              return response.json();
            })
            .then((d) => {
              if (d.success) {
                this.ret = d.data
                console.log(this.ret)
              }
            }, function (err) {
              message('出错了')
            });
        })
      },
      resetForm(formName) {
        this.$refs[formName].resetFields()
      }
    }
  })
</script>

</html>
