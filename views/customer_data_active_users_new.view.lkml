include: "/views/user_id_map.view"
# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: customer_daily_active_users_new {
  join: user_id_map {
    type: inner
    relationship: one_to_one
    sql_on: ${user_id_map.gaia_id} = ${customer_daily_active_users_new.gaia_id} ;;
  }
}

view: customer_daily_active_users_new  {
  derived_table: {
    sql: SELECT
          customer_date.dates_for_calc as date_range_activity,
          customer_dummy_data.product as product,
          customer_dummy_data.gaia_id
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
      SELECT  B.gaia_id, B.activity_timestamp , B.product
      FROM
      `bip-insights.looker_poc.CustomerDummyData` AS B
      WHERE DATE(TIMESTAMP_MICROS(B.activity_timestamp)) IS NOT NULL
      GROUP BY 1, 2 , 3
      ) AS customer_dummy_data
      ON (DATE_DIFF(customer_date.dates_for_calc, DATE(TIMESTAMP_MICROS(customer_dummy_data.activity_timestamp)), DAY)<7) AND (DATE_DIFF(customer_date.dates_for_calc, DATE(TIMESTAMP_MICROS(customer_dummy_data.activity_timestamp)), DAY)>=0)
          ;;
  }
  dimension: date_range_activity {
    type: date
    datatype: date
    link: {
      label: "Drill into this day ({{ date_range_activity }})"
      url: "/explore/bip_insights_demo/customer_daily_active_users_new?fields=customer_daily_active_users_new.gaia_id&f[customer_daily_active_users_new.date_range_activity]={{ filterable_value }}"
      # url: “/explore/events_by_hour_drilldown/events_day?fields=events_day.created_date,events_day.average_per_hour,events_day.max_per_hour&f[events_day.created_month]={{ created_month | url_encode }}%20for%201%20month”
    }
    sql: ${TABLE}.date_range_activity ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}.product ;;
  }

  dimension: gaia_id {
    type: number
    # drill_fields: []
    sql: ${TABLE}.gaia_id ;;
  }

}
