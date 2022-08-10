create table public_test.users_mod as (
    select distinct b.postid,
           a.displayname,
           a.reputation,
           b.creationdate as post_creationdate,
           b.userid,
           case
               when c.name like '%Editor%'
               then 1
               else 0
               end as is_editor,
           case
               when c.name like '%Critic%'
               then 1
               else 0
               end as is_critic,
           case
               when datediff(day, cast(post_creationdate AS TIMESTAMP), current_date) <= 30
               then count(b.postid)
           end as post_created_last30days
    from test2.users_xml a
    left join test2.badges_xml c
    on a.accountid = c.userid
    left join test2.posthistory_xml b
    on a.accountid = b.userid
    group by
             a.displayname,
             a.reputation,
             b.postid,
             b.creationdate,
             b.userid,
             c.name
)