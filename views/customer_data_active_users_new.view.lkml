
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
      `bip-insights.looker_poc.CustomerDummyData`
           AS customer_dummy_data
      ON DATE_DIFF(customer_date.dates_for_calc, DATE(TIMESTAMP_MICROS(customer_dummy_data.activity_timestamp)), DAY)<2 AND DATE_DIFF(customer_date.dates_for_calc, DATE(TIMESTAMP_MICROS(customer_dummy_data.activity_timestamp)), DAY)>=0
      WHERE DATE(TIMESTAMP_MICROS(customer_dummy_data.activity_timestamp)) IS NOT NULL
      GROUP BY
          1, 2
          ;;
  }
}
