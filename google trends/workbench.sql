-- UK INTEREST PEAK
(select
    'learn sql' as Search_Term,
    Month,
    `learn sql` as Count
from
    uk
order by
    `learn sql` desc
limit 1
)
union (
select
    'learn python' as Search_Term,
    Month,
    `learn python` as Count
from
    uk
order by
    `learn python` desc
limit 1
)
-- Search_Term, Month, Count
-- 'learn sql', '2004-10', '100'
-- 'learn python', '2020-04', '92'

-- UK INTEREST TROUGH
(select
    'learn sql' as Search_Term,
    Month,
    `learn sql` as Count
from
    uk
order by
    `learn sql` asc
limit 1
)
union (
select
    'learn python' as Search_Term,
    Month,
    `learn python` as Count
from
    uk
order by
    `learn python` asc
limit 1
)
-- Search_Term, Month, Count
-- 'learn sql','2004-03','0'
-- 'learn python','2004-04','0'

-- SK INTEREST PEAK
(select
    'learn sql' as Search_Term,
    Month,
    `learn sql` as Count
from
    sk
order by
    `learn sql` desc
limit 1
)
union (
select
    'learn python' as Search_Term,
    Month,
    `learn python` as Count
from
    sk
order by
    `learn python` desc
limit 1
)
-- Search_Term, Month, Count
-- 'learn sql','2004-11','100'
-- 'learn python','2004-03','40'

-- SK INTEREST TROUGH
(select
    'learn sql' as Search_Term,
    Month,
    `learn sql` as Count
from
    sk
order by
    `learn sql` desc
limit 1
)
union (
select
    'learn python' as Search_Term,
    Month,
    `learn python` as Count
from
    sk
order by
    `learn python` desc
limit 1
)
-- Search_Term, Month, Count
-- 'learn sql','2004-01','0'
-- 'learn python','2004-01','0'