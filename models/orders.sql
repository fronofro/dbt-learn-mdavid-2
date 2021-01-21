with order_totals as (

    SELECT 
        order_id, 
        SUM(amount_usd) as order_amount
    FROM 
        {{ ref('stg_payment')}}
    GROUP BY 1

),

orders as (

    SELECT * FROM {{ ref('stg_orders')}}

)

SELECT 
    order_totals.order_id, 
    customer_id,
    order_amount,
    order_date,
    status
FROM
    order_totals
INNER JOIN
    orders using (order_id)