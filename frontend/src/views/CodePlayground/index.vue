<template>
  <div class="playground-layout">
    <div class="editor-panel">
      <div class="editor-toolbar">
        <el-select v-model="language" size="small" style="width:120px">
          <el-option label="C++" value="c++" />
          <el-option label="C" value="c" />
          <el-option label="Python" value="python" />
        </el-select>
        <el-button size="small" @click="resetCode">重置代码</el-button>
        <div style="flex:1" />
        <el-button size="small" type="success" @click="handleRun" :loading="runLoading">
          运行
        </el-button>
        <el-button size="small" type="primary" @click="handleSubmit" :loading="submitLoading">
          提交判题
        </el-button>
      </div>
      <div class="editor-area">
        <CodeEditor v-model="code" :language="monacoLang" />
      </div>
    </div>

    <div class="result-panel">
      <el-tabs v-model="activeTab" class="result-tabs">
        <el-tab-pane label="标准输入" name="stdin">
          <el-input
            v-model="stdin"
            type="textarea"
            :rows="4"
            placeholder="输入测试数据，如：3 5"
          />
        </el-tab-pane>

        <el-tab-pane label="运行结果" name="run">
          <template v-if="runResult">
            <template v-if="runResult.compileError">
              <el-alert type="error" :closable="false" title="编译错误" style="margin-bottom:8px" />
              <pre class="error-pre">{{ runResult.compileError }}</pre>
            </template>
            <template v-else>
              <div class="result-block">
                <div class="result-label">输出</div>
                <pre class="result-pre">{{ runResult.stdout || '(无输出)' }}</pre>
              </div>
              <div v-if="runResult.stderr" class="result-block">
                <div class="result-label error-text">错误输出</div>
                <pre class="error-pre">{{ runResult.stderr }}</pre>
              </div>
              <div class="result-meta">
                <el-tag size="small" type="info">退出码: {{ runResult.exitCode ?? '-' }}</el-tag>
                <el-tag size="small" type="info">耗时: {{ runResult.executionTime ?? '-' }}ms</el-tag>
              </div>
            </template>
          </template>
          <el-empty v-else description="点击「运行」查看结果" :image-size="60" />
        </el-tab-pane>

        <el-tab-pane label="判题结果" name="submit">
          <template v-if="submitResult">
            <div class="status-banner" :class="submitResult.status?.toLowerCase()">
              <span class="status-icon">{{ submitResult.status === 'ACCEPTED' ? '✓' : '✗' }}</span>
              {{ submitStatusText }}
              <span class="pass-count" v-if="submitResult.passCount != null">
                {{ submitResult.passCount }}/{{ submitResult.totalCount }} 个测试用例通过
              </span>
            </div>
            <div v-if="submitResult.status === 'COMPILE_ERROR'">
              <pre class="error-pre">{{ submitResult.errorMessage }}</pre>
            </div>
            <div v-else-if="submitResult.testResults" class="test-results">
              <div
                v-for="(tr, i) in submitResult.testResults"
                :key="i"
                class="test-result-item"
                :class="{ passed: tr.passed, failed: !tr.passed }"
              >
                <el-tag :type="tr.passed ? 'success' : 'danger'" size="small">
                  用例 {{ i + 1 }}：{{ tr.passed ? '通过' : '失败' }}
                </el-tag>
                <div v-if="!tr.passed" class="tr-detail">
                  <span class="tr-label">输入：</span><code>{{ tr.input }}</code><br>
                  <span class="tr-label">期望：</span><code>{{ tr.expectedOutput }}</code><br>
                  <span class="tr-label">实际：</span><code>{{ tr.actualOutput }}</code>
                </div>
              </div>
            </div>
          </template>
          <el-empty v-else description="点击「提交判题」查看结果" :image-size="60" />
        </el-tab-pane>
      </el-tabs>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue'
import { runCode, submitCode } from '@/api/modules/code.js'
import CodeEditor from '@/components/CodeEditor/CodeEditor.vue'

const DEFAULT_TEMPLATES = {
  'c++': '#include <bits/stdc++.h>\nusing namespace std;\n\nint main() {\n    // 在此编写代码\n    \n    return 0;\n}',
  'c': '#include <stdio.h>\n\nint main() {\n    // 在此编写代码\n    \n    return 0;\n}',
  'python': '# Python code\n'
}

const language = ref('c++')
const code = ref(DEFAULT_TEMPLATES['c++'])
const stdin = ref('')
const activeTab = ref('stdin')
const runLoading = ref(false)
const submitLoading = ref(false)
const runResult = ref(null)
const submitResult = ref(null)

const monacoLang = computed(() =>
  ({ 'c++': 'cpp', 'c': 'c', 'python': 'python' }[language.value] || 'cpp')
)

