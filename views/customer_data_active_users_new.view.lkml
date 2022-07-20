# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: customer_daily_active_users_new {
}

view: customer_daily_active_users_new  {
  derived_table: {
    sql: SELECT
          customer_date.dates_for_calc as date_range_activity,
          customer_dummy_data.gaia_id as customer_dummy_data_gaia_id,
          count(*) as total_times_active_in_range
      FROM
      (SELECT
        DATE(TIMESTAMP_MICROS(customer_dummy_data.activity_timestamp)) as dates_for_calc
      FROM
        `bip-insights.looker_poc.CustomerDummyData` as customer_dummy_data
      GROUP BY 1
      HAVING dates_for_calc IS NOT NULL
      ORDER BY 1 DESC
      LIMIT 7
      ) AS customer_date
      LEFT JOIN
      (
      SELECT  customer_dummy_data.gaia_id, customer_dummy_data.activity_timestamp
      FROM
      `bip-insights.looker_poc.CustomerDummyData`
      GROUP BY 1, 2
      )
           AS customer_dummy_data
      ON DATE_DIFF(customer_date.dates_for_calc, DATE(TIMESTAMP_MICROS(customer_dummy_data.activity_timestamp)), DAY)<2 AND DATE_DIFF(customer_date.dates_for_calc, DATE(TIMESTAMP_MICROS(customer_dummy_data.activity_timestamp)), DAY)>=0
      WHERE DATE(TIMESTAMP_MICROS(customer_dummy_data.activity_timestamp)) IS NOT NULL
      GROUP BY
          1, 2
          ;;
  }
  dimension: date_range_activity {
    type: date
    datatype: date
    sql: ${TABLE}.date_range_activity ;;
  }

  dimension: customer_dummy_data_gaia_id {
    type: number
    sql: ${TABLE}.customer_dummy_data_gaia_id ;;
  }

  dimension: total_times_active_in_range {
    type: number
    sql: ${TABLE}.total_times_active_in_range ;;
  }
}
