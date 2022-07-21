# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: customer_daily_active_users_new {
}

view: customer_daily_active_users_new  {
  derived_table: {
    sql: SELECT
          customer_date.dates_for_calc as date_range_activity,
          customer_dummy_data.product as product,
          CASE
          WHEN customer_dummy_data.gaia_id IS NOT NULL
          THEN 1
          ELSE 0
          END AS DAU_FLAG
      FROM
      (SELECT
        DATE(TIMESTAMP_MICROS(A.activity_timestamp)) as dates_for_calc
      FROM
        `bip-insights.looker_poc.CustomerDummyData` as A
      GROUP BY 1
      HAVING dates_for_calc IS NOT NULL
      ORDER BY 1 DESC
      LIMIT 7
      ) AS customer_date
      LEFT JOIN
      (
      SELECT  B.gaia_id, B.activity_timestamp, B.product
      FROM
      `bip-insights.looker_poc.CustomerDummyData` AS B
      WHERE DATE(TIMESTAMP_MICROS(B.activity_timestamp)) IS NOT NULL
      GROUP BY 1, 2, 3
      ) AS customer_dummy_data
      ON (DATE_DIFF(customer_date.dates_for_calc, DATE(TIMESTAMP_MICROS(customer_dummy_data.activity_timestamp)), DAY)<2) AND (DATE_DIFF(customer_date.dates_for_calc, DATE(TIMESTAMP_MICROS(customer_dummy_data.activity_timestamp)), DAY)>=0)
      GROUP BY
          1, customer_dummy_data.product, customer_dummy_data.gaia_id
          ;;
  }
  dimension: date_range_activity {
    type: date
    datatype: date
    sql: ${TABLE}.date_range_activity ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}.product ;;
  }

  dimension: DAU_FLAG {
    type: number
    sql: ${TABLE}.DAU_FLAG ;;
  }

}
