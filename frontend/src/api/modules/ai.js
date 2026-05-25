import axios from 'axios'
import { ElMessage } from 'element-plus'

// Python AI 服务：走 Vite 代理 /api/ai -> localhost:9000（勿用 Java 的 Result 包装）
const aiHttp = axios.create({
  baseURL: '/api/ai',
  timeout: 120000,
})

aiHttp.interceptors.response.use(
  (response) => response.data,
  (error) => {
    const detail = error.response?.data?.detail
    const msg =
      (typeof detail === 'string' && detail) ||
      (Array.isArray(detail) && detail[0]?.msg) ||
      error.response?.data?.message ||
      (error.response?.status === 405
        ? 'AI 接口方法不允许：请确认 AI 服务(9000)已启动且访问的是本项目的 Vite 端口'
        : null) ||
      error.message ||
      'AI 服务请求失败'
    ElMessage.error(msg)
    return Promise.reject(error)
  },
)

/** 发送 AI 问答消息 */
export function sendChatMessage(data) {
  return aiHttp.post('/chat', data)
}

/** AI 代码分析与纠错 */
export function analyzeCode(data) {
  return aiHttp.post('/code/analysis', data)
}

/** AI 代码生成 */
export function generateCode(data) {
  return aiHttp.post('/code/generation', data)
}

/** 获取当前用户的会话列表 */
export function getSessionList(userId, limit = 50) {
  return aiHttp.get('/sessions', { params: { user_id: userId, limit } })
}

/** 获取历史对话记录 */
export function getChatHistory(sessionId, userId, limit = 50) {
  return aiHttp.get(`/sessions/${encodeURIComponent(sessionId)}`, {
    params: { user_id: userId, limit },
  })
}
