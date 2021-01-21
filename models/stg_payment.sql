with source as (
    select * from {{ source('stripe', 'payment') }}
)

SELECT 
    ID as payment_id,
    ORDERID as order_id,
    "STATUS" as payment_status,
    AMOUNT::INT/100 as amount_usd,
    CREATED as created_at,
    paymentmethod as payment_method
    --_BATCHED_AT
FROM 
    source
WHERE 
    payment_status = 'success'