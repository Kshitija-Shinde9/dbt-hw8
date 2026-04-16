with user_session as (
    select * from {{ ref('user_session_channel') }}
),

session_ts as (
    select * from {{ ref('session_timestamp') }}
),

final as (
    select
        u.userId,
        u.sessionId,
        u.channel,
        s.ts
    from user_session u
    join session_ts s on u.sessionId = s.sessionId
)

select * from final
