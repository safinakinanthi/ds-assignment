WITH rfm_values AS (
    SELECT
        customer_id,
        DATEDIFF('day', MAX(order_date), '2025-06-13') AS recency, --menghitung recency dari tanggal terakhir transaksi
        COUNT(order_id) AS frequency,                                  -- menghitung frequency berdasarkan jumlah pembelian
        SUM(payment_value) AS monetary                                 -- menghitung monetary
    FROM
        'e_commerce_transactions.csv' 
    GROUP BY
        customer_id
)

-- membuat segmentasi menjadi 7 segmen yaitu champions, loyal customers, big spenders, new customers, lost, at risk.
SELECT
    customer_id,
    recency,
    frequency,
    monetary,
    CASE
        
        WHEN recency <= 100 AND frequency >= 12 AND monetary >= 2500 THEN 'Champions' -- aktif, sering membeli, dan belanja dalam jumlah besar
        WHEN recency <= 150 AND frequency >= 12 THEN 'Loyal Customers' -- aktif dan sering membeli
        WHEN monetary >= 3000 THEN 'Big Spenders' --belanja dalam jumlah banyak / mengeluarkan banyak uang
        WHEN recency <= 30 AND frequency <= 4 THEN 'New Customers' --baru mulai membeli
        WHEN recency > 400 THEN 'Lost' --sudah lama tidak membeli
        WHEN recency > 300 THEN 'At Risk' --hampir menjadi kategori lost/hilang
        ELSE 'Others' --segmen yang lain
    END AS segment
FROM
    rfm_values 
ORDER BY
    customer_id;

-- melihat repurchase bulanan

EXPLAIN SELECT 
  customer_id,
  DATE_TRUNC('month', order_date) AS transaction_month,
  COUNT(*) AS tx_count
FROM 
  'e_commerce_transactions.csv'
GROUP BY 
  customer_id, transaction_month
HAVING 
  COUNT(*) > 1