const submitStatusText = computed(() => {
  if (!submitResult.value) return ''
  return {
    ACCEPTED: '通过',
    WRONG_ANSWER: '答案错误',
    COMPILE_ERROR: '编译错误',
    RUNTIME_ERROR: '运行错误'
  }[submitResult.value.status] || submitResult.value.status
})

watch(language, (lang) => {
  code.value = DEFAULT_TEMPLATES[lang] || ''
  runResult.value = null
  submitResult.value = null
})

function resetCode() {
  code.value = DEFAULT_TEMPLATES[language.value] || ''
  stdin.value = ''
  runResult.value = null
  submitResult.value = null
}

async function handleRun() {
  runLoading.value = true
  runResult.value = null
  activeTab.value = 'run'
  try {
    const res = await runCode({
      language: language.value,
      code: code.value,
      stdin: stdin.value
    })
    runResult.value = res
  } catch (e) {
    runResult.value = { compileError: '请求失败：' + (e.message || '未知错误') }
  } finally {
    runLoading.value = false
  }
}

async function handleSubmit() {
  submitLoading.value = true
  submitResult.value = null
  activeTab.value = 'submit'
  try {
    const res = await submitCode({
      language: language.value,
      code: code.value,
      testCases: []
    })
    submitResult.value = res
  } catch (e) {
    submitResult.value = {
      status: 'RUNTIME_ERROR',
      errorMessage: '请求失败：' + (e.message || '未知错误'),
      passCount: 0,
      totalCount: 0,
      testResults: []
    }
  } finally {
    submitLoading.value = false
  }
}
</script>

<style scoped>
.playground-layout {
  display: flex;
  height: calc(100vh - 56px);
  margin: -24px;
  background: #fff;
}

.editor-panel {
  flex: 1;
  display: flex;
  flex-direction: column;
  min-width: 0;
  border-right: 1px solid #e4e7ed;
}

.editor-toolbar {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px 16px;
  border-bottom: 1px solid #e4e7ed;
  background: #fafafa;
}

.editor-area {
  flex: 1;
  min-height: 0;
  overflow: hidden;
}

.result-panel {
  width: 420px;
  min-width: 320px;
  display: flex;
  flex-direction: column;
  overflow-y: auto;
}

.result-tabs {
  height: 100%;
  display: flex;
  flex-direction: column;
}

:deep(.result-tabs .el-tabs__content) {
  flex: 1;
  overflow-y: auto;
  padding: 16px;
}

:deep(.result-tabs .el-tab-pane) {
  height: 100%;
}

.result-block {
  margin-bottom: 12px;
}

.result-label {
  font-size: 12px;
  color: #909399;
  font-weight: 600;
  margin-bottom: 4px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.error-text {
  color: #f56c6c;
}

.result-pre {
  background: #f5f7fa;
  border: 1px solid #e4e7ed;
  border-radius: 6px;
  padding: 12px 16px;
  font-size: 13px;
  line-height: 1.6;
  margin: 0;
  white-space: pre-wrap;
  color: #1f2329;
  font-family: 'Cascadia Code', 'Fira Code', 'Consolas', monospace;
}

.error-pre {
  background: #fff2f0;
  border: 1px solid #ffccc7;
  border-radius: 6px;
  padding: 12px 16px;
  font-size: 12px;
  line-height: 1.6;
  color: #cf1322;
  margin: 4px 0;
  white-space: pre-wrap;
  font-family: 'Cascadia Code', 'Fira Code', 'Consolas', monospace;
}

.result-meta {
  display: flex;
  gap: 8px;
  margin-top: 8px;
}

.status-banner {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 12px 16px;
  border-radius: 8px;
  margin-bottom: 12px;
  font-weight: 600;
  font-size: 16px;
}
.status-banner.accepted { background: #f6ffed; color: #389e0d; border: 1px solid #b7eb8f; }
.status-banner.wrong_answer { background: #fff2f0; color: #cf1322; border: 1px solid #ffccc7; }
.status-banner.compile_error { background: #fff7e6; color: #d46b08; border: 1px solid #ffd591; }
.status-banner.runtime_error { background: #fff2f0; color: #cf1322; border: 1px solid #ffccc7; }

.status-icon { font-size: 20px; }
.pass-count { font-size: 13px; font-weight: 400; color: #909399; margin-left: auto; }

.test-results { margin-top: 8px; }
.test-result-item {
  border: 1px solid #e4e7ed;
  border-radius: 6px;
  padding: 10px 14px;
  margin-bottom: 8px;
  background: #fafafa;
}
.test-result-item.passed { border-color: #b7eb8f; background: #f6ffed; }
.test-result-item.failed { border-color: #ffccc7; background: #fff2f0; }

.tr-detail {
  margin-top: 8px;
  font-size: 13px;
  line-height: 1.8;
  color: #4e5969;
}
.tr-label { color: #909399; font-weight: 500; }
</style>
