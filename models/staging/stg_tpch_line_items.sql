select
    {{
        -- Generate a surrogate key for the line item using the order key and line number
        -- This is a composite key that uniquely identifies each line item in an order
        -- Used when you have multiple tables you want to join on the same key
        dbt_utils.generate_surrogate_key([
            'l_orderkey',
            'l_linenumber'
        ])
    }} as order_item_key,
	l_orderkey as order_key,
	l_partkey as part_key,
	l_linenumber as line_number,
	l_quantity as quantity,
	l_extendedprice as extended_price,
	l_discount as discount_percentage,
	l_tax as tax_rate
from
    {{ source('tpch', 'lineitem') }}