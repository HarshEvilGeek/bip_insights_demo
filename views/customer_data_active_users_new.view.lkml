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
      url: "/explore/workinsights/customer_daily_active_users_new?fields=customer_daily_active_users_new.date_range_activity,customer_daily_active_users_new.gaia_id&f[customer_daily_active_users_new.date_range_activity]={{ filterable_value }}&f[customer_daily_active_users_new.gaia_id]=NOT+NULL,{% assign vis_config = '{
     \"type\": \"table\",
     \"show_view_names\": false,
     \"show_row_numbers\": false,
     \"truncate_column_names\": false,
     \"table_theme\": \"gray\","
      # https://googlecloud.looker.com/explore/workinsights/customer_daily_active_users_new?fields=customer_daily_active_users_new.date_range_activity,count_of_gaia_id&fill_fields=customer_daily_active_users_new.date_range_activity&f[customer_daily_active_users_new.gaia_id]=NOT+NULL&sorts=customer_daily_active_users_new.date_range_activity+desc&limit=500&vis=%7B%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Atrue%2C%22show_view_names%22%3Afalse%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Atrue%2C%22show_x_axis_ticks%22%3Atrue%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trellis%22%3A%22%22%2C%22stacking%22%3A%22%22%2C%22limit_displayed_rows%22%3Afalse%2C%22legend_position%22%3A%22center%22%2C%22point_style%22%3A%22none%22%2C%22show_value_labels%22%3Afalse%2C%22label_density%22%3A25%2C%22x_axis_scale%22%3A%22auto%22%2C%22y_axis_combined%22%3Atrue%2C%22ordering%22%3A%22none%22%2C%22show_null_labels%22%3Afalse%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22type%22%3A%22looker_column%22%2C%22show_null_points%22%3Atrue%2C%22interpolation%22%3A%22linear%22%2C%22defaults_version%22%3A1%2C%22series_types%22%3A%7B%7D%7D&filter_config=%7B%22customer_daily_active_users_new.gaia_id%22%3A%5B%7B%22type%22%3A%22%21null%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22%22%7D%2C%7B%7D%5D%2C%22id%22%3A3%2C%22error%22%3Afalse%7D%5D%7D&dynamic_fields=%5B%7B%22measure%22%3A%22count_of_gaia_id%22%2C%22based_on%22%3A%22customer_daily_active_users_new.gaia_id%22%2C%22expression%22%3A%22%22%2C%22label%22%3A%22Count+of+Gaia+ID%22%2C%22type%22%3A%22count_distinct%22%2C%22_kind_hint%22%3A%22measure%22%2C%22_type_hint%22%3A%22number%22%7D%5D&origin=share-expanded
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
