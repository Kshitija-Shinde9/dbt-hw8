with source as (
    select
        sessionId,
        ts
    from USER_DB_FERRET.raw.session_timestamp
)

select * from source
