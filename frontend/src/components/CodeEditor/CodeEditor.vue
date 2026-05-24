<template>
  <div ref="editorContainer" class="monaco-editor-wrap"></div>
</template>

<script setup>
import { ref, watch, onMounted, onBeforeUnmount, shallowRef } from 'vue'
import * as monaco from 'monaco-editor'

const props = defineProps({
  modelValue: { type: String, default: '' },
  language: { type: String, default: 'cpp' }
})

const emit = defineEmits(['update:modelValue'])

const editorContainer = ref(null)
const editorInstance = shallowRef(null)
let ignoreNextChange = false

const EDITOR_OPTIONS = {
  theme: 'vs',
  fontSize: 14,
  minimap: { enabled: false },
  scrollBeyondLastLine: false,
  automaticLayout: true,
  tabSize: 4,
  wordWrap: 'on'
}

onMounted(() => {
  if (!editorContainer.value) return

  const model = monaco.editor.createModel(props.modelValue, props.language)

  editorInstance.value = monaco.editor.create(editorContainer.value, {
    model,
    ...EDITOR_OPTIONS
  })

  editorInstance.value.onDidChangeModelContent(() => {
    if (ignoreNextChange) {
      ignoreNextChange = false
      return
    }
    const value = editorInstance.value.getValue()
    emit('update:modelValue', value)
  })
})

watch(() => props.modelValue, (newValue) => {
  if (!editorInstance.value) return
  const currentValue = editorInstance.value.getValue()
  if (currentValue !== newValue) {
    ignoreNextChange = true
    editorInstance.value.setValue(newValue || '')
  }
})

watch(() => props.language, (newLang) => {
  if (!editorInstance.value) return
  const model = editorInstance.value.getModel()
  if (model) {
    monaco.editor.setModelLanguage(model, newLang)
  }
})

onBeforeUnmount(() => {
  if (editorInstance.value) {
    editorInstance.value.dispose()
    editorInstance.value = null
  }
})
</script>

<style scoped>
.monaco-editor-wrap {
  width: 100%;
  height: 100%;
  min-height: 300px;
}
</style>
