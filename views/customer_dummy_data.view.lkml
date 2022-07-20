# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: customer_dummy_data_1 {
  view_name: customer_dummy_data
  join: customer_dummy_data__product {
    view_label: "Customer Dummy Data: Product"
    sql: LEFT JOIN UNNEST(${customer_dummy_data.product}) as customer_dummy_data__product ;;
    relationship: one_to_many
  }

  join: customer_dummy_data__taxonomy_nodes {
    view_label: "Customer Dummy Data: Taxonomy Nodes"
    sql: LEFT JOIN UNNEST(${customer_dummy_data.taxonomy_nodes}) as customer_dummy_data__taxonomy_nodes ;;
    relationship: one_to_many
  }
}

explore: customer_daily_active_users {
  view_name: customer_dummy_data
  fields: [customer_dummy_data.gaia_id, customer_dummy_data.activity_date]
  join: customer_B {
    from: customer_dummy_data
    type: inner
    relationship: one_to_many
    sql_on: DATE_DIFF(${customer_dummy_data.activity_date},${customer_B.activity_date}, DAY)<2 AND DATE_DIFF(${customer_dummy_data.activity_date}, ${customer_B.activity_date}, DAY)>=0 AND ${customer_B.gaia_id}=${customer_dummy_data.gaia_id};;
  }
}

# view: customer_daily_active_users_new  {
#   derived_table: {
#     sql: SELECT
#     customer_date.dates_for_calc as date_range_activity,
#     customer_dummy_data.gaia_id as customer_dummy_data_gaia_id,
#     count(*) as total_times_active_in_range
# FROM
# (SELECT
#   DATE(TIMESTAMP_MICROS(customer_dummy_data.activity_timestamp)) as dates_for_calc
# FROM
#   `bip-insights.looker_poc.CustomerDummyData` as customer_dummy_data
# GROUP BY 1
# HAVING dates_for_calc IS NOT NULL
# ORDER BY 1 DESC
# LIMIT 7
# ) AS customer_date
# LEFT JOIN
# `bip-insights.looker_poc.CustomerDummyData`
#     AS customer_dummy_data
# ON DATE_DIFF(customer_date.dates_for_calc, DATE(TIMESTAMP_MICROS(customer_dummy_data.activity_timestamp)), DAY)<2 AND DATE_DIFF(customer_date.dates_for_calc, DATE(TIMESTAMP_MICROS(customer_dummy_data.activity_timestamp)), DAY)>=0
# WHERE DATE(TIMESTAMP_MICROS(customer_dummy_data.activity_timestamp)) IS NOT NULL
# GROUP BY
#     1, 2
#     ;;
#   }
# }
# The name of this view in Looker is "Customer Dummy Data"
view: customer_dummy_data {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `bip-insights.looker_poc.CustomerDummyData`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Activity Timestamp" in Explore.

  dimension: activity_timestamp {
    type: number
    sql: ${TABLE}.activity_timestamp ;;
  }

  dimension: activity_date {
    type: date
    datatype: date
    sql:  DATE(TIMESTAMP_MICROS(${activity_timestamp})) ;;
  }
  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  # measure: total_activity_timestamp {
  #   type: sum
  #   sql: ${activity_timestamp} ;;
  # }

  # measure: average_activity_timestamp {
  #   type: average
  #   sql: ${activity_timestamp} ;;
  # }

  dimension: form_factor {
    type: string
    sql: ${TABLE}.form_factor ;;
  }

  dimension: form_factor_group {
    type: string
    sql: ${TABLE}.form_factor_group ;;
  }

  dimension: gaia_id {
    type: number
    sql: ${TABLE}.gaia_id ;;
  }

  dimension: interactivity_level {
    type: string
    sql: ${TABLE}.interactivity_level ;;
  }

  dimension: official_activity_level {
    type: string
    sql: ${TABLE}.official_activity_level ;;
  }

  dimension: os {
    type: string
    sql: ${TABLE}.os ;;
  }

  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: product {
    sql: ${TABLE}.product ;;
  }

  dimension: rocket_event_code {
    type: number
    sql: ${TABLE}.rocket_event_code ;;
  }

  dimension: taxonomy_nodes {
    sql: ${TABLE}.taxonomy_nodes ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

# The name of this view in Looker is "Customer Dummy Data Product"
view: customer_dummy_data__product {
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Customer Dummy Data Product" in Explore.

  dimension: customer_dummy_data__product {
    type: string
    sql: customer_dummy_data__product ;;
  }
}

# The name of this view in Looker is "Customer Dummy Data Taxonomy Nodes"
view: customer_dummy_data__taxonomy_nodes {
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Customer Dummy Data Taxonomy Nodes" in Explore.

  dimension: customer_dummy_data__taxonomy_nodes {
    type: number
    sql: customer_dummy_data__taxonomy_nodes ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  # measure: total_customer_dummy_data__taxonomy_nodes {
  #   type: sum
  #   sql: ${customer_dummy_data__taxonomy_nodes} ;;
  # }

  # measure: average_customer_dummy_data__taxonomy_nodes {
  #   type: average
  #   sql: ${customer_dummy_data__taxonomy_nodes} ;;
  # }
}
