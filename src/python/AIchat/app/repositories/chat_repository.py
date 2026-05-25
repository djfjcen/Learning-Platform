from typing import Sequence

from app.models import ChatRole


class ChatRepository:
    @staticmethod
    def save_message(connection, user_id: int, session_id: str, role: ChatRole, content: str) -> int:
        sql = """
        INSERT INTO ai_chat (user_id, session_id, role, content)
        VALUES (%s, %s, %s, %s)
        """
        with connection.cursor() as cursor:
            cursor.execute(sql, (user_id, session_id, role.value, content))
            return cursor.lastrowid

    @staticmethod
    def get_session_messages(connection, user_id: int, session_id: str, limit: int) -> Sequence[dict]:
        sql = """
        SELECT role, content, create_time
        FROM ai_chat
        WHERE user_id = %s
          AND session_id = %s
        ORDER BY create_time DESC, id DESC
        LIMIT %s
        """
        with connection.cursor() as cursor:
            cursor.execute(sql, (user_id, session_id, limit))
            # fetchall() 返回 tuple，勿对其调用 reverse()
            return list(reversed(cursor.fetchall() or []))

    @staticmethod
    def list_user_sessions(connection, user_id: int, limit: int = 50) -> Sequence[dict]:
        sql = """
        SELECT
            a.session_id,
            MAX(a.create_time) AS last_time,
            (
                SELECT t.content
                FROM ai_chat t
                WHERE t.user_id = %s
                  AND t.session_id = a.session_id
                  AND t.role = 'USER'
                ORDER BY t.id ASC
                LIMIT 1
            ) AS first_question
        FROM ai_chat a
        WHERE a.user_id = %s
        GROUP BY a.session_id
        ORDER BY last_time DESC
        LIMIT %s
        """
        with connection.cursor() as cursor:
            cursor.execute(sql, (user_id, user_id, limit))
            return list(cursor.fetchall() or [])
