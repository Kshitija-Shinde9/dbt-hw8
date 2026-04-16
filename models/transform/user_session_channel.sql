with source as (
    select
        userId,
        sessionId,
        channel
    from USER_DB_FERRET.raw.user_session_channel
)

select * from source
